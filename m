Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031FD20179
	for <e@80x24.org>; Fri, 17 Jun 2016 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbcFQP6A (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 11:58:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbcFQP57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 11:57:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CA0923FC6;
	Fri, 17 Jun 2016 11:57:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GASabuugDUIc3yQz8vUNWzoiO4E=; b=Lik5WD
	9xdE5FJjODvOuYxKgoSRYr+B+5TjChESolKVuvYvVvLwnfmqjzpU6JJU4dRar36P
	W398c4pSCJYn0NmY8+7nhqerJC7+WRrQKmm3YzBluCNcO/ZGM0VqZPHLKP2coWi7
	iYCfDM+5ZaPvq09KMzO3ZQrtBbe4LypjHGqMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfeE1ly0cw55wnRw+8mcQmxgVkVEFSwr
	TSJJftFgHb1HvrZd38wKBsfHoIJe3WY6OLMILLw2GU3YfzFBE0WE3v1jfjUi7ycW
	+Ad32r08W/8Utxy6je/sqwcul36PbebzyOHElPoOpeiWTXcg8Cep6khpKDBBAC0a
	yNTSGsjSfnE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85DA923FC4;
	Fri, 17 Jun 2016 11:57:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 082E423FC3;
	Fri, 17 Jun 2016 11:57:56 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/4] clarify %f documentation
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-2-joeyh@joeyh.name>
	<xmqq8ty44y4t.fsf@gitster.mtv.corp.google.com>
	<20160617024803.GB17088@kitenet.net>
	<xmqqfusc33aa.fsf@gitster.mtv.corp.google.com>
	<20160617123209.GA24025@kitenet.net>
Date:	Fri, 17 Jun 2016 08:57:55 -0700
In-Reply-To: <20160617123209.GA24025@kitenet.net> (Joey Hess's message of
	"Fri, 17 Jun 2016 08:32:09 -0400")
Message-ID: <xmqqbn2z3j0c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42261454-34A4-11E6-9388-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <id@joeyh.name> writes:

> Junio C Hamano wrote:
>> "tracked by Git" is not all that interesting, compared to the fact
>> that your filter needs to give contents relevant to that path
>> because that is what the command line argument Git gives you with
>> '%f' means.  It is not a random filename "tracked by Git".  Among 47
>> other files tracked by Git, the single one being given is the one
>> the code that drives the filter is WORKING ON, and I think that
>> needs to be written in the description, hence "the path that is
>> being worked on" was my suggestion.
>
> Ah, "being worked on" does clarify it well, I think:
>
> + Note that "%f" is the name of the path that is being worked on. Depending
> + on the version that is being filtered, the corresponding file on disk may
> + not exist, or may have different contents. So, smudge and clean commands
> + should not try to access the file on disk, but only act as filters on the
> + content provided to them on standard input.

Looks much better than the original text.  Thanks.

Another reason why you do not want to say "tracked" is for "git add"
that adds a brand-new file that is not yet tracked.  Technically,
"trackable file" may work but we have to add "trackable" to the
glossary, but so far we did without having to, and I'm reluctant to
invent yet another word, so...
