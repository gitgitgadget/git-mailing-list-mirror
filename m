Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2001F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbcHPUh3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:37:29 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33333 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbcHPUTx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:19:53 -0400
Received: by mail-yw0-f194.google.com with SMTP id z8so3963584ywa.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 13:19:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8VugG90Hs2rzLvbYC850YMOYTlCR+i6LqvnjSTI6ZaY=;
        b=YoHF9jZecgRSfxZiQ0BCt+n2hd2AnZNybINovRRg95hvGGIpILhr9sRku005m+WwgR
         C9cshs7BqiKme0KMDophNaXOzdXwF7VTyHwKyWh/JHamJ2R8SD1XztcYV1hauOcdj6OR
         7L2LZ2pBegIhSDiuiMfxsY4p+3IoTsWsmmrcdZiORQY2aZBHBDSl38coamnKIucqyptu
         oxlF5nC83eu18Vpc1ZYbJxyD9+G016dXEjC3ugVZkZXyJwmTtlLM/fZgJcvCsqTun95n
         xORqfQop/PvUC9unqy39tM7Ce8hEDtsTWk3OxQtEFdwHhUNXLPggEMMXsEnQBo7YvLEa
         nigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8VugG90Hs2rzLvbYC850YMOYTlCR+i6LqvnjSTI6ZaY=;
        b=Vpf/uhyx83hDVVwEBc79SZK5le4tIUO4HRB60bH8aSzp1Z7a5H7TChP4cWV6enbMwx
         aYFBeAp6Xq07G98D7FKeqa3qT0C4H6pnAVmThjyH2MmWhZdu/zq3KCepN7vBHwsP5vBJ
         C5JFTFdYoelN75Ik9NOhOMB6ibzF0YltqLoPwsUQa/qa2Ts6QkekCVoTPSBn9gUcDWQS
         pFaDCJn+wVSZMWb7zn4vsokI/QBOTbpKNUWDI5jbym6NF9s1Yq9GKQir2F0BWaOsgHuA
         D99HmcC4whSJgz5gGlf7RnIUrlJn8QTECMeDhefAMZk5GNr6C06cf0b70oCp1lAJw2o6
         dmgg==
X-Gm-Message-State: AEkoouselxpcli1xFaoq+PCQXtSrkJJDSSVc6mAA7/OShisn0By8ie/N4zK1XO5MIssFFZeGZNKDQUi09J8Qkw==
X-Received: by 10.13.228.196 with SMTP id n187mr27356460ywe.83.1471378792885;
 Tue, 16 Aug 2016 13:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 13:19:32 -0700 (PDT)
In-Reply-To: <xmqqlgzwd14w.fsf@gitster.mtv.corp.google.com>
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
 <20160815230702.30817-3-jacob.e.keller@intel.com> <xmqqlgzwd14w.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 13:19:32 -0700
Message-ID: <CA+P7+xrsbNpCjm_bQ6kBK=FGcWOr0WkuVnWyV6p_0FFEMKTxhw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] graph: add support for --line-prefix on all
 graph-aware output
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> To make this work, we have to fix a few bugs in the graph API that force
>> graph_show_commit_msg to be used only when you have a valid graph.
>> Additionally, we extend the default_diff_output_prefix handler to work
>> even when no graph is enabled.
>>
>> This is somewhat of a hack on top of the graph API, but I think it
>> should be acceptable here.
>
> Unlike the opt-prefix-length I removed in 1/3, the length of the
> line-prefix will never change during the lifetime of a single
> diff_options struct, so it might turn out that repeated strlen()
> on it for each and every line output is wasteful.
>

I could change this to store the length at option initialization,
probably a good idea. Would it be better to just store it as a strbuf,
since these know their length already? Or just add a
line_prefix_length field? I agree that calling strlen a lot is
probably wasteful.

> Other than that, I didn't spot anything immediately questionable.
>

Thanks. I definitely feel like this is somewhat abusing the graph API
because we're adding something not exactly graph-related. But in some
ways it really is graph related as well, so I think it makes some
sense.

Regards,
Jake

> Thanks.
