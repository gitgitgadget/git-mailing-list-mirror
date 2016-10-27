Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4051720193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030453AbcJ0W1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:27:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57804 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964947AbcJ0W1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:27:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D2774B770;
        Thu, 27 Oct 2016 18:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oqWXDiftAgNRVxuL+vjDwGR3zpc=; b=T3f56u
        WIf+q9TA8suzZN6YvvDiDDXgPZMWUx7OhJU0h0zmUbDTE5hB+0az+PFGfbib1yJQ
        gk+koi+Typ5FF4ZV9ilGepqRoPTkR3xdW6DumZ23Fuce2cd0eB8jlxJzLafFiwnD
        u+GpmPiqKtlXpEF1HN+HW+RaVFQE6oOeOFqp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VId4VbY2NG2JKmzsCRNS6qkusPkcBvEL
        Ta/cBlpLqWKs9TU20+47BFozt8DnO1Hh4ctDtaenqRpzPqxFy9WRH49eXeluAd4D
        LMvXfKrZKkUbJdbXn+n/5GILzWuqPhjt6X0PSvie3yfBHwTqAW1OcWx1hEWb1zRk
        H7gPQWciyVY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 340FB4B76F;
        Thu, 27 Oct 2016 18:27:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A5AA04B76E;
        Thu, 27 Oct 2016 18:27:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Rood <mr.john.rood@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: feature request
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
        <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
        <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
        <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com>
Date:   Thu, 27 Oct 2016 15:27:44 -0700
In-Reply-To: <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com>
        (John Rood's message of "Thu, 27 Oct 2016 17:24:08 -0500")
Message-ID: <xmqq1sz15swv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95FE30EA-9C94-11E6-88E6-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Rood <mr.john.rood@gmail.com> writes:

> I suppose I can do git config --global core.editor notepad
> However, this really only addresses my second concern.
>
> My first concern is that using a text editor at all seems like
> overkill in many scenarios.

Nobody stops you from writing a "type whatever you want; I won't let
you edit any mistakes as I am not even a text editor; just hit
RETURN when you are done, as you can only write a single line"
program and set it as your GIT_EDITOR.

I do not know what would happen when you need "git commit --amend",
though.
