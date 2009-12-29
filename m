From: Junio C Hamano <gitster@pobox.com>
Subject: Re: config for merging master to test branch
Date: Tue, 29 Dec 2009 08:53:41 -0800
Message-ID: <7vvdfphgbu.fsf@alter.siamese.dyndns.org>
References: <20091228233838.GA28052@panix.com>
 <20091229164343.GA17546@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfKY-0002i7-Q7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbZL2Qxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbZL2Qxv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:53:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZL2Qxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:53:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39348ABF4B;
	Tue, 29 Dec 2009 11:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P64iC9UfalRN8XmlBrrXGQ0kjEM=; b=WnySUq
	QIKhlP2z9ZUIWP78eQXEmT3qdikc1RsYW1oIvYm4V8Ng1ldi3vP9DGyF3uT3RrBE
	HjKiaowGDxErKCImZVc2bHavzyGwKg6SHV0VL2Hic84oZfJCkvKAZKOawWZh/BLl
	c0JCxF0EtBJnQtXgQXjpMkIRClN42yB/vCeHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mLC6V2l6VzPl2sMsW+1GRKnNDRMJ+RjO
	aUdTEFivt+jNWa9lF1GQHkVo7/1CiSIVwzBNeH3l7xgN7BjTfNaB0PqQR4hKEcQC
	AB8J/dU2XFRWxPJk/6K+4qNPKGzjQizMQCEMgzHLlRGG+s1SrC/DklliS5ODE5/x
	QqGPrMEfjpw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1820CABF4A;
	Tue, 29 Dec 2009 11:53:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37A9CABF46; Tue, 29 Dec 2009
 11:53:42 -0500 (EST)
In-Reply-To: <20091229164343.GA17546@panix.com> (Daniel Convissor's message
 of "Tue\, 29 Dec 2009 11\:43\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA9B6A98-F49A-11DE-ABB0-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135809>

Daniel Convissor <danielc@analysisandsolutions.com> writes:

> On Mon, Dec 28, 2009 at 06:38:39PM -0500, Daniel Convissor wrote:
>> 
>> Now, here's the question.  I want to go back into the testing directory 
>> and do a "git pull" and have the changes from master automatically merged 
>> into my test branch in one step, without having to do an explicit set of 
>> checkouts and merges.
>
> I found this is possible by being in the "test" checkout and calling
> "git pull origin master".  Is this the best way to do it?

Good.  That is how it was designed to be used ;-)

If you feel lazy and want to omit typing " origin master", you could add a
few configuration items in your .git/config in the test repository.

    [branch "test"]
        remote = origin
        merge = refs/heads/master

That configures git in such a way that...

    When on branch "test", "pull" and "fetch" by default interact with the
    "origin" repository, and "pull" integrates what was found on the
    'master' branch from that remote into your history.
