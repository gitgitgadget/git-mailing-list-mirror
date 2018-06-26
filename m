Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A3551F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeFZRxv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:53:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40955 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeFZRxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:53:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so3551977plo.7
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lPq1auCyrMJd4mogbYbVjtDft1s0DcVvKIPk0KZFEw=;
        b=rMwuNd5oNrMASJQT/jILabAbz4bn9S+yAIt8J4+runVqxXtnVoud8Rt9RK42JP3rJ7
         yn2TIUlVYps2viZMcjhYv0c6rs6B0y9ThOpYN+nz/us7bMNJITU4cgzwf5pxN8atKxOM
         72XhpOXWN8Js/9FneWDFinqO+DqsZZ8U+jXtb8asQj7fTdZcYu+bYeqyNoMjTgm6/bF2
         wf3h1YycNPXcPu+1MS07JG8EWDkyk/qEWXskt1Kh/4wBdRP8+06Ador8EUiDo1tQvsNK
         CTE//LHggl5H+MZDXNnysTlcwsTtnryalToZYZhwUOhGwXICqsdMxiw6h8FOGl/aSRte
         l4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lPq1auCyrMJd4mogbYbVjtDft1s0DcVvKIPk0KZFEw=;
        b=CNNNNs/Bg7yRubED0x/uGyOo/V/SIVf0D2S1hIvniqiKCPDU7A3mqcyiIBa3XMDpZP
         GMkWTECvBav743DUpJvQeIU4BGh2RdFFJ3DpNecx2Usm7xyy+nr9JwZ9S9chgz/KZ+/q
         YWHW4ViBZVWOEGjQhwQojcv9X/jJTOZ33vVqK9I6SQhhIAdO8De4CG3h/DnT7Ix85oVn
         GSfzBd1FWEMq4A4j6O/M0cupTcCoEql+zE0lxyrZtZRd9N4oAX1+a/gR3qwOi6SrxGa3
         eR28pDvFAFBHtopjLf+Am7byECOXl0O1e2WC4Se5pVyAICE5VmMDY/KVo2S/REfV7Fwu
         auSQ==
X-Gm-Message-State: APt69E3usnim1p2G0hjrtCJ3aktaW2X8gMXDZf4N6+zsIM7BteDHLJEF
        s9adF/yRIbZYmWFGUwXf1p0=
X-Google-Smtp-Source: ADUXVKK07MiGvtEFNqU/s2YHaabU9mmeenSY396fSNkIZtOYU5IK5BteaA8kTCu0ZsYNMOTw6QhJ1A==
X-Received: by 2002:a17:902:e209:: with SMTP id ce9-v6mr2574966plb.233.1530035629439;
        Tue, 26 Jun 2018 10:53:49 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c74-v6sm3946139pfd.19.2018.06.26.10.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:53:48 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:53:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH] fetch-pack: support negotiation tip whitelist
Message-ID: <20180626175324.GA12488@aiede.svl.corp.google.com>
References: <20180625193752.255319-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625193752.255319-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> During negotiation, fetch-pack eventually reports as "have" lines all
> commits reachable from all refs. Allow the user to restrict the commits
> sent in this way by providing a whitelist of tips; only the tips
> themselves and their ancestors will be sent.
>
> This feature is only supported for protocols that support connect or
> stateless-connect (such as HTTP with protocol v2).
>
> This will speed up negotiation when the repository has multiple
> relatively independent branches (for example, when a repository
> interacts with multiple repositories, such as with linux-next [1] and
> torvalds/linux [2]), and the user knows which local branch is likely to
> have commits in common with the upstream branch they are fetching.
>
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/
> [2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Very neat.  Thanks to Greg Thelen and Michel Lespinasse (cc-ed) for
this suggestion.

> This is based on jt/fetch-pack-negotiator, but if that branch is
> undesirable for whatever reason, I can port this to master.
>
>  builtin/fetch.c    | 21 ++++++++++++++++++
>  fetch-pack.c       | 19 ++++++++++++++--
>  fetch-pack.h       |  7 ++++++
>  t/t5510-fetch.sh   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  transport-helper.c |  3 +++
>  transport.c        |  1 +
>  transport.h        | 10 +++++++++
>  7 files changed, 114 insertions(+), 2 deletions(-)

Small nit: could this be documented in Documentation/fetch.txt as well?

Thanks,
Jonathan

Patch left unsnipped for reference.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ea5b9669a..12daec0f3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -63,6 +63,7 @@ static int shown_url = 0;
>  static struct refspec refmap = REFSPEC_INIT_FETCH;
>  static struct list_objects_filter_options filter_options;
>  static struct string_list server_options = STRING_LIST_INIT_DUP;
> +static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
>  
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
> @@ -174,6 +175,8 @@ static struct option builtin_fetch_options[] = {
>  			TRANSPORT_FAMILY_IPV4),
>  	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
>  			TRANSPORT_FAMILY_IPV6),
> +	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
> +			N_("report that we have only objects reachable from this object")),
>  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>  	OPT_END()
>  };
> @@ -1075,6 +1078,24 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
>  			   filter_options.filter_spec);
>  		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
>  	}
> +	if (negotiation_tip.nr) {
> +		struct oid_array *oids;
> +		if (transport->smart_options) {
> +			int i;
> +			oids = xcalloc(1, sizeof(*oids));
> +			for (i = 0; i < negotiation_tip.nr; i++) {
> +				struct object_id oid;
> +				if (get_oid(negotiation_tip.items[i].string,
> +					    &oid))
> +					die("%s is not a valid object",
> +					    negotiation_tip.items[i].string);
> +				oid_array_append(oids, &oid);
> +			}
> +			transport->smart_options->negotiation_tips = oids;
> +		} else {
> +			warning("Ignoring --negotiation-tip because the protocol does not support it.");
> +		}
> +	}
>  	return transport;
>  }
>  
> diff --git a/fetch-pack.c b/fetch-pack.c
> index ba12085c4..c66bd49bd 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -213,6 +213,21 @@ static int next_flush(int stateless_rpc, int count)
>  	return count;
>  }
>  
> +static void mark_tips(struct fetch_negotiator *negotiator,
> +		      const struct oid_array *negotiation_tips)
> +{
> +	int i;
> +	if (!negotiation_tips) {
> +		for_each_ref(rev_list_insert_ref_oid, negotiator);
> +		return;
> +	}
> +
> +	for (i = 0; i < negotiation_tips->nr; i++)
> +		rev_list_insert_ref(negotiator, NULL,
> +				    &negotiation_tips->oid[i]);
> +	return;
> +}
> +
>  static int find_common(struct fetch_negotiator *negotiator,
>  		       struct fetch_pack_args *args,
>  		       int fd[2], struct object_id *result_oid,
> @@ -230,7 +245,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>  	if (args->stateless_rpc && multi_ack == 1)
>  		die(_("--stateless-rpc requires multi_ack_detailed"));
>  
> -	for_each_ref(rev_list_insert_ref_oid, negotiator);
> +	mark_tips(negotiator, args->negotiation_tips);
>  	for_each_cached_alternate(negotiator, insert_one_alternate_object);
>  
>  	fetching = 0;
> @@ -1295,7 +1310,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			else
>  				state = FETCH_SEND_REQUEST;
>  
> -			for_each_ref(rev_list_insert_ref_oid, &negotiator);
> +			mark_tips(&negotiator, args->negotiation_tips);
>  			for_each_cached_alternate(&negotiator,
>  						  insert_one_alternate_object);
>  			break;
> diff --git a/fetch-pack.h b/fetch-pack.h
> index bb45a366a..1859ee927 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -16,6 +16,13 @@ struct fetch_pack_args {
>  	const struct string_list *deepen_not;
>  	struct list_objects_filter_options filter_options;
>  	const struct string_list *server_options;
> +
> +	/*
> +	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
> +	 * lines only with these tips and their ancestors.
> +	 */
> +	const struct oid_array *negotiation_tips;
> +
>  	unsigned deepen_relative:1;
>  	unsigned quiet:1;
>  	unsigned keep_pack:1;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a..ea1b5e53c 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -865,4 +865,59 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
>  	test_cmp expect actual
>  '
>  
> +negotiator_tip () {
> +	SERVER="$1"
> +	URL="$2"
> +	USE_PROTOCOL_V2="$3"
> +
> +	rm -rf "$SERVER" client &&
> +	git init "$SERVER" &&
> +	test_commit -C "$SERVER" alpha_1 &&
> +	test_commit -C "$SERVER" alpha_2 &&
> +	git -C "$SERVER" checkout --orphan beta &&
> +	test_commit -C "$SERVER" beta_1 &&
> +	test_commit -C "$SERVER" beta_2 &&
> +
> +	git clone "$URL" client &&
> +
> +	if [ "$USE_PROTOCOL_V2" -eq 1 ]
> +	then
> +		git -C "$SERVER" config protocol.version 2
> +		git -C client config protocol.version 2
> +	fi &&
> +
> +	test_commit -C "$SERVER" beta_s &&
> +	git -C "$SERVER" checkout master &&
> +	test_commit -C "$SERVER" alpha_s &&
> +	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2 &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
> +		origin alpha_s beta_s &&
> +
> +	# Ensure that {alpha,beta}_1 are sent as "have", but not {alpha_beta}_2
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	grep "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	grep "fetch> have $BETA_1" trace &&
> +	ALPHA_2=$(git -C client rev-parse alpha_2) &&
> +	! grep "fetch> have $ALPHA_2" trace &&
> +	BETA_2=$(git -C client rev-parse beta_2) &&
> +	! grep "fetch> have $BETA_2" trace
> +}
> +
> +test_expect_success '--negotiator-tip limits "have" lines sent' '
> +	negotiator_tip server server 0
> +'
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +test_expect_success 'fetch with --filter=blob:limit=0 and HTTP' '
> +	negotiator_tip "$HTTPD_DOCUMENT_ROOT_PATH/server" \
> +		"$HTTPD_URL/smart/server" 1
> +'
> +
> +stop_httpd
> +
>  test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index 1f8ff7e94..ad8f7c772 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -684,6 +684,9 @@ static int fetch(struct transport *transport,
>  			transport, "filter",
>  			data->transport_options.filter_options.filter_spec);
>  
> +	if (data->transport_options.negotiation_tips)
> +		warning("Ignoring --negotiation-tip because the protocol does not support it.");
> +
>  	if (data->fetch)
>  		return fetch_with_fetch(transport, nr_heads, to_fetch);
>  
> diff --git a/transport.c b/transport.c
> index a32da30de..9f10f8ad9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -318,6 +318,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.filter_options = data->options.filter_options;
>  	args.stateless_rpc = transport->stateless_rpc;
>  	args.server_options = transport->server_options;
> +	args.negotiation_tips = data->options.negotiation_tips;
>  
>  	if (!data->got_remote_heads)
>  		refs_tmp = get_refs_via_connect(transport, 0, NULL);
> diff --git a/transport.h b/transport.h
> index 7792b0858..d31be5be6 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -25,6 +25,16 @@ struct git_transport_options {
>  	const char *receivepack;
>  	struct push_cas_option *cas;
>  	struct list_objects_filter_options filter_options;
> +
> +	/*
> +	 * This is only used during fetch. See the documentation of
> +	 * negotiation_tips in struct fetch_pack_args.
> +	 *
> +	 * This field is only supported by transports that support connect or
> +	 * stateless_connect. Set this field directly instead of using
> +	 * transport_set_option().
> +	 */
> +	struct oid_array *negotiation_tips;
>  };
>  
>  enum transport_family {
> -- 
> 2.18.0.rc2.347.g0da03f3a46.dirty
> 
