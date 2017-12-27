Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB6F1F424
	for <e@80x24.org>; Wed, 27 Dec 2017 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdL0SMl (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:12:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdL0SMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:12:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E526BC3A9;
        Wed, 27 Dec 2017 13:12:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OAYPmvlXJEM7LynaAfh1jV9dUM4=; b=J/R7xt
        vUlBtgSxmoAY9g9I0vSsSzPkOUy4xuVr2vp9RiZR6x7HGx1HWRXUXvOwvhUDqUEx
        QIj5Tbk12Mp6gCqdMpwHwwwzX+5XKYYqLBKKdAmJvB5Xr5FOT6kyzYb2rMCeRcPf
        oXzRS22AZxUmNaCMVKvLohTjE19fSEBbAd3ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JyQRISokKKF267kHtyzg92pMIIPZglGa
        N/e/4qZ4JugI5VymX3FhaajHmoWXD0AJFCSIYabBgP3qR/4R+veh7Nx+kbnAglu2
        yAKWTE99Ik+ju85LTU2dd40Ej/laGBJ+SWMI3Fob7onzhMVjHvfTFDSyA4uem8nQ
        6AN9xTFs3s4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66D44BC3A8;
        Wed, 27 Dec 2017 13:12:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5671BC3A7;
        Wed, 27 Dec 2017 13:12:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, alexmv@dropbox.com,
        git@vger.kernel.org
Subject: Re: [PATCH] status: handle worktree renames
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
        <20171225103718.24443-1-pclouds@gmail.com>
        <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
        <20171226021150.GA10059@duynguyen.vn.dektech.internal>
Date:   Wed, 27 Dec 2017 10:12:38 -0800
In-Reply-To: <20171226021150.GA10059@duynguyen.vn.dektech.internal> (Duy
        Nguyen's message of "Tue, 26 Dec 2017 09:11:50 +0700")
Message-ID: <xmqqh8scnip5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 866691DA-EB31-11E7-BEBD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Or we disable rename-from-worktree when porcelain v2 is requested (and
> optionally introduce v3 to support it). Jeff, any preference?

I actually think disabling rename-from-worktree consistently may be
the best way to go.

