Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C391F461
	for <e@80x24.org>; Thu, 27 Jun 2019 16:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF0Qru (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 12:47:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50380 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0Qru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 12:47:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44FE769855;
        Thu, 27 Jun 2019 12:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZFFK34vAT2iYli+kTsIpKBAyE2k=; b=L9AmxW
        fuwez/nX+oOnOFtMvtB597ZmnZN6jAVhi1F3QrsOUxi46eI9UywSRGgojx8sixqX
        6owUle48roWGWnZH53MOHDNeX+docCEFnY01FzzQ7UgwSG/y7S3hBHvUNLaZeXKw
        2rR55X+Wy1R2+M9i2xaQbObiEC4xQkGiEuK10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4cBc3Ss9kKooZTI04g4OeLEY/f8Nxsl
        m72l2ZF/jd1rlm0TbUypBzk6DK5b3IeLFDp9g/U3JvJUH/dspRJcmGTbkzfUpcQA
        qe44BIyjLPCgjPfahZUisQeovm7ogVi8WEQ77NSCJuGCWS+dAOZvCEPIHeFYHCoi
        Pi141tmtRpM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D40169854;
        Thu, 27 Jun 2019 12:47:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5607669851;
        Thu, 27 Jun 2019 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kyle Meyer <kyle@kyleam.com>,
        "Boettger\, Heiko" <Heiko.Boettger@karlstorz.com>
Subject: Re: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control resolution process
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
        <20190626084139.30246-1-pclouds@gmail.com>
        <xmqqk1d8ch9g.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AB+YVNi07G-nFkEhexyo2TG=qeNLT=JLksDVnDvs0gxg@mail.gmail.com>
Date:   Thu, 27 Jun 2019 09:47:43 -0700
In-Reply-To: <CACsJy8AB+YVNi07G-nFkEhexyo2TG=qeNLT=JLksDVnDvs0gxg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 27 Jun 2019 09:52:45 +0700")
Message-ID: <xmqqtvcbasb4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49C99014-98FB-11E9-B16A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> If refs/heads/master does _not_ exist, then ref/heads/master can
> resolve to refs/heads/refs/heads/master, which I think is unexpected.
> "ref not found" error or something should be returned instead.

Ah, that was what I missed.  Thanks.
