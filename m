From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/9] Add column layout skeleton and git-column
Date: Wed, 14 Mar 2012 11:29:54 -0700
Message-ID: <7vbonzqbml.fsf@alter.siamese.dyndns.org>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <cover.1331638663.git.pclouds@gmail.com>
 <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
 <7vaa3kt9zf.fsf@alter.siamese.dyndns.org>
 <CACsJy8D8U7L4P+z9DT6hq0Rze=p2M6UZKMCqia1kN-QGJFE_zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7sxW-0005qU-02
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab2CNS35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 14:29:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab2CNS34 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 14:29:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0661C7AAF;
	Wed, 14 Mar 2012 14:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=v8cS4WEQ2CEJ
	e96gTBE95ogbiz4=; b=cKwB/iwob0QqZvOD2nK4fsp9Z+UMluxt+u97l7lSntAe
	suKxU6qD2j4HvCL14CUxu7N+SPZyWrfP59ubSlGEBaRJ0Bwu0+7G1aEDdhBYwVKc
	fhyODMzC+pjKYoaLW+F+vNwHjqH/fr4gpSqMDgrJM8TLN0b7EJLJIqx4ACAbp00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z2T4PI
	u7i1C6oeMf/EHGnWmdtKO+gCSCsfBR9rD27RgAixMonfxs70LzcFZ3zPnO13V/2p
	qWZl73qZCsjBYtklghWvC76YC3y0oDyQ21adlDLkDfPB0Fj1POHlLu1hmbmP6OdT
	XVvyYOaUjTBbJfao0tP/WI8KT9n232ODkxmN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F28567AAE;
	Wed, 14 Mar 2012 14:29:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81F927AAB; Wed, 14 Mar 2012
 14:29:55 -0400 (EDT)
In-Reply-To: <CACsJy8D8U7L4P+z9DT6hq0Rze=p2M6UZKMCqia1kN-QGJFE_zg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 14 Mar 2012 18:17:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B26F59F8-6E03-11E1-9E40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193146>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/3/14 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> +#define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)
>>
>> That is a misleading name for a boolean macro. =C2=A0It looked as if=
 this
>>
>>> + =C2=A0 =C2=A0 assert(COL_ENABLE(colopts) !=3D COL_AUTO);
>>
>> was asking the helper to *enable* the column machinery with the give=
n set
>> of option in colopts, and expecting the helper to answer how it enab=
led
>> ("I took the 'automatic' decision path"). =C2=A0But that is not what=
 is
>> happening.
> ...
> I'm running out of names. Suggestions are welcome.

An obvious interface to expose to API users (as opposed to internal
details to the implementation) would be "extern bool COL_ENABLED(opts);=
",
no?
