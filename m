From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/6] environment: static list of repo-local env vars
Date: Wed, 24 Feb 2010 11:36:25 -0800
Message-ID: <7vocjemnnq.fsf@alter.siamese.dyndns.org>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1266996196-25978-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vhbp64odi.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1002241120i4bbbce0bl50460c76db0c6529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:36:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkN2X-00040t-5R
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757850Ab0BXTgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:36:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843Ab0BXTgo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 14:36:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9ADE9C3FA;
	Wed, 24 Feb 2010 14:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zh78PIiGuEYM
	kwIqiic55cc8V/0=; b=rt6JlU/yyDEPWPNNhs8fOC4IvyCJ90CTPnz9t5wEzTZX
	m+EmuGGDBrZ50Yxp5KYejBqVtAeOQBavuh1qQxlDIXhu0yTX12D68xfEEydFnuKr
	MpJ5We53Z59UpFmbR5Vh6SeQsNsRQl0oi9jKwvM3tJWPk2u2D8btoVRuWjCcGd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dUXlCa
	KD1sLqSBTEJr4NTiVk8RWLGnZW8QwWGV3vT6XaWnnhQz72WW60DdKEbrXbI9YG6z
	BfCMDRTEDSeiha/mjDCTw7idyKVkJoX1VJ08EgUOzouKvnXi6UCNp1ivvnCHha8l
	ugqQIXB5OBJ5kKj/WWE8168RvUfpax4fDdlYc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62EA89C3F6;
	Wed, 24 Feb 2010 14:36:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8A819C3D2; Wed, 24 Feb
 2010 14:36:26 -0500 (EST)
In-Reply-To: <cb7bb73a1002241120i4bbbce0bl50460c76db0c6529@mail.gmail.com>
 (Giuseppe Bilotta's message of "Wed\, 24 Feb 2010 20\:20\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBB707B4-217B-11DF-B537-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140982>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Wed, Feb 24, 2010 at 4:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> +/* Repository-local GIT_* environment variables */
>>> +const char *const local_repo_env[] =3D {
>>> + =C2=A0 =C2=A0 ALTERNATE_DB_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 CONFIG_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 DB_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 GIT_DIR_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 GIT_WORK_TREE_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 GRAFT_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 INDEX_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 NO_REPLACE_OBJECTS_ENVIRONMENT,
>>> + =C2=A0 =C2=A0 NULL
>>> +};
>>> +
>>> +const unsigned int local_repo_env_size =3D ARRAY_SIZE(local_repo_e=
nv);
>>
>> This does not look very useful for two reasons.

By the way, I said "frustrating" but didn't mean we should bend backwar=
ds.
The earlier one is more than Ok, and is certainly better than having
local_repo_env_size that is not very useful in practice.
