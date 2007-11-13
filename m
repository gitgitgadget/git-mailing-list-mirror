From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 10:48:01 +0100
Message-ID: <vpqzlxiiii6.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 10:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsOM-0003i8-4R
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXKMJsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXKMJsy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:48:54 -0500
Received: from imag.imag.fr ([129.88.30.1]:55941 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXKMJsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:48:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAD9m1p0007796
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 10:48:02 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IrsNF-0000bA-L1; Tue, 13 Nov 2007 10:48:01 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IrsNF-00014U-IX; Tue, 13 Nov 2007 10:48:01 +0100
In-Reply-To: <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 12 Nov 2007 13\:56\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Nov 2007 10:48:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64775>

Junio C Hamano <gitster@pobox.com> writes:

> But both of Johannes's points apply equally well to an empty
> bare repository and to an empty non bare repository.  IOW,
> bareness does not matter to the suggestion Johannes gave.

He was suggesting to create the initial commit before cloning:

>> So you need to populate the repository before starting _anyway_.

To create an initial commit in a non-bare repository, I put files in
it, git add, and git commit.

To create an initial commit in a bare repository, the most natural way
for me is to clone it, create the commit in the clone, and then push.

Bare-ness _does_ matter for that.

I repeat the use-case I mentionned above :

,----
| a typical use-case is when I want to create a new project. I'd
| like to initialize an empty bare repo on my backed up disk, and then
| clone it to my local-fast-unreliable disk to get a working copy and do
| the first commit there.
`----

I find this quite natural, and up to now, no one gave me either a
rationale not to do that, or a _simple_ way to achieve this. As I
said, it's currently not _very_ hard to do, but I have to edit
.git/config by hand, while git clone knows how to do this much faster
than I for non-empty repositories.

-- 
Matthieu
