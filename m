Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2E01F404
	for <e@80x24.org>; Fri,  7 Sep 2018 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeIHBG3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 21:06:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36335 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHBG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 21:06:29 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so17597613qtn.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ub3i8ZO0TFWFJe/HSj5vKUeSIJ+L5h8tUpK5h+Uc/WU=;
        b=ksTJC8Z2/Qdk9zc0i9qgoZ855vPq+WmuCXgCfWKYrb9bkH4+LpSO0ieFmF3R/vJ0UM
         bFOb/+YDkMg5bVHi3L3VcRA6WSbL0G0qiL15+tDV8icZ0Y6wamqAT/2ZFjraxdX3hlPA
         AZQnNX5w5Z65Lcj/BF2oKj0e1PfR7OvD2ZKnDa93qI+9DpzI/fgJClnpugnSOs/JTLZh
         lWMRPNzDf/P67OoXG40lAZSmD3XiRdYL+mydA6PsVqIxQ0pQ+LoJlEx2hN9FNA6Hv+IU
         dsquUJ3pU7By1SbvYFldBhlNe85KcbUbFHgnVekx+0wjbCncJq0+Gk4cPnJu3vzCyQWu
         KIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ub3i8ZO0TFWFJe/HSj5vKUeSIJ+L5h8tUpK5h+Uc/WU=;
        b=TxHuzqxSpbTpC7Ks3FHf6noP0LFBtOqDnRt1G8VL4zUcNLTK2cWMRmk6ZGTzdYF8Q+
         Rbc0pxS5YRkQj6DpyWDCF16bQNTDDka2m9+stKWouFsae1RLS5eaDnsPpgRX4EE9+Q38
         KMZHdFciHFk2CaYEPeyVBMMZThSSXgB/Q6wrfPS5n1H70Se21qsUVRphk+urIcVRAsd5
         xKx+WbMuEhRx9EGOHM4aJLss2qcR9CyinZnwytpCs5qIRTyi6fz2t37dcm0c5NnPkaO0
         ucCxq63Ty+ea9FGH+uQ19h2749ClgYMg9KwnPdgzJotFP250RcJGap38bpo4HdflSo/H
         5eOg==
X-Gm-Message-State: APzg51Ap6sIEfrjaPhz48BbONENT74i3p+wLPEhd3PuXrjENun7Vu5GG
        CbIXWCWdcL8lJyu8pXBycCI=
X-Google-Smtp-Source: ANB0VdYguZnarKB9aym8IfJpKHcJFTD3eotYZz2T9a/vy4TDG2zEA3oGp3qydS01YtsSEUL5IHLvag==
X-Received: by 2002:ac8:382b:: with SMTP id q40-v6mr7696557qtb.304.1536351833766;
        Fri, 07 Sep 2018 13:23:53 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id u7-v6sm5768144qtc.76.2018.09.07.13.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:23:52 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
 <20180906210227.54368-3-benpeart@microsoft.com>
 <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <fc531863-c46c-6d27-4749-c6b092a14a6f@gmail.com>
Date:   Fri, 7 Sep 2018 16:23:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/7/2018 1:55 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> The extension consists of:
>>
>> - 32-bit offset to the end of the index entries
>>
>> - 160-bit SHA-1 over the extension types and their sizes (but not
>> their contents).  E.g. if we have "TREE" extension that is N-bytes
>> long, "REUC" extension that is M-bytes long, followed by "EOIE",
>> then the hash would be:
>>
>> SHA-1("TREE" + <binary representation of N> +
>> 	"REUC" + <binary representation of M>)
> 
> I didn't look at the documentation patch in the larger context, but
> please make sure that it is clear to the readers that these fixed
> width integers "binary representations" use network byte order.
> 

At the top of the documentation it says "All binary numbers are in 
network byte order" and that is not repeated for any of the other 
sections that are documenting the file format.

> I briefly wondered if the above should include
> 
>      + "EOIE" + <binary representation of (32+160)/8 = 24>
> 
> as it is pretty much common file format design to include the header
> part of the checksum record (with checksum values padded out with NUL
> bytes) when you define a record to hold the checksum of the entire
> file.  Since this does not protect the contents of each section from
> bit-flipping, adding the data for EOIE itself in the sum does not
> give us much (iow, what I am adding above is a constant that does
> not contribute any entropy).
> 
> How big is a typical TREE extension in _your_ work repository
> housing Windows sources?  I am guessing that replacing SHA-1 with
> something faster (as this is not about security but is about disk
> corruption) and instead hash also the contents of these sections
> would NOT help all that much in the performance department, as
> having to page them in to read through would already consume
> non-trivial amount of time, and that is why you are not hashing the
> contents.
> 

The purpose of the SHA isn't to detect disk corruption (we already have 
a SHA for the entire index that can serve that purpose) but to help 
ensure that this was actually a valid EOIE extension and not a lucky 
random set of bytes.  I had used leading and trailing signature bytes 
along with the length and version bytes to validate it was an actual 
EOIE extension but you suggested [1] that I use a SHA of the 4 byte 
extension type + 4 byte extension length instead so I rewrote it that way.

[1] 
https://public-inbox.org/git/xmqq1sl017dw.fsf@gitster.mtv.corp.google.com/

>> +	/*
>> +	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before the SHA1
> 
> s/SHA1/trailing checksum/ or something so that we can withstand
> NewHash world order?
> 

I thought about this but in the document elsewhere it refers to it as 
"160-bit SHA-1 over the content of the index file before this checksum." 
and there are at least a dozen other references to "SHA-1" so I figured 
we can fix them all at the same time when we have a new/better name. :-)

>> +	 * so that it can be found and processed before all the index entries are
>> +	 * read.
>> +	 */
>> +	if (!strip_extensions && offset && !git_env_bool("GIT_TEST_DISABLE_EOIE", 0)) {
>> +		struct strbuf sb = STRBUF_INIT;
>> +
>> +		write_eoie_extension(&sb, &eoie_c, offset);
>> +		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
>>   			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
>>   		strbuf_release(&sb);
>>   		if (err)
> 
> OK.
> 
>> +#define EOIE_SIZE 24 /* <4-byte offset> + <20-byte hash> */
>> +#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */
>> +
>> +#ifndef NO_PTHREADS
>> +static unsigned long read_eoie_extension(void *mmap, size_t mmap_size)
>> +{
>> +	/*
>> +	 * The end of index entries (EOIE) extension is guaranteed to be last
>> +	 * so that it can be found by scanning backwards from the EOF.
>> +	 *
>> +	 * "EOIE"
>> +	 * <4-byte length>
>> +	 * <4-byte offset>
>> +	 * <20-byte hash>
>> +	 */
>> +	const char *index, *eoie = (const char *)mmap + mmap_size - GIT_SHA1_RAWSZ - EOIE_SIZE_WITH_HEADER;
>> +	uint32_t extsize;
>> +	unsigned long offset, src_offset;
>> +	unsigned char hash[GIT_MAX_RAWSZ];
>> +	git_hash_ctx c;
>> +
>> +	/* validate the extension signature */
>> +	index = eoie;
>> +	if (CACHE_EXT(index) != CACHE_EXT_ENDOFINDEXENTRIES)
>> +		return 0;
>> +	index += sizeof(uint32_t);
>> +
>> +	/* validate the extension size */
>> +	extsize = get_be32(index);
>> +	if (extsize != EOIE_SIZE)
>> +		return 0;
>> +	index += sizeof(uint32_t);
> 
> Do we know we have at least 8-byte to consume to perform the above
> two checks, or is that something we need to verify at the beginning
> of this function?  Better yet, as we know that a correct EOIE with
> its own header is 28-byte long, we probably should abort if
> mmap_size is smaller than that.
> 

I'll add that additional test.

>> +	/*
>> +	 * Validate the offset we're going to look for the first extension
>> +	 * signature is after the index header and before the eoie extension.
>> +	 */
>> +	offset = get_be32(index);
>> +	if ((const char *)mmap + offset < (const char *)mmap + sizeof(struct cache_header))
>> +		return 0;
> 
> Claims that the end is before the beginning, which we reject as bogus.  Good.
> 
>> +	if ((const char *)mmap + offset >= eoie)
>> +		return 0;
> 
> Claims that the end is beyond the EOIE marker we should have placed
> after it, which we reject as bogus.  Good.
> 
>> +	index += sizeof(uint32_t);
>> +
>> +	/*
>> +	 * The hash is computed over extension types and their sizes (but not
>> +	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
>> +	 * long, "REUC" extension that is M-bytes long, followed by "EOIE",
>> +	 * then the hash would be:
>> +	 *
>> +	 * SHA-1("TREE" + <binary representation of N> +
>> +	 *               "REUC" + <binary representation of M>)
>> +	 */
>> +	src_offset = offset;
>> +	the_hash_algo->init_fn(&c);
>> +	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
>> +		/* After an array of active_nr index entries,
> (Style nit).
>> +		 * there can be arbitrary number of extended
>> +		 * sections, each of which is prefixed with
>> +		 * extension name (4-byte) and section length
>> +		 * in 4-byte network byte order.
>> +		 */
>> +		uint32_t extsize;
>> +		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
>> +		extsize = ntohl(extsize);
> 
> Earlier we were using get_be32() but now we use memcpy with ntohl()?
> How are we choosing which one to use?
> 

I literally copy/pasted this logic from the code that actually loads the 
extensions then removed the call to load the extension and replaced it 
with the call to update the hash.  I kept it the same to facilitate 
consistency for any future fixes or changes.

> I think you meant to cast mmap to (const char *) here.  It may make it
> easier to write and read if we started this function like so:
> 
> 	static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size)
> 	{
> 		const char *mmap = mmap_;
> 
> then we do not have to keep casting mmap and cast to a wrong type by
> mistake.
> 

Good suggestion.

>> +
>> +		/* verify the extension size isn't so large it will wrap around */
>> +		if (src_offset + 8 + extsize < src_offset)
>> +			return 0;
> 
> Good.
> 
>> +		the_hash_algo->update_fn(&c, (const char *)mmap + src_offset, 8);
>> +
>> +		src_offset += 8;
>> +		src_offset += extsize;
>> +	}
>> +	the_hash_algo->final_fn(hash, &c);
>> +	if (hashcmp(hash, (unsigned char *)index))
>> +		return 0;
>> +
>> +	/* Validate that the extension offsets returned us back to the eoie extension. */
>> +	if (src_offset != mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER)
>> +		return 0;
> 
> Very good.
> 
>> +	return offset;
>> +}
>> +#endif
> 
> Overall it looks like it is carefully done.

Thanks for the careful review!

> Thanks.
> 
