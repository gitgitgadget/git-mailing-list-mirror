Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DE141F404
	for <e@80x24.org>; Thu, 16 Aug 2018 22:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeHQBK5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 21:10:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40571 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeHQBK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 21:10:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so5431168wrs.7
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vByCW2s4C6dUE4kIjtD+B/Wu5oEgE9gJUalsskZxu5c=;
        b=lus7tvFXaeIlPYO9Nal2elE0mYK2VlnF7y5JAcv9xihA2TgS4+tWWtEYknubUZg2WZ
         n69tovfTrl0yfL1lKNr9dR+dv/eb8izcWVzrQUPXm0qzjPYhNyPOTWpaNJ4P3sN1ri1p
         HKk8EGKE9l68nP4Dk/4HH5YDqgn+KKauWQtmAiyhMRqrMCcxN5+AyE6dwpMPtfj6m4NN
         SFHXgiFTSSve6BxVly3fBWUvSYZ4d+jpsljcbly1QDJwLsT6yTfjTmZMlnfdNmiWialG
         ea/elv/W52VhYjj4V4d7U87raF63OatK1tUjgIm3DEWzXsqTN4f2aj0hJGg+oCxuq4M9
         JLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vByCW2s4C6dUE4kIjtD+B/Wu5oEgE9gJUalsskZxu5c=;
        b=iNj7PswNDyEa2h8WdXZLEEkka5cN5i50jowSg6JZ1FkUjE0q3oPDr89jzppo3v6tkz
         qoAdkQHOLGfhQJziGtPcvI4BxpIYOwRZtw7A5jYk6+lWW6voPeIvhlmgo5Pd4eXmJNNo
         KeoV4FGgRV1fcKlDgDzu53pzsqblc0/MCWW4yIojI/LceiXia+q/yGJoOc/UeWEFkc76
         C8JXKjnGC0keN9U3KSxv/abHqqNDJxEZal6MP1OUdsz0mP8Y/RZaslEIG7jPvzL9Zfs6
         UzZilAH3fg4mGKkGTrW8tjTud1NjPHreptMdsFL5bi8sdv60+0336WPqSkdlceJBfQJ8
         XQ4Q==
X-Gm-Message-State: AOUpUlGlVsWpslJv+aNRLV/ExVSsd1oqj+TSIcRJ1HVsnOGB642GVg3p
        4QEWbXkM19r0T9A80xL5VJA=
X-Google-Smtp-Source: AA+uWPytgF2XOQdRKAJLtTAb8ZipYlsuWVDfUqwb242jVGkPrNOQgDQO/Pz7se92XT/TnXlN/ZuYOA==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr21631238wrf.206.1534457403640;
        Thu, 16 Aug 2018 15:10:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x82-v6sm5035283wmd.11.2018.08.16.15.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 15:10:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
        <20180816155714.GA22739@sigill.intra.peff.net>
        <20180816200222.GA7422@sigill.intra.peff.net>
Date:   Thu, 16 Aug 2018 15:10:02 -0700
In-Reply-To: <20180816200222.GA7422@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 16 Aug 2018 16:02:23 -0400")
Message-ID: <xmqq36vedkud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 16, 2018 at 11:57:14AM -0400, Jeff King wrote:
>
>> The only way to solve that is to count bytes. We don't have a total byte
>> count in most cases, and it wouldn't always make sense (e.g., the
>> "Compressing objects" meter can show the same issue, but it's not really
>> putting through bytes in a linear way).  In some cases we do show
>> transmitted size and throughput, but that's just for network operations.
>> We could do the same for "gc" with the patch below. But usually
>> throughput isn't all that interesting for a filesystem write, because
>> bandwidth isn't the bottleneck.
>
> Just realized I forgot to include the patch. Here it is, for reference.

I've been wondering when you'd realize the omission ;-)

> Doing something similar for fsck would be quite a bit more invasive.

Yeah, on that codepath there is no streaming write passing through a
single chokepoint you can count bytes X-<.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 80c880e9ad..e1130b959d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -837,7 +837,7 @@ static void write_pack_file(void)
>  		if (pack_to_stdout)
>  			f = hashfd_throughput(1, "<stdout>", progress_state);
>  		else
> -			f = create_tmp_packfile(&pack_tmp_name);
> +			f = create_tmp_packfile(&pack_tmp_name, progress_state);
>  
>  		offset = write_pack_header(f, nr_remaining);
>  
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 9f3b644811..0df45b8f55 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -178,7 +178,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
>  	if (!(flags & HASH_WRITE_OBJECT) || state->f)
>  		return;
>  
> -	state->f = create_tmp_packfile(&state->pack_tmp_name);
> +	state->f = create_tmp_packfile(&state->pack_tmp_name, NULL);
>  	reset_pack_idx_option(&state->pack_idx_opts);
>  
>  	/* Pretend we are going to write only one object */
> diff --git a/pack-write.c b/pack-write.c
> index a9d46bc03f..b72480b440 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -334,14 +334,15 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
>  	return n;
>  }
>  
> -struct hashfile *create_tmp_packfile(char **pack_tmp_name)
> +struct hashfile *create_tmp_packfile(char **pack_tmp_name,
> +				     struct progress *progress)
>  {
>  	struct strbuf tmpname = STRBUF_INIT;
>  	int fd;
>  
>  	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
>  	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
> -	return hashfd(fd, *pack_tmp_name);
> +	return hashfd_throughput(fd, *pack_tmp_name, progress);
>  }
>  
>  void finish_tmp_packfile(struct strbuf *name_buffer,
> diff --git a/pack.h b/pack.h
> index 34a9d458b4..c87628b093 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -98,7 +98,8 @@ extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
>  #define PH_ERROR_PROTOCOL	(-3)
>  extern int read_pack_header(int fd, struct pack_header *);
>  
> -extern struct hashfile *create_tmp_packfile(char **pack_tmp_name);
> +extern struct hashfile *create_tmp_packfile(char **pack_tmp_name,
> +					    struct progress *progress);
>  extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
>  
>  #endif
