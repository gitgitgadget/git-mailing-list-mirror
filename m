From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name issues
Date: Wed, 23 Mar 2016 08:56:44 -0700
Message-ID: <xmqq37rhdw77.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
	<56F18F5E.9090301@web.de>
	<xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
	<56F1CACA.5040709@web.de>
	<xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
	<56F22F85.3010507@web.de>
	<alpine.DEB.2.20.1603231148510.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:56:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ail9P-0002C5-QK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 16:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbcCWP4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 11:56:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752620AbcCWP4r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 11:56:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 036964D648;
	Wed, 23 Mar 2016 11:56:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iNbA8GXistRt
	xqoCuce9C0VNznM=; b=DdeeowpDjU/FJM0g0+WqTe46N/jhkRciKzAOkdrtRAjM
	CB/xmOB18ed2zp4pSQ2GskFsdBXlHXGC9KohUk7G29Fpj5XuhfzejdCzlItTjFo7
	ts4AnhWIdb0O7v4iiBeXb3wuAOA1tDXBveFDUzVz3WUQ80eA2Jnm7TF0l0yh/BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p+beBI
	2ParTI6hIUasftsKitvtSYKmf+QBLiURA1xFIDXtsR/UyN4h4QaOYSs9CxJFNsLC
	MWJhjMiQwUXDLnO7bZYruo8/FApO3KrtZtAvXau9JzlvH6H3v+lPpiNPwUnLT9df
	os/TgxG8b3fYYM4J1VQqsag5S0y0OQNkL/CNo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE6C74D647;
	Wed, 23 Mar 2016 11:56:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 741EB4D646;
	Wed, 23 Mar 2016 11:56:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603231148510.4690@virtualbox> (Johannes
	Schindelin's message of "Wed, 23 Mar 2016 11:49:49 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7F995E2-F10F-11E5-950A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289663>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & Torsten,
>
> On Wed, 23 Mar 2016, Torsten B=C3=B6gershausen wrote:
>
>> On 2016-03-22 23.57, Junio C Hamano wrote:
>> > Dscho, I queued two out of these four, with a proposed fix-up patc=
h
>> > for each of them, on 'pu'; but I won't squash them together myself
>> > without hearing from you as I do not test mingw or macosx.
>
> The suggested changes will be squashed into v2.
>
>> Beside that, do we want to amend the commit message like this:
>>=20
>> Author: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date:   Tue Mar 22 18:43:00 2016 +0100
>>=20
>>     skip some tests in t9115 due to file name issues
>>=20
>>     These two tests wanted to write file names which work under Linu=
x or
>>     CYGWIN, but are incompatible with file naming rules under mingw =
or HFS.
>>=20
>>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>     Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>>     Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks, I used a slightly different version, as I had crafted it befo=
re
> reading this mail already.

Thanks; Torsten, sorry but could you do another round of check, please?
