From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/94] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Thu, 12 May 2016 12:11:03 -0700
Message-ID: <xmqqeg97f5x4.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-4-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Thu May 12 21:11:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0w0u-0004pz-Op
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbcELTLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:11:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752441AbcELTLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:11:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5C5A1BB10;
	Thu, 12 May 2016 15:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BY4s0ZBExYm3jcehgHmhjsCVPe8=; b=FAsGNx
	ubi0WcDTkhrao3VoXGhA1j/EkmK7/C3DnqJlSfoyEhHe0tOf6iO1EOiXXOMltAzh
	dv07ccLda36YJzzCUPNFSOPzobHdYturyc8jUfuoE2vyrN4jYyzaaCWmkTMT+pJN
	nj2Hr90AEIAlY4FGCyXqi2cqOLS+uaQKJhDI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OvnoPAbNF9ZveLj3EZfWS8/pq4jV3WFr
	Blo2Du5eKTRNut4qkewEBEoszToFgqT8EYDS2+X3u6Z0FQui8GfGxCVs7oZFWXVd
	15MQkG991ltDhcPnrjrftR9G8dEsREjUNbqllKicPIAzXYV+uswtuN3a2bX2jT4j
	nmH9D4Z5coI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C78C1BB0F;
	Thu, 12 May 2016 15:11:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 201411BB0E;
	Thu, 12 May 2016 15:11:06 -0400 (EDT)
In-Reply-To: <20160511131745.2914-4-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46F63BEE-1875-11E6-8BBB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294430>

Christian Couder <christian.couder@gmail.com> writes:

> Let's just rename the global 'state_linenr' as it will become
> 'state->linenr' in a following patch.
>
> This also avoid errors when compiling with -Wshadow and makes
> it safer to later move global variables into a "state" struct.

Looks correctly done (I looked at remaining instances of "linenr").

Will queue.  Thanks.
