From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I create a commit without a parent?
Date: Tue, 02 Feb 2010 00:05:25 -0800
Message-ID: <7vwryw6p16.fsf@alter.siamese.dyndns.org>
References: <ron1-5383E3.00002602022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 09:05:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcDle-0002Q6-Dg
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab0BBIFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:05:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab0BBIFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:05:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CA896709;
	Tue,  2 Feb 2010 03:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d0r+O0eiNSkVlzMvTxNNsXr8IL4=; b=xeyIyH
	QcIDDWvcX/IP9GZjvX/RpOJN8mpI6RqK/XyFVlRr+QGZMKcY8YO6iDNSSEBtDQ7D
	aA3OMN1ZfD4JF92ZTEHGgBX0Oc658bKU6ATiA+EZ0wLAaqlaHj7m4sqoubEh73xd
	or+U+pJstg7OgB6FKqe5nbl1128X7SBnJ1s3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IdCYgyIpiEZ3MnN3adhalkraCQ3HDgYd
	cYk6rhKNJiRNX2r6xQhlu2QxpEUIYSG4qrno2RWk1mIxjtlE1no5Er5W839hL/vm
	uqNO/LZiexgUnM+/kC8B9w1vMAScwQnl2slL//eKwKjQGicCAzJVfseJML7BtGhb
	5rxTop8R0yU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 859D296700;
	Tue,  2 Feb 2010 03:05:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDDDA966FD; Tue,  2 Feb
 2010 03:05:26 -0500 (EST)
In-Reply-To: <ron1-5383E3.00002602022010@news.gmane.org> (Ron Garret's
 message of "Tue\, 02 Feb 2010 00\:00\:26 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA72DC5C-0FD1-11DF-AF27-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138695>

Ron Garret <ron1@flownet.com> writes:

> git commit-tree insists on having at least one parent commit at 
> the command line.

Incorrect.  "git commit" might but "git commit-tree" does.  Perhaps you
are forgetting that the first object name is a tree to be wrapped.

A short answer is that you don't create a root commit twice in a single
repository, period.  Your repository _may_ be end up with more than one
root but that typically is due to you fetching unrelated histories from
different repositories, each created its own root.
