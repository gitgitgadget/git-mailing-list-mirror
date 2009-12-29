From: Junio C Hamano <gitster@pobox.com>
Subject: Re: config for merging master to test branch
Date: Tue, 29 Dec 2009 10:32:51 -0800
Message-ID: <7vskatd418.fsf@alter.siamese.dyndns.org>
References: <20091228233838.GA28052@panix.com>
 <20091229164343.GA17546@panix.com> <7vvdfphgbu.fsf@alter.siamese.dyndns.org>
 <20091229175607.GA3683@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 19:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPgsV-00059X-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 19:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbZL2SdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 13:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZL2SdB
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 13:33:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbZL2SdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 13:33:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CE418CBC4;
	Tue, 29 Dec 2009 13:32:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3kZYjZMv8TUz6/2vAYxxMtOlRM=; b=MSgCrj
	ufMFq6/fdWmftkkmd2e7F2GBAk86nJ/2Es9R4G+2OtV2B8J7Eo9zdVphDBhNNby/
	99XnKwK+0Hn/qvuCkenSnwN4pS/OMaCrpJeiNILbgGeeXl8n/MHOyq0ZWZ2Z4v4i
	1WK6Srytsr730qzp99iN/sRYl9f0ZwMUVMDN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r9GKoQZaa2vQDOM8OWJbucoy/mDwYSX5
	N+5cFCFzN8Ryx0plWUD1hdYlMUGF5fVumM6xZXnidt9WnXOO3Hwy/J96healUShi
	FLs6Pe5MGIFmyv9Es0pJx346XAcTdRaGEnAZE7wyYc1lcJW8pQ4rHIRFlc79Bci3
	wP5PfVxtGBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AE48CBC3;
	Tue, 29 Dec 2009 13:32:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE20B8CBBE; Tue, 29 Dec
 2009 13:32:52 -0500 (EST)
In-Reply-To: <20091229175607.GA3683@panix.com> (Daniel Convissor's message of
 "Tue\, 29 Dec 2009 12\:56\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94A15CA4-F4A8-11DE-9722-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135817>

Daniel Convissor <danielc@analysisandsolutions.com> writes:

> Excellent.  Initially, I wasn't sure what the following commands did:
>
>    git config branch.test.remote origin
>    git config branch.test.merge refs/heads/master
>
> Between further reading and your explanation I now understand it better. 
> "refs/heads/master" refers items displayed by "git show-ref".

Not quite.  refs/heads/master there refers to the _local_ master branch,
but it is _local_ with respect to the origin repository, not your
repository.  "git show-ref" is about showing refs in _your_ repository.

> So what is "refs/remotes/origin/master", please?

    http://gitster.livejournal.com/30313.html

If you read Japanese, you may also want to read Ch.13 of my book ;-)

The refs/remotes/ hierarchy is used to store a copy of the branch tips
fetched from the named remotes (like "origin").
