From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/17] ls: add -1 short for --no-column in the spirit
 of GNU ls
Date: Thu, 27 Mar 2014 23:52:54 -0400
Message-ID: <CAPig+cRay7cRJ=zMSpMNFvDVHUR2q+PgoAimSuM67_Ps1t0Yig@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:53:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNql-0005ca-QT
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbaC1Dw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 23:52:56 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:57946 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaC1Dwz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 23:52:55 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so4547661yha.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 20:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=W5KM7Fohxk4SSxL9N2TRoeb3fWgmtBvx8ZPqp6uru3c=;
        b=xvLI/V6YjF4bzd8oQpBhKcaIHVTU+6aiFw6KHCugZkAWnzp1J8rHXurD9WYUm6gvu/
         5q+G+lVrnC2UyZgJcLzpIYNqVmLni1FiMvOB/hrF78rHRPmyC1xHz8u+lo4o4YnQK3c+
         +Ls7iVidPf3LsxQL87TfyV4THreflMniWxs68R0gzvHooNK1aLBH3JWvFqPafYaUpU39
         fkqhwsqCa3PfJm66/c61LTXVHL9ikrGYF80dS5pGnpat7jZLCF6i/angj8RKzd+hfzSJ
         C+Mx8+Bl3Cu4vgEhe8suTEMPDHm+eeK6KmSQS4FWW1PRpVZ2rzei/KjnAhemTjJNgpsT
         x8Fw==
X-Received: by 10.236.44.173 with SMTP id n33mr8058306yhb.2.1395978774628;
 Thu, 27 Mar 2014 20:52:54 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 20:52:54 -0700 (PDT)
In-Reply-To: <1395841697-11742-14-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 6kBRarc6XSeV6EgrCVKpS3rQC0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245359>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Subject: ls: add -1 short for --no-column in the spirit of GNU ls

The -1 option is POSIX [1]; not a GNU extension.

[1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/ls.html

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-ls.txt | 3 +++
>  builtin/ls-files.c       | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/git-ls.txt b/Documentation/git-ls.txt
> index 10df6b0..0480c42 100644
> --- a/Documentation/git-ls.txt
> +++ b/Documentation/git-ls.txt
> @@ -51,6 +51,9 @@ OPTIONS
>  --recursive::
>         Equivalent of --max-depth=3D-1 (infinite recursion).
>
> +-1::
> +       Equivalent of --no-column.
> +
>  --color[=3D<when>]::
>         Color file names. The value must be always (default), never,
>         or auto.
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 772a6ce..014de05 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -729,6 +729,8 @@ int cmd_ls(int argc, const char **argv, const cha=
r *cmd_prefix)
>                             N_("shortcut for --max-depth=3D-1"), -1),
>                 OPT__COLOR(&use_color, N_("show color")),
>                 OPT_COLUMN(0, "column", &colopts, N_("show files in c=
olumns")),
> +               OPT_SET_INT('1', NULL, &colopts,
> +                           N_("shortcut for --no-column"), COL_PARSE=
OPT),
>                 { OPTION_INTEGER, 0, "max-depth", &max_depth, N_("dep=
th"),
>                         N_("descend at most <depth> levels"), PARSE_O=
PT_NONEG,
>                         NULL, 1 },
> --
> 1.9.1.345.ga1a145c
