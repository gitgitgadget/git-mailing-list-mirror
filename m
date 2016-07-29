Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897CC1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbcG2SK0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:10:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34218 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcG2SKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:10:24 -0400
Received: by mail-yw0-f193.google.com with SMTP id j12so8766439ywb.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 11:10:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=COBINXVtQmQkSlo3cg+g3pgSXGATC/PekWxC+z3lwaM=;
        b=c4I5/tujCQ3sjnnvb+5ebOVgg8Blxe2BxEKsb/A4KBiB8VfGQKS02qWImk22pUsWZ+
         Rz5QGmN6UiwOLEgu+8O8FXQSGcj4T5zdxJ2/rzb56z0XEDodYb+DfnHQQhXKQ7JAPDSP
         YRBL3wBe4YfcU+tjJEEUtKYnzOcotvoFTf7/AhVcFzamHd0isKsVJZMaoDkQ9urXpxoC
         6QNEnFajUQLXQUpgXnoAMylL0d7zu6/nZX7HYCKHNAGYWdSjTMVLl1nsi7QntjFz/rRP
         92xMbRi0CCXLmdgRg6olURaK3qTbkwJP+OhUES6kJeqKWLIeEc/ns73RcbO34XzghuZw
         tgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=COBINXVtQmQkSlo3cg+g3pgSXGATC/PekWxC+z3lwaM=;
        b=NUz0pwCOwdl6nCtyL6ltSZa5E8JCyoJRUtYYGQioHvRgSWW+p0ZaJqfBPecr7QHA6p
         oSlotLf/YIh0VwSvMHjQMG1z+BDgWGvf+OnyDYqovgXDciGDL8/dBqXJBpwZLlyc9SF5
         GnmB96JyWlw7B2SqvFx8E4sPVy3BydcMYgyAPmhdLlin1aj1Fjm1dKFsw9la97d7AUep
         ZLbxEBDQOL1FE3azaXGlNybVfMpGIb+I2Tl8NFrnSYgoFert1m9LMG4TAqQVfZtYfHLA
         Fo7E3CwmDTKdlhP8UFqbRRklzP9VOLqV/RcpGuVK37ZhpFYs42oS2mPbSEjrm9P8KvZ/
         /FUQ==
X-Gm-Message-State: AEkoouswXds0oc5Z015+QV8kA87Fd7UfScXB2XTWrB00f5bbgsWTcf9US1akELs2dNkuZR6Fr+rAn7XibEPADQ==
X-Received: by 10.129.106.139 with SMTP id f133mr37402962ywc.163.1469815823749;
 Fri, 29 Jul 2016 11:10:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 29 Jul 2016 11:10:04 -0700 (PDT)
In-Reply-To: <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net> <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 29 Jul 2016 11:10:04 -0700
X-Google-Sender-Auth: gtpnoBEwFBbA9aMu_0WUtQITtAI
Message-ID: <CAPc5daX5FrUyk2UMJ47iPFwGbg_ru+GAny4uqrBL20k=uyO5Hg@mail.gmail.com>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 5:37 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 28, 2016 at 5:29 PM, Jeff King <peff@peff.net> wrote:
>>
>> I guess we want something like:
>>
>> +void reset_ident_date(void)
>> +{
>> +       strbuf_reset(&git_default_date);
>> +}
>
> Looks sane.
>
>> and then to sprinkle calls liberally through builtin-ified programs when
>> they move from one unit of work to the next.
>
> Maybe we can just add it to the end of commit_tree_extended(), and
> just say "the cache is reset between commits".
>
> That way there is no sprinking in random places.

Hmph, wouldn't that equally work well if we cleared at the beginning of the
function, instead of at the end?
