Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EF41F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfARRQK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:16:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARRQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:16:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so15933362wrx.9
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=16yPIIDB+mZdr5AARVCGBpvLNVBsdOahQled9DejHpU=;
        b=eaPBKLQME9z4zib3W9zEVOFxl7yWwKIQidmDsV4s58JgiPwTLS4vYF7NPgO6z0PMe9
         hLLbpRC3GLbx9PtF1DBLpIJ0zrX4TghkEvm9b7LbgdMqvS/YekRG3JLrJxPa/giX3yCV
         WdJ+n/nrLZD00dW22MpYCUf3vrE2fb+xbTdlD/xlG9GwL/hgcakB1PH4mfXx7d3AYV/n
         oEDIUJLQIVmGEBq4KlaNhPa/JyCdbyRlXCRazyqKoUcch5UUeMZSEmQJIfHqV3LbivXM
         igjzQancoGyeXwXo5EY1KetAaJlQ4g6Zyk/zHpo/FobzFbCVyTtdmup/33QIX/ZDWqm2
         +M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=16yPIIDB+mZdr5AARVCGBpvLNVBsdOahQled9DejHpU=;
        b=BkrgjtkiF0EuHqyJMN4tCPKnYCWulf5FQ4rfKQKjKBLANQf7t2hOvGdIDsPXkYDXkb
         +DiHlmb9b8EMH413WHs0xQpAQ0S+x2MDVjg4MOF9ta8TNl7eum4YbQ2D0Z0xRnCr3YV9
         iEPX8IbLefwSbf4TM1GRbv/xMMduBQi0EkaxFjn55GK9LLc/quQjd2nKuKxnod5r3yvZ
         0FbulhVvClzrJvoI/uFV4VEXJ2IRadfMnrT0wuIxKPnqGeKg9LH5pvexs2NLwkhSv7AT
         YwlSG5baLhno3l6cuTMLRRu+W5/AnsttDnQSZeUHk1X/OFkzEpLYd1ZBJrQ1FiRtSRJ/
         WNLw==
X-Gm-Message-State: AJcUukcrADdkEh6jv/+Q2dbTR7hSzO19giuDO43lNZclPWJTJfPK32G6
        0DjgttFTIbmDIZG5Zu/re6M=
X-Google-Smtp-Source: ALg8bN6SGMzVTdyU3098zakTmdoOd3N2Sm/uWwp7ZosPVPn0R2gU1V8QVadLnJWWFZYk8DPMuN7j0g==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr17572154wrr.253.1547831768230;
        Fri, 18 Jan 2019 09:16:08 -0800 (PST)
Received: from szeder.dev (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id t18sm25898884wmt.35.2019.01.18.09.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:16:07 -0800 (PST)
Date:   Fri, 18 Jan 2019 18:16:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 3/9] commit-graph write: add "Writing out" progress
 output
Message-ID: <20190118171605.GM840@szeder.dev>
References: <20181122153922.16912-2-avarab@gmail.com>
 <20190116132947.26025-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116132947.26025-4-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 16, 2019 at 02:29:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> @@ -941,11 +957,25 @@ void write_commit_graph(const char *obj_dir,
>  		hashwrite(f, chunk_write, 12);
>  	}
>  
> -	write_graph_chunk_fanout(f, commits.list, commits.nr);
> -	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr);
> -	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
> +	if (report_progress) {
> +		/*
> +		 * Each of the write_graph_chunk_*() functions just
> +		 * below loops over our N commits. This number must be
> +		 * kept in sync with the number of passes we're doing.
> +		 */
> +		int graph_passes = 3;
> +		if (num_large_edges)
> +			graph_passes++;

write_commit_graph() already has the 'num_chunks' variable, which
holds exactly the right value.

> +		progress = start_delayed_progress(
> +			_("Writing out commit graph"),
> +			graph_passes * commits.nr);
> +	}
> +	write_graph_chunk_fanout(f, commits.list, commits.nr, progress, &progress_cnt);
> +	write_graph_chunk_oids(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
> +	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr, progress, &progress_cnt);
>  	if (num_large_edges)
> -		write_graph_chunk_large_edges(f, commits.list, commits.nr);
> +		write_graph_chunk_large_edges(f, commits.list, commits.nr, progress, &progress_cnt);
> +	stop_progress(&progress);
>  
>  	close_commit_graph(the_repository);
>  	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
> -- 
> 2.20.1.153.gd81d796ee0
> 
