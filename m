Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A6F1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 16:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeCNQsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 12:48:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNQsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 12:48:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id h76so5391126wme.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6P+wCuGevEf/oVvYvDuGKF7uemVAd/TgTxaq3avklPs=;
        b=Eh6ZHiMgAtgjsGcih1i3SF7UsVwmzQ0ffDwQQjURV9ONq4fVgDVmbs+d4hdmb7IpFI
         oTnp/2heEGWo1to0C2FtjKonry2RlJugDOrFcqSI3WytrOiAPQw+5a3JC5sXj3vuEL4P
         DehkT2fxwgwPrr3lroirsheA7e5HGijm8pXLMFwhf8HMv1vWrfcolz0/Ww8rFLKvboLl
         ij3vlI5AUYOlgdHIzgDc6jbGIizmyFgdFjklq6RfThdRoMgFISQ8qsiIrLqazLUFbBoc
         2PtPVL+xdzMc01s4XSIm6EPehEWwz6qg9iTreDcaDEEyH2KwKxRGkeJfrS9dU98bUcFy
         4k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6P+wCuGevEf/oVvYvDuGKF7uemVAd/TgTxaq3avklPs=;
        b=tffFEGq39iiwGJAykqo1IOwdoMwFn11Zx7fsMeUmYnkASnTfnBxkduJAvT6TWjNcNm
         9/itwU8+VMgLGCsteENlcRk+MD3hf3FFGq3zAO0QjsTHc7TIhsZgHmETqg+212+TbJbW
         sW5vN0y0CJ8OhWd6VcPew09NqNW4GFUyGP1Syc/yH649TlvqJgCveP8Zme9fSVOTBVl+
         aAXCgNZEcYQPGkTM5FfoumTk1TrZD08Qdbmr1PjIgjgK+ZFJNcIpucWETmUhiZFQtW9n
         ziH1nvn7XGQJTJP9J2nUj4byo0P1eo+gLTOQjBIpIrCBqv9Wfu53qxhcCeVSkcWMy2FR
         Zxgg==
X-Gm-Message-State: AElRT7GuRBS0G9qvyZHPbOovvJFdQD3wC7tn/5mHLBSkfrFtnOHezdyC
        zaG+Xm9KKijZheGqVelrlqc=
X-Google-Smtp-Source: AG47ELuVG04/+zXnDYy6/SPdKbe7coplh7YEpx3SLmGB5tA7XAnpDVpEa+BWfuA8Pf8c839a5gXVGA==
X-Received: by 10.28.101.85 with SMTP id z82mr2289366wmb.65.1521046111291;
        Wed, 14 Mar 2018 09:48:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m191sm2034528wma.21.2018.03.14.09.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 09:48:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/36] object_id part 12
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
Date:   Wed, 14 Mar 2018 09:48:30 -0700
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 12 Mar 2018 02:27:20 +0000")
Message-ID: <xmqqtvtizjq9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the twelfth in a series of patches to convert various parts of
> the code to struct object_id.
>
> Changes from v2:
> * Rebase onto master (to fix "typename" → "type_name" changes).
> * Replace some uses of hashcpy with memcpy.
> * Replace some instances of "20" with references to the_hash_algo.
>
> Changes from v1:
> * Rebase onto master.
>
> tbdiff output below.
>
> brian m. carlson (36):
>   bulk-checkin: convert index_bulk_checkin to struct object_id
>   builtin/write-tree: convert to struct object_id
>   cache-tree: convert write_*_as_tree to object_id
>   cache-tree: convert remnants to struct object_id
>   resolve-undo: convert struct resolve_undo_info to object_id
>   tree: convert read_tree_recursive to struct object_id
>   ref-filter: convert grab_objectname to struct object_id
>   strbuf: convert strbuf_add_unique_abbrev to use struct object_id
>   wt-status: convert struct wt_status_state to object_id
>   Convert find_unique_abbrev* to struct object_id
>   http-walker: convert struct object_request to use struct object_id
>   send-pack: convert remaining functions to struct object_id
>   replace_object: convert struct replace_object to object_id
>   builtin/mktag: convert to struct object_id
>   archive: convert write_archive_entry_fn_t to object_id
>   archive: convert sha1_file_to_archive to struct object_id
>   builtin/index-pack: convert struct ref_delta_entry to object_id
>   sha1_file: convert read_loose_object to use struct object_id
>   sha1_file: convert check_sha1_signature to struct object_id
>   streaming: convert open_istream to use struct object_id
>   builtin/mktree: convert to struct object_id
>   sha1_file: convert assert_sha1_type to object_id
>   sha1_file: convert retry_bad_packed_offset to struct object_id
>   packfile: convert unpack_entry to struct object_id
>   Convert remaining callers of sha1_object_info_extended to object_id
>   sha1_file: convert sha1_object_info* to object_id
>   builtin/fmt-merge-msg: convert remaining code to object_id
>   builtin/notes: convert static functions to object_id
>   tree-walk: convert get_tree_entry_follow_symlinks internals to
>     object_id
>   streaming: convert istream internals to struct object_id
>   tree-walk: convert tree entry functions to object_id
>   sha1_file: convert read_object_with_reference to object_id
>   sha1_file: convert read_sha1_file to struct object_id
>   Convert lookup_replace_object to struct object_id
>   sha1_file: introduce a constant for max header length
>   convert: convert to struct object_id

As always, thanks for working on this.  

After this series, what jumps at me out of output from

    git grep -e '[^0-9A-Za-z_][24]0[^0-9A-Za-z_]' -- '*.[ch]' \
		':!*sha1*' ':!contrib/' ':!compat/'

are code that parses the incoming patch in apply.c (where the full
blob object names used for binary patches are assumed to be in
SHA-1), builtin/pack-objects.c (where it has to know the current
file format of a packfile intimately) and diff.c (where it clips the
length to which the blob object names on the "index" lines are
abbreviated to).  Changing 40 in the last one to "the hex length of
the currently deployed hash" should be relatively uncontroversial.
