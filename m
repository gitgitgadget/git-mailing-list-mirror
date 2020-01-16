Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07398C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F402072E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 23:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gehUikir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgAPXOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:14:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57544 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgAPXOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 18:14:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 271B339133;
        Thu, 16 Jan 2020 18:14:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sa70s+UxFagSk+UT3EaKjF1uFWw=; b=gehUik
        irOHzNLUi1s9absggE66HQomUaIbHkVnAfwjnwr5HzPowdT6RNCFLCLsV3SBfwyM
        Z2v9TfqL1v7MC6nLWuzM5yUKiPdfvA1KM++sXBEVSUHMHOpzaXWiziIzi1hZfGbp
        6IHG6hs4J3KV1hYF7XwMu7wd/T3YPo2lRwKNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kpNf1HhN1Mst07sPRiY7k1xrGvYktc5Z
        ZafANxPAlv/YSAYIkXbWuEuL6NZHgqTpiFICVXCWf4ijAO17zuBkaOkMVL8uwrJg
        UQPw2q0aO4uGTahXAH+9fWmxmkKUURvpXN1r/aIm047+q0z/6IEFpGuiqKI/rzki
        haAiQotCf8s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C8E939131;
        Thu, 16 Jan 2020 18:14:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7923439130;
        Thu, 16 Jan 2020 18:14:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] remote: rename also remotes in the branch.<name>.pushRemote config
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
Date:   Thu, 16 Jan 2020 15:14:11 -0800
In-Reply-To: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Thu, 16 Jan 2020 22:25:26 +0100")
Message-ID: <xmqq7e1rf0zg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8426CB6-38B5-11EA-8AAF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Subject: Re: [PATCH] remote: rename also remotes in the branch.<name>.pushRemote config
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

This is way under-explained.

It is not even clear what "also" in "remote: rename also remotes..."
refers to.  It hints that something that is not "remotes" is
renamed, but the readers do not know what it is.  It is not clear
when that said renaming is done, either.  

Is it supposed to be a bugfix?  If so, readers would need the issue
being addressed described, perhaps like so:

	When X is done, Y is renamed, but at the same time Z should
	also be renamed, but it is not.

> ---
> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c  | 16 ++++++++++++++--
>  t/t5505-remote.sh |  4 +++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 96bbe828fe..ddceba868a 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -246,7 +246,7 @@ static int add(int argc, const char **argv)
>  }
>  
>  struct branch_info {
> -	char *remote_name;
> +	char *remote_name, *push_remote_name;
>  	struct string_list merge;
>  	enum {
>  		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
> @@ -269,13 +269,16 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  		char *name;
>  		struct string_list_item *item;
>  		struct branch_info *info;
> -		enum { REMOTE, MERGE, REBASE } type;
> +		enum { REMOTE, PUSH_REMOTE, MERGE, REBASE } type;

Is there a reason why this new one has to come between REMOTE and
MERGE?  Otherwise, the usual convention is either to add
alphabetically (if the list is sorted alphabetically from the
beginning) or add to the end (otherwise).

>  		size_t key_len;
>  
>  		key += 7;
>  		if (strip_suffix(key, ".remote", &key_len)) {
>  			name = xmemdupz(key, key_len);
>  			type = REMOTE;
> +		} else if (strip_suffix(key, ".pushremote", &key_len)) {
> +			name = xmemdupz(key, key_len);
> +			type = PUSH_REMOTE;
>  		} else if (strip_suffix(key, ".merge", &key_len)) {
>  			name = xmemdupz(key, key_len);
>  			type = MERGE;
> @@ -294,6 +297,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  			if (info->remote_name)
>  				warning(_("more than one %s"), orig_key);
>  			info->remote_name = xstrdup(value);
> +		} else if (type == PUSH_REMOTE) {
> +			if (info->push_remote_name)
> +				warning(_("more than one %s"), orig_key);
> +			info->push_remote_name = xstrdup(value);
>  		} else if (type == MERGE) {
>  			char *space = strchr(value, ' ');
>  			value = abbrev_branch(value);
> @@ -680,6 +687,11 @@ static int mv(int argc, const char **argv)
>  			strbuf_addf(&buf, "branch.%s.remote", item->string);
>  			git_config_set(buf.buf, rename.new_name);
>  		}
> +		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.old_name)) {
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
> +			git_config_set(buf.buf, rename.new_name);
> +		}
>  	}
>  
>  	if (!refspec_updated)
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 883b32efa0..59a1681636 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -737,12 +737,14 @@ test_expect_success 'rename a remote' '
>  	git clone one four &&
>  	(
>  		cd four &&
> +		git config branch.master.pushRemote origin &&
>  		git remote rename origin upstream &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
>  		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
>  		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
> -		test "$(git config branch.master.remote)" = "upstream"
> +		test "$(git config branch.master.remote)" = "upstream" &&
> +		test "$(git config branch.master.pushRemote)" = "upstream"
>  	)
>  '

OK, so the issue the patch wants to address is

	git remote rename X Y

ought to rename branch.X.Z (for any value of Z) to branch.Y.Z but it
forgot to do so for Z==pushRemote?

If that is the case, I have to wonder if the patch is making the
situation better or even worse.  Shouldn't we be not even caring
what Z is by not having to list these specific keys?  I dunno.

