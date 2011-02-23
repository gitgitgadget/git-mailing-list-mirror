From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Wed, 23 Feb 2011 10:56:06 -0800
Message-ID: <7vmxlm8trt.fsf@alter.siamese.dyndns.org>
References: <201102231811.45948.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 19:56:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsJsq-0002QW-QH
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 19:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab1BWS4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 13:56:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab1BWS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 13:56:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E94754436;
	Wed, 23 Feb 2011 13:57:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XoyWhL5E6O/LXdSmwHrRW6fturI=; b=VwBjfd
	8KfZTpS+/HFDkuLeaxgcfyvFOyMTIKwYzpgqSKIDnzGCP18vXLLWaN9CxobbhP7s
	CbM1f366GRxiRTl3HOk1luajR9/cXWBRvZ6v/gdXT0eJxe5083j+NavqbKHID8OT
	J5XW9zxgoezfU9m19uxgZEkPaBn2wIKDFBctg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ik6dbWPgpNFngyJMiGGadEoH7yhGY+GA
	/LH67NUhqMo1XDFaIhwczguKtQdMTOMwxNGGQgImFxYXjgZ47gDo8poJkQn+WPtm
	Lj1fWXncLCu4Y3et4QZ9yM0kKaviuH9m9z7IYbFOuGAGMcl5lYDYTW0L1FHAW327
	hhPrIuubjhE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C51B54435;
	Wed, 23 Feb 2011 13:57:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED0104434; Wed, 23 Feb 2011
 13:57:20 -0500 (EST)
In-Reply-To: <201102231811.45948.johan@herland.net> (Johan Herland's message
 of "Wed\, 23 Feb 2011 18\:11\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BFD0BE0C-3F7E-11E0-A7C7-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167710>

Johan Herland <johan@herland.net> writes:

> Are there better suggestions on how to deal with this?

Just from the top off my head, perhaps you can go to the same route as
symbolic link support on filesystems that are not symlink-capable?
