From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 21:24:09 -0700
Message-ID: <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 <4BA544FC.7050007@gmail.com>
 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
 <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 05:24:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtZBj-0003eM-Gp
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 05:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab0CVEYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 00:24:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0CVEYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 00:24:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57551A4EEC;
	Mon, 22 Mar 2010 00:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4dpx4GTsbl0OvUOqeqyZD0NLOSU=; b=koUtIZ
	mbQEogkNH4nqT6GAph2rT/HDUgybfGfvk1YxpxjjdiDDaOkANcRvoZPZ/ffSrp+P
	SlrHUL064152rG5n+D7ncstDsyP1c0PWiVhXgIvNhIboNdt+a1ha7MKTLUwWxXsq
	omoJViunpg8+8QYJmMSzeSg3P8hWgqB0GgIsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEna803dEMcM0wwQEV7OMC4Bi+bp4LqU
	VohUKj9r4Sza8WKZ2DZcu+Pt5f8+3ddSyJsgO9f/QvocqmzqOeKIeEylAF8b31Qd
	bsjbhH80TpWgTGj+r0RgSNywynLerfeXgMIn2FIdsi8Nb+SYXzqflumxQ1m6eB32
	yj7+hXTUOrI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F8CAA4EE4;
	Mon, 22 Mar 2010 00:24:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42D90A4EE2; Mon, 22 Mar
 2010 00:24:10 -0400 (EDT)
In-Reply-To: <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com> (Bo
 Yang's message of "Mon\, 22 Mar 2010 11\:48\:38 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C611819E-356A-11DF-95DB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142894>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Yeah, how do you think use the following syntax:
>
> <file1>@<rev1>:<start pos>,<end pos> <file2>@<rev2>:<start pos>,<end pos>

Horrible.  That is not how we name things.

What's wrong with bog standard:

    $ git log -L 10,20 master -- Documentation/git.txt

which is exactly how "blame" does it?
