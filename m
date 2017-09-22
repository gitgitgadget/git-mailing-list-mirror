Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF297202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 00:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdIVAAI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 20:00:08 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45414 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdIVAAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 20:00:07 -0400
Received: by mail-pg0-f53.google.com with SMTP id 188so4373231pgb.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZcWzBkeHXFQveDk3ViwjrmEGojWr7dLZG2tG4wDkg0=;
        b=ByuFkiIv5lbpVrxu92rKpJlDiNTj4w4Jy2ysn8DDJONCbTgQaBMJLtS3MIr5DgPS9n
         sIinLOjHT8hLr2sQnrFIVqdSe67CKSpm0yqlVmKLq75bJsybHn+GZTMtyzruBGT113uW
         lPpKlZtF0P7S1PaeKtyMQS6XmHlgB5sL5SmkWX4dvwSN8LwRQ0FJjrH0F3o3DLP8yD98
         qfzpF32ZkDRNbfLJtpztGQUZglnkEICOanCP2wUAXKqZH/TPI3fGQGOMAiCPZS68t0tC
         Ed2qAz+f3D1JOW5G+mEbiRD7avfye2IiwNK9Zfg9G8MixZPuhk9t96ORvsKeoQfhltjg
         u/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZcWzBkeHXFQveDk3ViwjrmEGojWr7dLZG2tG4wDkg0=;
        b=YKsLlh0wAI77LdOX7yAo3Of6dnqMmjSsgs8HfswEr3o2zxdZ0A3yIYE+I5slkfFJIv
         0JvnUZQ/uFbj+Ch6WpcAg5yX+J6zMtEDunyB0TtpXw4CMEvUR0+Q7PgQiPm9ACUZu7Qt
         YNL+yREOoZb0T0GYFhr6afN3d99qmHGZnCMx+SQsYUXR9OJJuzngvcwjJIdsLolBCPgh
         xRLkh0kS+9m4JtBXNfDsr3YrIIr3lihaqO6JJ4xqBwznqhIaLqaA8OBdCWPe8g6HIONe
         /HfRAvxFzi2NKS81FGtchAOVdocJH1T3j028PEJDTGq3HeOg8TQZKwYCSaevOpzVER7n
         RWaw==
X-Gm-Message-State: AHPjjUjSh09cShk4ILgm1MUHdXU3NNK9tUgodLfchJ/0KTfDO1gbY7tF
        rwvaTIo36sWu7nHGalY7QNi3Ksfgj34=
X-Google-Smtp-Source: AOwi7QAdxxIE/nLVsU2aZVAAf5xfBuFeii0Hj7MBnGsjRdQZjLHTw+99TGhLdyY4xGIMaJOC1FxOog==
X-Received: by 10.99.120.3 with SMTP id t3mr7333887pgc.388.1506038407048;
        Thu, 21 Sep 2017 17:00:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id b22sm4035873pfh.175.2017.09.21.17.00.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 17:00:05 -0700 (PDT)
Date:   Thu, 21 Sep 2017 17:00:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v2] connect: in ref advertisement, shallows are last
Message-ID: <20170922000004.GB77641@google.com>
References: <20170921204501.32198-1-jonathantanmy@google.com>
 <20170921234534.18964-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921234534.18964-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/21, Jonathan Tan wrote:
> Currently, get_remote_heads() parses the ref advertisement in one loop,
> allowing refs and shallow lines to intersperse, despite this not being
> allowed by the specification. Refactor get_remote_heads() to use two
> loops instead, enforcing that refs come first, and then shallows.
> 
> This also makes it easier to teach get_remote_heads() to interpret other
> lines in the ref advertisement, which will be done in a subsequent
> patch.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> In some in-office discussion, I was informed that my original patch
> relaxed the ordering of ".keep" lines. Here is an update.
> 
> I'm also using a switch statement now, which avoids having multiple
> lines of read_remote_ref().


Looks cleaner than the last patch.

> 
>  connect.c | 159 ++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 93 insertions(+), 66 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 49b28b83b..e0821dbff 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -107,6 +107,84 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  	string_list_clear(&symref, 0);
>  }
>  
> +/*
> + * Read one line of a server's ref advertisement into packet_buffer.
> + */
> +static int read_remote_ref(int in, char **src_buf, size_t *src_len,
> +			   int *responded)
> +{
> +	int len = packet_read(in, src_buf, src_len,
> +			      packet_buffer, sizeof(packet_buffer),
> +			      PACKET_READ_GENTLE_ON_EOF |
> +			      PACKET_READ_CHOMP_NEWLINE);
> +	const char *arg;
> +	if (len < 0)
> +		die_initial_contact(*responded);
> +	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
> +		die("remote error: %s", arg);
> +
> +	*responded = 1;
> +
> +	return len;
> +}
> +
> +#define EXPECTING_REF 0
> +#define EXPECTING_SHALLOW 1
> +
> +static int process_ref(int *state, int len, struct ref ***list,
> +		       unsigned int flags, struct oid_array *extra_have)
> +{
> +	struct object_id old_oid;
> +	char *name;
> +	int name_len;
> +
> +	if (len < GIT_SHA1_HEXSZ + 2 ||
> +	    get_oid_hex(packet_buffer, &old_oid) ||
> +	    packet_buffer[GIT_SHA1_HEXSZ] != ' ') {
> +		(*state)++;

I think it may be cleaner if the state variable is updated outside of
this function based on a return value from this function.

> +		return 0;
> +	}
> +
> +	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
> +	name_len = strlen(name);
> +	if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> +		free(server_capabilities);
> +		server_capabilities = xstrdup(name + name_len + 1);
> +	}
> +
> +	if (extra_have && !strcmp(name, ".have")) {
> +		oid_array_append(extra_have, &old_oid);
> +	} else if (!strcmp(name, "capabilities^{}")) {
> +		if (**list)
> +			/* cannot coexist with other refs */
> +			die("protocol error: unexpected capabilities^{}");
> +		/* There should be no more refs; proceed to the next state. */
> +		(*state)++;
> +	} else if (check_ref(name, flags)) {
> +		struct ref *ref = alloc_ref(name);
> +		oidcpy(&ref->old_oid, &old_oid);
> +		**list = ref;
> +		*list = &ref->next;
> +	}
> +	return 1;
> +}
> +
> +static int process_shallow(int *state, struct oid_array *shallow_points)

state isn't needed here and could be dropped from the parameter list.

> +{
> +	const char *arg;
> +	struct object_id old_oid;
> +
> +	if (!skip_prefix(packet_buffer, "shallow ", &arg))
> +		return 0;
> +
> +	if (get_oid_hex(arg, &old_oid))
> +		die("protocol error: expected shallow sha-1, got '%s'", arg);
> +	if (!shallow_points)
> +		die("repository on the other end cannot be shallow");
> +	oid_array_append(shallow_points, &old_oid);
> +	return 1;
> +}
> +
>  /*
>   * Read all the refs from the other end
>   */
> @@ -123,76 +201,25 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 * willing to talk to us.  A hang-up before seeing any
>  	 * response does not necessarily mean an ACL problem, though.
>  	 */
> -	int saw_response;
> -	int got_dummy_ref_with_capabilities_declaration = 0;
> +	int responded = 0;
> +	int len;
> +	int state = EXPECTING_REF;
>  
>  	*list = NULL;
> -	for (saw_response = 0; ; saw_response = 1) {
> -		struct ref *ref;
> -		struct object_id old_oid;
> -		char *name;
> -		int len, name_len;
> -		char *buffer = packet_buffer;
> -		const char *arg;
> -
> -		len = packet_read(in, &src_buf, &src_len,
> -				  packet_buffer, sizeof(packet_buffer),
> -				  PACKET_READ_GENTLE_ON_EOF |
> -				  PACKET_READ_CHOMP_NEWLINE);
> -		if (len < 0)
> -			die_initial_contact(saw_response);
> -
> -		if (!len)
> -			break;
> -
> -		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
> -			die("remote error: %s", arg);
> -
> -		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
> -			skip_prefix(buffer, "shallow ", &arg)) {
> -			if (get_oid_hex(arg, &old_oid))
> -				die("protocol error: expected shallow sha-1, got '%s'", arg);
> -			if (!shallow_points)
> -				die("repository on the other end cannot be shallow");
> -			oid_array_append(shallow_points, &old_oid);
> -			continue;
> -		}
> -
> -		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
> -			buffer[GIT_SHA1_HEXSZ] != ' ')
> -			die("protocol error: expected sha/ref, got '%s'", buffer);
> -		name = buffer + GIT_SHA1_HEXSZ + 1;
> -
> -		name_len = strlen(name);
> -		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> -			free(server_capabilities);
> -			server_capabilities = xstrdup(name + name_len + 1);
> -		}
>  
> -		if (extra_have && !strcmp(name, ".have")) {
> -			oid_array_append(extra_have, &old_oid);
> -			continue;
> -		}
> -
> -		if (!strcmp(name, "capabilities^{}")) {
> -			if (saw_response)
> -				die("protocol error: unexpected capabilities^{}");
> -			if (got_dummy_ref_with_capabilities_declaration)
> -				die("protocol error: multiple capabilities^{}");
> -			got_dummy_ref_with_capabilities_declaration = 1;
> -			continue;
> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +		switch (state) {
> +		case EXPECTING_REF:
> +			if (process_ref(&state, len, &list, flags, extra_have))
> +				break;
> +			/* fallthrough */
> +		case EXPECTING_SHALLOW:
> +			if (process_shallow(&state, shallow_points))
> +				break;
> +			die("protocol error: unexpected '%s'", packet_buffer);
> +		default:
> +			die("unexpected state %d", state);
>  		}
> -
> -		if (!check_ref(name, flags))
> -			continue;
> -
> -		if (got_dummy_ref_with_capabilities_declaration)
> -			die("protocol error: unexpected ref after capabilities^{}");
> -
> -		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
> -		oidcpy(&ref->old_oid, &old_oid);
> -		*list = ref;
> -		list = &ref->next;
>  	}
>  
>  	annotate_refs_with_symref_info(*orig_list);
> -- 
> 2.14.1.728.g20a5b67d5.dirty
> 

-- 
Brandon Williams
