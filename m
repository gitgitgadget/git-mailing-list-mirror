Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F88C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA79E2080C
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dQvMmd4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbgDBRnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:43:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60260 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbgDBRnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:43:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43C805FEF5;
        Thu,  2 Apr 2020 13:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymZUBcA0kdenKWAn/Vb9LoGmBgk=; b=dQvMmd
        4rwb7p4jwMHm8p1U87YA5cmeidx9Hpp6qOEq/O0sm+8vB9EkY3AguwSGrOk0ajzZ
        bbOBoNJpiPUESp70Mpu1AEllvrBUBlV5e72vKQHKKu8oBNrRHfl1CLrRlHIDi/9c
        DbgfLy1dJtPXn+v/0hGxXmni72mmmV2RJ3ws8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tulo3/2seyOOiEpOM0TyOhWqAtTvCKQC
        VLfhDYjgtFDm63xu263OB6F07tzlRRdFoeQbCnkILT3YZX2Szml+qgceVqxq4Zpe
        5QTKCpGMxEd3rD0pfV96BUSgeksOAs6f3chATUsQYeAOvtegIdkp6DzPnkinlG2e
        CfIKikYvpQk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFFA45FEF4;
        Thu,  2 Apr 2020 13:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6855FEF3;
        Thu,  2 Apr 2020 13:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
        <CAN7CjDC-cSQtJmShc6iXyW=1LWBXk0_KX1OaZK8_TEnHbsX0NA@mail.gmail.com>
Date:   Thu, 02 Apr 2020 10:42:59 -0700
In-Reply-To: <CAN7CjDC-cSQtJmShc6iXyW=1LWBXk0_KX1OaZK8_TEnHbsX0NA@mail.gmail.com>
        (Miriam R.'s message of "Thu, 2 Apr 2020 08:56:35 +0200")
Message-ID: <xmqq1rp54wd8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6549C30A-7509-11EA-BEBC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

> I sent a v2 patch series of "Finish converting git bisect to C part 2"
> twelve days ago:
> https://public-inbox.org/git/20200321161020.22817-1-mirucam@gmail.com/
> and I haven't received any feedback, who could review it again?
> Also I was wondering why the patch series is not in 'pu'.

Unfortunately what's not viewed won't touch 'pu', and a topic
without many interested parties can be left unattended for a long
time.  In an ideal world, capable people would drop whatever they
are doing immediately after seeing others' patches on the list and
spend their time on reviewing them, but the world is not ideal X-.


