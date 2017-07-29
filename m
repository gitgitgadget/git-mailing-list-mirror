Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CE82089D
	for <e@80x24.org>; Sat, 29 Jul 2017 00:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbdG2AVP (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 20:21:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52763 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752987AbdG2AVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 20:21:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8F9B98092;
        Fri, 28 Jul 2017 20:21:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AnKfaAM7AcKIQtiTXHufl+MMNtU=; b=CiiUlG
        YLahpHdK2QYAL51Piwz/nvBEKOT51UEfarNIHoRXYNsTZJUqT3LVGRbqvrqj8Ddw
        CZXD1ur9wOkvHi4zKFfiqLiTcqukTH8Wv6bg1f8KB02gMOC4Pv8Crkl0y3tZYObN
        0kvDYWRkhmB1f7hDAOIOe4nJlysQSoZJxdyN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OeUrH+45n3HOIc3TX2iWDwMuZZmwfUxy
        qLVvUT/QLGVyotaTBq/RMCqOhVYNoc40O60Jc+cjo4k+6zFCAg7MEFrnjpEMizno
        GF6QwHR3nvHQ0TiMFMnLB7j0EHZ2lJyKFpFHnCWDoBRBLbu9pMVHQ/DxCWsYtB6V
        9HlCa668Yc8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B003798091;
        Fri, 28 Jul 2017 20:21:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F91A98090;
        Fri, 28 Jul 2017 20:21:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 1/4] environment, fsck: introduce lazyobject extension
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
        <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
        <20170728165035.2be61cec@twelve2.svl.corp.google.com>
Date:   Fri, 28 Jul 2017 17:21:12 -0700
In-Reply-To: <20170728165035.2be61cec@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Fri, 28 Jul 2017 16:50:35 -0700")
Message-ID: <xmqqinicks93.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D42351F2-73F3-11E7-B121-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> >  extern int repository_format_precious_objects;
>> > +extern char *repository_format_lazy_object;
>> 
>> This is not a new problem, but I think these two should be
>> called repository_extension_$NAME not repository_format_$NAME.
>
> Looking at the original commit 067fbd4 ("introduce "preciousObjects"
> repository extension", 2015-06-24), it seems that this was so named to
> be analogous to the existing "struct repository_format { int version;
> ...}" => "int repository_format_version;". The existing
> repository_format_$NAME thus seems reasonable to me.

OK.  They smell like "repository extension" to me, but probably the
fully spelled name of the concept is "repository format extension",
so using the word "format" out of that phrase sounds OK to me.

Thanks.
