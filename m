Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712C41FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 02:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdJFCin (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 22:38:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751418AbdJFCim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 22:38:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BEFD99995;
        Thu,  5 Oct 2017 22:38:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=09S3/mkZjkkxFOW3drjUANknbZs=; b=doVA99
        xoPilq7WrXchGpPeK+C02jzZZDsQ0zPhz3hoPRyF8T3sYfq378KoUEgyLIvBAMW2
        iYwX3LR1i+Aem9UkzfnEaAJV46a+n5S+GB4bNrjuj6lfhHxkpqAzMUzxOP+ccwA6
        kS9Y80PV6L05UIFYaEBFYzfDEiVWhVRCF9FRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XOhbSd2tYJ9YXYafhTNX5GdDb0Lc2ArY
        HphXF18n7eErLi3tUbrJhtg5W7o+49UYJG22g/XG6bdWIDuNPdknZknaLxCz12fk
        FbrVG+oUKZ3qN8lcjPD1t2wr7r8tAMGSBNXNGxg4Yiho4o0tXlH9nNjt+lSaTES8
        90ezkZSif08=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20C5E99994;
        Thu,  5 Oct 2017 22:38:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B3F899993;
        Thu,  5 Oct 2017 22:38:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] api-argv-array.txt: Update link to string-list API
References: <20171005211203.11913-1-tmz@pobox.com>
Date:   Fri, 06 Oct 2017 11:38:40 +0900
In-Reply-To: <20171005211203.11913-1-tmz@pobox.com> (Todd Zullinger's message
        of "Thu, 5 Oct 2017 17:12:03 -0400")
Message-ID: <xmqq4lrdyp8v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77189FC6-AA3F-11E7-A3E3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> I noticed this broken link in the html documentation while building
> 2.15.0-rc0.  I'm not sure whether it's better to point the link to the
> string-list.h file on Git Hub, remove the link, or drop the entire
> paragraph.

Probably removing the link is the right thing to do.  In the longer
term, as we move more and more API documentation to the header file,
we may want to have a mechanism in the documentation build procedure
to extract them back to text.  And at that point:

 - the API doc for argv-array is no longer in api-argv-array.txt in
   the source form;

 - however, it would be extacted from argv-array.h and made into
   manpage or html or whatever human readable format.

 - the API doc for string-list would also be extracted from
   string-list.h and made into manpage or html or whatever human
   readable format.

 - And these two can refer to each other as needed.

But we are not there yet.

> The change I made to remove the link was simply:
>
> -The link:api-string-list.html[string-list API] is similar, but cannot be
> +The string-list API (documented in string-list.h) is similar, but cannot be

This is preferrable for now, I would think.

