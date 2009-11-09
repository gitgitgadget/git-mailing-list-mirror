From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] builtin-push: add --delete as syntactic sugar for
 :foo
Date: Mon, 09 Nov 2009 09:08:59 -0800
Message-ID: <7vr5s7wrpw.fsf@alter.siamese.dyndns.org>
References: <20091109130935.2bea7771@perceptron>
 <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:10:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Xl2-0001iQ-TJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 18:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbZKIRJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbZKIRJG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 12:09:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZKIRJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 12:09:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C267AD06;
	Mon,  9 Nov 2009 12:09:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJ9aT0vw5glcZ62vNv97YPAtNPI=; b=mzLxlv
	jVjEpqDUyCd85F4FJWSBapzVCPk9tJkHa+DOj/ikdQCp1D2joV/ogENc84DWyl9S
	v5YwuQ8Z5rq+tIvBysjLiRJUIxVrBmC4ql7JhFa+VZvGxAWFC2EHEkQ0/6b+t7BE
	LL6hpjWtsZsKqydswAaUp+4eO4XrbVG7wcjD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ReS2286CIcjOFbek5KCPQ79rLFpAc30z
	KZkR++bqH9w7AqdPpcrVySWSdSDpi69lox+PFJmhwZLh8dYj4qWGlerxj3D9USdS
	YxGN1WzODnq6B1NwANplGL8AOe/fXeacCkS0nqLJNrzMeSopGhf08T9S2KHGdovf
	o9GZVBJW7a4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4378E7AD05;
	Mon,  9 Nov 2009 12:09:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D43D7AD01; Mon,  9 Nov
 2009 12:09:00 -0500 (EST)
In-Reply-To: <7v8wefy6pi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 09 Nov 2009 08\:59\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 953B30B8-CD52-11DE-8862-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132496>

Junio C Hamano <gitster@pobox.com> writes:

> Will it barf and error out if there is any colon-ful one?  I think it
> should.  I was about to write "I guess it could be argued both ways", but
> after thinking about it for 5 seconds I do not see a sane way to explain a
> command line "push origin --delete one two:three".

Actually the one I had in mind was

	git push origin --delete one two:three four

If it were

	git push origin --tags --delete=one --delete=four two:three

it would be perfectly understandable, though.

No, I am not saying that we should make --delete take a parameter, allow
multiple of them, and make them compatible with --tags.  At least not yet.
