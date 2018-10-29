Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7EA81F454
	for <e@80x24.org>; Mon, 29 Oct 2018 05:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeJ2OBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:01:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33274 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2OBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:01:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so7207466wrn.0
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=L6fIMJyuRXcAh4xjzAjFeggGTw7TO8nOmTg7/qLGtNg=;
        b=aN7bpjB/07XwoiVhuo2mziCbcBATp6aP2BZyRD8ftyH+AwVCiX918Escqrrn//RKOp
         EfzYmHlaGmaXyG/AHV04OxdBstwpSzfe7tBIq3dPwvVJHgtKHQF5csuH24DmiXd3BzoB
         qJZbQ1MSns1axiukKGaOagGF0AJfRE35lA3/OhoMniWb8Gpcitc2WoTTcYkT8zTtxtgW
         dIcK62I6dnjBhcNdqWgN74J4VvjxbHuXNoEUmrHBnkWr1CB4hg7TGUNBuXYr9SFW7bCc
         GKFPHPaWNUNy5imP2+RNs0k+OCbhfPAr2KzzsGycXnyvR71vFPo6qgKzI0GvuqW4YDDO
         5uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=L6fIMJyuRXcAh4xjzAjFeggGTw7TO8nOmTg7/qLGtNg=;
        b=kC00pDC4a8IVpN8MCBcDYhrI9y+o+WfQJdbK0iDF985aaEv0hqEfhcgA+Nu2KSsjbI
         V+8u4QbnIEDFRam3IS6O1WvFWHucTmJkTJt89G/VQM2POgRUNmJgU2BLb7nIrU/ngUsw
         UB1ZmTPJl3jEH+5rGXGQIzlxIUO0bTsO9/ZPvSLNiPan3OytKX+mDXGVOfL5SZhWBN4/
         49ImQyNZwz5L3tV6I+6+ucQuhbKGnTWav/YuUhjpxTXNWx/xDIyr7N2fUCLTYyHyxEtg
         RIO5WTnvDiISAOaRhsNQK9Df8xyl+g0bkwl49tBjad0glBHI3haybUdUGZ9axqEAIMPp
         lNCw==
X-Gm-Message-State: AGRZ1gLSinrsBau8pzvXkCYFkikoU7UFiMkW5O78kbmCqRnMsEQVfVV3
        JOp/Cl6Z+qqAKzQVwBZhImY=
X-Google-Smtp-Source: AJdET5cVdoNGh9vOvpeVPc6wU+ujvBzQtvvNUwECIo/+lyYqv6Q4rQuy8OTyp+QwvcK49sG28mFsOA==
X-Received: by 2002:adf:eb02:: with SMTP id s2-v6mr13991522wrn.201.1540790044578;
        Sun, 28 Oct 2018 22:14:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 195-v6sm12580990wmx.21.2018.10.28.22.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:14:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 5/8] push: add an advice on unqualified <dst> push
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-6-avarab@gmail.com>
Date:   Mon, 29 Oct 2018 14:14:02 +0900
In-Reply-To: <20181026230741.23321-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Oct 2018 23:07:38 +0000")
Message-ID: <xmqqva5l49np.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +	if (!advice_push_unqualified_ref_name)
> +		return;
> +
> +	if (get_oid(matched_src_name, &oid))
> +		BUG("'%s' is not a valid object, "
> +		    "match_explicit_lhs() should catch this!",
> +		    matched_src_name);
> +	type = oid_object_info(the_repository, &oid, NULL);
> +	if (type == OBJ_COMMIT) {
> +		advise(_("The <src> part of the refspec is a commit object.\n"
> +			 "Did you mean to create a new branch by pushing to\n"
> +			 "'%s:refs/heads/%s'?"),
> +		       matched_src_name, dst_value);

Good, except that "git push $there notes/commits^0:newnotes" may not
want to become a branch and neither may "git push $there stash:wip",
I think it is a reasonable piece of advice we'd give by default.

I do not think it is worth the effort of inspecting the tree of the
commit object to special case notes and stash ;-)

> +	} else if (type == OBJ_TAG) {
> +		advise(_("The <src> part of the refspec is a tag object.\n"
> +			 "Did you mean to create a new tag by pushing to\n"
> +			 "'%s:refs/tags/%s'?"),
> +		       matched_src_name, dst_value);

Good.

> +	} else if (type == OBJ_TREE) {
> +		advise(_("The <src> part of the refspec is a tree object.\n"
> +			 "Did you mean to tag a new tree by pushing to\n"
> +			 "'%s:refs/tags/%s'?"),
> +		       matched_src_name, dst_value);
> +	} else if (type == OBJ_BLOB) {
> +		advise(_("The <src> part of the refspec is a blob object.\n"
> +			 "Did you mean to tag a new blob by pushing to\n"
> +			 "'%s:refs/tags/%s'?"),
> +		       matched_src_name, dst_value);

These two are questionable, but assuming that heads and tags are the
only two hiearchies people would push into, they are acceptable
choices.

> +	} else {
> +		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
> +		    matched_src_name, type);
> +	}
>  }
>  
>  static int match_explicit(struct ref *src, struct ref *dst,
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index d2a2cdd453..2e58721f98 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1222,4 +1222,29 @@ test_expect_success 'add remote matching the "insteadOf" URL' '
>  	git remote add backup xyz@example.com
>  '
>  
> +test_expect_success 'unqualified <dst> refspec DWIM and advice' '
> +	test_when_finished "(cd test && git tag -d some-tag)" &&
> +	(
> +		cd test &&
> +		git tag -a -m "Some tag" some-tag master &&
> +		for type in commit tag tree blob
> +		do
> +			if test "$type" = "blob"
> +			then
> +				oid=$(git rev-parse some-tag:file)
> +			else
> +				oid=$(git rev-parse some-tag^{$type})
> +			fi &&
> +			test_must_fail git push origin $oid:dst 2>err &&
> +			test_i18ngrep "error: The destination you" err &&
> +			test_i18ngrep "hint: Did you mean" err &&
> +			test_must_fail git -c advice.pushUnqualifiedRefName=false \
> +				push origin $oid:dst 2>err &&
> +			test_i18ngrep "error: The destination you" err &&
> +			test_i18ngrep ! "hint: Did you mean" err

Any failure in the &&-chain (or the last grep) would not terminate
the for loop, so for the purpose of determining the success of this
test_expect_success, the last "blob" iteration is the only thing
that matters.

Which is probably not what you want.  If testing all of these is
important, then you can do this:

	(
		exit_with=true &&
		for type in ...
		do
			... many ... &&
			... many ... &&
			... tests ... ||
			exit_with=false
		done
		$exit_with
	)

or just say "|| exit" and leave the loop (and the subprocess running
it) early on the first failure.

> +		done
> +	)
> +'
> +
> +
>  test_done
