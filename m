Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B151F404
	for <e@80x24.org>; Wed, 10 Jan 2018 17:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeAJR5d (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:57:33 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:41875 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeAJR5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:57:32 -0500
Received: by mail-pl0-f51.google.com with SMTP id q3so2378393plr.8
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qm5wb9UeokCve/eOOoL07RGb9/Yh1Da+2sGYJxsYgc=;
        b=PSzyi54yIepr8GdR/p+GuLmee16JXfgmEnsXdp9T6N7aQoOjWphRwLHi3eOnYiPJMA
         YX6VbI4ZoP/iolBfCh1nsGZV1JUa+hSCXpcZYNlTGom0JvFdIvUJmf5A0GRFP1fD4Tao
         0FU1s3mLIAPozUqc+u7U+YsohwqXfx8AzDqp1UdoiEY0GPDA7xHUAOb0iA6tWJ6skA7J
         sCVV7WTjq2JmjRuePgluAqtxXxiSdavwQg/6RNiB/LzjySCAWTI+6V6bvfwU52euHpPp
         KyMCaHPUJp78vWSuQA+7ARHvvL3FO4jvNs82WwxiRQyufGuwMrc4LiA8L6xw7u5UX0VQ
         77wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qm5wb9UeokCve/eOOoL07RGb9/Yh1Da+2sGYJxsYgc=;
        b=eTvfbAafnU6+mrfbaEYthxPyIJmALhv19+kwpcPeBQAgOpZg4jyTL1K3iIJWLYhKmu
         z/CgC2EZvDkOKr25NQ7MdxCzBj5CDrdSGd1e5YyKwBEC5DJzPuLcNFNl0bKwBd4NzNEQ
         9mijni8mFf112xeRYsckXqTJLl2rZRJBoDTnecKop7mAep8xJNAn5BZh31+K5/KVcxqy
         CUFvpDMaMB3fP+FlN4HoBHjROJXg83HlaxDmW0pBVMUKHayQ9N/Lsg3MEdvBRKOo2Rrt
         aSunk11wBwB7xJjbYDmAZqWitCY36bqSBlnyII9XGcxEIU97pmYtYNOPdTQlI7euVvn1
         QN5A==
X-Gm-Message-State: AKGB3mICQ6Czg3gGvlkCAW8L/d9SKRYaaUWHV5RzzCHXq7s8KocsGH7S
        5IY+tPqOSSq9BvTjdeeYRlWNEQ==
X-Google-Smtp-Source: ACJfBosKEhNNLZ474ieXmgmhk/kM3nbFANMgvg2lbdNe5hBU/RbpC+84m8zswA34pW9Yk+oIbin9Xg==
X-Received: by 10.84.137.169 with SMTP id 38mr20225608pln.246.1515607051529;
        Wed, 10 Jan 2018 09:57:31 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:64a5:1889:307:c3c0])
        by smtp.gmail.com with ESMTPSA id o88sm14595125pfi.82.2018.01.10.09.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 09:57:30 -0800 (PST)
Date:   Wed, 10 Jan 2018 09:57:30 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 26/26] remote-curl: implement connect-half-duplex
 command
Message-Id: <20180110095730.1daaa70d7c583c58b85142a3@google.com>
In-Reply-To: <20180103001828.205012-27-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-27-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:28 -0800
Brandon Williams <bmwill@google.com> wrote:

> +static size_t proxy_in(void *ptr, size_t eltsize,
> +		       size_t nmemb, void *buffer_)

OK, I managed to look at the Curl stuff in more detail.

I know that these parameter names are what remote_curl.c has been using
for its callbacks, but I find them confusing (in particular, some Curl
documentation rightly refer to the 1st parameter as a buffer, and the
4th parameter is actually userdata). Also, according to the Curl
documentation, the type of the first parameter is "char *". Could we
change the type of the first parameter to "char *", and the name of the
fourth parameter either to "proxy_state_" or "userdata"?

> +{
> +	size_t max = eltsize * nmemb;
> +	struct proxy_state *p = buffer_;
> +	size_t avail = p->request_buffer.len - p->pos;
> +
> +	if (!avail) {
> +		if (p->seen_flush) {
> +			p->seen_flush = 0;
> +			return 0;
> +		}
> +
> +		strbuf_reset(&p->request_buffer);
> +		switch (packet_reader_read(&p->reader)) {
> +		case PACKET_READ_EOF:
> +			die("error reading request from parent process");

This should say "BUG:", I think. I'm not sure what the best way of
explaining it is, but basically connect_half_duplex is supposed to
ensure (by peeking) that there is no EOF when proxy_in() is called.

> +		case PACKET_READ_NORMAL:
> +			packet_buf_write_len(&p->request_buffer, p->reader.line,
> +					     p->reader.pktlen);
> +			break;
> +		case PACKET_READ_DELIM:
> +			packet_buf_delim(&p->request_buffer);
> +			break;
> +		case PACKET_READ_FLUSH:
> +			packet_buf_flush(&p->request_buffer);
> +			p->seen_flush = 1;
> +			break;
> +		}
> +		p->pos = 0;
> +		avail = p->request_buffer.len;
> +	}
> +
> +	if (max < avail)
> +		avail = max;
> +	memcpy(ptr, p->request_buffer.buf + p->pos, avail);
> +	p->pos += avail;
> +	return avail;

Thanks, this looks correct. I wish that the Curl API had a way for us to
say "here are 4 more bytes, and that is all" instead of us having to
make a note (p->seen_flush) to remember to return 0 on the next call,
but that's the way it is.

> +}
> +static size_t proxy_out(char *ptr, size_t eltsize,
> +			size_t nmemb, void *buffer_)

Add a blank line before proxy_out. Also, same comment as proxy_in()
about the function signature.

> +{
> +	size_t size = eltsize * nmemb;
> +	struct proxy_state *p = buffer_;
> +
> +	write_or_die(p->out, ptr, size);
> +	return size;
> +}
> +
> +static int proxy_post(struct proxy_state *p)
> +{
> +	struct active_request_slot *slot;
> +	struct curl_slist *headers = http_copy_default_headers();
> +	int err;
> +
> +	headers = curl_slist_append(headers, p->hdr_content_type);
> +	headers = curl_slist_append(headers, p->hdr_accept);
> +	headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
> +
> +	slot = get_active_slot();
> +
> +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);

I looked at the Curl documentation for CURLOPT_HTTPHEADER and
curl_easy_setopt doesn't consume the argument here (in fact, it asks us
to keep "headers" around), so it might be possible to just generate the
headers once in proxy_state_init().

> +
> +	/* Setup function to read request from client */
> +	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
> +	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
> +
> +	/* Setup function to write server response to client */
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
> +
> +	err = run_slot(slot, NULL);
> +
> +	if (err != HTTP_OK)
> +		err = -1;

This seems to mean that we cannot have two requests in flight at the
same time even while there is no response (from the fact that we have a
HTTP status code after returning from run_slot()).

I thought that git fetch over HTTP uses the two-requests-in-flight
optimization that it also does over other protocols like SSH, but I see
that that code path (fetch_git() in remote-curl.c) also uses run_slot()
indirectly, so maybe my assumption is wrong. Anyway, this is outside the
scope of this patch.

> +
> +	curl_slist_free_all(headers);
> +	return err;
> +}
> +
> +static int connect_half_duplex(const char *service_name)
> +{
> +	struct discovery *discover;
> +	struct proxy_state p;
> +
> +	/*
> +	 * Run the info/refs request and see if the server supports protocol
> +	 * v2.  If and only if the server supports v2 can we successfully
> +	 * establish a half-duplex connection, otherwise we need to tell the
> +	 * client to fallback to using other transport helper functions to
> +	 * complete their request.
> +	 */
> +	discover = discover_refs(service_name, 0);
> +	if (discover->version != protocol_v2) {
> +		printf("fallback\n");
> +		fflush(stdout);
> +		return -1;
> +	} else {
> +		/* Half-Duplex Connection established */
> +		printf("\n");
> +		fflush(stdout);
> +	}
> +
> +	proxy_state_init(&p, service_name);
> +
> +	/*
> +	 * Dump the capability listing that we got from the server earlier
> +	 * during the info/refs request.
> +	 */
> +	write_or_die(p.out, discover->buf, discover->len);
> +
> +	/* Peek the next packet line.  Until we see EOF keep sending POSTs */
> +	while (packet_reader_peek(&p.reader) != PACKET_READ_EOF) {
> +		if (proxy_post(&p)) {
> +			/* We would have an err here */

Probably better to comment "Error message already printed by
proxy_post".
