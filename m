From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/6] worktree: simplify prefixing paths
Date: Sun, 22 May 2016 19:32:19 -0400
Message-ID: <CAPig+cSpoi0eMKQPqKG6+skc87dgDLZiLJZJLUk-iyd13P3E3g@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522093356.22389-1-pclouds@gmail.com>
	<20160522093356.22389-7-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 01:41:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4d0B-0003lo-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 01:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcEVXcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 19:32:21 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35937 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbcEVXcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 19:32:20 -0400
Received: by mail-io0-f174.google.com with SMTP id f8so49755176ioe.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=jyOUjGdBBJtyZkw+RDzd7F6/XvM7J7/mTpSm2zeEJ9s=;
        b=G1Yw3PtBQB0iRdKZsxjdfUuGRdLmqRfm32533UAVEzJhQHa1BP1EuRSG7eo6UbueXw
         t8MXOAy0ZngaqsquB+7ANgriTP5uaSN7Pze7pVEwms+stBQW+Klo+MqfUDgimtrSZunY
         LRsXpmw8B8l/IIONJgG33YusfQoyyM2L8MPbjIgpX3D0D0O+waKs4+1lNn5bO0/r5r4a
         zSv8Vni2zqClfQ6HRE0cowoFmfkSOXmxwicw0atvBFITk3FMd5I4Jq87LNHHiq3ea4h2
         v9JkLdTs8/IZb+aK+J59fye3mZMmOUmgRWaxw3bQAxL9uFc2nxcF9kbKIcLBGARXCoOH
         mIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=jyOUjGdBBJtyZkw+RDzd7F6/XvM7J7/mTpSm2zeEJ9s=;
        b=GnTUw5xyiyKsOfzXYCh4F5W6Izw+yEeXvNLw7XtQ+yLlZizA0TySZiWLIvKzxOBHE+
         yDRvAZW+MowAXZgmaF7O/tDwt5VPNxBfXmxIx3phOsZhOfuX88paJH6zTYRi086LXbTp
         4pK0mMNG2y6k3ZU2aUKFpqtqswSPDqoQbuD532YcPzEA/E7cdyxePAmlE0hvqEzGVwHL
         wBv6h7YqH27DIU3cuC8kBSfPm0zYcJ1VqnNz7obLlyTIEUBL+C6e22U3yqqZxHZ5NZYy
         Eo9hKbt5rXhpTWzJF1J/9ukqCvu+SOXRMjEwlMFFS++G1c5qCjsXmxBX6RRLbUKNyg9M
         V7sQ==
X-Gm-Message-State: AOPr4FVOkP3aBjz3xjud+za/sY++Bxk9Vs+Io9Es66Z9dXGFBh/UzT/wvZS7cpBFg9hTHHAdjcWm6ern3SB6lA==
X-Received: by 10.36.55.13 with SMTP id r13mr10756192itr.73.1463959939509;
 Sun, 22 May 2016 16:32:19 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 16:32:19 -0700 (PDT)
In-Reply-To: <20160522093356.22389-7-pclouds@gmail.com>
X-Google-Sender-Auth: AfEGVQp5By6aBrASLAI8t4zIW9E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295293>

On Sun, May 22, 2016 at 5:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This also makes slash conversion always happen on Windows (a side eff=
ect
> of prefix_filename). Which is a good thing.

Selling this patch as a mere simplification seems misguided
(especially as it's subjective whether this is indeed simpler). I'd
find it more easy to buy this change if it was described primarily as
benefiting Windows, in the same vein as[1].

More below...

[1]: http://git.661346.n2.nabble.com/PATCH-Do-not-skip-prefix-filename-=
when-there-is-no-prefix-tp7657038.html

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -337,7 +337,7 @@ static int add(int ac, const char **av, const cha=
r *prefix)
>         if (ac < 1 || ac > 2)
>                 usage_with_options(worktree_usage, options);
>
> -       path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[=
0]) : av[0];
> +       path =3D prefix_filename(prefix, strlen(prefix), av[0]);
>         branch =3D ac < 2 ? "HEAD" : av[1];
>
>         opts.force_new_branch =3D !!new_branch_force;
> @@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const c=
har *prefix)
>
>         if (ac < 2)
>                 usage_with_options(worktree_usage, options);
> +       if (!prefix)
> +               prefix =3D "";

Considering that all the other existing git-worktree subcommands
already handle NULL prefix acceptably, it makes me a bit uncomfortable
that this "fix", which could be local to add(), leaks into all the
other subcommands, thus making the assumption that they (or other new
subcommands) will never care about the distinction between NULL and
"".

Not a big objection; just a minor niggle, probably not worth a re-roll.

>         if (!strcmp(av[1], "add"))
>                 return add(ac - 1, av + 1, prefix);
>         if (!strcmp(av[1], "prune"))
