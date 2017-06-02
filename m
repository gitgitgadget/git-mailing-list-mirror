Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC9B2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdFBSWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 14:22:18 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33839 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 14:22:17 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so54550168pfj.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PTsCrYuz/OgNnpipu3KKCfcT/akwzSCYGl1MIaMZBtQ=;
        b=E5d632IiMrpjUMDtZ9BqT9ar0Fjwo+3N/AKXjmWm/hGKr92Gp51aOBsmLXe70Ee3rM
         SkftgnC5B6M861J16aa5eIkGi0AGq3u5mxzXr5AR6Ozbf1i9YrqyuPKjTRao8cJ2Hk19
         576j3QuropYeHVyGVhx71hNuiTh/yHWiVmwOKw98f279Z+fRymnj3gRKHNDnQlRL4UE1
         HQuenZIAJvpVwNugnP/z47rPZgqrjPdJEeBF2hLamFpwVvQiLwltOhE/37gqaa44xQaw
         +4nF32nks2ua7jLtRoGnMrUZ+Nla+nOY5xegVk18i5xWfamkThGGhM2vgjYQEhkykBkj
         1vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PTsCrYuz/OgNnpipu3KKCfcT/akwzSCYGl1MIaMZBtQ=;
        b=oa0tFMfWOXkOu3XB9g1GY6U3hFn4v521nvwBufc7Z4cp4BByr8SO3K8nlcyct15sOo
         pAUvxXu01AO3Nu4Q487GmCs3Oqq3+nVHCgNvNPu8/FBSLhOucoqX0XZAPoydwPU88iM2
         srnr1ZOV9B9RubZXP+4V/Hy7gvaIQWOh0EOfmjqqOeTg+62HtSmZVhh/ah1o+aWBz8+b
         X4h9vuZavEmYwTUBnIsMaQg4Gr6JF/NsrcV0Zxste87iUL2PDMeKYyWeFBScLNlYsQy/
         p9ndS73rKMtHqVu82aKie22Lf/NzF2tiGsoVUFTwiOguibYAkyVKpScCidVKLkwmm1Bc
         P/5Q==
X-Gm-Message-State: AODbwcCQ1K0I4i0blOm/jDyGK3vL1oBWvbXDJ4u64uKZwa5+UKstczvc
        QpGZ9L3amTT2g/LkpLN/nA==
X-Received: by 10.99.60.6 with SMTP id j6mr8536548pga.18.1496427737093;
        Fri, 02 Jun 2017 11:22:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d2:8d21:abcd:1e61])
        by smtp.gmail.com with ESMTPSA id i71sm23317023pge.61.2017.06.02.11.22.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 11:22:16 -0700 (PDT)
Date:   Fri, 2 Jun 2017 11:22:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
Message-ID: <20170602182215.GA57260@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
 <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com>
 <xmqqtw3yyhzc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw3yyhzc.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Brandon Williams <bmwill@google.com> writes:
> >>
> >>> A month or so ago I thought I would lend a hand to Brian and do a round of
> >>> conversions from sha1 -> struct object_id.  Now that Brian's latest series has
> >>> hit master I can finally send these patches out.
> >>>
> >>> The first couple patches are from Brian which convert some of the notes logic
> >>> to using 'struct object_id'.  The remaining patches are to convert the grep and
> >>> diff machinery to using 'struct object_id'.
> >>
> >> Nicely done for all of them.  Thanks.  Will queue (with tweaks
> >> mentioned in the comments).
> >
> > Oops.  I won't be able to queue this for now as it heavily conflicts
> > with blame-lib topic.  The resolution should be trivial, mechanical
> > and boring, but takes time that I do not have today.
> 
> I lied.  This also conflicts somewhat with Peff's diff-blob topic.
> I think I resolved them correctly (there needs evil merges applied
> to two files when merging this topic), and hopefully can push out
> the result by the end of the day.
> 
> Thanks.

If it ends up being too much of a headache for you to deal with, let me
know and I can rebase on top of those series.  That way you don't have to
deal with the conflict resolutions.  Just let me know what you'd like me
to do.

-- 
Brandon Williams
