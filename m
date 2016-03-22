From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name issues
Date: Tue, 22 Mar 2016 15:57:00 -0700
Message-ID: <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
	<56F18F5E.9090301@web.de>
	<xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
	<56F1CACA.5040709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:57:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiVEc-0001fP-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbcCVW5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 18:57:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752011AbcCVW5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 18:57:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C2E44F03F;
	Tue, 22 Mar 2016 18:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yz1xmOk8SrBs
	SCFGLqmho9THlCU=; b=BQOok2YKThtjPxUF5CRVLL72uGOHZhob21xRgDY5SRG+
	0EGpkrkKgFZm24W1e1qWGw3hwubc0Lugdc7J73pwKd/0w9fll9E6LWwYm7GkGHfJ
	aC+vBPuChtK1M9hydn+gcx/fSwgN7Di/o6GCJXC+gM+KpVvHxUCiXasUORUqwN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PHvmcB
	NrIpa8zs7ZabqhlLS1gZa4iHlmHJ+qICPfNbsTi6DX4oEd3BXFFSdl0GyKxIHyTe
	qxsum2SpSmb/AAV4ESiX1KdYR3kWYxTQVLv6pGjar9A+nyGU4XVz16awNZ6GtGCa
	HSKK3vqOrbJjzzPlxiuWRPtXegFRXQE2x6U/M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63E104F03E;
	Tue, 22 Mar 2016 18:57:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B78114F03B;
	Tue, 22 Mar 2016 18:57:01 -0400 (EDT)
In-Reply-To: <56F1CACA.5040709@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 22 Mar 2016 23:44:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 63AA986E-F081-11E5-B75F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289586>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2016-03-22 21.44, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> On 2016-03-22 18.43, Johannes Schindelin wrote:
>>>> These two tests wanted to write file names which are incompatible =
with
>>>> Windows' file naming rules.
>>>>
>>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> Is there a chance to squeeze in a precondition for HFS under Mac OS=
 ?
>>=20
>> So you want this squashed into it?
> Yes, please.

Dscho, I queued two out of these four, with a proposed fix-up patch
for each of them, on 'pu'; but I won't squash them together myself
without hearing from you as I do not test mingw or macosx.

Thanks.
