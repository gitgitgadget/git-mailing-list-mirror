From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Sat, 26 Nov 2011 14:38:16 -0800
Message-ID: <7v39day0fb.fsf@alter.siamese.dyndns.org>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
 <20111126023002.GA17652@elie.hsd1.il.comcast.net>
 <CAOTq_pv4dyAkbqye+diK9mTTsrTg9OKg0tExKcfDgs8RfiTwTQ@mail.gmail.com>
 <20111126085455.GB22656@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	=?utf-8?B?4piCSm9zaCBDaGlhICg=?= =?utf-8?B?6LCi5Lu75LitKQ==?= 
	<joshchia@gmail.com>, git@vger.kernel.org,
	Soeren Sonnenburg <sonne@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 23:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUQt6-0003wM-Bh
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 23:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab1KZWiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 17:38:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1KZWiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 17:38:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D58E152AF;
	Sat, 26 Nov 2011 17:38:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mGvwW9nOg+tubmsu0UlxndcZLr8=; b=DgHsVI
	OLBL8Oh5QmLT5oB5nJpL0r67k4ixXY3Nbf4nkg+Bt3pIHzovKz1BjLVursIpAYrs
	tkbfVKYzQCHAu5J4prX2RBkoOzjD7ylx5nDZkFXFnt1VM5d+GPPgUIsDMShPSZpD
	7l6EnxvfW84dWY2CwJkGbe4xGVEAO7hdhYorU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWdZeEBGmQWC6aSRqBbVNjelCAY6gyPD
	dzRJlc/XMcYyZLoSyo48XZKoybRGAzrn7R4HVGJRyGmAZWcsfNKK5k+UMaLWG2qV
	q+IxZ9Wf30Ejnhu1tN70cmhB77bgbY5JT/pZlD1b5DN2O89OyVTS+PLirS03lFMy
	DP6+DlH6TB8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBCF452AE;
	Sat, 26 Nov 2011 17:38:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6118F52AD; Sat, 26 Nov 2011
 17:38:18 -0500 (EST)
In-Reply-To: <20111126085455.GB22656@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Sat, 26 Nov 2011 02:54:55 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 563581FA-187F-11E1-802F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185956>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In other words, when on master, "git checkout -B master <commit>"
> would be another way to say "git reset --keep <commit>", except that
> it also sets up tracking.

I havn't look at the patch (not a regression between 1.7.7 and 1.7.8 so
not a candidate for the remainder of this cycle), but I like the above
description quite a lot. I think Linus's "git reset --sane" which was
initially called "git reset --merge" but ended up as "git reset --keep"
should have been spelled as "checkout -B <current-branch>" from the
beginning.
