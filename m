From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [patch 07/15] host-IRIX.patch
Date: Tue, 16 Mar 2010 00:24:36 -0700
Message-ID: <7vljdsn2yz.fsf@alter.siamese.dyndns.org>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054331.991677000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrR8z-0003qZ-Da
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937509Ab0CPHYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:24:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936263Ab0CPHYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:24:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C72EEA200E;
	Tue, 16 Mar 2010 03:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qQ86euhOtD6NaAQoRtoLy1u+IOY=; b=Q6qN3dZwDvPobLaz/A/ldkx
	zV4qOeEC889Q5lWCmFdsE9Ztb1o2QWoAJVE76iuj4hM94/Vp2iPLfHrf6RXdVgsX
	KnIOJ6ekFFb8Qp8bclz7m03momHXnRk4HGcf/M52FDzw5O56TzcHA6wWX64ZeRqh
	wjTX9+PdcEbxA7fn5pug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hsaGHbIDrnV7n51znOhBYnRY3zYQgVwM7Lh5sz+hc5VuNU/Oa
	gJ2oPTy55BcBtGwHmjTArJ7hWHOlBhENkpg1fJraPnRPyaZ39R7fOnNnJhMExSf+
	FX+EkWLLkxmhpoMT7glPsS8I2SsvAW/u3sLZ1yPEwyRA9qkcOxaKbMjOk4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5720A200D;
	Tue, 16 Mar 2010 03:24:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1680AA2005; Tue, 16 Mar
 2010 03:24:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC29C28E-30CC-11DF-97D6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142328>

"Gary V. Vaughan" <git@mlists.thewrittenword.com> writes:

> Irix 6.5 does not define 'sgi', but does define '__sgi'.
>
> Also, Irix 6.5 requires _BSD_TYPES to be defined in order for the BSD
> u_short types et. al. to be declared properly.

If Irix 6.5 defines __sgi and the patch _adds_ "defined(__sgi)" I wouldn't
have to worry too much, but would replacing "defined(sgi)" with the
double-underscore version make somebody who added "defined(sgi)" in the
first place cry, if it was done for different version of Irix that does
define "sgi" (worse yet, but not "__sgi")?

Another natural question is if defining _BSD_TYPES everywhere has negative
effects on somebody else's platforms, but that is what people on different
platforms will have to apply this patch, test, and report success or
breakage.  Help from the list audience is appreciated.

Thanks.
