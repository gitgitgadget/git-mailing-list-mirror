From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New commit object headers: generation and note headers
Date: Sat, 09 Feb 2008 13:03:57 -0800
Message-ID: <7vlk5tetaa.fsf@gitster.siamese.dyndns.org>
References: <200802091746.09102.jnareb@gmail.com>
	<alpine.LNX.1.00.0802091220030.13593@iabervon.org>
	<fcaeb9bf0802090950l27aa247ei5d067e0f24fcade0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:04:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwsR-0003AD-Rr
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 22:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbYBIVEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 16:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbYBIVEG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 16:04:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbYBIVEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 16:04:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECDB3D07;
	Sat,  9 Feb 2008 16:04:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 813613D06;
	Sat,  9 Feb 2008 16:03:59 -0500 (EST)
In-Reply-To: <fcaeb9bf0802090950l27aa247ei5d067e0f24fcade0@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sun, 10 Feb 2008 00:50:12 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73265>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Sun, Feb 10, 2008 at 12:35 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>>
>> On Sat, 9 Feb 2008, Jakub Narebski wrote:
>>  > 2. 'note' header (no semantical meaning)
>>  >
>>  > There was some time ago discussion about adding 'note' header, initially
>>  > to save original sha-1 of a commit for cherry-picking and rebase; then
>>  > for saving explicit rename or corrected rename info, for saving chosen
>>  > merge strategy, and for saving original ID of SCM import.
>>
>>  Probably want to have a prescribed syntax for specifying what note this
>>  is, so that different programs using notes don't confuse each other.
>
> How about git ignoring all X- headers and let programs freely add
> them? For example, X-SVN may be used for git-svn.

Please don't.

When two people/programs create an otherwise identical (for the
purpose of git) commits that have two different object names,
there'd better be a very good reason other than "I felt like
adding an extra header that I can use willy-nilly".

Please separate the 'note' part and the 'generation' part and
make two separate discussion threads.

And kill 'note' part altogether, but that can be done in that
thread ;-).
