From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 13:37:39 -0700
Message-ID: <xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-4-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 17 22:37:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2lkZ-00038o-R3
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcEQUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 16:37:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751719AbcEQUho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 16:37:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67C801ABFC;
	Tue, 17 May 2016 16:37:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XYkhJF9h8pL6Np8EER//lfa10FY=; b=kPlmv2
	cJ44BS7YZbGHqya32DQEQoI7VgO9VW1RW5Z+Vsl1PgDYT0HD1sA3xGUgsGiqizKY
	Fjp2e5xkGp7strT82ktb+a/oKnaxf5FkZQ7dgp7Ymw0Od99RA4zafT27mx6LxZcz
	E3+vVwqQz15NLOzUDPV/baeLpa92IRP0Odai8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UgUo5FvaVWwVwGvIWeufD3NfQXr7xEy8
	ZquVtCXyPtLWeXTO1OnzmJ4ZsnRJfVNcxJjPrDOET2a+6MesMZ/LTJIKKQvWlpB3
	I3dYJjn09lKy64iKzNEgou4gSCtWCRGfZ5yDORKEq25NcbMVeprLbFO/3huC1TIm
	AJCytecynOg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F9041ABFB;
	Tue, 17 May 2016 16:37:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C84431ABFA;
	Tue, 17 May 2016 16:37:41 -0400 (EDT)
In-Reply-To: <20160517193630.10379-4-sunshine@sunshineco.com> (Eric Sunshine's
	message of "Tue, 17 May 2016 15:36:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33E5CB20-1C6F-11E6-97DB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294912>

Eric Sunshine <sunshine@sunshineco.com> writes:

> +			git ${dir:+-C "$dir"} rev-parse --$o >actual &&

This is kosher POSIX, but I vaguely recall some shells had trouble
with the SP between -C and "$dir" in the past.  Let's see if anybody
screams; hopefully I am misremembering or buggy shells died out.

Other than that, the entire series makes the script easier to grok.
Thanks.
