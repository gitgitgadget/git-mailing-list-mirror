Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA751FF40
	for <e@80x24.org>; Fri, 17 Jun 2016 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbcFQDZV (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 23:25:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754091AbcFQDZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 23:25:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9364E24BAA;
	Thu, 16 Jun 2016 23:25:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SyYWkKEdpVOI2GPnDvbpiTsRExA=; b=CJBRV5
	cp28qGAyE7W4ORBho7M7vsrp0cwJoRde3rash7QaUnTdKTFXrX/2msqKoV1m/rgI
	ykY527APoOt+XpIf/uvZvcHG2vJWZSoaJOV+mLGBrjz9rcqA4K0+A0nuGDyG/Lx4
	oCQbxo0KMengsSreu4Nzn6L7IuJNAZtQGdnzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s2bP5kM8J1bO2uu9xSmEFKDGZfBvYIHj
	xnZH9iEwhiPQwyo4P9rgTyoQg9KJTagYtkD5dv1+tuvER16ewVvDiDn5QpEYXCy8
	ZLnOxe71lvXYlRjRrg2mdsQSQB/QfV8CG6t/1Y/pyktbh1nKpVTgS40EvQidX2mj
	P2kmYV/Umkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1B424BA9;
	Thu, 16 Jun 2016 23:25:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1192324BA7;
	Thu, 16 Jun 2016 23:25:19 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/4] clarify %f documentation
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-2-joeyh@joeyh.name>
	<xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
	<20160617024803.GB17088@kitenet.net>
Date:	Thu, 16 Jun 2016 20:25:17 -0700
In-Reply-To: <20160617024803.GB17088@kitenet.net> (Joey Hess's message of
	"Thu, 16 Jun 2016 22:48:03 -0400")
Message-ID: <xmqqfusc33aa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DE81038-343B-11E6-B2C6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> Junio C Hamano wrote:
>> I agree that "the name of the file" can be interpreted in many ways,
>> and I agree that it would be a good idea to find a better phrase to
>> name the path that is being worked on, but I do not think "the file
>> in the git repository" is that phrase.
>
>> I think using the word "path" somewhere in the updated description
>> is more likely to have the effect you desire.
>
> "path" is also very ambiguous. I see that "tracked" is often used to
> describe what %f is, so how about:
>  
> + Note that "%f" is the name of a file tracked by Git. Depending on the
> + version that is being filtered, the corresponding file on disk may not
> + exist, or may have different contents. So, smudge and clean commands should
> + not try to access the file on disk.

I think that places stress on a wrong point.

I do have a preference between "file" or "path", merely because, as
I showed already (go back and read what you are responding to), the
preceding paragraphs all talk in terms of "paths".  But that is not
the important part.  

"tracked by Git" is not all that interesting, compared to the fact
that your filter needs to give contents relevant to that path
because that is what the command line argument Git gives you with
'%f' means.  It is not a random filename "tracked by Git".  Among 47
other files tracked by Git, the single one being given is the one
the code that drives the filter is WORKING ON, and I think that
needs to be written in the description, hence "the path that is
being worked on" was my suggestion.



