From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Tue, 17 Jan 2012 15:42:53 -0800
Message-ID: <7v1uqxq4jm.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 <CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
 <CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
 <7vzkdmqebh.fsf@alter.siamese.dyndns.org>
 <CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 00:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnIg9-0000V4-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 00:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099Ab2AQXm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 18:42:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080Ab2AQXm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 18:42:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB73374BB;
	Tue, 17 Jan 2012 18:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nv8s9XYctHZJBjEvz8BWJ6R68V8=; b=gGDhS7
	XcVc6J1yq8BThwDhCGtAia/oNoC6WvGUoVJCFW/4/KYOqltnrWCPl20RYySRfs0T
	QTv+SfeUpW/rXs1Hg7eqN8q8pj0OppOeGoJHJU3oHL/4KcTbkvgClq3VkSNGhO78
	P/vsL95mg6RcRCorgpzOiPZ5nDG2p5lBk9Z5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Liz7VOIf8oHUd2jG/CrChGiFtRZj3mxf
	8U+eegj74HB1I1HRzhZ6bKsH0KNbv9W0S7xZwNgZNJnLHqvEETTq/usx9X5A2Oc7
	2ggHNwH1g3SA8iKvSkwrxoiEh4kxivm9N8BkSpwnJ3F/p4iR6z8Qz23e0HuG31Qu
	USH5+FWCax0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F6574BA;
	Tue, 17 Jan 2012 18:42:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44BEE74B9; Tue, 17 Jan 2012
 18:42:55 -0500 (EST)
In-Reply-To: <CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 18 Jan 2012 01:04:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA7DFD10-4164-11E1-A792-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188728>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> As I was planning to queue Matthieu's patch as-is as a regression fix
>> before v1.7.9-rc2, I would appreciate if you can clarify this report a
>> bit. Do you mean with the patch more recent versions of zsh still does not
>> like the workaround and adds quoted space at the end?
>
> I am saying I am seeing the issue (or at least the same symptom) even
> before a31e626 with recent zsh versions. I will try a patched version
> of the script and a31e626, but I'm guessing the result would be the
> same.

OK, so the issue the patch addresses may not be a regression in the
upcoming v1.7.9 we want to fix quickly, but if you tried the patch we
might see improvements, or we might not see any improvements.

I'll hold onto Matthieu's patch for now, then. It would be nice to get
this minor detail fixed before the release, though, as any fix would be
of limited scope, affecting zsh users for which it is already broken.

Thanks.
