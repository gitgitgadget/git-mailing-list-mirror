Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7ABD20281
	for <e@80x24.org>; Tue, 31 Oct 2017 02:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdJaCoe (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 22:44:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60560 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751399AbdJaCod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 22:44:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A28CA90DD;
        Mon, 30 Oct 2017 22:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eso7Dc3yAsj4QjbsoVOSBTZEQws=; b=akzCrG
        ODD+197EkuON/+bREZiaREgEhxKZfhAS4eOaR9cX7MGbtG/3a0NlB9B5MsMW48iO
        vZrTZpLAwS6ZkqO27ecpylpZyuU6Eqv/TpgAvxYivbuONZzwCyeSEXHNE4JLbXAu
        rdNI/rstOjZq3rGFw5OzoTGPI7tEcwEUnle3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x3/qDmOOGbpFxgBIxsFPtVnvIu28F83D
        k7FYAQAJoBjoVe5h3S4lRTpz6HZB1W50ncHar27don6O8G39gIihy2Y4PZxCcjjD
        qXliDl2EdZJKmVKmEykHc8D4BXtCpCWlNAJmpZVAXhFzP+RHQJA1levE1DGhvIAu
        lhr4cp8GLHM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3134BA90DB;
        Mon, 30 Oct 2017 22:44:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A574A90D9;
        Mon, 30 Oct 2017 22:44:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Re* Consequences of CRLF in index?
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
        <20171027170745.2125-1-sbeller@google.com>
        <CAGZ79kbNMWqPkk9PGDH44YYPC=Mgqk4+sTmRwQUGKF_JCmbpLA@mail.gmail.com>
Date:   Tue, 31 Oct 2017 11:44:31 +0900
In-Reply-To: <CAGZ79kbNMWqPkk9PGDH44YYPC=Mgqk4+sTmRwQUGKF_JCmbpLA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 30 Oct 2017 10:20:59 -0700")
Message-ID: <xmqqpo942fzk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CB5CCC0-BDE5-11E7-8C52-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> (I note this as you regard your patches as a lunch time hack
> in the cooking email; I am serious about these patches though.)

We do not want to touch borrowed code unnecessarily.  Are these
lines and bits hampering further progress we are actively trying to
make right now?

