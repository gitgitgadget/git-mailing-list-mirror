Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9FB1FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbcFTWWC (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:22:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751646AbcFTWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:21:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A02B27868;
	Mon, 20 Jun 2016 18:21:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:cc:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lx79qQJNgDyhZQ5F20IR/HZjZug=; b=sIQ+76
	hQC8PZwsZjT5mnuTz4sIk5L1HalYWmoV8S6CQ+TWGGP7ri6nwpnWt8u5JpSeSi6f
	mKqjEYjwvC008xbLyWysTHkBeNxIJ+r+wkhj4LQUai0vdwHKM/cVZ+bobawKoTCm
	XmM54PK0ElewF73Az5Rh2/kvA8BR8qNdw4wZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:cc:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LJTUPIg2WLy1vCmGnRwaOdrczQQToelP
	UpUAqWrRq8Bqmke1GZCcREVLyULKHcDgWE2G6/VzHafZ1YDF9jaQ9zRKzZPIEo+b
	KijdqhXuo3WEqmaC7fRcFn0HT7p+Nf0GMBybSJ50BwC8bVAq3+LtmAaQlQTzYqvi
	I10+08uZCts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2249227867;
	Mon, 20 Jun 2016 18:21:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A6D927866;
	Mon, 20 Jun 2016 18:21:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
cc:	git@vger.kernel.org
Date:	Mon, 20 Jun 2016 15:21:20 -0700
In-Reply-To: <878txz8ubq.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
	"Mon, 20 Jun 2016 13:43:37 -0700")
Message-ID: <xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51CAD172-3735-11E6-AF4A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nikolaus Rath <Nikolaus@rath.org> writes:

> What's the best way to find all commits in a branch A that have not been
> cherry-picked from (or to) another branch B?
>
> I think I could format-patch all commits in every branch into separate
> files, hash the Author and Date of each files, and then compare the two
> lists. But I'm hoping there's a way to instead have git do the
> heavy-lifting?

"git cherry" perhaps?

