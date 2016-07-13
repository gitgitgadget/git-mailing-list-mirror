Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182342018F
	for <e@80x24.org>; Wed, 13 Jul 2016 16:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbcGMQRF (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:17:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbcGMQRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 12:17:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3895529374;
	Wed, 13 Jul 2016 12:16:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E0g63X99HfuU
	BZcbFrjBpWxhpeQ=; b=VdiqagrPAes6dGq2cX9rHTJq+XChofSSiRqpVBj7Xdi4
	Pu2//zE9/jHNL4ntAgulEMli9cm0DcliTQFxxlgbHQkgOLLIb7MikhMbSd16mfHj
	hNzU/56rIxvErKo9Tq8skhx4zrpObpX0AgzPWUkv2iVoP4rR0dMD0cfUVQwlNpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QXthB0
	T0fD2cFSlWfa2XeJLGAuf/0SLP7IuvxnwyQ7VVD6FMLRNl9MLdPQtShHuUANu9x6
	ILctFV6DgiZ3ZpeJYZmVyFijnMMtMM1MeDUMdm6npXm6Qml2+8SOupOP6oN4GZG6
	6VUuI1jlHacgSK2rPLihMhzZhQEoD6qPdStD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 307ED29372;
	Wed, 13 Jul 2016 12:16:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B27D929371;
	Wed, 13 Jul 2016 12:16:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH v2 0/7] Number truncation with 4+ GB files on 32-bit systems
References: <20160705170558.10906-1-pclouds@gmail.com>
	<20160713154404.22909-1-pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 09:16:39 -0700
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Wed, 13 Jul 2016 17:43:57 +0200")
Message-ID: <xmqq8tx53448.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F427FC8-4915-11E6-9BC7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> A diff from nd/pack-ofs-4gb-limit can explain the changes better than
> me.
>
> I did not add PRIdMAX or similar because that carries a risk to exotic
> platforms that people rarely test. Just casting to unsigned should be
> fine.

Looks very sensible.  Thanks.
