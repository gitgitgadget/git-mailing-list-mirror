From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CR codes from git commands
Date: Thu, 22 Jan 2009 00:04:41 -0800
Message-ID: <7vbptzahra.fsf@gitster.siamese.dyndns.org>
References: <18805.64312.289059.660023@hungover.brentg.com>
 <alpine.LNX.1.00.0901212319310.19665@iabervon.org>
 <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
 <alpine.LNX.1.00.0901220238380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 09:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPuZu-00066l-34
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 09:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZAVIEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 03:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZAVIEu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 03:04:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZAVIEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 03:04:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AFD192E31;
	Thu, 22 Jan 2009 03:04:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 74BCE92E2F; Thu,
 22 Jan 2009 03:04:44 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0901220238380.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 22 Jan 2009 02:46:57 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5714E22A-E85B-11DD-B32C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106735>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The terminal type, at least in my version of Emacs, is "dumb", which ought 
> to be sufficient to tell git that a pager isn't going to be useful is most 
> cases (might be worthwhile to keep "git log" from eating all your memory, 
> though), and that using CR to rewrite lines isn't going to work.

I think we pay attention to "dumb" when deciding if pager is useful and if
we can do color, but I do not think we check anything beyond "is it a tty"
when deciding to show progress or not.  The only thing we do differently
for "dumb" terminal is if we use ANSI clear-to-eol escape sequence or fill
with a run of SPs to overwrite trailing part of a line, and we assume even
dumb terminals know how to do a carriage-return.
