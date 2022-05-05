Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F0C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386523AbiEEWxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 18:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386498AbiEEWxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 18:53:05 -0400
Received: from pb-sasl-trial3.pobox.com (pb-sasl-trial3.pobox.com [64.147.108.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF35E755
        for <git@vger.kernel.org>; Thu,  5 May 2022 15:49:23 -0700 (PDT)
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id D694336D76;
        Thu,  5 May 2022 18:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hjKIMst0oa01
        EJHH8U3U8y7vu80=; b=fDvxglDc3l539zF7crjjS1FxGPC9G6uQaTMryWZyPmIY
        I74UPslZZ01e/8MaJMoUmQqPkA91+8HRU/hrXA4jgpxZ5sgWRM45WpvO84w973qd
        iaX15vjTZYQKUlQ4m8CoW6yc2cVnexzxS/mDbGW0S1DVe50n6pySL1NcAnT4X3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wOr0sV
        4YxHrLrjy7jrdVyUhfU2yevNZD1a6KtJbjg1FBOJaSKoC8a5py0u4KXyIuYLJ6bG
        zUJGNsy2p33ELHLBHnpP5Veyd9t3tyih+ptDFW3ZJ8q+rEphr+omrEv8rhq9z0n3
        HMF1hs/ZSBXSrSuoH83xnGqoNZ/aKb1ziDvxM=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id B148D36D75;
        Thu,  5 May 2022 18:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F23A8128E30;
        Thu,  5 May 2022 18:49:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Santos <dacs.git@brilhante.top>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
References: <20220503132354.9567-1-worldhello.net@gmail.com>
        <xmqqtua5nz61.fsf@gitster.g> <YnKS1zIr0YAUJ6N4@acer>
        <CANYiYbFDm+aYE9avabnffcTNR4HT6rv77bQiWbAWSzzxeFxUxw@mail.gmail.com>
        <YnRI6u+dV5GNHoD9@acer>
Date:   Thu, 05 May 2022 15:49:17 -0700
In-Reply-To: <YnRI6u+dV5GNHoD9@acer> (Daniel Santos's message of "Thu, 5 May
        2022 23:00:10 +0100")
Message-ID: <xmqq5ymjppci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 990F7F70-CCC5-11EC-A066-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Santos <dacs.git@brilhante.top> writes:

> It is worth discussing this.
>
> Also, I don't believe Github issue is the proper way to discuss about
> this in the beginning. It cannot be expected to make everyone on board
> with this modification of workflowm being discussed on a web service
> website obscure issue, that needs login. We have a mailing list that
> is to be used for this purpose.
>
> I feel less part of this community, with important issues happening on
> Github issues.

While I understand the sentiment, after reading that issues page, I
actually have a totally different impression.

Step back and take a deep breath, and let me ask you the same
question under a few hypothetical settings:

 * Imagine that =C3=86var have been working on this series alone, without
   help from Jiang.  He did some brainstorming with himself to
   polish the ideas, cleaned up the code, etc. in his own head,
   perhaps with help from some automated tools and CI.  And after
   working for a month, sent this as a patch series to be reviewed
   to the list?  Do you feel excluded for not being invited for an
   early review?  I would guess not.  I certainly don't feel
   excluded myself.

 * What if he, during the course of the above month working on this
   topic, asked for a help from a specific person of his choice?
   Perhaps Jiang was visiting the same part of the world and they
   talked about the series in person, private over a glass of beer
   or two?  Do you feel excluded that you didn't have a chance to
   join this discussion?  I would guess not.  I certainly don't feel
   excluded myself.

 * What if that exchange of ideas and help to polish the series was
   done virtually, and the medium of choice between the two happened
   to be GitHub issues?  Do you now suddenly feel excluded?  I do
   not feel excluded myself, but do you?

The way I read that issues page, I think the exchange between them
falls squarely into that category.  They are not pretending to make
"project decisions".  They are preparing a proposal to bring forward
to the project participants.  During the course of their conversation,
they may express their opinions on how better to serve the audience
as if they were a fact, but that is something you can dispute once
the proposal comes out to the list.

In other words, we should treat this just another patch series to be
reviewed, instead of "two important people in Git i18n/l10n are
presenting fait-accompli to the community".   I do not see a problem
in that.

As long as they do not duck a valid question about anything in the
series with "well that has been decided long ago while we prepared
this series and it is too late to change now", that is.

And I do not think anything like that has happened yet so far.

So, yes, please discuss and see a consensus form among i18n/l10n
stakeholders.  Perhaps some of the design decisions they made are
based on different values from you have (e.g. you highly value the
line numbers, while they justify the removal with reduced size) and
it is a fair discussion to have if the decisions the patch series
makes is based on the right balance between pros-and-cons.

Thanks.
