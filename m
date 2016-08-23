Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCC81FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbcHWRQX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:16:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54092 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751032AbcHWRQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:16:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D801035C44;
        Tue, 23 Aug 2016 13:16:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NS73WSnaP+oE1OeKlka1C8QkiGY=; b=odrCZf
        WUAYqz8v35G+HIHJMNiWD/+fdZysUoYqduBAjqbtkAUM9BVygtpDPVBl9hhOimQz
        5spXNcVJwBUWj12LlhLh1RipcqK55TwpH0LiUcPhP9QdB/4lSxhiCGLPwFzeUBcW
        1jdnTbTw6zbTTdVJxVxglpxCVn1GuzYYNGfRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KlQ3aNQ5pSgtIlYhXE0cdFHlJDKlmWN/
        XVn/fKReebAejAcgvpTZAMQ70FWXWctk9Z+HXfEQOe2WfFwhdDjdppKUVwMIiHFX
        144oUbMKS91N+fayKOj7ETo55vM8yqEmab10XjHRKp3NnayXxXz0RhISBOciCjj7
        eOORg2bpIAw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D04A835C43;
        Tue, 23 Aug 2016 13:16:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EAF535C41;
        Tue, 23 Aug 2016 13:16:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
Subject: Re: git-config(1) should mention `git -c`
References: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
        <20160822185709.izdfbkbsmeip5u7c@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 10:16:18 -0700
In-Reply-To: <20160822185709.izdfbkbsmeip5u7c@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 Aug 2016 14:57:09 -0400")
Message-ID: <xmqqpoozwgm5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F3E2B64-6955-11E6-B67D-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That seems like the most sensible place, as that is where we should
> cover the order of reading and precedence. Perhaps FILES should be
> renamed to SOURCES or something (though I do not recall if we are
> restricted to "usual" manpage section names or not).
>
> Arguably this is not about git-config the program at all, but the
> general concept of "configuration for git", because the precedence rules
> apply equally to all of the git programs that read config.

True, but that argument leads us to say git(1) is the best place ;-)

If the user wants to know "how does the configuration values get
read?", and wishes not having to go around fishing for the
information in multiple places (and I think that is a reasonable
thing to wish for), I think adding it to the FILES section of
git-config(1) is a better option than inventing a separate
gitconfig(7), which would still require the user to consult two
places.

