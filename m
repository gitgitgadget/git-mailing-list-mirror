Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF5C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F125207DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ymoc9W74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHUVlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:41:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54391 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUVlS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 582F9E4E40;
        Fri, 21 Aug 2020 17:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=znFVM3rsMdxZLsD9wBx5KDSfmB4=; b=Ymoc9W
        74bxucurrIwfaK7JgxmZlsgFPXlWu2vJlOmaBpZ6yN6Nj/uoeijNOJQP709f2Cjz
        HeE71sjicFxhAJXBVfVmM7rZ3WD/UNdtOm0J75wKjzVRfMNYPsgHfdOIWUkAc1FR
        kHnVp7TrBJIsLRihfGteHR1FprewY61f/lpTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpnDCNXX2kCdDBcBQ7E5WSLyDz8J7tmK
        PXDyJIjP6NkO1NGMIEQScMdj7NMcm08jbgtLIMIgXDalFtoD4TdgT7gaRqmfhyiR
        cVSztsCTz8evbn9LKxC15pbbDRruB/o+OcjfsFl1leFXjI7ALtoGGgIQ7IdAQmTx
        vHx0EQ4F+cE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50303E4E3F;
        Fri, 21 Aug 2020 17:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D596E4E3E;
        Fri, 21 Aug 2020 17:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC 1/3] refspec: fix documentation referring to refspec_item
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
        <xmqqk0xx455u.fsf@gitster.c.googlers.com>
        <CA+P7+xpew4-ZxcOjuTqq7B3ziYOpNzUWSaTMQLRnxZQPsb1PSA@mail.gmail.com>
Date:   Fri, 21 Aug 2020 14:41:11 -0700
In-Reply-To: <CA+P7+xpew4-ZxcOjuTqq7B3ziYOpNzUWSaTMQLRnxZQPsb1PSA@mail.gmail.com>
        (Jacob Keller's message of "Fri, 21 Aug 2020 14:17:58 -0700")
Message-ID: <xmqqsgcf7k3s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09049CA2-E3F7-11EA-B5D8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Aug 17, 2020 at 9:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>> > From: Jacob Keller <jacob.keller@gmail.com>
>> >
>> > In commit d27eb356bf25 ("remote: move doc to remote.h and refspec.h")
>> > the documentation for the refspec structure was moved into refspec.h
>> >
>> > This documentation refers to elements of the refspec_item, not the
>> > struct refspec. Move the documentation slightly in order to align it
>> > with the structure it is actually referring to.
>>
>> Makes sense to me.
>>
>
> Hi Junio,
>
> I'm thinking I should send the first two patches a separate
> preparatory series while I follow up with a v2 of the RFC of negative
> refspecs
>
> Does that seem reasonable?
>
> Thanks,
> Jake

Sure; thanks.
