From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Tue, 18 Jun 2013 22:21:07 +0530
Message-ID: <CALkWK0m90Z7Qsxr6ai7t-D2LW6WP6sVaQYcM0eCa1R2xYNk9Jw@mail.gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
 <7v1u81ibjp.fsf@alter.siamese.dyndns.org> <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
 <CALkWK0n2AvL49DNp1t7ty0Dneprd7r_V2p=brS0qMKz=wdZz6A@mail.gmail.com> <7vip1b75uc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoz8J-0004Tg-WF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab3FRQvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:51:48 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:59544 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab3FRQvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:51:47 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so10072891iec.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nsDfeksZwzx7y45ojB5NSgnrz9i45bp31+Uls9nWPt4=;
        b=0gf/IpuWxvMKMMSvwts0OpRn/v3Vczv8atCtuSOhyT2g3uiIDdN3Dt42EE6vzTrrAG
         59hZ2ms6ajtOyjd/AOjz2byHZs5BUOoBu6V3jLkL2BuHWgvMJPY8/oE70URw1TDQczhr
         4BWEuZwktrlSGbZ+plRNM6gUJBxkNoXklD4KPUIvKsQhfnOrFqxyO3YsAGEZHLR0DD/0
         ISdGpf7rqjE1ec7gVBJOJddcyengT7Spl7WpKU1JcWS1kX9BGa7GygljtSiT3PfoTGl/
         YyiR3jM5N4EuiIek956Izne8Y3MEhr4uHPQTcJtNbNDjSlOSD2kfBbTPJ6VOx//6M9fL
         It6g==
X-Received: by 10.50.79.231 with SMTP id m7mr7892695igx.40.1371574307119; Tue,
 18 Jun 2013 09:51:47 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 09:51:07 -0700 (PDT)
In-Reply-To: <7vip1b75uc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228271>

Junio C Hamano wrote:
> Apply the test change without the "do not leak" part in the fix-up
> (queued as a single "SQUASH???" commit on 'pu') to what you posted
> earlier and see how it breaks.
>
>     --- expect      2013-06-18 16:09:21.000000000 +0000
>     +++ actual      2013-06-18 16:09:21.000000000 +0000
>     @@ -1,4 +1,4 @@
>     -rebase -i (start): checkout I
>     +rebase -i (start): checkout branch-reflog-test: checkout I
>      rebase -i (pick): G
>      rebase -i (pick): H
>      rebase -i (finish): returning to refs/heads/branch-reflog-test
>
> If you apply the test part of that fixup to what you posted today,
> what would you see?

Damn it!  I didn't realize that your subshell was for a do-not-leak.
I'm feeling especially stupid now.

Will post a re-roll in a bit.
