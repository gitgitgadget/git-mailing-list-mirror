From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Sun, 14 Nov 2010 10:55:37 -0800
Message-ID: <7v8w0v3fbq.fsf@alter.siamese.dyndns.org>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-5-git-send-email-avarab@gmail.com>
 <AANLkTi=SbqD_3yYsRGCsmSxh-B8kpupnjq0XPGjMsxdK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 19:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHhk3-0007FN-Ld
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 19:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab0KNSzv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 13:55:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab0KNSzu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 13:55:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C42E53673;
	Sun, 14 Nov 2010 13:55:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pB+kYldi/bB/
	7Wp5cKuw+alU2ng=; b=RXB33X6FcfwIZCpmEcvWwrFNLHx/z5WwmxNWuBO5V+0t
	vf5iipdgTp8iviuHnNznJIpqN9sd5Z3O6V3rvxpK1BQ+AifejGeapy8zgav+ulTp
	vSHWIa3SXJacgaNCUARjLZc+Wt7Z4vMmhLncmoKAZrZw1NTSlF1J8px+bzLJpG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bSZgAH
	P+dd5gSwpHl+QDmI9CoqnEZy/dZBaVWa41k/DZUm36siB5KHLibGFRlhGHALdwr0
	ebDsMvar0HtxzABERcYeh/NPqfZXSIjbUEHqM+dhncLnClzxElI+gVdoLMGHxKdS
	f4AFXMUbUc1SvCHLdTmM33/3K0g9XDOApatVs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83E2C366D;
	Sun, 14 Nov 2010 13:55:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39DE33664; Sun, 14 Nov 2010
 13:55:45 -0500 (EST)
In-Reply-To: <AANLkTi=SbqD_3yYsRGCsmSxh-B8kpupnjq0XPGjMsxdK@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 14 Nov 2010 16\:01\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD18FAE6-F020-11DF-8494-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161432>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Nov 14, 2010 at 15:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> diff --git a/wt-status.c b/wt-status.c
>> index fc2438f..bfc97fb 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1,4 +1,4 @@
>> -#include "cache.h"
>> +#include "builtin.h"
>
> Doesn't this suggest wt-status.c should be moved to builtin? Or
> something like that.

Why?  builtin.h is to declare cmd_foo() and to be included by files tha=
t
implement cmd_foo() (i.e. builtin/*.c) and the file that needs to see
cmd_foo() declarations (i.e. git.c).

wt-status.c is about giving common service routines for status related
commands in builtin/commit.c to implement both commit and status.  Its
services may have gained callers outside builtin/cocmmit.c, but that is
not a good reason to export its services via builtin.h nor for it to
include builtin.h.

This is a tangent but I think for the same reason the types and functio=
ns
related to notes-rewrite currently in builtin.h do not belong there; th=
ey
should be moved to notes.h or somewhere.
