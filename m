From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Tue, 25 Feb 2014 20:24:47 -0500
Message-ID: <CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 02:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WITEz-0002Hx-6z
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 02:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbaBZBYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 20:24:49 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:47324 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaBZBYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 20:24:48 -0500
Received: by mail-yk0-f174.google.com with SMTP id 20so662944yks.5
        for <git@vger.kernel.org>; Tue, 25 Feb 2014 17:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=C3kRNVqlJAGa+KoUqrzS9/cYNSuCCY2O/XbNuaX9gkU=;
        b=WjWo7jFFDxQ22JqRBWUJOn0KNh9jxxaujPbLAkCbTWGx8DTO/uzv/eT1ecm0CGrESP
         qxtzZU+guhdachdhXGaPa1goyQoGIbiW4jEkylHXOmdZUuuXun+b+sO68NE1dTsMK6mJ
         ezWTv545DZ52tRw8HKwsIf9rY2aXOEiiCvPkRMWJPYNgU47Y3i0RyEAyL/9xRDqyY/fv
         MeDHpVegS289L0P1/rlbbEb4/FnIxepsBOmbhZXrG8/EP+3nuAYek4HVNHaa5MXxieTz
         VOmh2NzdJVIvAkJ9c9vz4KvDIYEiAefTVqkKhwU2Hqcfa7mxi49EywiCV6f0wJdspV5x
         MaKQ==
X-Received: by 10.236.120.17 with SMTP id o17mr66075yhh.121.1393377887965;
 Tue, 25 Feb 2014 17:24:47 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 25 Feb 2014 17:24:47 -0800 (PST)
In-Reply-To: <1392730814-19656-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: S_ius4OKogf-YriXCq3Ye8Y43e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242697>

On Tue, Feb 18, 2014 at 8:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This variable is intended to support multiple working directories
> attached to a repository. Such a repository may have a main working
> directory, created by either "git init" or "git clone" and one or mor=
e
> linked working directories. These working directories and the main
> repository share the same repository directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 02bbc08..2c4a055 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -773,6 +773,14 @@ Git so take care if using Cogito etc.
>         an explicit repository directory set via 'GIT_DIR' or on the
>         command line.
>
> +'GIT_COMMON_DIR'::
> +       If this variable is set to a path, non-worktree files that ar=
e
> +       normally in $GIT_DIR will be taken from this path
> +       instead. Worktree-specific files such as HEAD or index are
> +       taken from $GIT_DIR. This variable has lower precedence than
> +       other path variables such as GIT_INDEX_FILE,
> +       GIT_OBJECT_DIRECTORY...

=46or a person not familiar with "git checkout --to" or its underlying
implementation, this description may be lacking. Such a reader may be
left wondering about GIT_COMMON_DIR's overall purpose, and when and
how it should be used. Perhaps it would make sense to talk a bit about
"git checkout --to" here?

>  Git Commits
>  ~~~~~~~~~~~
>  'GIT_AUTHOR_NAME'::
