Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33FEA1FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdDIT4J (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:56:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33043 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdDIT4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:56:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id l28so1815586wre.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Ep1DUKzPVZ86x+dl6TileJ0vdQiMThVuhzaFAasF+s=;
        b=Xqg45wCd2rGWeTcRGu3K7w4ET7vKRDy7zK3hy/A//YdhDdESrYX+J3X9lo3g0hAgnJ
         ZYDMZJLLCHGbllJVcw9Hsnhud3SM05ShPIKVg6FWTm2hKsALPTKlukjuxRoaduPLaT3V
         83gQM+TcsE7xZIuJ3uNoln+pbrQR5or7Djelz86mVeUubab+/v7To0oFtrG9wL6LH9Bw
         Tf06g8VixaNffry1YqswHn5BCW237gYA798cZQpcwmD6DzjrTgCf6cHqkPDsJJuOf7e+
         psw4xs9879TlglasC0D9dOlsRlGWXle2uVJ+Xy90odLBWJWEucoAUGqYNk6oipCOX0i8
         xbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3Ep1DUKzPVZ86x+dl6TileJ0vdQiMThVuhzaFAasF+s=;
        b=BSZU7pgwswQZ/kDMMpTtD39cKtbZBM5qMiTSNaglGsMaX11iLUPPZiB2p7CBUbrQ0b
         B0qaCdJ18CBrJlllATzniU3ih2BmtQNlzLZ1gzrIxlVGWpvjGOWKevZQ+dO4lCrfcFxE
         e9y8xQsKd7TYzdheyQLAp91dE+4ia7msTSiCVjTvnDiMqCLJzb+Gm10pOjoO3dhuYsI2
         NUEkzpbg+beW+0o0LISfom5+aVJQBui2y4KTvTy7USsGE2MP0jlCSob1tl1/KSaUPAlM
         4Oa5Vp4XHcVpP7M4CA6RdSsjkltmdIXEIkjzmvo6AWi1YzegV8pOcW+ETGRb+1ki1VZ9
         JBYQ==
X-Gm-Message-State: AN3rC/4wEgDyIy7m3mGJK4dK87FwnTllx8qwHuwaaiWetCrK/3VF7/wf8IzlouChgXS59g==
X-Received: by 10.223.135.7 with SMTP id a7mr5321466wra.103.1491767766329;
        Sun, 09 Apr 2017 12:56:06 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id x127sm7467991wmf.31.2017.04.09.12.56.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:56:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two separate functions
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170407120354.17736-4-benpeart@microsoft.com>
Date:   Sun, 9 Apr 2017 21:56:04 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C977E0BA-8386-4B87-9569-A1C3B9E97B31@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-4-benpeart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Apr 2017, at 14:03, Ben Peart <peartben@gmail.com> wrote:
>=20
> To enable future reuse of the filter.<driver>.process infrastructure,
> split start_multi_file_filter into two separate parts.
>=20
> start_multi_file_filter will now only contain the generic logic to
> manage the creation and tracking of the child process in a hashmap.
>=20
> start_multi_file_filter_fn is a protocol specific initialization
> function that will negotiate the multi-file-filter interface version
> and capabilities.
>=20
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
> convert.c | 63 =
++++++++++++++++++++++++++++++++++++++-------------------------
> 1 file changed, 38 insertions(+), 25 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 793c29ebfd..404757eac9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -565,35 +565,14 @@ static void stop_multi_file_filter(struct =
child_process *process)
> 	finish_command(process);
> }
>=20
> -static struct cmd2process *start_multi_file_filter(struct hashmap =
*hashmap, const char *cmd)
> +static int start_multi_file_filter_fn(struct cmd2process *entry)
> {
> 	int err;
> -	struct cmd2process *entry;
> -	struct child_process *process;
> -	const char *argv[] =3D { cmd, NULL };
> 	struct string_list cap_list =3D STRING_LIST_INIT_NODUP;
> 	char *cap_buf;
> 	const char *cap_name;
> -
> -	entry =3D xmalloc(sizeof(*entry));
> -	entry->cmd =3D cmd;
> -	entry->supported_capabilities =3D 0;
> -	process =3D &entry->process;
> -
> -	child_process_init(process);
> -	process->argv =3D argv;
> -	process->use_shell =3D 1;
> -	process->in =3D -1;
> -	process->out =3D -1;
> -	process->clean_on_exit =3D 1;
> -	process->clean_on_exit_handler =3D stop_multi_file_filter;
> -
> -	if (start_command(process)) {
> -		error("cannot fork to run external filter '%s'", cmd);
> -		return NULL;
> -	}
> -
> -	hashmap_entry_init(entry, strhash(cmd));
> +	struct child_process *process =3D &entry->process;
> +	const char *cmd =3D entry->cmd;
>=20
> 	sigchain_push(SIGPIPE, SIG_IGN);
>=20
> @@ -642,7 +621,41 @@ static struct cmd2process =
*start_multi_file_filter(struct hashmap *hashmap, cons
> done:
> 	sigchain_pop(SIGPIPE);
>=20
> -	if (err || errno =3D=3D EPIPE) {
> +	if (err || errno =3D=3D EPIPE)
> +		err =3D err ? err : errno;

Nice! I should have done this here, too:
=
https://github.com/git/git/blob/b14f27f91770e0f99f64135348977a0ce1c7993a/c=
onvert.c#L755

This is clearly a bug in my code. I'll send a patch shortly.


> +
> +	return err;
> +}
> +
> +static struct cmd2process *start_multi_file_filter(struct hashmap =
*hashmap, const char *cmd)
> +{
> +	int err;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	const char *argv[] =3D { cmd, NULL };
> +
> +	entry =3D xmalloc(sizeof(*entry));
> +	entry->cmd =3D cmd;
> +	entry->supported_capabilities =3D 0;
> +	process =3D &entry->process;
> +
> +	child_process_init(process);
> +	process->argv =3D argv;
> +	process->use_shell =3D 1;
> +	process->in =3D -1;
> +	process->out =3D -1;
> +	process->clean_on_exit =3D 1;
> +	process->clean_on_exit_handler =3D stop_multi_file_filter;
> +
> +	if (start_command(process)) {
> +		error("cannot fork to run external filter '%s'", cmd);
> +		return NULL;
> +	}
> +
> +	hashmap_entry_init(entry, strhash(cmd));
> +
> +	err =3D start_multi_file_filter_fn(entry);
> +	if (err) {
> 		error("initialization for external filter '%s' failed", =
cmd);
> 		kill_multi_file_filter(hashmap, entry);
> 		return NULL;
> --=20
> 2.12.0.windows.1.31.g1548525701.dirty

Looks good to me.

Thanks,
Lars

