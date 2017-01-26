Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1F51F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 20:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdAZU52 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 15:57:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751880AbdAZU51 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 15:57:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C4CD647CA;
        Thu, 26 Jan 2017 15:51:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=loAQUDyect2OV6q4qdbkySpRqvI=; b=KY3oD1
        mBPa6kTL3xFu1oQfEey822ijKp0iqL1JQSgLbtWxe/b4ohT73kzXAE4B2fLPaewW
        LKw3P9XBwF27xyszS5cfEWzSlAe3j9lXtBKHSKhpakWw5mtjg60xgpY+GWaxh4Ms
        It/25n4jCTDq3kqkkwh0+EMj7A8fOrxL0uTao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b6/9vJKigwhB/8rkxBjVYZ266H1EYC92
        qPt1aZx610GLgPY5BleRfeO1cM0wQHoLBL++2bp1hw9AeuNMb0+7NqVwcorfHP2J
        9xPLsVPuYKivx68LdjNjdOJCYIGaH4vSScAkwMzZk8Yg+MCOghqbZnSW2PmVNeYE
        MoDSp/Rrg7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44D60647C9;
        Thu, 26 Jan 2017 15:51:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7BBB647C8;
        Thu, 26 Jan 2017 15:51:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Force Confirmation for Dropping Changed Lines
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
        <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
        <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
        <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
        <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com>
        <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
        <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com>
        <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
        <CAE1pOi0foJpZXSpHrbWqvOuG1+VoNKTCMjuLK5TCVcJuGMSOoQ@mail.gmail.com>
Date:   Thu, 26 Jan 2017 12:51:32 -0800
In-Reply-To: <CAE1pOi0foJpZXSpHrbWqvOuG1+VoNKTCMjuLK5TCVcJuGMSOoQ@mail.gmail.com>
        (Hilco Wijbenga's message of "Thu, 26 Jan 2017 11:19:51 -0800")
Message-ID: <xmqqy3xx35pn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 389D479E-E409-11E6-B10C-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 25 January 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
>> I think you should be able to do something like
>>
>>         $ cat >$HOME/bin/fail-3way <<\EOF
>>         #!/bin/sh
>>         git merge-file "$@"
>>         exit 1
>>         EOF
>>         $ chmod +x $HOME/bin/fail-3way
>>         $ cat >>$HOME/.gitconfig <<\EOF
>>         [merge "fail"]
>>                 name = always fail 3-way merge
>>                 driver = $HOME/bin/fail-3way %A %O %B
>>                 recursive = text
>>         EOF
>>         $ echo pom.xml merge=fail >>.gitattributes
>>
>> to define a custom merge driver whose name is "fail", that runs the
>> fail-3way program, which runs the bog standard 3-way merge we use
>> (so that it will do the best-effort textual merge) but always return
>> with a non-zero status to signal that the result is conflicting and
>> needs manual resolution.
>
> Thank you, that's an improvement. :-) Unfortunately, it still
> completes the merge. Is there any way to simply get the
>>>>>>>>>/<<<<<<<< markers?

You can, but you need to write one yourself without relying on "git
merge-file", because the whole point of the 3way merge we implement
(including in that program) is "do not bother the user when both
sides made the same change."

