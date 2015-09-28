From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote.txt: delete unsupported option
Date: Mon, 28 Sep 2015 10:43:52 -0700
Message-ID: <xmqq37xye8x3.fsf@gitster.mtv.corp.google.com>
References: <1443443417-20235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:44:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgcT1-00032p-5u
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934405AbbI1Rnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 13:43:55 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35652 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbI1Rny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:43:54 -0400
Received: by pacfv12 with SMTP id fv12so184109585pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Joqhs8SKKJDNzgV0mm33cLIW0PjanMjGttcAqwVQgRk=;
        b=yvUzgQB4yHyQaq4B6HfJhgEcfzlwmMLxqSixLxNT9Y+/LCCduByLJkERN9ylTRbFVf
         5LAGxfUqr0fFLqqUeaJ2hwcjlwioYR2fbCKkiSknewCpyPfUXYqB6N5oinjDHyRJM21X
         TttNhGXUGL7TUe6IeG6KIP/CsXoujt29idHWj5ZetHHxVmhQi4/uqnu3yLAktw+nCScv
         P8rlMrpGmgxyomAh1tSBW5zmgAFnlPNfnz5AFP2OtbyhyJLPbWJqLvTr1mwHYIB8sOsp
         MkM0aXmQvBWw4R1qgb/sNrzoQXSgHin+Uujw3tWop9Ln9/zUnkuOHEhAZlmHjCQ3FJW9
         v/Hg==
X-Received: by 10.66.182.135 with SMTP id ee7mr27790355pac.95.1443462234139;
        Mon, 28 Sep 2015 10:43:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id vv9sm20539328pbc.95.2015.09.28.10.43.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 10:43:53 -0700 (PDT)
In-Reply-To: <1443443417-20235-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 28
 Sep 2015 19:30:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278735>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -u <exec> has never been supported, but it was mentioned since
> 0a2bb55 (git ls-remote: make usage string match manpage -
> 2008-11-11). Nobody has complained about it for seven years, it's
> probably safe to say nobody cares. So let's remove "-u" in documents
> instead of adding code to support it.

This sounds OK.

A potential argument for consistency with fetch does not even apply,
as over there --upload-pack and -u are different options.



>
> While at there, fix --upload-pack syntax too.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-ls-remote.txt | 3 +--
>  builtin/ls-remote.c             | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-r=
emote.txt
> index 2e22915..d510c05 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repositor=
y
>  SYNOPSIS
>  --------
>  [verse]
> -'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec=
>]
> +'git ls-remote' [--heads] [--tags]  [--upload-pack=3D<exec>]
>  	      [--exit-code] <repository> [<refs>...]
> =20
>  DESCRIPTION
> @@ -29,7 +29,6 @@ OPTIONS
>  	both, references stored in refs/heads and refs/tags are
>  	displayed.
> =20
> --u <exec>::
>  --upload-pack=3D<exec>::
>  	Specify the full path of 'git-upload-pack' on the remote
>  	host. This allows listing references from repositories accessed via
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 4554dbc..5e9d545 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -4,7 +4,7 @@
>  #include "remote.h"
> =20
>  static const char ls_remote_usage[] =3D
> -"git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>=
]\n"
> +"git ls-remote [--heads] [--tags]  [--upload-pack=3D<exec>]\n"
>  "                     [-q | --quiet] [--exit-code] [--get-url] [<rep=
ository> [<refs>...]]";
> =20
>  /*
