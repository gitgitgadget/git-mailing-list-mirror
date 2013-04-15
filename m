From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [BUG] git-clone fails due to GnuTLS recv error (-9), then deletes
 entire local repo
Date: Mon, 15 Apr 2013 23:58:54 +0800
Message-ID: <CALUzUxr5i6sRywbKB=eFEcrpHdVtduMQFKaXwMX-WdcWAa6g2A@mail.gmail.com>
References: <510B8416.7010802@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: TJ <git@iam.tj>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URloP-0002nR-5T
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab3DOP7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:59:16 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57618 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3DOP7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:59:16 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so1204364ied.19
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fcU6emeqDKmKGYSWsiVnL2ERZoj9dPwdaB3YhHy1lqI=;
        b=nEGgOdubLpKdLX74VpzwTXx0irukgpzYc+8MazUbSRoRee6VbX0S78oql5f0Tqk4/3
         TeQzwj8N7dk1axT5rA5qT8CiPFAxz5e2PoNWHgFeSfbl4aVTNLQ97jKRmRfbjo82PfSl
         HtWAfNnfpnXam7vDiafwlj0pgMNRA2dbnIFm9uyBOkO8jp6R5hRYZLbIiPSfnUiYhWa3
         ERkq1DbHAfltMixMIN2z7Xd6FcW3UqyaDgGP0Ih8hmlfDg8aE91MqsxlBmGayqJZxuX6
         jWGr8Zf6PahBo8rKsrAiWo2u3htP1COPAYGCXSgSsOoarWaW8648uvanEkkqwBeiJbic
         KdBg==
X-Received: by 10.50.170.36 with SMTP id aj4mr5463195igc.67.1366041555537;
 Mon, 15 Apr 2013 08:59:15 -0700 (PDT)
Received: by 10.64.61.70 with HTTP; Mon, 15 Apr 2013 08:58:54 -0700 (PDT)
In-Reply-To: <510B8416.7010802@iam.tj>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221242>

On Fri, Feb 1, 2013 at 5:00 PM, TJ <git@iam.tj> wrote:
> Using Ubuntu Precise 12.04 with git version (1.8.0.3) I discovered a bug whereby git-clone deletes the repository
> it has just created if there is a GnuTLS error after the final transfer.
>
> I switched to building and using the current git head (1.8.1.2.433.g070c57d.dirty) and found the same issue is still present.
>
> There are two problems here:
>
> 1. At the end of the transfer "GnuTLS recv error (-9): A TLS packet with unexpected length was received"
> 2. git-clone goes on to resolve deltas *then* deletes the entire repository
>
> This is reported as Ubuntu bug #1111882 at https://bugs.launchpad.net/ubuntu/+bug/1111882

I believe this is due to git not supporting resumable clones, and that
the repo is in an unusable state.

It's listed as a 2011 GSoC idea [1] but has since been taken off
because it's considered a "hard" problem (can't come with a email
thread right off the top of my head).

[1] https://git.wiki.kernel.org/index.php/SoC2011Ideas#Resumable_clone

--
Cheers,
Ray Chuan
