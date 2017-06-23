Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5DE2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 05:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754007AbdFWFXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 01:23:21 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33164 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdFWFXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 01:23:20 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so18974716pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 22:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eBaeJXpfUeb5Q8hae+gSOxm1kuLc12aNEr+ctJ9jCmM=;
        b=gO1Ws5l4od5OWGN2zacSCG6bgASk8Dy8fG78pJyfdLxiVY1E/I/2ebGJqZhtPRop4c
         fqSdsodckQze1C3n535eQIlxZRTCKM7as/fLowUUZV49OLj2bECDNJ3PcByLWn87585K
         rYcr4EMWecN9bmnu9E9DjTnRf2GkGPsmXgN2m5rB5Mk15gqepk4fGe0+L5FrixxRgjLJ
         b0IjYgTEyozAD9ZK0kk1G/JzFVYLSTgLqoW34kiamtRfc7pGdLJyCI3AxIrHJJD+MrLN
         9g/zI4kUyeKxhyme2JXuirp9BxEb1EolBH8E/gpqiZSTeaq4M5Z9wm4vAPRIa/wQZBxH
         d4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eBaeJXpfUeb5Q8hae+gSOxm1kuLc12aNEr+ctJ9jCmM=;
        b=IIrgZqBUYG5WzkxFDFk0BuwksRSyYSW7VPTuuFA01Jp1nvwqRj+bVM2Iz2RW8s0bE5
         NH2mimtEt1GdQypbDjKgKUFvgg+OjaN1GC7LkUDN7+GPZzjeJICqnTUXZYFx4/SrwMn7
         UxDL5W0uwUyaTBzGyf713MFeARNdWy58aq0e1HWAVQEhgzy3AwsyiGD+AJJbmwnoYlQU
         bZasEZe29nP+TQnA1d2GohCsLwKlRpSvheHEaeaPxu1E3llAo+tb7kzs3zmXwaxYH7Ec
         YSxkDP/98iWRrXFl/n0yYKR6mot8KI7w1UDYS8D+8RdtIHjahxPzIJOWwJmwm1rhrDRd
         bu8w==
X-Gm-Message-State: AKS2vOwybpasYlF2VADa12a59qeOdZ+OBE6cIrShAuLGYcoyDJ/TDxtN
        3opMaLVD+JRejw==
X-Received: by 10.98.58.78 with SMTP id h75mr6203698pfa.50.1498195399647;
        Thu, 22 Jun 2017 22:23:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id u73sm7279210pfi.105.2017.06.22.22.23.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 22:23:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
        <20170622124803.45sduodpfbwuuq52@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
        <20170622134708.fcc4zxakga6p255x@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
        <20170622204628.eintlap4uchlncub@ruderich.org>
        <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
        <878tkjk7m7.fsf@gmail.com>
        <20170622232156.vptuoafdtglokujw@sigill.intra.peff.net>
Date:   Thu, 22 Jun 2017 22:23:17 -0700
In-Reply-To: <20170622232156.vptuoafdtglokujw@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Jun 2017 19:21:56 -0400")
Message-ID: <xmqqshirffay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +You don't need to be subscribed to the list to send mail to it, and
>> +others on-list will generally CC you when replying (although some
>> +forget this). It's adviced to subscribe to the list if you want to be
>> +sure you're not missing follow-up discussion, or if your interest in
>> +the project is wider than a one-off bug report, question or patch.
>> +
>>  The maintainer frequently sends the "What's cooking" reports that
>>  list the current status of various development topics to the mailing
>>  list.  The discussion following them give a good reference for
>
> You perhaps already read it, but you may want to steal wording or
> suggestions from the mailing list section at:
>
>   https://git-scm.com/community
>
> which is covering the same ideas (and vice versa, patches to that page
> are welcome if the README says something better).

OK, so... Ævar's version does not mention:

 - text/plain, which is a very good addition.

 - note about CC in a way as useful as the "community" page does,
   which may want to steal from the latter.

 - the archive, but it may not be needed in the context of this
   document.  "Read the archive to make sure you are not repeating
   somebody else said before speaking" is something we silently wish
   everybody to follow, but it is something we do not want to say
   out loud, especially to new people.

 - Windows, but I am not sure if it is necessary or even healthy.
   One thing I would rather not to see is the Windows mailing list
   becomes the first line triage place for any and all issues that
   were experienced by a user who happened to be using Windows, and
   majority of the issues turn out to be unspecific to Windows.  I'd
   suspect that all of us rather would want to see the referral go
   the other way around.

Otoh, "community" page does not encourage subscription as a way to
ensure you'll see follow-up discussion, which may be a good thing to
add.

A tangent I just found funny is this paragraph on the "community"
page:

    The archive can be found on public-inbox. Click here to
    subscribe.

Of course clicking does not take you to a subscription page for
public-inbox, even though the two sentences appear to be related.

Perhaps swap the order of the two, like so, with a bit richer
explanation taken from Ævar's version:

	... disable HTML in your outgoing messages.

	By subscribing (click here), you can make sure you're not
	missing follow-up discussion and also learn from other
	development in the community.  The list archive can be found
	on public-inbox.

