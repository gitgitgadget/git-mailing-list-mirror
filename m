From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Tue, 12 Feb 2008 13:42:15 -0800
Message-ID: <7vbq6l3l8o.fsf@gitster.siamese.dyndns.org>
References: <20080209162234.GA25533@fieldses.org>
 <alpine.LNX.1.00.0802091251430.13593@iabervon.org>
 <20080209185038.GB25533@fieldses.org>
 <7vr6fletkl.fsf@gitster.siamese.dyndns.org>
 <7vabm9gk1p.fsf@gitster.siamese.dyndns.org>
 <20080212074323.GD27535@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Tue Feb 12 22:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2uv-0003e0-HA
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbYBLVnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYBLVnI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:43:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYBLVnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:43:04 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AACA53911;
	Tue, 12 Feb 2008 16:42:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 889363909; Tue, 12 Feb 2008 16:42:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73698>

bdowning@lavos.net (Brian Downing) writes:

> On Sun, Feb 10, 2008 at 02:52:50AM -0800, Junio C Hamano wrote:
>>  - It is Ok to indent with all spaces the Python and Elisp
>>    sources in the contrib/ area.
>
> Should contrib simply be exempt from all rules?  Certainly with my
> contribution to contrib (contrib/stats/packinfo.pl) I made no effort to
> conform to the Git style because I thought contribs were auxiliary to
> Git.  (It contains indention with all spaces, which is my personal
> default style.)

You are quoting an older draft.  The rules applied to 'master'
is actually a bit more lenient:

 - Unless otherwise specified, indent with SP that could be
   replaced with HT are not "bad".  But SP before HT in the
   indent is "bad", and trailing whitespaces are "bad".

 - For C source files, initial indent by SP that can be replaced
   with HT is also "bad".

 - Test scripts in t/ and test vectors in its subdirectories can
   contain anything, so we make it unrestricted for now.

So your particular "indent without HT" is generally accepted,
and considered a violation only in C sources.

I see what you mean by "excempt from all rules" and it is
certainly a valid approach, but I at the same time think minimal
whitespace policy should be there, and flagging trailing spaces
and SP before HT is a good idea.
