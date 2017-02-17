Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BE7201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964872AbdBQXOh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:14:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33006 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964821AbdBQXOg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:14:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so5973346pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0UswQk7tPfPFGMJZ+fy/+bcqUNRipkNU5m5f1AL8Syc=;
        b=GJ3aV4ILx7dbsllOdK2carzWr3hrJpo6ttYJGpb7OqV9vxqKTGItwIsZs2yHf7yogq
         0F4tHap/B74Tvo0/58nqtq4b0pEVXVJP39y3SyoTOEawgRS3jK8tSk/cGvdHe2Ll3cmg
         ul3zkNA5yyYL0s62v8hcovDkLmru465K9Em8n4e/Al/4TlRxNXtP5qqKqgj+9sF7ssOL
         zog39KGtVi/vPlivrZO8ekivCUuRgx4EmNBEw2KMk8x/H5b5LinLgeWh0uS+vNp00bjV
         UwgCF6slM/+sfHhvl/Q5YbE2ntAj0b13XA5dydh1WovfMvCTVlmgggoDmRRF3aWjksIM
         k5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0UswQk7tPfPFGMJZ+fy/+bcqUNRipkNU5m5f1AL8Syc=;
        b=ZBPkn8TOBgHsWQJNCmViPofQAFOB1slWGZvi8W3NRPJ69wJJ8B9icZk+LsSpe0I9Mh
         Ux7s8cz+Fq5vOkzAyoftOitPrwrgh2PjX60dwG1u6glUCRUC4MhkOMSc9Nk3agoNJbfY
         7e0eMAP27Z7CLMmPzLActvNfhQVnCkf7V5lsrPTZ4o8Fg4TdKK43VQgncdrp0CSXL2A4
         n3HiIlz43b3aTZzPmVT+02fCi8cuz1cM1PrlAwRC7UaFu+TujXW0kHkLG5DRM+bOeyM0
         9PrB6xP0fPtRN/Aq7CwSeLv9OiHIZTIFdck0Poqbp0aoC4lLU6clFi7kSE6e0lZYJ+I2
         9jUQ==
X-Gm-Message-State: AMke39msyUDkgwHyn4StOFKInO1mB/OcqoTUcoebkmxEHpO/NBUruFpA4x3nt8wCf6BJIg==
X-Received: by 10.99.52.196 with SMTP id b187mr12936803pga.131.1487373275456;
        Fri, 17 Feb 2017 15:14:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id y201sm11310802pfb.16.2017.02.17.15.14.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:14:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A_=2E_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/6] stash: support pathspec argument
References: <20170212215420.16701-1-t.gummerer@gmail.com>
        <20170217224141.19183-1-t.gummerer@gmail.com>
        <xmqqfujcpgky.fsf@gitster.mtv.corp.google.com>
        <20170217231246.GI652@hank>
Date:   Fri, 17 Feb 2017 15:14:33 -0800
In-Reply-To: <20170217231246.GI652@hank> (Thomas Gummerer's message of "Fri,
        17 Feb 2017 23:12:46 +0000")
Message-ID: <xmqq37fcpfza.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 02/17, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> [some people may see this message twice, as I forgot to check if the
>> copy I received had "Some A . Body" not enclosed in dq; blindly
>> doing "Reply-All" ended up listing an invalid address on my Cc: line
>> and dropped by vger. apologies]
>> 
>> > diff --git a/git-stash.sh b/git-stash.sh
>> > index a184b1e274..1446fbe2e8 100755
>> > --- a/git-stash.sh
>> > +++ b/git-stash.sh
>> > @@ -67,51 +67,20 @@ create_stash () {
>> >  		case "$1" in
>> >  		-m|--message)
>> >  			shift
>> > -			test -z ${1+x} && usage
>> > -			stash_msg="$1"
>> > -			new_style=t
>> > +			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
>> >  			;;
>> 
>> Did you mean ${1?"BUG: ..."} here and also "-u" below?
>
> Yeah, shell scripts are still confusing me sometimes.  Thanks for
> catching.  Would you mind fixing this up while queuing or do you want
> me to resend?

I'll fix it up myself (please remind me if you notice that I forgot ;-).
