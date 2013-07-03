From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv3] submodule update: allow custom update command
Date: Wed, 03 Jul 2013 10:09:43 -0700
Message-ID: <7v8v1nh8o8.fsf@alter.siamese.dyndns.org>
References: <7vehbii6un.fsf@alter.siamese.dyndns.org>
	<1372759974-19765-1-git-send-email-judge.packham@gmail.com>
	<51D3064C.80901@web.de>
	<CAFOYHZC1xMt2eqaNm0vtLVJ3X2TNjRxa3sEjBPmHVeHrQmSc4A@mail.gmail.com>
	<51D3CAE8.50509@web.de> <51D3D8CD.5090804@gmail.com>
	<51D3E5BA.1090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, GIT <git@vger.kernel.org>,
	iveqy@iveqy.com, stefan.naewe@atlas-elektronik.com,
	hvoigt@hvoigt.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 19:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuQYz-0001mG-1w
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 19:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab3GCRJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 13:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab3GCRJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 13:09:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A5C52DBE4;
	Wed,  3 Jul 2013 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3IsbsMdF++nbDlVmlYrLOmFa0gY=; b=fDb17S
	/m3PCEA0RQr3rSX8CIAf8IMPEpTa/cipe97xYmR6IUaoz+z1XJSlLUzAEj06jJUU
	cYbnZ4nv5ihRKmOS0xnT6xlmPpkc3tubdbURo1mKo/Qoy0Tmjq6EPMH3ZVJHoVes
	TNaSL1M52cX4+5HhBN/xAhwy+VexPDFm5Q8b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+IriddP36PxzSTuSKEqtLyBGmVWqXQR
	hYyoaPasgVsh5UwhDkXYhN3PbWu3/G1UC0OUsqpWRZtyAh0f3Qnb0bmJtOiHNTgZ
	OUxImBkL8o1HJj4b1Rbvl6zYISvkW2l5qoHO1Ipjb28vpf/Su490onuJPF8nXZxV
	Tl8VACIRBkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3662DBE3;
	Wed,  3 Jul 2013 17:09:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A80F92DBDE;
	Wed,  3 Jul 2013 17:09:45 +0000 (UTC)
In-Reply-To: <51D3E5BA.1090408@gmail.com> (Chris Packham's message of "Wed, 03
	Jul 2013 20:50:02 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C571D4A-E403-11E2-AC8A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229497>

Chris Packham <judge.packham@gmail.com> writes:

> On 03/07/13 19:54, Chris Packham wrote:
>> On a related note should I be updating Documentation/config.txt as well?
>> Even if it's a statement that this feature exists refer to
>> git-submodule(1) for details.
>> 
>
> Answering my own question. While 'update' is mentioned it's possible
> values are not.

Yeah, I think it is good as-is.

The entry in config.txt points at git-submodule(1) and your patch
updates the latter by adding another possible value, so the values
are discoverable; we do not have to maintain two separate lists and
keep them in sync that way.
