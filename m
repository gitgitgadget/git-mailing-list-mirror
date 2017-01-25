Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285511F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdAYXq4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:46:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64006 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdAYXqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:46:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E856E64CDF;
        Wed, 25 Jan 2017 18:46:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8zw8DLj0SLs0/JyrO/wcSKfn4dY=; b=F5wJg3
        HuB84bh6bP8qUbxPbM6vSqcYhJo3zeE71LVCfe75+BcbnHNUmuX5IAY/AdQpdG8v
        dYVQLfyGnmifiWHZnAfENad6MmQ/YOxDPHYvaPohqh6+jHQXVovOA1Py7pI+IzYd
        IRWbSylqSXjHAKyFqQ4+jyNuqgWEYXqXzAjKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TjQhuUQOKwncoBYkc2LtnJghd4BnJARv
        z1hy1/b4mlOd3o0Kf9joyraQ01mVkJatYbh8OWjuAzaWb35ZqCLshLr1VzzKfdbF
        hFeRP7ihvySKCjtuHQl7/MfK9cn9u+gDp9Et5WB7V57ATYTlnkQ8NJMi1deJRh+T
        O0TuTSTVdy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0AB764CDE;
        Wed, 25 Jan 2017 18:46:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 486A764CDC;
        Wed, 25 Jan 2017 18:46:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Force Confirmation for Dropping Changed Lines
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
        <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
        <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
        <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
Date:   Wed, 25 Jan 2017 15:46:52 -0800
In-Reply-To: <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 25 Jan 2017 14:54:08 -0800")
Message-ID: <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C600490-E358-11E6-82ED-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> Mmm, that sounds complex. The "my-code.x" is made up so I could keep
>> my example as simple as possible. In reality, it's Maven's POM files
>> (pom.xml).
>>
>> So there is no setting for any of this? There is no way to switch off
>> auto merging for certain files?
>
> Not really sure, but a quick google search revealed
> https://github.com/ralfth/pom-merge-driver
>
> Maybe that will help you?

Its readme seems to indicate that it is either solving a different
problem, or solving the same problem with the opposite goal in mind,
in that its goal seems to be to forcibly resolve what textually does
not resolve cleanly by choosing sides with an arbitrary policy, so
that humans do not have to get involved when they ordinarily would
have to.

Hilco's goal sounded to me the opposite---to force conflict even
when the two histories did what textually does resolve cleanly and
require humans to get involved even when they ordinarily wouldn't
have to.
