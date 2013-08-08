From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 3/4] pack-objects: do not print usage when repacking
Date: Thu, 8 Aug 2013 08:40:51 +0200
Message-ID: <CALWbr2yQBK9D3HJ2k9xPryKL=TFh_u7V2K5qOZJQw=J=qYXs+g@mail.gmail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
	<1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
	<1375884049-14961-4-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com, git <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 08:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Ju4-00082h-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 08:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933296Ab3HHGkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 02:40:53 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:53039 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab3HHGkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 02:40:52 -0400
Received: by mail-qe0-f51.google.com with SMTP id nd7so1473535qeb.24
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+sWFoa9G73ON4CdbMlGFoNotvguhAMFb5uqO2LnvStM=;
        b=e41Fvkn1aLPYz6Xb/FYXOngg096p0pnQ9UpDXXFqcK/SOpGqWuiuAH5/C67AMfwACY
         vjRNCxPkAHc4gsR+iKRCuDd7zO6i8meQ3WlI6xs3gy2R0SNwJmJ1Fg2c/kqJ5PAUev/d
         MviK2Ik//Gm/+HScZ5jiSUMHsufxNm25PK+yctuHf1Gok5O6BXRuZdPwqlNP1qphYjin
         +pJEIBMh31jvWwMsgvL24oO5C8pA2gBFa7ihBPTvqjWvl0dErU4AP+GWVGE1ONxkB2AA
         3vu7VVRq0WPTUo3Ggx6HIYjcCvQevFbGpRnRlwCD7Urd667HNMNtUoJqlK8DivVSw338
         u+2A==
X-Received: by 10.49.3.131 with SMTP id c3mr4425029qec.33.1375944051621; Wed,
 07 Aug 2013 23:40:51 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Wed, 7 Aug 2013 23:40:51 -0700 (PDT)
In-Reply-To: <1375884049-14961-4-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231865>

On Wed, Aug 7, 2013 at 4:00 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> ---
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1742ea1..0bd8f3b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2585,7 +2585,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>                 base_name = argv[0];
>                 argc--;
>         }
> -       if (pack_to_stdout != !base_name || argc)
> +       if (!(repack_flags & REPACK_IN_PROGRESS) && (pack_to_stdout != !base_name || argc))
>                 usage_with_options(pack_usage, pack_objects_options);
>
>         rp_av[rp_ac++] = "pack-objects";

Hello Stefan,
I'm not sure I understand that and why it's needed, would you mind
explain it to me ? (and/or maybe add it to the commit message)

Thanks,
