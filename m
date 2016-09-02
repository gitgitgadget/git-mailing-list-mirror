Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934561FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbcIBThU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:37:20 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35786 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbcIBThS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:37:18 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so5888463pad.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IfovZ701AAzEE0N26xjucdorhdnrnPfQDIgUaftFhBQ=;
        b=V3aaIdEf/biro+gBYhWQc3NPmDLg7vwT3GGnDI1JlD1zD1wylaNprx/4ZEpTd+dadu
         9At3j+PPaWqdNW5bXNIfND6PvqbzYKvjLjslA1n48AAeOaY5r6M+PlRIyfDrzzBrQ7Q6
         BgINYYxqFmHLqq7BOYjbK4KYMkRRAgI1taUvdtfd4b7+VntQs6ahrc0b68uYobQB+5QG
         +4lqLUvGN8XrsPiE3QaM8My1Emfvac3Nk7xGBKxp6G4i3wwdeE7sCfVq7CyU20So9aYD
         gjoidkh/18gSaIg1bQlOFzE+R4olQE9otKkgyecoOgQWfcIVU7StPxnBcDQ9lLvDmqNJ
         GPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfovZ701AAzEE0N26xjucdorhdnrnPfQDIgUaftFhBQ=;
        b=PlxxhcjXecu4bDWJbtnDl/iqfosGs4CI9zIQhhWhM7ji9FTx6fHHrFL8TdDe/zNc32
         zqd+uM309p9vDku27/taaXqiD0xetTUV5QGcHOjIo3FE/NdUAEMGxjywu7+0KYcnTfWQ
         lBCRglqqiTgSYPglLlxxBK504r449UZZCI5FGNJ17mkgvv4wpr4q7bh17v2voTHfxdZ2
         DcE3MeyIerezatw+ochYItMrfiKH11qZcHjdxPoNC90290xpAsLeo/c3HlfWIpHztCyw
         be4g0y/cXJT1LM9a7nCjkW2KRH2pY3rK4cMKGwuWqBA5+cD/fFj+OovnLIylz1ueQcJV
         0cyw==
X-Gm-Message-State: AE9vXwNwlFlk6TxC3ZdW3cfRbVNKP+CffYv2pwqnGYbcY25OHihyY61CP8eqtWLicM9Nkg==
X-Received: by 10.66.182.136 with SMTP id ee8mr38712813pac.137.1472845037678;
        Fri, 02 Sep 2016 12:37:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:34:ec2f:e9e8:7f87])
        by smtp.gmail.com with ESMTPSA id vy9sm16690480pab.22.2016.09.02.12.37.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 12:37:16 -0700 (PDT)
Date:   Fri, 2 Sep 2016 12:37:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] connect: know that zero-ID is not a ref
Message-ID: <20160902193714.GF14758@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bea354c6218a33db3972e42baa75676fdcbc598.1472836026.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> connect.c, when processing packfiles, treats a zero ID (with
> `capabilities^{}` in place of the refname) as an actual ref instead of a
> placeholder for a capability declaration, contrary to the specification
> in Reference Discovery in Documentation/technical/pack-protocol.txt.
> This is an issue when interacting with Git implementations that follow
> this specification. For example, `ls-remote` (against a git://
> repository served by such a Git implementation) will report a ref when
> there are none, and `clone` (against something similar) will fail its
> checkout.

For example, this means I get the following confusing message when
cloning an empty repository served by "jgit daemon":

 $ git clone https://googlers.googlesource.com/jrn/empty
 Cloning into 'empty'...
 Checking connectivity... done.
 warning: remote HEAD refers to nonexistent ref, unable to checkout.

 $

It also means that standard "git daemon" is not able to advertise
capabilities on a fetch from a repository without advertising some
refs, so I cannot fetch-by-sha1 from a C git server unless some refs
are advertised.

This fix should solve the former problem and paves the way for the
latter to be solved once a year or two passes and people's clients are
up to date (or earlier if a server operator chooses).

> Make connect.c follow the specification with respect to this, while
> maintaining compatibility with existing implementations that do not
> serve the zero ID when a repository has no refs.

This description focuses on the code.  When deciding whether to apply
the patch (or whether to revert it if it comes up while trying to
investigate another problem), I am likely to wonder "what effect will
the patch have on me?" instead of "what standards does it follow?"

Flipping the emphasis, we could say something like

	connect: treat ref advertisement with capabilities^{} line as one with no refs

	When cloning an empty repository served by standard git, "git clone"
	produces the following reassuring message:

		$ git clone git://localhost/tmp/empty
		Cloning into 'empty'...
		warning: You appear to have cloned an empty repository.
		Checking connectivity... done.
	
	Meanwhile when cloning an empty repository served by JGit, the output
	is more haphazard:

		$ git clone git://localhost/tmp/empty
		Cloning into 'empty'...
		Checking connectivity... done.
		warning: remote HEAD refers to nonexistent ref, unable to checkout.

	This is a common command to run immediately after creating a remote
	repository as preparation for adding content to populate it and pushing.
	The warning is confusing and needlessly worrying.

	The cause is that, since v3.1.0.201309270735-rc1~22 (Advertise capabilities
	with no refs in upload service., 2013-08-08), JGit's ref advertisement
	includes a ref named capabilities^{} to advertise its refs on, while git's
	ref advertisement is empty in this case.  This allows the client to learn
	about the server's capabilities and is need, for example, for fetch-by-sha1
	to work when no refs are advertised.

	Git advertises the same capabilities^{} ref in its ref advertisement for
	push but since it never remembered to do so for fetch, the client forgot
	to handle this case. Handle it.

	So now you can see the same friendly message whether the server runs C
	git or JGit.

	The pack-protocol.txt documentation gives some guidance about the expected
	server behavior: what JGit does is currently required, since a list-of-refs
	is required to be non-empty.

		  advertised-refs  =  (no-refs / list-of-refs)
				      *shallow
				      flush-pkt

		  no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
				      NUL capability-list)

		  list-of-refs     =  first-ref *other-ref

	Because git client versions without this fix are expected to exist in the
	wild for a while, we should not change the server to always send the
	capabilities^{} line when there are no refs to advertise yet.  A transition
	will take multiple steps:

	 1. This patch, which updates the client

	 2. Update pack-protocol to clarify that both server behaviors must be
	    tolerated.

	 3. Add a configuration variable to allow git upload-pack to advertise
	    capabilities when there are no refs to advertise.  Leave it disabled
	    by default since git clients can't be counted on to have this patch (1)
	    yet.

	 4. After a year or so, flip the default for that server configuration
	    variable to true.

[...]
> --- a/connect.c
> +++ b/connect.c
> @@ -165,6 +165,13 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			continue;
>  		}
>  
> +		if (is_null_oid(&old_oid)) {
> +			if (strcmp(name, "capabilities^{}"))
> +				warning("zero object ID received that is not accompanied by a "
> +				        "capability declaration, ignoring and continuing anyway");
> +			continue;
> +		}

I'd rather this be stricter.  Though it's not your fault: the code
before it is very lax in letting each line specify capabilities again.

Could this behave more like the ".have" case?  That is, just

		if (!strcmp(name, "capabilities^{}"))
			continue;

Or if we want to sanity-check the line further,

		if (!strcmp(name, "capabilities^{}")) {
			if (len == name_len + GIT_SHA1_HEX_SZ + 1)
				die("protocol error: expected capabilities after nul, got none");
			if (!is_null_oid(&old_oid))
				die("protocol error: expected zero-id, got %s", oid_to_hex(&old_oid));
			continue;
		}

The protocol definition and other clients already handle capabilities^{} differently
from other cases of zero-id.

[...]
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -207,5 +207,27 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
[...]
> +test_expect_success JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
> +	JGIT_DAEMON_PID= &&
> +	git init --bare empty.git &&
> +	touch empty.git/git-daemon-export-ok &&
> +	{
> +		jgit daemon --port="$JGIT_DAEMON_PORT" . &
> +		JGIT_DAEMON_PID=$!
> +	} &&
> +	test_when_finished kill "$JGIT_DAEMON_PID" &&
> +	sleep 1 && # allow jgit daemon some time to set up

Can this sleep be avoided?  E.g. start_git_daemon in lib-git-daemon.sh
uses output from the daemon to tell when it is serving.

Thanks for writing this.  I'll be happy when this protocol blip is gone.

Sincerely,
Jonathan
