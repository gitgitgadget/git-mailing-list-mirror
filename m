Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7E42047F
	for <e@80x24.org>; Mon,  7 Aug 2017 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdHGQau (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 12:30:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34139 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdHGQat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 12:30:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id t86so851238pfe.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IzNYTq89sb7Naf5nFFR2tilT60ISexkoX3/nrcGaZdE=;
        b=dq92dF94XsyoL9DNevAJ8EryM8WUMcZmuPP/r79mhqc7vyATYYymPL8KL0990HV5Du
         n1KSXpM/KIUF4BzyDuQpzDnjuIDVUeG1WVe+hKbzOkJzpKLzjX/JaCDe5rgnIswQqCPG
         zNqgw+Ci5F3Qzt9+gqa3PWGkyB7I+h+oluQSrfiqSsRRvGM2CiZAspuk4lnNw9UJBdUg
         wJCB37fVqpgyly4tGG7D5E/YTK0u4NrLQaQeAUyvJuzTtzhq981aXlENvhza/tZRplqm
         HJQQURZ8obJFETsR4d1hpycTYze4NQckCM3G7tf8q+rhmkqbznAB2Y8BjBGnd5r0dwM0
         Hz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IzNYTq89sb7Naf5nFFR2tilT60ISexkoX3/nrcGaZdE=;
        b=kEC3bH7ybjsmmiTct2wRL7YyeSUpMUbkPveWpF966lHurzugSsWHS6UJMSezUcFUaE
         ED0I6fpJhVrkwS03GjI+p1OAZG4yCqEDqFs8n/qtPikzhVoGs2JQrqxdeJJ1QxjQb26f
         9SRenPlthcqSjKrhAynpm2O3hDnfW61PZmhH8db72dGhaULtaeLPWoVSF5GQSSBfySVb
         08NfY4sintN+7QBOy33aPAsCG+mDVBMPvWtqHcR1XthJhF6fL3ZfGAEyT0Exue+6yxBi
         ChCdYXSFyWeLB2Fh6khdS+k5xa0UXKCn/uDpvamrDBKdPE+OiapPkuZgI4WlanQPzrvF
         R66Q==
X-Gm-Message-State: AHYfb5jPHai0QZ3zQaOXU5xSjh/KV0C3vQdVJ8Cz5Nzkb8j1zbEP14cs
        +BV9lZPAmgqgswH8khwkJ7abYM8K/ePP
X-Received: by 10.98.35.147 with SMTP id q19mr1199919pfj.242.1502123449258;
 Mon, 07 Aug 2017 09:30:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 7 Aug 2017 09:30:48 -0700 (PDT)
In-Reply-To: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 Aug 2017 18:30:48 +0200
Message-ID: <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if needed
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 August 2017 at 16:03, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index b2d0b849b..38b3c817e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -926,6 +926,29 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
>         return 0;
>  }
>
> +static void server_fill_credential(struct imap_server_conf *srvc)
> +{
> +       struct credential cred = CREDENTIAL_INIT;
> +
> +       if (srvc->user && srvc->pass)
> +               return;
> +
> +       cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
> +       cred.host = xstrdup(srvc->host);
> +
> +       cred.username = xstrdup_or_null(srvc->user);
> +       cred.password = xstrdup_or_null(srvc->pass);
> +
> +       credential_fill(&cred);
> +
> +       if (!srvc->user)
> +               srvc->user = xstrdup(cred.username);
> +       if (!srvc->pass)
> +               srvc->pass = xstrdup(cred.password);
> +
> +       credential_clear(&cred);
> +}
> +
>  static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
>  {
>         struct credential cred = CREDENTIAL_INIT;
> @@ -1078,20 +1101,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>                 }
>  #endif
>                 imap_info("Logging in...\n");
> -               if (!srvc->user || !srvc->pass) {
> -                       cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
> -                       cred.host = xstrdup(srvc->host);
> -
> -                       cred.username = xstrdup_or_null(srvc->user);
> -                       cred.password = xstrdup_or_null(srvc->pass);
> -
> -                       credential_fill(&cred);
> -
> -                       if (!srvc->user)
> -                               srvc->user = xstrdup(cred.username);
> -                       if (!srvc->pass)
> -                               srvc->pass = xstrdup(cred.password);
> -               }
> +               server_fill_credential(srvc);
>
>                 if (srvc->auth_method) {
>                         struct imap_cmd_cb cb;

"cred.username" is checked further down, but now it will always be NULL,
no?
