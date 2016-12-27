Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E721200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbcL0TJr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:09:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64204 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754578AbcL0TJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:09:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E557459A91;
        Tue, 27 Dec 2016 14:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1hbeJuhqqD57tI/Mu0dyBi+/+hc=; b=rscCMn
        wkmLAl4JwmKXRwGWUwMKIVavUAr/hUvhBL/VE49tyatEKvXrWlgdf1+7QyhdtKIN
        n8AuUW0xg1TtJIpSTQDl7AtZk/DxmaZVtBq26BOJ7oCSL5pMNopEPDzHc2Qxm1/F
        l01CwNz1U4P7bfbdrp01C/UeuUYbszFBKHJ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LxZEQp98sZNCmGSsrkpDuPC6Z4MOHfJo
        +xOAHf7u8gtzmtElw15TrCc5NPj5NnfbS1Q2mMmMdI3XFGrY+SZ0+zAGTuYHbfuO
        h/NZBNZYMTQH1PSd8XN1M993LTmfdjcxxQTAowxrI8t7J9D55TLL7fy350s5HncY
        EOUGOLL+RYg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D958D59A90;
        Tue, 27 Dec 2016 14:09:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60E4659A8F;
        Tue, 27 Dec 2016 14:09:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 13/21] sha1_file: make check_and_freshen_file() non static
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-14-chriscool@tuxfamily.org>
Date:   Tue, 27 Dec 2016 11:09:43 -0800
In-Reply-To: <20161226102222.17150-14-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 26 Dec 2016 11:22:14 +0100")
Message-ID: <xmqqh95pb348.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06CD335E-CC68-11E6-9ED7-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This function will be used in a commit soon, so let's make
> it available globally.

See comment on 14/21; I am not convinced that this is the function
you would want to borrow.
