From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 0/5] rebase: improve the keep-empty
Date: Tue, 28 May 2013 10:17:09 -0700
Message-ID: <CANiSa6haWGOjpydxX-B9W1ZGAANAJ5Wi5_sLqedQwGCSTu86nA@mail.gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:17:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNWO-0001dC-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934934Ab3E1RRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:17:12 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56825 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934735Ab3E1RRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:17:11 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so5481621wgg.28
        for <git@vger.kernel.org>; Tue, 28 May 2013 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h3w4cfOPkxqR26u6Tza5xn8EROaXVXRvzjzSLcTTijQ=;
        b=VbUqUVdMYqN4Dn3lYLmBkBaxNkbhe65hVPd+Id7MASXORb1lPQjknwYuJcgs8Tz188
         /0/kTkaJ/+GE3CrFYxMQ9JBX1VRgAcWzvhOdMshMeQu1UF3BVC+O7FpNhCIG/pWp+bqs
         tWwGCTF6xsc9T6QwmCXQmiFwoC5rY77TLKrGn6GeidZ2CkevdOggCZ4mnsZoXGhPGfh3
         xZqpnQBcC81Gxo10fWjL8aa8udI3wdu3VSJeYvJehwDa4dl40xEVDLsZXonpriM4lryn
         syoJAVFcH0TGVV9RFgcR843t99oAkx1Ko22ndtLlCoIpibjv68u6lVsmg2pj+QIxioA+
         4BHQ==
X-Received: by 10.180.108.3 with SMTP id hg3mr12785515wib.17.1369761430023;
 Tue, 28 May 2013 10:17:10 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 10:17:09 -0700 (PDT)
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225670>

Hi,

I think I have some patches at home that instead teach 'git am' the
--keep-empty flag. Does that make sense? It's been a while since I
looked at it, but I'll try to take a look tonight (PST).

Martin

On Tue, May 28, 2013 at 6:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I've been analyzing 'git rebase' and found that the --keep-empty option
> triggers a very very different behavior. Here's a bunch of patches that make it
> behave like the 'am' does does for the most part.
>
> There's only a few minor changes, after which it might be possible to replace
> the whole 'am' mode to use cherr-pick instead.
>
> Felipe Contreras (5):
>   rebase: split the cherry-pick stuff
>   rebase: fix 'cherry' mode storage
>   rebase: fix sequence continuation
>   rebase: fix abort of cherry mode
>   rebase: fix cherry-pick invocations
>
>  .gitignore            |  1 +
>  Makefile              |  1 +
>  git-rebase--am.sh     | 65 ++++++++++++++++++++++-----------------------------
>  git-rebase--cherry.sh | 55 +++++++++++++++++++++++++++++++++++++++++++
>  git-rebase.sh         |  8 +++++++
>  5 files changed, 93 insertions(+), 37 deletions(-)
>  create mode 100644 git-rebase--cherry.sh
>
> --
> 1.8.3.rc3.312.g47657de
>
