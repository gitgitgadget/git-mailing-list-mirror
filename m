From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC] Revert "git am/mailinfo: Don't look at in-body
 headers when rebasing"
Date: Wed, 24 Jun 2015 18:36:07 +0800
Message-ID: <CACRoPnRFCZWih-uFMRnqWwOCmeM9=RgUUpQURk4vrZZsDOjGvg@mail.gmail.com>
References: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7i2b-0001FW-5k
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 12:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbFXKgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 06:36:19 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33194 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbbFXKgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 06:36:09 -0400
Received: by lbbvz5 with SMTP id vz5so23610071lbb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z0fDRwr6LfUhgZV1EioqLJtTJ8h9YHhljuY/NV6doG4=;
        b=UzVbmAHxvRkLWn3GBDbm3MKByzEvSvvt2TJRJYijFjVsaPEhPHaGpt81ucxRLyjDwV
         sxshKdmVrqH1aZEtMA2cG1jxgZgJcdgoboYN1t1JGNvOl+SqkSSDqgZ+0vLXQCjXHGoQ
         ttd1iScqrl1am1k0YNC2uKbWFHtnlDgDlAO4DkB7iRGxJMFrkT5lLFuRCpB9td9/DqqJ
         edMjjPQB/6+aiwZYtKMXRILqxhKrqRxyX+odgml1ocU68JVITj7/MdZKUhW+jNvZac0Y
         MTi9C7JNfcipus2sOhIFocEefA10jAqrIoxvFcpnzJmps9QbjfmF/01pAl6b/vzGR+rY
         ho8g==
X-Received: by 10.112.64.72 with SMTP id m8mr14848901lbs.98.1435142167472;
 Wed, 24 Jun 2015 03:36:07 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 24 Jun 2015 03:36:07 -0700 (PDT)
In-Reply-To: <1434445392-6265-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272547>

Hi Junio,

On Tue, Jun 16, 2015 at 5:03 PM, Paul Tan <pyokagan@gmail.com> wrote:
> This reverts commit d25e51596be9271ad833805a3d6f9012dc24ee79, removing
> git-mailsplit's --no-inbody-headers option.
>
> While --no-inbody-headers was introduced to prevent commit messages from
> being munged by git-mailinfo while rebasing, the need for this option
> disappeared since 5e835ca (rebase: do not munge commit log message,
> 2008-04-16), as git-am bypasses git-mailinfo and gets the commit message
> directly from the commit ID in the patch.
>
> git-am is the only user of --no-inbody-headers, and this option is not
> documented. As such, it should be removed.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>

What do you think about applying this patch?

Either way, the no-inbody-headers code in git-am.sh is dead code so I
don't think I will be implementing it in the git-am rewrite.

Thanks,
Paul
