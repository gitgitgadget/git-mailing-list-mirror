From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 02 Mar 2009 15:30:29 -0800
Message-ID: <7vsklvlcyy.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
 <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
 <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
 <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
 <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
 <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903021746140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeHcF-00008E-Ef
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbZCBXai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbZCBXai
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:30:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZCBXah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 18:30:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B97089E0DE;
	Mon,  2 Mar 2009 18:30:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 548C89E0D9; Mon,
  2 Mar 2009 18:30:31 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0903021746140.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 2 Mar 2009 18:00:57 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21877398-0782-11DE-A70E-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111977>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The issue, in my case, is importing from a system where branches contain 
> projects instead of projects containing branches (and everything is a 
> single namespace). So I want to match an insane (for us) LHS with a sane 
> RHS to get stuff into reasonable shape. I don't really care about any 
> patterns where the branch identifier is multiple components, but I 
> wouldn't be surprised if somebody did.

Isn't this just getting more and more insane?  Is this really worth
supporting, I have to wonder...

> Oh, and it looks like "?" is reserved and currently unused, so we could 
> have * match one or more full path components, and ? match partial path 
> components.

Well, "?" is not allowed exactly because it often is used to match a
single character by things like for-each-ref.
