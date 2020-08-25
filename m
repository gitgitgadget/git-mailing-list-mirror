Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5F5C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D8320782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLuLEhA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHYQKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:10:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56510 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgHYQKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:10:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF8AADCC74;
        Tue, 25 Aug 2020 12:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RqPdiRitvooaLv/Z957vXIT1J7U=; b=ZLuLEh
        A2BnVgW3p7ZIVyhlPqMkW9AbeeSDMlFG3pWneZLBiLScPa296084RZq6RaG+nNcs
        Rilysk+VG6NERnbl9aboZZnU4N0Q09Bgx9qaDS4RodZk4OWLo4Bxt9gKw6FA+uoD
        wI6DzX3bOkQ/ZgijUAXI43kxX3diqM5jb2gok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=itrHUrDeAzeMHmUhr2pR7mccMYs9qhgC
        wmmIXcBuT8LGZqUxHj44kMPdzVRdA2Mh13H+JBpFZNHNbLyKVJBJPNYS+5vKMDUl
        R5vOoNXtsltilFGkaa1Dk3Y8tvnD9If/903SFZOjx74+kxLdtPUKiH/lmXrdtFY+
        e9C/hQx4jf0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7585DCC73;
        Tue, 25 Aug 2020 12:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12A29DCC70;
        Tue, 25 Aug 2020 12:10:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
        <20200825113020.71801-4-shouryashukla.oo@gmail.com>
        <2a1ea501-4974-4d74-fe3c-d173bbe76855@gmail.com>
Date:   Tue, 25 Aug 2020 09:10:35 -0700
In-Reply-To: <2a1ea501-4974-4d74-fe3c-d173bbe76855@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 25 Aug 2020 20:03:24 +0530")
Message-ID: <xmqqlfi21zb8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8331BFC0-E6ED-11EA-A855-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> @@ -1061,8 +1061,9 @@ static void generate_submodule_summary(struct summary_cb *info,
>>  	}
>>  
>>  	if (S_ISGITLINK(p->mod_src)) {
>> -		src_abbrev = verify_submodule_committish(p->sm_path,
>> -							 oid_to_hex(&p->oid_src));
>> +		if (p->status != 'D')
>> +			src_abbrev = verify_submodule_committish(p->sm_path,
>> +								 oid_to_hex(&p->oid_src));
>>  		if (!src_abbrev) {
>>  			missing_src = 1;
>>  			/*

Interesting.  There is a mirroring if-else cascade that begins with
"if (S_ISGITLINK(p->mod_dst))" immediately after the if-else cascade
started here, and in there, the same verify_submodule_committish()
is called for oid_dst unconditionally.  Should the asymmetry bother
readers of the code, or is the source side somehow special and needs
extra care?


