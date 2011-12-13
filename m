From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: add 'help' target for target summary
Date: Tue, 13 Dec 2011 07:00:51 -0800 (PST)
Message-ID: <m3aa6wh5xu.fsf@localhost.localdomain>
References: <1323782164-11759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-16be
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 16:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTql-0000GG-DO
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab1LMPAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 10:00:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60318 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1LMPAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 10:00:54 -0500
Received: by eekc4 with SMTP id c4so2155601eek.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=BsulSm348uBLj7b4B4zXigSULXjPO3IN+bHJpsakGfg=;
        b=GnABObc+jrS/NGm+/gaXQqc7oSN/qaHcwQD3LF/hZ04lcpY7QPRMbqdDB76FDg3GRH
         lHz5RRCRcNEdSg9pVo1dEZHdH/1HTGEkHL9DDzcZpmigtKC0hf3clo59k+K4FvtkJE3H
         EQzXqwZwA7rXMimYDEU74TL4HPI2WTPRHt/gc=
Received: by 10.14.4.167 with SMTP id 39mr4366501eej.17.1323788453189;
        Tue, 13 Dec 2011 07:00:53 -0800 (PST)
Received: from localhost.localdomain (abvm99.neoplus.adsl.tpnet.pl. [83.8.210.99])
        by mx.google.com with ESMTPS id 54sm11149469eeo.10.2011.12.13.07.00.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 07:00:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBDF13jC019964;
	Tue, 13 Dec 2011 16:01:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBDF12Bb019961;
	Tue, 13 Dec 2011 16:01:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1323782164-11759-1-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187025>

Nguy=FE=FF=1E=C5n Th=FE=FF=00=E1i Ng=FE=FF=1E=CDc Duy  <pclouds@gmail.c=
om> writes:

> I find this "make help" very helpful (at work, on a different
> project). With this I don't have to crawl through Makefile when I nee=
d
> something but cannot remember what's the target name. It should also
> help discover new targets.
>=20
> We may also have "make vars" (or something like that) that shows list
> of user-configurable variables, basically a conversion of the big
> comment block near the makefile's top into a printable target.
>=20
> I don't work with this Makefile much, so this is just an idea. Anyone
> up to turn it to something actually useful?

Should this be in commit message, or in comments (below "---\n")?

Nb. there was at least one attempt to add "make help" using
in-Makefile _annotations_, so that "make help" wouldn't get badly out
of sync...

> Signed-off-by: Nguy=FE=FF=1E=C5n Th=FE=FF=00=E1i Ng=FE=FF=1E=CDc Duy =
<pclouds@gmail.com>
> ---
>  Makefile |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index ed82320..abf6cf9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2603,3 +2603,17 @@ profile-all: profile-clean
>  	$(MAKE) CFLAGS=3D"$(PROFILE_GEN_CFLAGS)" all
>  	$(MAKE) CFLAGS=3D"$(PROFILE_GEN_CFLAGS)" -j1 test
>  	$(MAKE) CFLAGS=3D"$(PROFILE_USE_CFLAGS)" all
> +
> +.PHONY: help
> +
> +help:
> +	@echo "test		Run the test suite"
> +	@echo "coverage	Build git with coverage support"
> +	@echo "cover_db	Generate coverage database from *.gcov"
> +	@echo "cover_db_html	Generate coverage report"
> +	@echo "profile-all	Build git with profiling support"
> +	@echo "clean		Clean intermediate files"
> +	@echo "distclean	Clean even more for dist packaging"
> +	@echo "sparse		Run git with sparse"
> +	@echo "cscope		Generate cscope symbol database"
> +	@echo "check-docs	Check documentation"
> --=20
> 1.7.8.36.g69ee2
>=20

--=20
Jakub Nar=FE=FF=01=19bski
