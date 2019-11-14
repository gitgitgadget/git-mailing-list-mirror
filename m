Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6015A1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKNQl2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:41:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:41:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so4602250pfl.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cz1A/cxvjeE8C+5q5pp5IeeatS9qzqoPo4yiTYytw/0=;
        b=Z2Fk0fxzT+gqbYz3f4sgfaFu5578FM2baw45Wz1e8if9yu46vH6OZfcgB0VH+8mtbB
         sZgbH9DNZ7YcieW0TTaRAT9gKoQDV+El4WMhzKXknZBAgWbv24ch4KZfNjv9rtUNpaF4
         FFZHdm9fG/GbeguaDTNkeKuaeiiaUzUFh8ODN1Iw0IHKaU+mukT9owsmz6Sd6EkWp1FU
         hgbTSAWklYL4QormymnS36pnDoTPYS9IVNmLTcEx/98f71PtXxd1Du3FO6W6lKYIfmxy
         DiB2kKB1Y9JBGgMDO6ma9b8XzswA8TPMjU0vJ5xAkxZQ2yzhLwxpn9R65DzirRkwGx0s
         jY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cz1A/cxvjeE8C+5q5pp5IeeatS9qzqoPo4yiTYytw/0=;
        b=aSJ5Dgyt3+8JBFOXRD8fQZ6YM1rbnANw+GwA8PqhdYM8QPGr9O16/jNZR17B2YjUfv
         Qy5pKbhQ4TCHKXSBLfwUUcqVWZWyqRVgsA/j+K09rpN33xVPrQraCiBnaPn0PbfIjMmL
         +DV8L+G1lucwEkVuTn5xAIwZlVzDXta0Az9Ias1+b6BPHauWktZMpQWBMRNWgD+nqNtW
         TM1WSLxdXsVHET3oa5LO0kux3HqkdD2i2/XXdZICArMvulg68LSwoVRxRf+/7QVnpBDK
         JgpRfI3kgYG8stkpByQ14Clw4fBV5UUWMlEfPZd1CVPuPimZnhE/+kDm3novY58/uG82
         pbxA==
X-Gm-Message-State: APjAAAUzvefWLeeVyt8V/PUgo3kW/lvPuigaH56FHun07C54vV7rftkH
        5CEZ98/tS9EEY08GMK9oV7s=
X-Google-Smtp-Source: APXvYqyRNqWFT51qftTReJ01UkCs/SCwULFBarw30y1i8lks/3PuBXoe9WllnZIygKjSZB+m1SlzYw==
X-Received: by 2002:a62:75d7:: with SMTP id q206mr11546793pfc.232.1573749687133;
        Thu, 14 Nov 2019 08:41:27 -0800 (PST)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:f:cd34:756c:854:94de])
        by smtp.gmail.com with ESMTPSA id u207sm8635860pfc.127.2019.11.14.08.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:41:26 -0800 (PST)
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
To:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
 <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
 <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
 <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <beb5a2b4-f07c-c3fd-9e68-dbee85fba2ee@gmail.com>
Date:   Thu, 14 Nov 2019 08:41:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/12/19 5:30 PM, Junio C Hamano wrote:
> Thanks.  Here is what I came up with to tie the loose ends of this
> thread.
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH] fsmonitor: do not compare bitmap size with size of split index
> 
> 3444ec2e ("fsmonitor: don't fill bitmap with entries to be removed",
> 2019-10-11) added a handful of sanity checks that make sure that a
> bit position in fsmonitor bitmap does not go beyond the end of the
> index.  As each bit in the bitmap corresponds to a path in the
> index, this is the right check most of the time.
> 
> Except for the case when we are in the split-index mode and looking
> at a delta index that is to be overlayed on the base index but
> before the base index has actually been merged in, namely in read_
> and write_fsmonitor_extension().  In these codepaths, the entries in
> the split/delta index is typically a small subset of the entire set
> of paths (otherwise why would we be using split-index?), so the
> bitmap used by the fsmonitor is almost always larger than the number
> of entries in the partial index, and the incorrect comparison would
> trigger the BUG().
> 
> Reported-by: Utsav Shah <ukshah2@illinois.edu>
> Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Helped-by: William Baker <William.Baker@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  fsmonitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 1f4aa1b150..0477500b39 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -55,7 +55,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>  	}
>  	istate->fsmonitor_dirty = fsmonitor_dirty;
>  
> -	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> +	if (!istate->split_index &&
> +	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>  		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>  		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>  
> @@ -83,7 +84,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
>  	uint32_t ewah_size = 0;
>  	int fixup = 0;
>  
> -	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> +	if (!istate->split_index &&
> +	    istate->fsmonitor_dirty->bit_size > istate->cache_nr)
>  		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
>  		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>  
> 

This looks good to me.

Thanks,
William
