Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDB520D12
	for <e@80x24.org>; Mon, 30 Jan 2017 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbdA3V6Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:58:24 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34571 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbdA3V6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:58:21 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so24335407pfb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ja1Sh+Arpu1ui3+nQ7bA6lvPdCz50yNWBbzZshPgqA8=;
        b=fWgPXAARXQPOdOLlsC2KdAAshONy2ZpbxgIbAtoAqhn2JovYmaWeI9wzy/XsUPY36H
         VAG5O9CKkdRSnwUteuP8mssa9HIi48OTsbOUzwII3gYZ2ESXLsy8rp+cmGTD2FWLOeQ1
         kDGHRfIwp3u1aHdvMSOtc7LKCGGBKX7XwzkdYhePWN903vzzK5YAs4KutwtDD2oqg0iB
         8dZbnbNpS5o5LHYjO2aQ5hSr2+F+A9ZqG14LI8eO61BsTKPCkZvpCvAYsOTRp2TyRhe3
         ftKo5l8AfU2Q+w/LmK4y9+xR9yULbMka6a23ipr8DMgQRGY5xPcVqF+xMEQG+xKPpQOT
         RA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ja1Sh+Arpu1ui3+nQ7bA6lvPdCz50yNWBbzZshPgqA8=;
        b=OOdzxMDda4UbnDJT3T2vTUgyDOB/zUq/jM9nPB0+scJ45P0x/kuwcDsqzWiDKFgsKQ
         Px/2wdyWdOV/9+UG5A8BXjZ7odcrGA2+iNy3XPL/HUTBk4u4hCmNRXVYf89mneDi1zVM
         +eHqygCWdoakESotyHQnTiDmqiCxcx2TJeVZaMN+Tz/gtUU6Q0SqU/n5VeYWXves7425
         tNYKjgSTu3P1D+4hZjnyeEEjr+/vaXglNK+dpOGEtNOdo+3f+C5qxOcoliVB+ZnkJroK
         SJhWEkIo+5U1Ywx19gJhlkW/w9lxAh/tCj42/NEprk1UpPMJMsGfn9/dlhbbissb+eoo
         g03Q==
X-Gm-Message-State: AIkVDXJy6qVSkxfM2k7NL8ibR1IyuSFpaCZ9ns21u/PrK2vmwx7z51K30G9ftNxD+ANbNQ==
X-Received: by 10.99.112.6 with SMTP id l6mr26110272pgc.33.1485813491585;
        Mon, 30 Jan 2017 13:58:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id m6sm35024095pfm.22.2017.01.30.13.58.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:58:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
        <20170127100948.29408-1-cornelius.weig@tngtech.com>
        <20170127100948.29408-2-cornelius.weig@tngtech.com>
Date:   Mon, 30 Jan 2017 13:58:10 -0800
In-Reply-To: <20170127100948.29408-2-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Fri, 27 Jan 2017 11:09:47 +0100")
Message-ID: <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> Notes:
>     Changes wrt v2:
>     
>      - change wording in commit message s/do not typically/are not meant to/;
>      - in update_refs_for_switch move refname to the enclosing block, so that
>        should_autocreate_reflog has access. Thanks Junio for spotting this
>        potential bug early :)
>      - add test that asserts reflogs are created for tags if
>        logAllRefUpdates=always. The case with logAllRefUpdates=true is IMHO already
>        covered by the default case. To make that clearer, I explicitly added
>        logAllRefUpdates=true.

These look all sensible.  Especially thanks for reordering the code
to feed the real refname for the new branch in the "checkout"
codepath.

>     When writing the test for git-tag, I realized that the option
>     --no-create-reflog to git-tag does not take precedence over
>     logAllRefUpdate=always. IOW the setting cannot be overridden on the command
>     line. Do you think this is a defect or would it not be desirable to have this
>     feature anyway?

"--no-create-reflog" should override the configuration set to "true"
or "always".  Also "--create-reflog" should override the
configuration set to "false".

If the problem was inherited from the original code before your
change (e.g. you set logAllRefUpdates to true and then did
"update-ref --no-create-reflog refs/heads/foo".  Does the code
before your change ignore the command lne option and create a reflog
for the branch?), then it would be ideal to fix the bug before this
series as a preparatory fix.  If the problem was introduced by this
patch set, then we would need a fix not to introduce it ;-)

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfe685c..81ea2ed 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -612,14 +612,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	const char *old_desc, *reflog_msg;
>  	if (opts->new_branch) {
>  		if (opts->new_orphan_branch) {
> -			if (opts->new_branch_log && !log_all_ref_updates) {
> +			const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
> +			if (opts->new_branch_log && should_autocreate_reflog(refname)) {
>  				int ret;
> -				char *refname;
>  				struct strbuf err = STRBUF_INIT;
>  
> -				refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
>  				ret = safe_create_reflog(refname, 1, &err);
> -				free(refname);
>  				if (ret) {
>  					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
>  						opts->new_orphan_branch, err.buf);

Here you need to have another free(), as this block makes an early
return and you end up leaking refname.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 1cfa8a2..1bf622d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -71,6 +71,7 @@ test_expect_success 'creating a tag for an unknown revision should fail' '
>  
>  # commit used in the tests, test_tick is also called here to freeze the date:
>  test_expect_success 'creating a tag using default HEAD should succeed' '
> +	test_config core.logAllRefUpdates true &&
>  	test_tick &&
>  	echo foo >foo &&
>  	git add foo &&

This change is to make sure that 'true' does not affect tags (but
'always' does as seen in the later new test)?  I am just double
checking, not objecting.

Thanks.
