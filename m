Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAD21F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758413AbdLRSoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:44:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753224AbdLRSoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:44:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5BBAC3CFA;
        Mon, 18 Dec 2017 13:44:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dWjxtaZsrBCrohgI5tof6BM0zOs=; b=wJKtgh
        4xq2HxCOSGeqUWDPtAW8c5dGF99UgsAuMGN/I2tv/K/eWHPVkb6G/rPPmCgzRD4R
        bA8VQ7lvgMM6fvkfSPss9jquT+b/koj9TCwEpCZClVGnPjTFHrH2wCY+q3JnNtDk
        74Kh5naVg7So7uVaCoO/hcDl3GIAlEKCI8JrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CcHdSuqAm1ZoTgaeN7tlaMh39Zl/52cY
        SUmb/K2YbXM54WcjuUQNrShlnUJJFIxQmlryF/OQSbdEevbjeVnRdNlZbwWILHpq
        AyRnyMfDFrBEjPkSrrKNslyv1bZOVZHw3ThUCX51YV0VON40VTkaJN0nX/DtEVPi
        mWT70UJo0Uc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED23C3CF9;
        Mon, 18 Dec 2017 13:44:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 143D2C3CF8;
        Mon, 18 Dec 2017 13:44:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
References: <1513600223353.28799@arris.com>
Date:   Mon, 18 Dec 2017 10:44:03 -0800
In-Reply-To: <1513600223353.28799@arris.com> (Magnus Carlsson's message of
        "Mon, 18 Dec 2017 12:30:23 +0000")
Message-ID: <xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C5BA81C-E423-11E7-9CF8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlsson, Magnus" <Magnus.Carlsson@arris.com> writes:

> ----> So far so good, but then an error message appear:
> error: Server does not allow request for unadvertised object 50f730db793e0733b159326c5a3e78fd48cedfec
> ----> And nothing seems to be fetched.

Yes, that is what the error message is telling you.  

You'd need to coordinate with the server operator so that the server
allows such an request; uploadpack.allowAnySHA1InWant may help.
