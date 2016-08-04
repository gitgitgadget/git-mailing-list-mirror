Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F6A20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbcHDQC2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:02:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758721AbcHDQC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:02:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F42F30EBA;
	Thu,  4 Aug 2016 12:02:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1jmKMDQXSd0QiedhxkOrJ+dPMek=; b=cCSujT
	5Sy4EG36UHC7u9rlriP+OFPAND7p9bcEtJ/vTFrbdP1dy5S+56VT5KaNoRvc1m2+
	V1hDjfufr5+QpczfB242ucdWpi6KpeKBMQfFFN9uYl+6CdDfT1miyOCJw+YAFIT7
	IU+aO4d9nWCgsS283aOxI1bPGgeyFGmpRkF3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FHZMNEYv3kKljeLTGWK38GbdS5G4VdGv
	EC4hEofUQ3fE5RQREE06M5c4xw/iGb1acTOX3yy5WylgHfK8Ss9i+1z6L3OeSNQS
	DZNs5RXFgoGnHa6s1IsNDWKAiyd0l3f5+dznpdtM0kiWZ6e5b0t5UkFaVz8JTlim
	dwH7cG5sGpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 263B130EB8;
	Thu,  4 Aug 2016 12:02:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98AA230EB7;
	Thu,  4 Aug 2016 12:02:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #01; Tue, 2)
References: <xmqqlh0ebyhn.fsf@gitster.mtv.corp.google.com>
	<4877318E-3CBF-4C87-B24D-AAE35C427D66@gmail.com>
	<20160804113256.6idrdzfgolm4ne4o@john.keeping.me.uk>
	<4A2D83B3-916C-4FC8-BBEF-4D55C3204DFA@gmail.com>
	<alpine.DEB.2.20.1608041647520.5786@virtualbox>
Date:	Thu, 04 Aug 2016 09:02:23 -0700
In-Reply-To: <alpine.DEB.2.20.1608041647520.5786@virtualbox> (Johannes
	Schindelin's message of "Thu, 4 Aug 2016 16:53:09 +0200 (CEST)")
Message-ID: <xmqqmvks5xps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6120FAA-5A5C-11E6-A857-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Something like this will make the test more consistent with the rest of
>> > the file:
>> > 
>> > diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
>> > index 5f29664..e5bbbd8 100755
>> > --- a/t/t5533-push-cas.sh
>> > +++ b/t/t5533-push-cas.sh
>> > @@ -220,7 +220,7 @@ test_expect_success 'new branch already exists' '
>> > 	(
>> > 		cd src &&
>> > 		git checkout -b branch master &&
>> > -		test_commit c
>> > +		test_commit F
>> > 	) &&
>> > 	(
>> > 		cd dst &&
>> 
>> Confirmed. This patch fixes the issue!
>
> Funny. I worked heads-down to have some kind of Continuous Integration to
> run on my laptop, and this breakage came up. I fixed it locally, and only
> then did it occur to me that it might have been fixed already, and then I
> found this mail with a patch identical to mine.
>
> Will send out the patch in a moment.

Thanks.
