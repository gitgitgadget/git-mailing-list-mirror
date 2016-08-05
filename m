Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7392018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947091AbcHEVuF (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:50:05 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36663 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S3002424AbcHEVuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 17:50:00 -0400
Received: by mail-wm0-f50.google.com with SMTP id q128so45784415wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:49:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/IVl7MaYwhrfGda7r80UXEu/Jt5D0tFXqefFCaQPhUU=;
        b=LkJ7Q7vP/DElX38plpf2A5BnhJat0I11XH2z2K52NzQyP9d/pm48MfsKDv3yqh9hQS
         YAGPivddMCNra3WVp9Vo36omg1lP8lYIK/nLPiTxsnR9pNzobZAas8Xb6HB+K+Xgw6GG
         fez/hS3UmZegIjfj4t/XIdIbSROJh/ComIZ8iP1dTw24oKqB5DRHc9q3J1M9ttVQVqHP
         RS9DuL71FNucILnEt70VxMaiEJde0BrJuWg3+LOlPtpeeVvlquk4fBdgUERHj5EjzBzS
         cdE79uINwtKHebIKcLjjKZGHYJ29oxLA1rEmK/JvxAH2UoaqT+1CujxKZmU5dyGZ8tcD
         3giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/IVl7MaYwhrfGda7r80UXEu/Jt5D0tFXqefFCaQPhUU=;
        b=nAbKsleCwwQophkHEegLFV8lg6Fo3TMBQwbiXJCDx0w/dryvMPWNQL+yO0tpPgQfbD
         hc74h8kkFBfsWRGjko4qpiddpKmYCwCdkzXKdMMYETXNd+3T5jbovjVkJxBdlUlt1QAR
         A3WWtY5UaZJicA4J9ly7c/epgR9KI2p+YEDp3je9klyf23GSZhvFV8Fj7VoGRjq13RTG
         MiI1j1SDgkGNg3SnvtmkpOhWUZ/ZoYDemjPWxgpA0Hq4VxSrPCZknMAAnYgVWZkQMDzJ
         f/qpFDmTmOcPCvoQZeBUMxKaeA/S/t59h0ZK+2HyJIufJsA/fSdNKCyyozXsIy4PNCTp
         VmUQ==
X-Gm-Message-State: AEkoouuU5ymW6uP8t19836OWC/NSR720pbwEki9IdjNxNx2km59nOI1SBBlNcqLHjj0wYQ==
X-Received: by 10.194.101.225 with SMTP id fj1mr80409069wjb.57.1470433798010;
        Fri, 05 Aug 2016 14:49:58 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB641A.dip0.t-ipconnect.de. [93.219.100.26])
        by smtp.gmail.com with ESMTPSA id 3sm10501963wms.1.2016.08.05.14.49.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 14:49:57 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
Date:	Fri, 5 Aug 2016 23:49:55 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <59C5366C-AB41-49D9-8FFF-F109AF242580@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
To:	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 05 Aug 2016, at 23:34, Torsten Bögershausen <tboegi@web.de> wrote:
> 
> On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
>> The filter is expected to respond with the result content in zero
>> or more pkt-line packets and a flush packet at the end. Finally, a
>> "result=success" packet is expected if everything went well.
>> ------------------------
>> packet:          git< SMUDGED_CONTENT
>> packet:          git< 0000
>> packet:          git< result=success\n
>> ------------------------
> I would really send the diagnostics/return codes before the content.
> 
>> If the result content is empty then the filter is expected to respond
>> only with a flush packet and a "result=success" packet.
>> ------------------------
>> packet:          git< 0000
>> packet:          git< result=success\n
>> ------------------------
> 
> Which may be:
> 
> packet:          git< result=success\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000
> 
> or for an empty file:
> 
> packet:          git< result=success\n
> packet:          git< SMUDGED_CONTENT
> packet:          git< 0000

I think you meant:
packet:          git< result=success\n
packet:          git< 0000

Right?

> 
> or in case of an error:
> packet:          git< result=reject\n
> # And this will not send the "0000" packet
> 
> Does this makes sense ?

I see your point. However, I think your suggestion would not work in the
true streaming case as the filter wouldn't know upfront if the operation 
will succeed, right?

Thanks for the review,
Lars

