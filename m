From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 11:32:59 +0200
Message-ID: <CAB9kjA4YdEa0RQvf9noDCr9GtBabvajBxgH=JF+Bd1ta=CxnyQ@mail.gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
	<0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3MU-00011X-G4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab3ILJiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:38:51 -0400
Received: from forward4h.mail.yandex.net ([84.201.186.22]:59389 "EHLO
	forward4h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3ILJiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:38:50 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Sep 2013 05:38:49 EDT
Received: from smtp4h.mail.yandex.net (smtp4h.mail.yandex.net [84.201.186.21])
	by forward4h.mail.yandex.net (Yandex) with ESMTP id 03F5F1B2241B
	for <git@vger.kernel.org>; Thu, 12 Sep 2013 13:33:01 +0400 (MSK)
Received: from smtp4h.mail.yandex.net (localhost [127.0.0.1])
	by smtp4h.mail.yandex.net (Yandex) with ESMTP id AFE732C1838
	for <git@vger.kernel.org>; Thu, 12 Sep 2013 13:33:01 +0400 (MSK)
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
	by smtp4h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id RBtHX71Rxm-X1CintxU;
	Thu, 12 Sep 2013 13:33:01 +0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1378978381;
	bh=+osEeQLSZqw0KnxcB6mpI1X8cAIB6D/NocgvTuy4moQ=;
	h=Received:X-Google-DKIM-Signature:MIME-Version:X-Received:Received:
	 In-Reply-To:References:Date:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	b=C9gQXpyniOvlm7jU9ur6KL/BaoD6B9czrXtYZmnTN1JkbXmiqN77Glc7BmS5/HKsp
	 CDj2GuuUejmc31ktt0khVb80WLDJGyZf7Q0XfifphQVR56P0ANJkgH9nuVJdelG84B
	 xXALoh6Ube1c5UCFureELed/ielO+OLW6z2X5mWI=
Authentication-Results: smtp4h.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by mail-ee0-f46.google.com with SMTP id c13so4784093eek.33
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 02:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+osEeQLSZqw0KnxcB6mpI1X8cAIB6D/NocgvTuy4moQ=;
        b=H+bvDFbK1kBdAvQbQ1Q2iDYckhn0dJCmOipDhhgZFDSCtWjWIDcz5Njpp5p67599MA
         6Gklz/6yaF3hpFPSwLekHFCff9StRcdAQbXsk6h/BXT8B0FKyPnuBTZ1MtC3MV75weRM
         kN3ierwXrShWHQQ3SqXBvAWXh/nTpPJbLPjlEIs7+T1SXLEzzjvFFOgf/2GhlRILnukX
         Bidh40M2En+T8bS5KC9qRIBmZ7PYVufvP2lpaJ/vQSqPaG+PTB79yw8JrIB3r3XuunDP
         MNtms8SSG69m4wK21APF/ysGKeP1ld7U+A1N70H/WziLDw1YLGIu1tB/Ac/ks44vPtOL
         orag==
X-Received: by 10.15.74.197 with SMTP id j45mr9472371eey.40.1378978380419;
 Thu, 12 Sep 2013 02:33:00 -0700 (PDT)
Received: by 10.15.44.69 with HTTP; Thu, 12 Sep 2013 02:32:59 -0700 (PDT)
In-Reply-To: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234635>

Thank you, this fixes the problem with `git svn rebase` on Windows for me.

--Tvangeste

On Thu, Sep 12, 2013 at 11:12 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> Tvangeste found that the "relative_path" function could not work
> properly on Windows if "in" and "prefix" have dos driver prefix.
> ($gmane/234434)
>
> e.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
> should return "C:/a/b", but returns "../../C:/a/b", which is wrong.
>
> So make relative_path honor dos_drive_prefix, and add test cases
> for it in t0060.
>
> Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  path.c                | 20 ++++++++++++++++++++
>  t/t0060-path-utils.sh |  4 ++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/path.c b/path.c
> index 7f3324a..ffcdea1 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,6 +441,16 @@ int adjust_shared_perm(const char *path)
>         return 0;
>  }
>
> +static int have_same_root(const char *path1, const char *path2)
> +{
> +       int is_abs1, is_abs2;
> +
> +       is_abs1 = is_absolute_path(path1);
> +       is_abs2 = is_absolute_path(path2);
> +       return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
> +              (!is_abs1 && !is_abs2);
> +}
> +
>  /*
>   * Give path as relative to prefix.
>   *
> @@ -461,6 +471,16 @@ const char *relative_path(const char *in, const char *prefix,
>         else if (!prefix_len)
>                 return in;
>
> +       if (have_same_root(in, prefix)) {
> +               /* bypass dos_drive, for "c:" is identical to "C:" */
> +               if (has_dos_drive_prefix(in)) {
> +                       i = 2;
> +                       j = 2;
> +               }
> +       } else {
> +               return in;
> +       }
> +
>         while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
>                 if (is_dir_sep(prefix[i])) {
>                         while (is_dir_sep(prefix[i]))
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 76c7792..c3c3b33 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -208,6 +208,10 @@ relative_path a/b/ a/b             ./
>  relative_path a                a/b             ../
>  relative_path x/y      a/b             ../../x/y
>  relative_path a/c      a/b             ../c
> +relative_path a/b      /x/y            a/b
> +relative_path /a/b     x/y             /a/b    POSIX
> +relative_path d:/a/b   D:/a/c          ../b    MINGW
> +relative_path C:/a/b   D:/a/c          C:/a/b  MINGW
>  relative_path a/b      "<empty>"       a/b
>  relative_path a/b      "<null>"        a/b
>  relative_path "<empty>"        /a/b            ./
> --
> 1.8.3.rc2.14.g5ac1b82
>
