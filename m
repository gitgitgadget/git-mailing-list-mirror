Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10491F406
	for <e@80x24.org>; Wed,  3 Jan 2018 19:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeACTYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 14:24:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbeACTYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 14:24:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67BE3C952E;
        Wed,  3 Jan 2018 14:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=94Q0sBi7yCOs
        lOD6CozEooaNces=; b=Ue+p8c0K3JWDxraBaHpkMLRbxL16w7y7kgiWcek+BH4I
        bs9EMs33XAh99lDze7MPf7zY0BBO+qBm6yGtds+3l0EgWPpgBdIl/HuBTw0OhOhB
        t+iMb3kZn4mV3o5Av2k7mZFlf+/DvurSxRnj08Puf3N/4F+NFB/WM49i6BS9HkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P80+tI
        R5BdqZoeZRLkoR/pm6zUTS5nIMTTp78VXaDN0ZsY08tYG13koZTk1ZHy5V9p/oPI
        YLVhZV+xOm+JYMVPkfnTn5f7g7+NvedIWMbO6Vpd3siu28h5yNMZf7pHF7j0rKVy
        0QcHHZnVujsHJ/D38kh3Nsm/oMKQNagV/C+aA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DA0EC952D;
        Wed,  3 Jan 2018 14:24:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B373FC952C;
        Wed,  3 Jan 2018 14:24:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Keith Smiley <k@keith.so>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
        <20171229224825.31062-1-szeder.dev@gmail.com>
        <87y3ll6s0e.fsf@evledraar.gmail.com>
        <20171230005222.GT3693@zaya.teonanacatl.net>
        <87vago76i8.fsf@evledraar.gmail.com>
Date:   Wed, 03 Jan 2018 11:24:04 -0800
In-Reply-To: <87vago76i8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 30 Dec 2017 13:19:27 +0100")
Message-ID: <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9E6B6E6-F0BB-11E7-9561-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Dec 30 2017, Todd Zullinger jotted:
>
>> And I think that should also apply to
>> not offering completion for commands/subcommands/options
>> which are only kept for backward compatibility.
>
> Yeah I think it makes sense to at some point stop completing things if
> we're going to remove stuff, if we decide to remove it.
>
>> Here's one way to make 'git remote rm <TAB>' work without
>> including it in the output of 'git remote <TAB>':
>>
>> diff --git i/contrib/completion/git-completion.bash w/contrib/completi=
on/git-completion.bash
>> index 3683c772c5..aa63f028ab 100644
>> --- i/contrib/completion/git-completion.bash
>> +++ w/contrib/completion/git-completion.bash
>> @@ -2668,7 +2668,9 @@ _git_remote ()
>>  		add rename remove set-head set-branches
>>  		get-url set-url show prune update
>>  		"
>> -	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>> +	# Don't advertise rm by including it in subcommands, but complete
>> +	# remotes if it is used.
>> +	local subcommand=3D"$(__git_find_on_cmdline "$subcommands rm")"
>>  	if [ -z "$subcommand" ]; then
>>  		case "$cur" in
>>  		--*)
>
> Neat!

Yes, indeed it is nice.


