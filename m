From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 14:26:41 -0700
Message-ID: <7vmx32590u.fsf@alter.siamese.dyndns.org>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
 <loom.20120714T114718-783@post.gmane.org>
 <7vzk725c86.fsf@alter.siamese.dyndns.org>
 <7vr4se5bg4.fsf@alter.siamese.dyndns.org>
 <CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: "Zeeshan Ali \(Khattak\)" <zeeshanak@gnome.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 23:26:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq9rX-0007D3-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 23:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab2GNV0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 17:26:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab2GNV0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 17:26:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6B37954;
	Sat, 14 Jul 2012 17:26:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IPJYxaT1yubtsjFsAXHFlUunS1E=; b=mUN2a2
	58yAX+AuNq02EXvwPRlhcL+CGwiU8dW2CeFWHDrhcdrPWHdnby9vkZGaBcuiP14a
	rTMxBUE1RYYTbL6kXtRYIjjUzcIbIP1+enDbRJmFfJvbccZqMetn4sGvSwb6DvQw
	4JbnvgG26/qDgIUsp4VfdMavYmzobaEKKuqPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NyXjuquwrvu00+ehQSElFftTHtmA45pE
	qrON7kZaBg8Sj+1d6Rym+1G9RhqN7FhQko6LlbXpe1yUmQBUUApmzXsTpfkp8yAF
	ClpCqiOj5ko+g0BdlZqAv9Bo8cGtsX8nCIDNX9ppPcDFOo2ewF2v/FPOvIr6zXxc
	Q+mPii6xhtU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF93F7953;
	Sat, 14 Jul 2012 17:26:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E70A7951; Sat, 14 Jul 2012
 17:26:43 -0400 (EDT)
In-Reply-To: <CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com> (Zeeshan
 Ali's message of "Sat, 14 Jul 2012 23:49:11 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BA49420-CDFA-11E1-ABB8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201458>

"Zeeshan Ali (Khattak)" <zeeshanak@gnome.org> writes:

> What about '^' and '^^' that I suggested?
>
>>> While I see your "~<N>" much distasteful compared to "^", you still
>>
>> s/dist/less dist/; sorry ;-)
>
> Why?

That "^^" is the most important reason why your "^ is the same as
HEAD^" is flawed, and goes against my taste.

Think what "log ^^ origin" would mean.  Is it "log ^HEAD^ origin"?
Is it "log HEAD^^ origin"?  They mean totally different things.

Compared to that, at least ~<n> does not have such ambiguity within
the context of Git (having to quote is an ambiguity within the
context of using Git with shells that support dirstacks in their
tilde expansion).
