Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222A320958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbdCWR4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:56:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935130AbdCWR4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:56:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 314ED88A53;
        Thu, 23 Mar 2017 13:55:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hf+O6TY1Aau2BYYB0NM2SvZErq4=; b=qBQrDw
        rgeBekwL1uE4un2uz+KChhdSupF4t4cgoSdAgNqY5PJmo0MfTF8QGPW/Vx6K1aJr
        /kLpY5abDmob7pl6oWDLQWqX6IB6rAXx1+xOikY/RCj49x2Ix/G0krCwj45XFclJ
        wfRKZl1LN94SGf/fHT9Rm1uUtrysrtUvYGhQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cG8ou74jEehLyA7LigXlrwqooVl6FEj9
        U22nMsxc/O/LNSAiljWln3De0tku3SS+zTXILyQwjlMHEaFmekNbRipvSdEzJoc+
        zwLNghKEn7OPyIWNaDnYMANLiuYh6W7g5TSoh00WJedZ3CnxWn4f6WFYd6OLelNp
        9dE/JPSeoVs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2987888A52;
        Thu, 23 Mar 2017 13:55:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 905DB88A50;
        Thu, 23 Mar 2017 13:55:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
        <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
        <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
        <20170320185038.GU26789@aiede.mtv.corp.google.com>
        <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
        <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
        <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
Date:   Thu, 23 Mar 2017 10:55:57 -0700
In-Reply-To: <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Thu, 23 Mar 2017 18:06:23 +0100")
Message-ID: <xmqqd1d7ev2q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F856824E-0FF1-11E7-BE6C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Are we at a point where we can still rename the new feature at least? If
> yes, and keeping everything else is mandatory, than "workspace" or
> "working space" may be a serious contender for naming the new thing.

I do not have a good answer to the first question, but workspace
does sound like a good name for what this feature is trying to
achieve.

