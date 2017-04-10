Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC5E20970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdDJKSt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:18:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34412 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbdDJKSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:18:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so20531093wrc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nzt2DjpGukTlaQTIlDAYgV4RMSao22j1SFvQU2t5MWo=;
        b=nfS3raxtEsaA4XYWj4p6H4QiYJaK6StO8+v+O4wvjkaO3YrNFIOOjpUiABEQt54iMS
         lUc8QJXcGX8N8wG6m/X1mBG1FV4X+Nz7n6o+63NnjV3odR/aMLLGJqlZqjM0nlMGpt7l
         J9SGTNOrzJUCIaPyK5QKi9+3NdhuVF0ECG/axp7lttzErb9/llnpAKBfsJ3ScM6hs121
         FqG62MwSD/SW0a6HpiWM7D334d3WVH48SdwwFigh0Scs1HVTndaH5tVVZYBPFI9ze92Z
         cdXxSTIADkd/n8DABLxfPSnFt5QnORRZVKsCmDLvHkwB4/bp0r5TYGrLGkBDBed0V0H/
         flfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nzt2DjpGukTlaQTIlDAYgV4RMSao22j1SFvQU2t5MWo=;
        b=E+PNon8s0+Hnja/O/DxYrtNMqpnD1x8V3UUdJIogIa6z3PNbNu5sydSSp76muDKRQC
         40aOoaYljYyqwhw+s6oMi0z7wkzweT42JOkax5Qi69oRvAPGE0N8Ox4BNxQlRoold+HT
         qsiXBiWfn1SA3K6VXPRcsyHTbrjMc4SSpduPVpX0OQ+a0k//dqC5THYvMNICs6U1a3LR
         qGGEzVVhWri6zbNCoR5nPK9JGY6gdYC21utHkTh59kIJOl9SLiBeCwiuNKvZysDq8UNs
         dmiwOWulkzQA4fKKHGBR2ZSw7GYzWOpZXRe2mjjEGqH1bK/HIVkoJhoMrVvXiS4XU9fE
         DBcA==
X-Gm-Message-State: AFeK/H3EKSMFA802m3r4zDBxQq5maHUDVzveAwMYfpYnZ6l91/ButLnQ7s/vKl+gHsXnOA==
X-Received: by 10.223.153.233 with SMTP id y96mr28940340wrb.96.1491819526999;
        Mon, 10 Apr 2017 03:18:46 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id m83sm9698575wmc.7.2017.04.10.03.18.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 03:18:46 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/8] convert: Separate generic structures and variables from the filter specific ones
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-5-benpeart@microsoft.com>
Date:   Mon, 10 Apr 2017 12:18:45 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
        benpeart@microsoft.com, christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-5-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> To enable future reuse of the filter.<driver>.process infrastructure,
> split the cmd2process structure into two separate parts.
>=20
> subprocess_entry will now contain the generic data required to manage
> the creation and tracking of the child process in a hashmap. Also move
> all knowledge of the hashmap into the generic functions.
>=20
> cmd2process is a filter protocol specific structure that is used to
> track the negotiated capabilities of the filter.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c | 57 =
+++++++++++++++++++++++++++++++--------------------------
> 1 file changed, 31 insertions(+), 26 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 404757eac9..f569026511 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -496,29 +496,40 @@ static int apply_single_file_filter(const char =
*path, const char *src, size_t le
> #define CAP_CLEAN    (1u<<0)
> #define CAP_SMUDGE   (1u<<1)
>=20
> -struct cmd2process {
> +struct subprocess_entry {
> 	struct hashmap_entry ent; /* must be the first member! */
> -	unsigned int supported_capabilities;
> 	const char *cmd;
> 	struct child_process process;
> };
>=20
> +struct cmd2process {
> +	struct subprocess_entry subprocess; /* must be the first member! =
*/
> +	unsigned int supported_capabilities;
> +};
> +
> static int cmd_process_map_initialized;
> static struct hashmap cmd_process_map;
>=20
> -static int cmd2process_cmp(const struct cmd2process *e1,
> -			   const struct cmd2process *e2,
> +static int cmd2process_cmp(const struct subprocess_entry *e1,
> +			   const struct subprocess_entry *e2,
> 			   const void *unused)
> {
> 	return strcmp(e1->cmd, e2->cmd);
> }
>=20
> -static struct cmd2process *find_multi_file_filter_entry(struct =
hashmap *hashmap, const char *cmd)
> +static struct subprocess_entry *find_multi_file_filter_entry(const =
char *cmd)

I am curious why you removed the hashmap parameter (here and in other =
pars of this patch).=20
I know the parameter is not strictly necessary as the hashmap is a =
global variable anyways.=20
However, I think it eases code maintainability in the long run if a =
function is "as pure as=20
possible" (IOW does rely on global state as less as possible).

As I consider this personal preference I think either way is fine.


> {
> -	struct cmd2process key;
> +	struct subprocess_entry key;
> +
> +	if (!cmd_process_map_initialized) {
> +		cmd_process_map_initialized =3D 1;
> +		hashmap_init(&cmd_process_map, =
(hashmap_cmp_fn)cmd2process_cmp, 0);
> +		return NULL;
> +	}
> +

I am a bit in doubt about this one. If the process map was not =
initialized yet, then
I would expect "find_multi_file_filter_entry" to return NULL. Creating =
the hash
map as side effect seems a bit unexpected to me.=20

The rest of the patch looks good to me.

Thanks,
Lars=
