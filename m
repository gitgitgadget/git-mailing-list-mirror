From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Wed, 13 Mar 2013 16:21:02 +0100
Message-ID: <5140995E.3070907@web.de>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com> <1363179556-4144-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tboegi@web.de, artagnon@gmail.com, robert.allan.zeh@gmail.com,
	finnag@pvv.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 16:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFnUq-0006Pv-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 16:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910Ab3CMPVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 11:21:14 -0400
Received: from mout.web.de ([212.227.17.11]:62078 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391Ab3CMPVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 11:21:13 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0Lk8Ow-1UrbLe0peE-00cAG0; Wed, 13 Mar 2013 16:21:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1363179556-4144-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V02:K0:M9cB5wd2mkrqq6c1wOEa1dCmKva1Ux509xB2RD95DC3
 d6+P8eVFWNPwJbM303Ft7mZ0JFGfYkS2YCH2LI6MWjuj3C6iSY
 lHOxUqtcaPdlLBjqau/Msc1JdZczFjtzoW3xAl6SiSpnR6RVI8
 sHWb8u3m3OlN02GK5SZO7FeWIy1f6YxRts9wr+B8KZXKkNgVTI
 VCIEu8yOx5stkZ7ij1cTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218056>

On 13.03.13 13:59, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> This patch attempts to advertise -uno to the users who tolerate slow
> "git status" on large repositories (or slow machines/disks). The 2
> seconds limit is quite arbitrary but is probably long enough to start
> using -uno.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  4 ++++
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  t/t7060-wtstatus.sh      |  2 ++
>  t/t7508-status.sh        |  4 ++++
>  t/t7512-status-help.sh   |  1 +
>  wt-status.c              | 20 +++++++++++++++++++-
>  wt-status.h              |  1 +
>  8 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bbba728..e91d06f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -178,6 +178,10 @@ advice.*::
>  		the template shown when writing commit messages in
>  		linkgit:git-commit[1], and in the help message shown
>  		by linkgit:git-checkout[1] when switching branch.
> +	statusUno::
> +		If collecting untracked files in linkgit:git-status[1]
> +		takes more than 2 seconds, hint the user that the option
> +		`-uno` could be used to stop collecting untracked files.
Thanks, I like the idea
could we make a "de-Luxe" version where

statusUno is an integer, counting in milliseconds?

/Torsten
