From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FW: question about merge in 1.7.10
Date: Fri, 24 Feb 2012 12:00:32 -0800
Message-ID: <7vobsoypb3.fsf@alter.siamese.dyndns.org>
References: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:00:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Jo-0007Gk-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757808Ab2BXUAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:00:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab2BXUAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:00:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62527609F;
	Fri, 24 Feb 2012 15:00:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=es0fjq1pnDe/6nes/K9rlp6aWBo=; b=K1p3PQ
	c02HX4aqRjRJNhgiVAU7nn77OQvYx5UE3/VHfxnZH6CBnf+ZW0q0vN/5bkCdY2ax
	WXK1NdXkmH6FjqwwRB7d9eO9KezVietGfcqrv89Fk6yjUOWtzwEhVgSCWEkV09qH
	kqIkYkjkLzs8QoiNrU8nex5XXCg1FJdQSHctY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s8x/xNbXQ9cVxnNTA55LzNgtRhfeEJou
	ISPop/MrJBZciVMX9nwhOg2En/mJrgx8bIPAMlCVf3WFyqCGnchSHGw6Guu4fSA9
	eQDurOPRkHPIeP7SetEjRBdd0nWCo740+DCZHkzRdkjqUoSAwIvrjUMecjE4m18O
	4vZNwU/uA7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AB9609E;
	Fri, 24 Feb 2012 15:00:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E327E609D; Fri, 24 Feb 2012
 15:00:33 -0500 (EST)
In-Reply-To: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local> (Marlene Cote's message of "Fri, 24 Feb 2012 14:33:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 361FD87C-5F22-11E1-BFDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191454>

Marlene Cote <Marlene_Cote@affirmednetworks.com> writes:

> I used merge with -no-commit -no-ff. So, I assume I won't see any
> change in behavior, since merge is not performing commits, right?

The _only_ difference is when

 (1) "git merge" is run interactively;
 (2) the merge goes cleanly that it does not need to ask help from the
     user to resolve conflicts; and
 (3) it records the result by creating a commit.

Because your use case with "--no-commit" does not satisfy the last
criteria, I do not expect you to see any difference.  Otherwise you may
have found a bug.

As noted in

    http://git-blame.blogspot.com/2012/02/anticipating-git-1710.html

please try out the version from the 'master' branch before it gets
released, so that you can help us avoid surprises in the corner cases.

Thanks.
