Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4A32018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbcGSTIQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:08:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751699AbcGSTIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:08:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E86562F1AB;
	Tue, 19 Jul 2016 15:08:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyxq7wSU9dbitObSitMeOQ6ZKOE=; b=B/lTTe
	bZIRpOUo7iHUdQ4uq26lbOdgc6jLG64Z3172KZBu+9aD1TsaHCi7zVh1QJimJQD8
	Jy4bKjwW/OFnaRpJAwXCYFwfAHAWFu9C/avZZmdL6tTgwXXF5DrXQmvXP14spO0L
	PsYJyNNsKmzphI30hDFuGhlkRFxlSmk/8dL4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pui4JgGnaY/5OL11e/BZ9TwH2V45IIwC
	v0NZRupCrC9b42hAuQZdl9IMDpSM0a7fAvOSAvVcYtDbKL5VdvynokbV5SulAxfO
	VVG2lg1BYzYVh25acsG/57b9nt2TCZoq1X1qTdNzb12AdhTROYxvm4HDksGd4JKP
	Az43exJguyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E14FF2F1AA;
	Tue, 19 Jul 2016 15:08:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 673532F1A9;
	Tue, 19 Jul 2016 15:08:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Antoine Tenart <antoine.tenart@ack.tf>
Cc:	git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] worktree: add: introduce the --name option
References: <20160719144701.571-1-antoine.tenart@ack.tf>
	<xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
	<20160719184510.GA28551@kwain>
Date:	Tue, 19 Jul 2016 12:08:11 -0700
In-Reply-To: <20160719184510.GA28551@kwain> (Antoine Tenart's message of "Tue,
	19 Jul 2016 20:45:10 +0200")
Message-ID: <xmqqh9blfntw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2410E940-4DE4-11E6-870A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Antoine Tenart <antoine.tenart@ack.tf> writes:

> Being able to manually define the name can also be useful in some (rare)
> cases, where you reorganize your project directory tree. But that's not
> a strong argument for adding this option :-)

Continuing the rationale that rejected the topic from the earlier
discussion thread, the above is like saying that we should expose
inode number more to the users and and allow users to tell a
specific inode number to use when creating an entry in a directory,
which would allow users to edit the directory with binary editor and
replace the entry with the same inode number to move or rename the
path.  The discussion considers that the "name" is an implementation
detail of the worktree subsystem, like inode number is for a
filesystem implementation.  A proper solution would be to invent
"mv" command ;-).

