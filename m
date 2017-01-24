Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E4520A17
	for <e@80x24.org>; Tue, 24 Jan 2017 01:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdAXBLj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 20:11:39 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33210 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdAXBLi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 20:11:38 -0500
Received: by mail-pg0-f48.google.com with SMTP id 204so49639979pge.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 17:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCq4tPEENLLVvOh0Iuy0vGnD5R/geyTYqidwS0Baq9E=;
        b=pPrwnPSQxzynB4fexFhhki4urkZlxFPidRB+i2Xur0rNahiJg50pmX+eOKpSpllzc7
         S2X3BxRM+pqaPu0172Z09PfkSMYLsH/mzw8EeAvHUqDlJ8s4avhtS1HFDHfa4JPp1aZR
         ZPgDOdJ1oMVkV0T3Er6+6t3M5QFDx0Q5tRnmu27lInO5/NztaENNJiPNBL21g/CC3l/T
         EEBX2EkQtaIBo6iRKb/CNthWSUeLgy4QMPHlWzEWSNr2Tn0KiELXsyF5v4l+/gdG2tII
         Tvuy/1gpG7B17z4cXwumdBYXpA6DBgrdMtKGu00/FmtKJhku3QJzfrjSfg375BuC4Ltj
         /aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCq4tPEENLLVvOh0Iuy0vGnD5R/geyTYqidwS0Baq9E=;
        b=fZbCjsQn/hD/HZfmhaykyLUTaXd2WKnPDHDLct7S35lV9v2W/cILW3zdSrGaRz5vDN
         QtsZaZXl0OVjBawQesGDaCgOwwCJxoALjZdkSsGwK4LJ5dr6hYflFUj7uuQRhhhNPQTH
         quQQBFwdn2ZtTmw5v0A8jJfh5TV0/AFfsTcCtzryCi4mxEDHlokwJ/6ym2x76ns3jCif
         4AfMQNKXlfZ80dMqnqAtyGF2aOkraTrlrhV2wgYDPHdZnRIrJTv1hIbmLlHyHDrkkTHa
         zByNwD+fU1+U/QztMqP5JeGQ7yoGC298apDW+a8u/gOb2HGeUTv4yzhGW8r9CnCV8JIY
         ISnQ==
X-Gm-Message-State: AIkVDXJarl4QR5gFuZEtqDuPqrB56fda8thjRQ75PSa9A6Jg0Onltcb549WxisbioHZDkRUy
X-Received: by 10.84.198.3 with SMTP id o3mr47350082pld.170.1485220297815;
        Mon, 23 Jan 2017 17:11:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:19da:d768:d0e6:f301])
        by smtp.gmail.com with ESMTPSA id p2sm539751pgd.17.2017.01.23.17.11.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 17:11:36 -0800 (PST)
Date:   Mon, 23 Jan 2017 17:11:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check
 structure
Message-ID: <20170124011135.GB187696@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com>
 <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
 <20170123220614.GA187696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170123220614.GA187696@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Brandon Williams wrote:
> As we discussed off-line I'll also do the rework to break up the
> question and result.  That way two threads can be executing using the
> same attr_check structure.

Thinking about this I don't really see what we would gain by breaking
them up.

Right now most callers have a static attr_check struct which holds the
question and answer (and in my series a buffer of all_attrs used during
the collection process).  If this struct is broken up into question and
answer then the only part of it that can be shared with multiple threads
is the question, which ends up being an array with 2 maybe 3 entries on
average.  The result and the array of all_attrs would then need to be
allocated each time calling into the attribute system since they can't
be shared.  Since this allocation is already going to happen wouldn't it
just make sense to drop the static modifier on the check structure (or
have a per-thread check structure) if you really wanted a particular
function thread safe?  It seems like breaking the question and answer up
doesn't buy you much in terms of reducing allocation churn and instead
complicates the API with needing to keep track of two structures instead
of a one.

-- 
Brandon Williams
