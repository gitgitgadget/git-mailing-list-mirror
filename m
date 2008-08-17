From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2008, #03; Thu, 14)
Date: Sat, 16 Aug 2008 20:29:36 -0700
Message-ID: <7vd4k8b9pb.fsf@gitster.siamese.dyndns.org>
References: <7v7iakdln7.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808161731300.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 05:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUYzo-0000ev-RA
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 05:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbYHQD3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 23:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYHQD3m
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 23:29:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYHQD3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 23:29:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 182F35C6E4;
	Sat, 16 Aug 2008 23:29:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 36F995C6E3; Sat, 16 Aug 2008 23:29:38 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808161731300.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 16 Aug 2008 17:33:50 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA3C2780-6C0C-11DD-BA69-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92566>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 14 Aug 2008, Junio C Hamano wrote:
>
>> * js/checkout-dwim-local (Sat Aug 9 16:00:12 2008 +0200) 1 commit
>>  + checkout --track: make up a sensible branch name if '-b' was
>>    omitted
>> 
>> I like this low-impact usability enhancement; will most likely be in
>> master soon after 1.6.0.
>
> Pity.  I kinda hoped it would make it into 1.6.0.

I do not see any pity here.  I do not think this is so high-impact that
needs to wait major version boundary --- it can go to 1.6.1 without
waiting for 1.7.0.

The policy of not taking new features and unproven "fixes" after -rc1 is
threefold.

 (1) We would want to avoid regression caused by last minute carelessness
     (e.g. a "fix" that wants to cover one user mistake and give an
     "appropriate" error message would give a wrong error message if it
     inadvertently covered cases wider than it should have).  

 (2) We would want to have enough time to advertize the change in advance
     if the change can introduce backward incompatibilities.

 (3) We would want to make sure that the change is general enough without
     obvious room for improvement (we do not want to give half-baked
     feature, soon to get replaced by something else).

But taking this before 1.6.0 would be a pity. I do not offhand think the
change can have downside impact (it is _supposed to_ kick in only when it
would have been an error earlier), so it may be excempt from #2 of the
post -rc rules, but I do think you and I have a track record of being
careless (not because your patches are often bad, but because you and I
tend to make the same kind of mistakes --- overlooking the same kind of
cases where changes are not such a good idea.  Notice I said "offhand" a
few lines earlier?), and I feel it is prudent to let rule #1 and #3 to
hold us back a bit longer.
