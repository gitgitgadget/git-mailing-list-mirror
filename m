Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0EE20281
	for <e@80x24.org>; Tue, 26 Sep 2017 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030721AbdIZSbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 14:31:48 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:54311 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967715AbdIZSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 14:31:46 -0400
Received: by mail-pf0-f178.google.com with SMTP id d187so5945684pfg.11
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=somM3ytgNaHKx5VXWy/INfIPILd+ItKLxFi/8NAhYmg=;
        b=vaz000avIozKCmDxq7TSijMSYVL9y+G07KP8vw4xu/+xpJPcadbC3Z87zV9I5JSnOW
         L5QoO0L53zRBglyC8NGD4VIP9OwbD+gKbr0v/Z5Fyg56PZnwd0tT6Vste5Q0NqQxR9Up
         fK56bCXbo9igZL7DAYUN0FOW9LCu+KGTxYcDD9spUC/tRbtcpY7Scv88snnzSHcwwzGg
         1I3YAiGDo95lWRvekV2HJmV4IAj/VimvVMFAnR41H8ahWIXsbIFzfnhy+iX5aS16MIhL
         FM6K/enVVhzXDpAEtTqGhksQ6/Fj9DOquWE6hkIrk5cW/mV58sB8y0rC5K9wtAJKDH0X
         4n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=somM3ytgNaHKx5VXWy/INfIPILd+ItKLxFi/8NAhYmg=;
        b=kSh9qTKoQo3uQHSo6GY7ANkHv6NNerCq+viWjZ9Og+79mwU5PWs+Xfi02aP5Gob/Tz
         ywn0/d8tREbvBL9j5JXnGZb7+ScsR9e6DghdKqUtTmNuSL0oOY6Dmf3mxxQZuL6P87xw
         ucN7t0cWRT/Twcdxghn7UyphrpMY4/EM6XLJd2Mb+Ynk7L+M8nYotvtMJwKHUiRNM8WJ
         FWgrQ+eEYz7TfyqgaceteVvGUguLsZ75D685k367Ct+ntAOqBMkLKzIQFwztmoF6rqZo
         S1Hq4v5tJXda9k9z4atqRpgQi1tJRntl6TkSfguERCIWwh/WrKXPRXksZaUdWfFc91PY
         pLew==
X-Gm-Message-State: AHPjjUiXkMlQT7a1q5kcvtqmRlX1lhfFEUI7gH6SPOGy1Cck2YdoCaa2
        YMdI8lkL0wAu4tvxkhWMA86HBg==
X-Google-Smtp-Source: AOwi7QAYy6Tc4ZETcT7TZ1VL7/ZWDwPV1iEx8SEmQJ71otXUkhKOf5FzHafKx81X71rIxlN47ErlpQ==
X-Received: by 10.84.235.137 with SMTP id p9mr11359925plk.263.1506450705883;
        Tue, 26 Sep 2017 11:31:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4905:123e:57ff:8ff9])
        by smtp.gmail.com with ESMTPSA id a68sm17080987pfe.71.2017.09.26.11.31.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 11:31:44 -0700 (PDT)
Date:   Tue, 26 Sep 2017 11:31:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5] connect: in ref advertisement, shallows are last
Message-ID: <20170926183143.GA144745@google.com>
References: <20170921204501.32198-1-jonathantanmy@google.com>
 <20170926182147.73336-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926182147.73336-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/26, Jonathan Tan wrote:
> Currently, get_remote_heads() parses the ref advertisement in one loop,
> allowing refs and shallow lines to intersperse, despite this not being
> allowed by the specification. Refactor get_remote_heads() to use two
> loops instead, enforcing that refs come first, and then shallows.
> 
> This also makes it easier to teach get_remote_heads() to interpret other
> lines in the ref advertisement, which will be done in a subsequent
> patch.
> 
> As part of this change, this patch interprets capabilities only on the
> first line in the ref advertisement, printing a warning message when
> encountering capabilities on other lines.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Changes in v5:
>  - print warning when encountering capabilities on other lines instead
>    of ignoring them (also updated commit message)
>  - explicitly disallow refs of name "capabilities^{}" (except when it is
>    the only ref)
> ---
>  connect.c | 183 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 117 insertions(+), 66 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index df56c0cbf..df65a3fc4 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -11,6 +11,7 @@
>  #include "string-list.h"
>  #include "sha1-array.h"
>  #include "transport.h"
> +#include "strbuf.h"
>  
>  static char *server_capabilities;
>  static const char *parse_feature_value(const char *, const char *, int *);
> @@ -107,6 +108,98 @@ static void annotate_refs_with_symref_info(struct ref *ref)
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
> +#define EXPECTING_FIRST_REF 0
> +#define EXPECTING_REF 1
> +#define EXPECTING_SHALLOW 2
> +
> +static void process_capabilities(int *len)
> +{
> +	int nul_location = strlen(packet_buffer);
> +	if (nul_location == *len)
> +		return;
> +	server_capabilities = xstrdup(packet_buffer + nul_location + 1);
> +	*len = nul_location;
> +}
> +
> +static int process_dummy_ref(void)
> +{
> +	static char *template;
> +	if (!template)
> +		template = xstrfmt("%040d capabilities^{}", 0);

My only complaint is still here, I don't like the notion of hardcoding
the 0's.  Its much more future proof and less error prone to call
parse_oid_hex and require that it matches null_oid.

> +	return !strcmp(packet_buffer, template);
> +}
> +
> +static void check_no_capabilities(int len)
> +{
> +	if (strlen(packet_buffer) != len)
> +		warning("Ignoring capabilities after first line '%s'",
> +			packet_buffer + strlen(packet_buffer));
> +}
> +
> +static int process_ref(int len, struct ref ***list, unsigned int flags,
> +		       struct oid_array *extra_have)
> +{
> +	struct object_id old_oid;
> +	const char *name;
> +
> +	if (parse_oid_hex(packet_buffer, &old_oid, &name))
> +		return 0;
> +	if (*name != ' ')
> +		return 0;
> +	name++;
> +
> +	if (extra_have && !strcmp(name, ".have")) {
> +		oid_array_append(extra_have, &old_oid);
> +	} else if (!strcmp(name, "capabilities^{}")) {
> +		die("protocol error: unexpected capabilities^{}");
> +	} else if (check_ref(name, flags)) {
> +		struct ref *ref = alloc_ref(name);
> +		oidcpy(&ref->old_oid, &old_oid);
> +		**list = ref;
> +		*list = &ref->next;
> +	}
> +	check_no_capabilities(len);
> +	return 1;
> +}
> +
> +static int process_shallow(int len, struct oid_array *shallow_points)
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
> +	check_no_capabilities(len);
> +	return 1;
> +}
> +
>  /*
>   * Read all the refs from the other end
>   */
> @@ -123,76 +216,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 * willing to talk to us.  A hang-up before seeing any
>  	 * response does not necessarily mean an ACL problem, though.
>  	 */
> -	int saw_response;
> -	int got_dummy_ref_with_capabilities_declaration = 0;
> +	int responded = 0;
> +	int len;
> +	int state = EXPECTING_FIRST_REF;
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
>  
> -		name_len = strlen(name);
> -		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> -			free(server_capabilities);
> -			server_capabilities = xstrdup(name + name_len + 1);
> -		}
> -
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
> +		case EXPECTING_FIRST_REF:
> +			process_capabilities(&len);
> +			if (process_dummy_ref()) {
> +				state = EXPECTING_SHALLOW;
> +				break;
> +			}
> +			state = EXPECTING_REF;
> +			/* fallthrough */
> +		case EXPECTING_REF:
> +			if (process_ref(len, &list, flags, extra_have))
> +				break;
> +			state = EXPECTING_SHALLOW;
> +			/* fallthrough */
> +		case EXPECTING_SHALLOW:
> +			if (process_shallow(len, shallow_points))
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
> 2.14.1.821.g8fa685d3b7-goog
> 

-- 
Brandon Williams
