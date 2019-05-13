Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4991F461
	for <e@80x24.org>; Mon, 13 May 2019 08:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfEMIum (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 04:50:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54501 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfEMIum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 04:50:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 191B377A48;
        Mon, 13 May 2019 04:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W1mT24saDThN
        PvQFOOx/wXXoNvQ=; b=Ocl6YobfUy5JOqFYlvV0b6YXaWS4Bot9bZObeFHNbDoI
        dp5OrCYJxemhyqOrUlmxMTybDc66MXtHfDbNUD21K8CsqgTNZRLbifM4rVZJgmnp
        vOUUqWtRjt0fnZITzDn8MlXKUXLMo+zcffvopQDL0bfo7fxAA0VQn2P1YALj4NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zud9ls
        M3C5JAuZQUo68mkH5YDzDrGIhwXKdu8SZWzU4sVnZ/amXcabHY9W6MyJ/I8UL7Ad
        0XIDy7ye72sWhNyIpQ1HgDQyyepX9lvcIqvtuUeANyVY9XdKo0qsbL1UcLbh8PFm
        5OHZg9aYiFQfcO/Tx2Bhqy8bpP2CgaF8W2RD4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10B4177A47;
        Mon, 13 May 2019 04:50:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C11E77A44;
        Mon, 13 May 2019 04:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
References: <20190508105607.178244-1-gitster@pobox.com>
        <20190509114830.29647-4-avarab@gmail.com>
Date:   Mon, 13 May 2019 17:50:35 +0900
In-Reply-To: <20190509114830.29647-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 9 May 2019 13:48:30 +0200")
Message-ID: <xmqqmujqbuw4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D8517B0-755C-11E9-83DE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  # Variables we fill in automatically, or via prompting:
> -my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@initial_bcc,$no_bcc=
,@xh,
> +my (@to,@cc,,@xh,$envelope_sender,

,,???
