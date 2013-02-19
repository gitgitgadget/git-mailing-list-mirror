From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell-prompt: clean up nested if-then
Date: Tue, 19 Feb 2013 08:28:35 -0800
Message-ID: <7vy5ek6zf0.fsf@alter.siamese.dyndns.org>
References: <1361204512.4758.10.camel@mas>
 <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
 <20130218191040.GB3234@elie.Belkin>
 <0c94f24b-f7ee-4699-87a7-6861b927cea4@email.android.com>
 <1361228206.17734.4.camel@mas> <7vtxp98bmx.fsf@alter.siamese.dyndns.org>
 <5123350D.4010802@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Erik Werner <martinerikwerner@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	trsten@science-computing.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7q3z-0006KQ-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573Ab3BSQ2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:28:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758451Ab3BSQ2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:28:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61BFCB696;
	Tue, 19 Feb 2013 11:28:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BzWMyPVzXYNxhpt8ylzYZaGbolE=; b=p6+82h
	C7r/dMLQgtIfaWRwRvu3DRp/89qkw5DsKEuTJfkYovAmBAs+nv8+P+8u4hCFUm+F
	+Z7WOu1z+B3ApQ+Nf5kQ+2U0+NVDmi+VVFuuJecJ3dqUv112pQI+f/zQlJRSw+6e
	ZrVP0AuGQECPQWFh9izI+My5DQ6B2DZrIv9Ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D8bLb5prDq77WJizxvsGj0P35N39gt+A
	TslvTBf54qgqpL8hcX6lanhMZTM+UUdcDxeTts/7wq2QABtUzABDm64+mYV12YY1
	8p6wsdx8ycthPbqGOcyXgAy/4pI4Nrfw+780lQTD8+BvK0/TsBpj3BjdaS7hR19p
	ca1ct8E3Kl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53FFEB695;
	Tue, 19 Feb 2013 11:28:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA102B694; Tue, 19 Feb 2013
 11:28:37 -0500 (EST)
In-Reply-To: <5123350D.4010802@xs4all.nl> (Simon Oosthoek's message of "Tue,
 19 Feb 2013 09:17:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69DC1508-7AB1-11E2-BFFC-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216629>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> I suppose it would be fine if a patch was sent to update the entire
> git-prompt.sh code to be more in line with the Git shell script style...

Please don't.  We do not want a "style conversion" for the sole
purpose of conversion, especially when a subsystem is already
internally consistent.

Besides, the git-prompt.sh thing needs to be fairly bash specific so
the usual "Git Porcelain scripts targetted for POSIX/Bourne shells"
rules does not apply there.

> My original gripe was just with doing it in one place while leaving all
> the others unchanged. It makes for messy reading and leads to confusion.

Yes, it is always preferred to match the _local_ convention.
