Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FBD02018B
	for <e@80x24.org>; Wed, 22 Jun 2016 22:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcFVWtw (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 18:49:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752448AbcFVWtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 18:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2D9227DCF;
	Wed, 22 Jun 2016 18:45:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tHmgCcst34L3hMTD2sZtOg4YRrw=; b=i5h8lF
	Y3qMEhIJk89abv0iqtrTQSuEPnihwVoS/kUfAcgg16Aw2P7OJPiXv0s8jesGDC4o
	GvyVDL/i3rK0I6G7fzQrfJhaTm9QoXLXBhVqRiJUsbkM9LbP4FLos+J7WEZUP1Ey
	yDczCvjA+6gk2Du6PmsYWnyh6n98un4oY3g8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lasTLjbb2P02hCWaYGvg4OhouJt88w9Y
	t27NVS/7oie9obB4ngW4Aihw8F8oPDpmscPOLyOFbJPiCXQFLYL8fRkUNZgEUjoI
	7f8fEpn+EC8BjbBOIJa3/d28LyIvCb7/VMrDQ0FK/egz91KOotwEUBlqiWp2hfFm
	hQUudusKtMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA38827DCD;
	Wed, 22 Jun 2016 18:45:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E57327DCC;
	Wed, 22 Jun 2016 18:45:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] use smudgeToFile filter in recursive merge
References: <1466629758-8035-1-git-send-email-joeyh@joeyh.name>
	<1466629758-8035-9-git-send-email-joeyh@joeyh.name>
	<xmqq7fdglx83.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 22 Jun 2016 15:45:22 -0700
In-Reply-To: <xmqq7fdglx83.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Jun 2016 14:39:24 -0700")
Message-ID: <xmqqy45wkflp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 020288FA-38CB-11E6-8C1D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +			int smudge_to_file = can_smudge_to_file(path);
>
> This does not compile with decl-after-statement.  I suspect other
> patches in this series have the same issue but I did not check.  Do
> you say "make DEVELOPER=1"?

As a tentative workaround, I've queued a squashable compilation fix
at the tip of the topic after queuing.  Please find it in 'pu' when
it gets pushed out sometime later today.

Thanks.
