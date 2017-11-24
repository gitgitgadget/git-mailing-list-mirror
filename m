Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC9E20954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdKXHvJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:51:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55415 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751869AbdKXHvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:51:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59AFFB7D90;
        Fri, 24 Nov 2017 02:51:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HYJO8IiH5rM5OP6JMY+blM5pxHg=; b=Rh2JlN
        gF0JCV5Hb80CqnouBd7U55iVQTbZkSqKMbYmPZqF7qx2UCENgrJACW9XkiA7hlGc
        gjOeKwAYNp5SG81k6KBUBfGMC9QVZ3lwemoeYfAnGt5VMLfXcz3Jwe0/bTXK8kCp
        l6alioGgn4ETcsfhn39YobEo0H7f093C8ssJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oe2MaKBTaEe6allvgvREfWR/46pxfz2e
        uTd5SctGl+1FoALOdyCDANvWJ6t3pFX9bovcuMbEcjJYwezEqDMVi+xypmak8pFp
        BSsRtqRo0MpCPloIcJvUVdS+k/MtixypurEICTlfrOrczXDF2qYqDl3hHM5XUcfZ
        Xo+jWg1aB8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51DEAB7D8E;
        Fri, 24 Nov 2017 02:51:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA556B7D8D;
        Fri, 24 Nov 2017 02:51:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     <git@vger.kernel.org>
Subject: Re: Make patch-id more flexible?
References: <20171124073327.GA15188@vmlxhi-102.adit-jv.com>
Date:   Fri, 24 Nov 2017 16:51:06 +0900
In-Reply-To: <20171124073327.GA15188@vmlxhi-102.adit-jv.com> (Eugeniu Rosca's
        message of "Fri, 24 Nov 2017 08:33:27 +0100")
Message-ID: <xmqqlgiwm7x1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AFA1FB4-D0EC-11E7-ABFA-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eugeniu Rosca <erosca@de.adit-jv.com> writes:

> file-names. Here comes my actual question. Would it be conceptually fine
> to implement some `git patch-id` parameter, which would allow ignoring
> the file-names (or reducing those to their `basename`) before computing
> the patch id? Or would it break the concept of patch id (which shouldn't
> accept variations)?

My gut feeling is that a tool like that would be fine as long as it
is local to your organization and is not called "git patch-id"; it
may be useful in the situation you described, but as you mention
above, it feels that it is differnt from what a patch-id is.

