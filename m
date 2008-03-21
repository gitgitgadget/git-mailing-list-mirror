From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Thu, 20 Mar 2008 23:26:49 -0700
Message-ID: <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcajI-0001le-DE
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 07:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYCUG1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 02:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYCUG1L
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 02:27:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbYCUG1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 02:27:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C15E02677;
	Fri, 21 Mar 2008 02:27:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0BD2E2676; Fri, 21 Mar 2008 02:26:59 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803210134070.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 21 Mar 2008 01:57:52 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77721>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 20 Mar 2008, Junio C Hamano wrote:
> ...
>> In any case, don't you agree that the patch you responded to is much
>> easier to understand what we are (and we are not) checking than the
>> original code?
>
> No, I think it's much more complicated. It mixes the semantics of what an 
> empty side means for a particular use of refspecs into the parsing of the 
> string. At the very least, the checks should be outside of _internal() in 
> the functions for particular uses.

The thing is, the syntax is the same between fetch and push only to a
degree.  They are both <LHS> ':' <RHS>.  What is allowed on LHS and RHS
are quite different even at the syntactic level.

I already know our criteria when judging if a particular code is clean or
complex are _vastly_ different, from the experience working with you in
other parts of the system (namely, read-tree 3-way rules and
unpack_trees() rewrite that happened quite a long time ago).

While I would note that you thought my version is more complex to read, I
would not argue about this issue with you anymore, except saying that I
strongly disagree.
