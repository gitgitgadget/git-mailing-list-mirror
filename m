From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/94] builtin/apply: avoid parameter shadowing 'p_value' global
Date: Thu, 12 May 2016 12:09:36 -0700
Message-ID: <xmqqinyjf5zj.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-3-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:09:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vzU-0002sn-2v
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcELTJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:09:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752169AbcELTJj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:09:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 627401A513;
	Thu, 12 May 2016 15:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/hb/4vtKUqCZhY9mO6NF9AwgoU=; b=eGkpkC
	SiTan2bFO0yMEtr3J/JBHrw2fn82h7D5MmwTuIVX6366NzPRRWczR7aZ2TPa5vcR
	nLW2aHS5StQ/b4Z8IQgHEOFORRMt42L3FFG0ViIyve/Tqaq8a84a/GvBieGbVAeQ
	gTLEr+4Z7XSGlJLzrJ+MrU1R5fNr6EPaNnQkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkoUGIB25Fn8N32DHfwokbRF9xN6cXG7
	ex8ENqB/zO4gs6StRzefT4sPYmAgl9FGv+ELWToze5iWmtQmAVUQwLAZMhDfZly/
	nsbqGGflhLp5civz6OndVQEX9zZmtmUnR8926zFnegtvuStnPy4R6Ns+4qfeeZyc
	g3deEe/PAvM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AC201A512;
	Thu, 12 May 2016 15:09:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF92A1A511;
	Thu, 12 May 2016 15:09:37 -0400 (EDT)
In-Reply-To: <20160511131745.2914-3-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1257662E-1875-11E6-A6D7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294429>

Christian Couder <christian.couder@gmail.com> writes:

> Let's just rename the global 'state_p_value' as it will become
> 'state->p_value' in a following patch.
>
> This also avoid errors when compiling with -Wshadow and makes
> it safer to later move global variables into a "state" struct.

Looks correctly done (I looked at remaining instances of "p_value").

Will queue.  Thanks.
