From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 12:30:54 -0800
Message-ID: <xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
	<546B2CE0.6020208@alum.mit.edu>
	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
	<546BA21C.9030803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpR3-0002jR-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbaKRUbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:31:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508AbaKRUbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:31:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B831EE79;
	Tue, 18 Nov 2014 15:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+QlxKErRlbz3Az+g/isAsZYqjVA=; b=X3IwWE
	9al3maKuB7MqGLKE39oABfPa3V3ZSvM3YNaWvAR2f3PYuciWwg1pgOjfVhnD/aNI
	CsOv2qIDjZW1xgX1JUvPttI9l5uxVjrPBNDk5m6cH4/B5kzoIJGxZ1mi7rM7j1qo
	AffpvEuwtUgegmv4Ch/DqKnilvmR9deADA2n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVC+GBOO/BfV5r0F82YYxFWeAeXqGt0/
	hiMr0fZTFKqDv3UqyBrgK7rLyiUwZyN328jDoSpTDbaK5gR0Z/HtL7DMWPMC6hGt
	Lo5GtHbokBLemdy3UhP8crenyZKDcO+KjxRr6B9RJYtug9SikcDZeeyabPPjLuT7
	fYDNeVw5m3g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C07741EE78;
	Tue, 18 Nov 2014 15:31:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 249131EE56;
	Tue, 18 Nov 2014 15:30:58 -0500 (EST)
In-Reply-To: <546BA21C.9030803@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 18 Nov 2014 20:46:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CDB40F4E-6F61-11E4-9BAF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'm still not convinced. For me, "reflog_expire()" is an unusual outlier
> operation, much like "git gc" or "git pack-refs" or "git fsck". None of
> these are part of the beautiful Git data model; they are messy
> maintenance operations. Forcing reference transactions to be general
> enough to allow reflog expiration to be implemented *outside* the refs
> API sacrificies their simplicity for lots of infrastructure that will
> probably only be used to implement this single operation. Better to
> implement reflog expiration *inside* the refs API.

Sorry, but I lost track---which one is inside and which one is
outside?
