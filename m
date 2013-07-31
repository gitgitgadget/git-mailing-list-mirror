From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 3/9] log, format-patch: parsing uses OPT__QUIET
Date: Wed, 31 Jul 2013 13:08:48 -0400
Message-ID: <CAPig+cSazYJDP40zqkr47iuJ925bH-eFEjp2kzb_D3efgqggNw@mail.gmail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
	<1375288117-1576-4-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 19:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZtT-0008G4-8c
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 19:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab3GaRIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 13:08:51 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:56386 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab3GaRIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 13:08:50 -0400
Received: by mail-la0-f50.google.com with SMTP id fn20so684848lab.23
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8MTZvZIek1Lw2EDfJU2qMBsW5xcjnYulNMQxG5UVnzk=;
        b=Ae/BbfSRQeMFryieKhrYBnfQK2Okpr6HctaKhIx5aegufFKSdcG7X2R10nhouiu/3P
         +S7HRpKMYxgpUEh/SXzw07QlNsrojUO3FyaDnYq2yc9S9a0i99X7Rzkl+64KffStRn4m
         RV2CcpPjYAH6cqu10Y14nlTunD3/lzZzlIh5Oq64mbzkAtBqZartpx5MQWic4sELsk1R
         A+dajMJg/E6AWGfxQbktAMDiTyxCNHDxndJS0v+85P3mo6qT7OTgbX9PV/7JuLFWs6Ez
         JLhq/GKDq2g30K/YJI03e+y/xiCtktcfMHw7FIsyhgPcCgfksgAhD7lOG8ukKnmylA0H
         Fp/A==
X-Received: by 10.152.116.109 with SMTP id jv13mr17830683lab.24.1375290529061;
 Wed, 31 Jul 2013 10:08:49 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 31 Jul 2013 10:08:48 -0700 (PDT)
In-Reply-To: <1375288117-1576-4-git-send-email-stefanbeller@googlemail.com>
X-Google-Sender-Auth: XI1WoTw87dUf3UkQKslil2zvPHc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231435>

On Wed, Jul 31, 2013 at 12:28 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> This patch allows users to use the short form -q on
> log and format-patch, which was non possible before.

It would make sense for documentation updates to accompany these changes.

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/log.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 1dafbd0..ed4dec4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -121,7 +121,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>         static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
>
>         const struct option builtin_log_options[] = {
> -               OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
> +               OPT__QUIET(&quiet, N_("suppress diff output")),
>                 OPT_BOOL(0, "source", &source, N_("show source")),
>                 OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
>                 { OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
> @@ -1210,8 +1210,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                             PARSE_OPT_OPTARG, thread_callback },
>                 OPT_STRING(0, "signature", &signature, N_("signature"),
>                             N_("add a signature")),
> -               OPT_BOOLEAN(0, "quiet", &quiet,
> -                           N_("don't print the patch filenames")),
> +               OPT__QUIET(&quiet, N_("don't print the patch filenames")),
>                 OPT_END()
>         };
>
> --
> 1.8.4.rc0.1.g8f6a3e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
