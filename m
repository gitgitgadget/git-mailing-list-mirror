Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175D01F461
	for <e@80x24.org>; Mon, 13 May 2019 22:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEMWow (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54440 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEMWov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:44:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8842215C5FF;
        Mon, 13 May 2019 18:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQkm45kSJgHfwh997nTuZQSxxkU=; b=f13DpB
        TJ3UTucTcSqGtwCGa43YIpnfNqKmqvmKLdkFdjhlDCWu7SGHQELbyVxDAEt7K2vX
        BlBLOdYkCBBTOT5T2MNXTIQIk0je/rvqwiqtI381alk+ikHMO1bib5+kgZcKKWv4
        JuAqPX99JPW+2OqoCbDC7ltPwp0H1rj8JRrIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xJg9PJTPHrQBc/Y3UIq8wf65wsUPFTTi
        J4LNxM2VqfnbCJGLjquyt5CJ2kxcKvWlLJhbVx5kdTce36JP49R9LGIL9YqPxWE1
        FsHMyxgdFXGeWROYPDcwBXVN4zr/WtTfq+L3p4ep5Gpbx0m71711mtHemdVWeBOL
        U68HuKxzrak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F56A15C5FE;
        Mon, 13 May 2019 18:44:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E636215C5FD;
        Mon, 13 May 2019 18:44:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: git --help not actually showing the git(1) help page..
References: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
        <20190513205301.GA22745@sigill.intra.peff.net>
        <a0afd3c4-93ff-31e6-a622-5751c6b5a549@iee.org>
Date:   Tue, 14 May 2019 07:44:48 +0900
In-Reply-To: <a0afd3c4-93ff-31e6-a622-5751c6b5a549@iee.org> (Philip Oakley's
        message of "Mon, 13 May 2019 22:55:47 +0100")
Message-ID: <xmqqwoiu9dpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B73FAC3A-75D0-11E9-A598-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> On GfW I commonly use the `git <cmd> --help` when things go wrong, so
> making the response to that give the right advice would be good.

There are three levels of details ;-) "git --help" is meant as a
shorter and sweeter version of "git help git" that is more detailed
than "git -h".

It is conceivable for an enterprising developer to write a set of
documentation with medium level details and make "git add --help"
give such a medium level doc, more detailed than "git add -h" but
more concice than "git help add".  Those who did "git <cmd> --help"
did not bother doing so.

