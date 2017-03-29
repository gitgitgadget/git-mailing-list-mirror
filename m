Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680C020958
	for <e@80x24.org>; Wed, 29 Mar 2017 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbdC2RPT (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 13:15:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52523 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753782AbdC2RPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 13:15:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B4ED858F0;
        Wed, 29 Mar 2017 13:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PG1qzKdhb+M7r2yOLhRqChcdgnI=; b=IPF6Vl
        jvou0iH9cXIgvld4T1V47cV6IRHTMfRucpg8TZdZJJjV8WNTvmMs0G3tPbyaqISX
        bphajpqiLWaAvTCT5hx4LLdRPVXhVWTLIqjXUV88UtatB+RRELPK3xXyrM7pvtHY
        uBXnOgYeYoTtMKhcE3qqZr6uwxdctw44RqVdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HVh4FQbxe10YgzDWl4Gzrb+5nhmmgqHw
        cOo3SdRxSEM8iDn3IC7+fW5kT3NYIWPbWFl5s1oHwBu0c09ixolwChaMivX/Hkm6
        uu+mKphsbrc9UQ8ixFf4/lQ7EbRFzjodTJhy+O3uns2QLvBlN9vtk2in/Dx80QyB
        DWHu2RU6iPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82FEF858EF;
        Wed, 29 Mar 2017 13:15:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEBF9858EE;
        Wed, 29 Mar 2017 13:15:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 0/3] name-rev sanity
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
        <cover.1490798142.git.git@grubix.eu>
Date:   Wed, 29 Mar 2017 10:15:13 -0700
In-Reply-To: <cover.1490798142.git.git@grubix.eu> (Michael J. Gruber's message
        of "Wed, 29 Mar 2017 16:39:14 +0200")
Message-ID: <xmqq4lycatsu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4645CA22-14A3-11E7-8AD2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> So here is v2 of the name-rev series, the result of our discussions being:
>
> Junio C Hamano (2):
>   name-rev: refactor logic to see if a new candidate is a better name
>   name-rev: favor describing with tags and use committer date to
>     tiebreak
>
> That second patch is slighty changed as discussed, but still mostly Junio's
>
> Michael J Gruber (1):
>   name-rev: provide debug output
>
> This replaces the patch which documented that --debug does not work with --contains :)
>
>  builtin/describe.c |   2 +
>  builtin/name-rev.c | 117 +++++++++++++++++++++++++++++++++++++++++++++--------
>  t/t4202-log.sh     |   2 +-
>  3 files changed, 103 insertions(+), 18 deletions(-)

The first two applies cleanly to the same base as jc/name-rev that
the first two of these patches are meant to replace, but the third
one doesn't apply on top.  Are you depending on something newer?
