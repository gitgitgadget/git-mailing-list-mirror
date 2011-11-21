From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Sun, 20 Nov 2011 23:50:08 -0800
Message-ID: <7vsjlhhq33.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 21 08:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSOdt-0004bF-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 08:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab1KUHuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 02:50:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab1KUHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 02:50:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD7F22777;
	Mon, 21 Nov 2011 02:50:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KzbilX6BYmLM51nRAMVy1775T1A=; b=rspCGX
	trWeNNVOV07HZQR0rqpYB+vFb/KQrdFVYXYsKoVxRZ2AKvUeFdJeODSNHHgkENK6
	1ZtMYksFUVN16mSnLr1Bo00eFDv9wwQWEnQBhR0GH6RpzeDtTMY/szp36kalBaKc
	uXM6jvXKDANhyAr9iISfKGPqn4tLnwqv7E4ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j8ziDRzR1ARLoIuUzE1jOfL9ml0OSJzO
	KlYCLONwSrcKvCgkz9xSg8aEPDRnEqxx6yzVTXNokcERd2AA3+2MJs58+3SK5SON
	Y1C1f/aFo4JHH0bZKRDiZPhcPGoCpudYFhyJH/wUrQpEQT81WbjF+RIGnRC33l56
	pVoLljW7/Lo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF17C2776;
	Mon, 21 Nov 2011 02:50:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 029C9275E; Mon, 21 Nov 2011
 02:50:09 -0500 (EST)
In-Reply-To: <4EC9FC81.3080306@viscovery.net> (Johannes Sixt's message of
 "Mon, 21 Nov 2011 08:23:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FCA5C94-1415-11E1-9CB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185735>

Johannes Sixt <j.sixt@viscovery.net> writes:

> It is a lucky accident: it allows the distinction between "untracked but
> precious" and "untracked and garbage". And it is a doubly lucky accident:
> .gitignore entries are meant for files like build products, which usually
> affect all consumers of a repository, whereas .git/info/exclude is
> intended for personal files, which frequently are precious (think of a
> TODO file).
> ...
> Here you are. As you can see from my commit message, IMO, this is
> a very useful accident. Therefore, there is no 'test_expect_failure'
> in the test script :-)

Heh.

If this is a feature, we would like a patch to Documentation/gitignore.txt
as well, I think.  Also I have a suspicion that this was an unintended
"regression"; do you have a bisection?
