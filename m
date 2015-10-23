From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gc: remove unused #include "sigchain.h"
Date: Fri, 23 Oct 2015 10:00:06 -0700
Message-ID: <xmqqoafpplk9.fsf@gitster.mtv.corp.google.com>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
	<1445517810-13998-2-git-send-email-tklauser@distanz.ch>
	<xmqqk2qer78a.fsf@gitster.mtv.corp.google.com>
	<20151023072527.GR2468@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 23 19:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpfhW-0000Ir-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 19:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbbJWRAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 13:00:12 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750869AbbJWRAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 13:00:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4294923EFA;
	Fri, 23 Oct 2015 13:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGrz43/jjTjUNbQyWqmZ+o9vqCI=; b=qtFqBH
	sUqk4dVnpgYR0WQz7V0LA7Qqcon4GnIl/NzHDSSiVaFc9kPinXvidFiRMgmdKk8Q
	cDDhLOYPEhXyRyBorZYokoV84wRkKZ7Ab5fiW+/Etp3cwxxauciaew/X6BWMYWen
	SA14oV8WFpUKMPesot3cFtp2tpZR9LIGiuAF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cpzAWCXjNVCNkG01UL6k4QvSgfvIq6Ir
	Hdv5kMp2u/rQ5kcgqpt0zwBs7KFrJ1CSuibBxKdIFrJHK8VsYxk5CHzXupmWWI+d
	6AZYa4OaVmm7JJsNzfg+b+rybb9vjgWJr/bnO8znS4f+cxkV3cX426hncgOcWlaF
	jnoo2X28Xbw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B8A723EF9;
	Fri, 23 Oct 2015 13:00:10 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B28F823EF8;
	Fri, 23 Oct 2015 13:00:09 -0400 (EDT)
In-Reply-To: <20151023072527.GR2468@distanz.ch> (Tobias Klauser's message of
	"Fri, 23 Oct 2015 09:25:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84B23720-79A7-11E5-B14A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280099>

Tobias Klauser <tklauser@distanz.ch> writes:

> On 2015-10-22 at 22:14:29 +0200, Junio C Hamano <gitster@pobox.com> wrote:
>> Tobias Klauser <tklauser@distanz.ch> writes:
>> 
>> > After switching to use the tempfile module in commit ebebeaea (gc: use
>> > tempfile module to handle gc.pid file), no declarations from sigchain.h
>> > are used in builtin/gc.c anymore. Thus, remove the #include.
>> >
>> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> > ---
>> 
>> I'll drop this one as we seem to have gained another user of the API
>> in this file in the nd/gc-auto-background-fix topic.
>
> Opps, sorry I didn't check against 'pu' carefully enough. Thanks for
> catching it.

Heh, that topic has been in master since Oct 15, I think.
