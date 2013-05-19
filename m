From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fetch: add new fetch.default configuration
Date: Sun, 19 May 2013 17:21:12 +0530
Message-ID: <CALkWK0nQzEK6-E7aMnGg6eYZJ_=XsE6FBmRgu9_8jBGkYmJe+Q@mail.gmail.com>
References: <1368843536-19781-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mGPMw8NuhJFS0gK2BVutRO=FxX1ss+1o8fnndCc13LWw@mail.gmail.com> <CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue29d-0005VP-1E
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401Ab3ESLvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:51:53 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:34936 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab3ESLvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:51:52 -0400
Received: by mail-ia0-f176.google.com with SMTP id j3so4248712iae.35
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z+siNgAIvWX5JS1aWrPens62hxLxshCshAy9OmxC45Y=;
        b=x53Bbjdc6N5Xy406vDg+WWjR+sf4LF8tDxqbsqkGIzmUHFwVaSXj32i7ZGavdB//4n
         Ue+fLKrikAPQlkQUPhVQiFxCFAJ+fgrh+OCik0dGJTiuxgZk3R8E9WahdWRSMXdnpToJ
         YLAYYMIaj4IySeQd13TrK5hrlWRBwH45cRG3f/BLSlo+ib7fROOGVFfpIAkl0kh+YSE+
         Mu4L1Oc6FmDkR+n3BBMvHUPOrdMxBLjP5KhI/jWWFaGANygVFOph08rHYu5xdMbXUGrl
         GUb5T489W8PvY2buv5t06sxo4rnruyN7nRmIkP1a+37o7u44JSIVnv/Jbfx1sfMXLbsu
         3RCQ==
X-Received: by 10.50.33.19 with SMTP id n19mr2863346igi.44.1368964312110; Sun,
 19 May 2013 04:51:52 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:51:12 -0700 (PDT)
In-Reply-To: <CAMP44s3pZYw87awogjjOdFRP39Ou0=td2erhV2-aC-9_A_Z75A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224864>

Felipe Contreras wrote:
> % git checkout fc/remote/hg-next
> % git rebase -i # rebase to master
> % git checkout fc/remote/hg-notes
> % git rebase -i # rebase to fc/remote/hg-next
> % git checkout fc/remote/hg-gitifyhg-compat
> % git rebase -i # rebase to fc/remote/hg-notes

So it is rebase, but rebase.defaultUpstream = origin won't suffice.
You want to specify a custom base.  What I don't understand is why
you're abusing @{u}, and crippling remote (by hard-interpreting it as
"origin") to achieve this.  For the record, I didn't think your
branch.<name>.base was a bad idea at all (re-visiting now).
