Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A841FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbcHJUwU (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:52:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932940AbcHJUwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 16:52:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A44E133012;
	Wed, 10 Aug 2016 16:52:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DfY5iZ3mWbtI
	g7MnTHYjS+LVnXw=; b=dlNIcy3PqmErsyVP5xGQOTQVc8DM/mPIj9PjOd+pS1QG
	I0czrnErToPyLdkoymil8wsJCKsR41HJktD0wP0jMnmmxZM0wubbtwjeIyDhg+zf
	HhEwza/LjlNy+wV5iIqoD7ZmcxF2Euu+ZftJkTSf2hozBRUTOMnyityJCBsRkAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hvQsrG
	bz4N0Vycrv/s/yaVLs+3/nf+z+CY84MgI0GL0wYuGOpLDirCsEOc33D4KsIf7WXT
	OX+RXPVujpvY/vmsQINYVI2LlmsJ3l5TXMLwY2T3qKv/8moZNuOEJvqNXygNcxmX
	JHUfQj1Wt+5wbM18s8iQ4N4z5hCFIGw/xnUJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9884633011;
	Wed, 10 Aug 2016 16:52:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0EF7733010;
	Wed, 10 Aug 2016 16:52:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michal =?utf-8?B?xIxpaGHFmQ==?= <michal@cihar.com>
Cc:	git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: git svn --version requires working copy
References: <8b881bf6-0b53-f917-fbe7-db22fe4910b8@cihar.com>
Date:	Wed, 10 Aug 2016 13:52:15 -0700
In-Reply-To: <8b881bf6-0b53-f917-fbe7-db22fe4910b8@cihar.com> ("Michal
	=?utf-8?B?xIxpaGHFmSIncw==?= message of "Wed, 10 Aug 2016 18:16:22 +0200")
Message-ID: <xmqqh9as4a9s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52A7406A-5F3C-11E6-A13C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michal Čihař <michal@cihar.com> writes:

> I've just noticed, that running git svn --version requires working copy,
> what is quite ugly to require working copy just to figure out if git svn
> is installed and what version.
>
> $ git svn --version
> fatal: Not a git repository (or any parent up to mount point /home)
> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
> Unable to find .git directory
>  at /usr/lib/git-core/git-svn line 347.

Wasn't this fixed sometime last month?

  ... goes and looks ...

c0071ae5 (git-svn: allow --version to work anywhere, 2016-07-22)
seems to be it.  Try the tip of 'master' if you can and report if it
works for you.  It will hopefully be part of the upcoming Git 2.10
release (the preview release is expected this coming weekend).

Thanks.




