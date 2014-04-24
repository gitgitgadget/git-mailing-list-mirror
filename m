From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 12/12] cherry-pick: copy notes and run hooks
Date: Thu, 24 Apr 2014 19:06:01 -0400
Message-ID: <CALkWK0=AywuFd1xaO3iXudhmnN1Sx2RDvhzmxLBjdaYD4OUB8w@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com> <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 01:06:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSjC-0003TZ-AU
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 01:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbaDXXGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 19:06:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55716 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbaDXXGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 19:06:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so1157881ier.26
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7C2QfvkjfnntSVQ8PUE9aBK82I2rtNxl1wpJL86PLTo=;
        b=Sm6dV85JeYxUhknqaQyzH3ZHHV+gh15Mgg+lN6PVCwHkSNFysWG+DznoaW8+CdK7C7
         Auvfa1ZGotk+FWUnrGjY2mngUyPL/CIBbdtUlsolyEwOwuvaECjzKb41Gd689oWL04GM
         IbH5skyexG7KJuFggH7uf+g2fxmLipBf+xnnOMEvrHn4nC6Qlawz3vbuvPPv6IluC2XK
         8tvn5MIXhINiNX6DifiGQW52gFLawnsdYghKGRKQ4zgCwN/qa0SpVOvcSNk4BIv0sKzY
         vvftRzDimxPFlfjadXLkrdXc0HXVfMJ2cqsqe40mprO+UMagacA1RmYb2VMrn8GSezS1
         rCrg==
X-Received: by 10.50.153.72 with SMTP id ve8mr1673734igb.16.1398380801424;
 Thu, 24 Apr 2014 16:06:41 -0700 (PDT)
Received: by 10.64.10.39 with HTTP; Thu, 24 Apr 2014 16:06:01 -0700 (PDT)
In-Reply-To: <1398307491-21314-13-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247022>

Felipe Contreras wrote:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 43631b4..fd085e1 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -248,7 +248,7 @@ pick_one () {
>
>         test -d "$rewritten" &&
>                 pick_one_preserving_merges "$@" && return
> -       output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
> +       output eval git cherry-pick "--action-name ''" "$strategy_args" $empty_args $ff "$@"

Passing an empty action-name looks quite ugly. Is there a better way
to achieve this?
