Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9972021E
	for <e@80x24.org>; Wed,  9 Nov 2016 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbcKIUMq (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 15:12:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61249 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751550AbcKIUMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 15:12:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7DC94CD85;
        Wed,  9 Nov 2016 15:12:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1A/oNCWx4oCu
        CG7gEviCUBPExAM=; b=h7OnmQvbgPrW+Bd7AIuHIFnv0+5KTW8GrIueYs2cvllf
        m6akDxd1IW7xFKNKXbVaQlyVcWlkY5NRmlH80CKS3A/enXZZ2+VjIZL5FP5ixg5C
        r89Y7CQe1Bz+Da5ERzqGZ0imo9JWv1otiNUSAPsWGdavyFJAPDKPADw4qqR3/dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=elbTL2
        Khs9vb7frhXK0kzJE0/+Xt/jVIuLD6LhUEtI5INPy5+hCWML14hj6FT2KvYiF6MG
        UQP6F+9bFhVbbu/9Q8sPP8imB0YwVx5t39IApL8per38d0Vakn5HwdGhFqlLMLyu
        8KkvI38QoO0ooFuG7LDGARncUZWceQnycQXLs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEF204CD84;
        Wed,  9 Nov 2016 15:12:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40D154CD81;
        Wed,  9 Nov 2016 15:12:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] rebase: add --forget to cleanup rebase, leave everything else untouched
References: <20161026094658.20704-1-pclouds@gmail.com>
        <20161109091131.17933-1-pclouds@gmail.com>
Date:   Wed, 09 Nov 2016 12:12:42 -0800
In-Reply-To: <20161109091131.17933-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 9 Nov 2016 16:11:31 +0700")
Message-ID: <xmqqh97g9zut.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF5AA42A-A6B8-11E6-BF07-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---
>  v2 changes just the subject line

That's not sufficient, is it?  What you did in the documentation
would raise the same "Hmph, is this only about HEAD?" and unlike the
commit subject, it will carve it in stone for end-users.

