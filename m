Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB9D20281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdJCAIG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:08:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62423 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbdJCAIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:08:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBBE7A4A4A;
        Mon,  2 Oct 2017 20:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=miXvSFSJ91qHsxDAoKJ0WzZukxM=; b=dR++30
        nCnP6J0mzT3SiypSIXqBUk62LbFJQh4ibXr0txrTDf9+9nY05jOMwzNQuNVuEnk5
        Re1lcAehsDhtGZZhrKTcAYvVBaxtT5d+K+TZ6hgqGBbbG9WwKBgh/rTHtzgGEIYi
        2GU/wPZH3bAmrlEK5N31RQ8UULER5MxoPvXhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PpWjnmEaVPPb4jAKXaUZuKcd4ZEE3xIC
        plwIefQ6vqPpZ4ItQFzrx2ySmd1v/iBG6R46FqcoIynGq1S8E4QJY599rR/MKp0A
        35k+GjsKU+zWbvIpA5WGf6qYw3S7a648UY2idnWxTNPkb5nOvKDjuO8be6q3Ay/F
        25Jn16J9t5E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B351BA4A49;
        Mon,  2 Oct 2017 20:08:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E760CA4A48;
        Mon,  2 Oct 2017 20:08:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     rpjday@crashcourse.ca, git@vger.kernel.org
Subject: Re: What means "git config bla ~/"?
References: <20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca>
        <20171002171300.GP19555@aiede.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 09:08:02 +0900
In-Reply-To: <20171002171300.GP19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 2 Oct 2017 10:13:00 -0700")
Message-ID: <xmqqfub1m6u5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED03FD48-A7CE-11E7-8F20-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> what's with that "git config bla ~/"? is this some config keyword
>> or something?
> ...
>
> I agree with you that it is less clear than it could be.  Ideas for
> clarifying it?

Yeah, if it were

	git config section.var ~/some/thing

that would be far clearer than "bla" that what we see is a mere
placeholder.

Another obvious option is to remove the parenthetical comment.

Or "(but you can give values without quoting and let your shell
expand it)", without a confusing sample command that proved not to
help very much.



