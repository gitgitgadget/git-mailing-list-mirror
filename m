From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 11:04:57 +0530
Message-ID: <CAFZEwPOfLvbu+QD9kV4i5_LQnv1N_NEz1wjsRSmb=YDFpy7=Nw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 07:35:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axpSo-0008Mn-I8
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbcEDFe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:34:59 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36426 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDFe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:34:58 -0400
Received: by mail-yw0-f180.google.com with SMTP id o66so66599375ywc.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5AeeF4bxt/h2lduvdZ6r5nIoX+BRBOQA9u1h9Hgjecc=;
        b=AtP4sL3m6YpC/Ys49w9SEkCUQ/YevGtoRBosnL5TEhOZpgXPgaB1Nug2+1E3Lkz9ga
         DK2PFrIsgrl3SYN4438AGoELKXgmFY2WaYiR2cu8t6zEUKdtG2n89jyrR5Wwp8SIATpt
         17NOJCFfeaHG5qxzTYZ4FJ2hdpnGRs9vRgY8nQ6mxluGFF9bDFJ4a5WioQ1nfI9JdaZh
         n4h3XvfhE76sl8T4ej9LBidlGTHzIJ8/9a1cGqY2WeyxNPzAIi7RGywaU3eykoD9Q4rW
         b7t2jUEzaM8cwr7U6opNPdYLYK+fdCDpMkVpM1y+xv5RByrdWDTR3GjtCB424I6bGcrq
         lV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5AeeF4bxt/h2lduvdZ6r5nIoX+BRBOQA9u1h9Hgjecc=;
        b=dd8SneYvf3UNWNMERi1h+mC2vGf1JISHlqeAMgtCyx91brabtJ2lYfCMNexldg5OnZ
         Vb1wPF+wkfaeZeSSoutj6rHGotGPl5dRbBKigODKD5M+JvBNr9IS/xnOiZHjHpLAIjuD
         Mnraji6LOLpRzuNYGhrczYnTaBZ6g2yixsWIiQJgmjc2Yic9JFiOhW9aK/C9/TyCbCcD
         +F84xpEijtxHpdPV00jnMJOyZmSj5jhypG2VpaBFVbwG9AbJzKduZMreTlH9crHfH2DC
         51nHAXbM8hpw9Bu0nBM4Zjh3NfKQ1a14m7TQFVMn4xOLQAo2Yi4IiS+7zHbY7bebjAuH
         m5Zg==
X-Gm-Message-State: AOPr4FWMJxqMPyWi2SowwQgyxbgXoy/0IIUdc2M+WqOiaNlTEqMnkxGiDD48XsIcErFDelzdfcRHRfJn4TtOZA==
X-Received: by 10.37.207.6 with SMTP id f6mr3750495ybg.131.1462340097803; Tue,
 03 May 2016 22:34:57 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 3 May 2016 22:34:57 -0700 (PDT)
In-Reply-To: <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293492>

On Wed, May 4, 2016 at 10:37 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> `--next-all` is meant to be used as a sub command to support multiple
> "operation mode" though the current implementation does not contain any
> other sub command along side with `--next-all` but further commits will
> include some more subcommands.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christain Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---

This is also a typo. s/Christain/Christian/g

>  builtin/bisect--helper.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..5f6ef8c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>         NULL
>  };
>
> +enum sub_commands {
> +       NEXT_ALL = 1
> +};
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -       int next_all = 0;
> +       int sub_command = 0;
>         int no_checkout = 0;
>         struct option options[] = {
> -               OPT_BOOL(0, "next-all", &next_all,
> -                        N_("perform 'git bisect next'")),
> +               OPT_CMDMODE(0, "next-all", &sub_command,
> +                        N_("perform 'git bisect next'"), NEXT_ALL),
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -23,9 +27,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options,
>                              git_bisect_helper_usage, 0);
>
> -       if (!next_all)
> +       if (!sub_command)
>                 usage_with_options(git_bisect_helper_usage, options);
>
> -       /* next-all */
> -       return bisect_next_all(prefix, no_checkout);
> +       switch (sub_command) {
> +       case NEXT_ALL:
> +               return bisect_next_all(prefix, no_checkout);
> +       default:
> +               die(_("bug: unknown subcommand '%d'"), sub_command);
> +       }
> +       return 0;
>  }
> --
> 2.8.1
>
