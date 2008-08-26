From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is '-c'
Date: Tue, 26 Aug 2008 08:53:44 +0200
Message-ID: <vpqy72ktgg7.fsf@bauges.imag.fr>
References: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<48B29B2A.6000802@gnu.org>
	<alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
	<alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<20080825210345.GE14930@eagain.net>
	<alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	<20080825222002.GF14930@eagain.net>
	<alpine.DEB.1.00.0808260249090.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommi Virtanen <tv@eagain.net>,
	Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsVj-0003wy-Tf
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbYHZG4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYHZG4m
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:56:42 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:40841 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbYHZG4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:56:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7Q6rxMR012013;
	Tue, 26 Aug 2008 08:53:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KXsQz-0002vv-2W; Tue, 26 Aug 2008 08:53:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KXsQy-0002LZ-VE; Tue, 26 Aug 2008 08:53:44 +0200
In-Reply-To: <alpine.DEB.1.00.0808260249090.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 26 Aug 2008 02\:52\:35 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 26 Aug 2008 08:54:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93718>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 26 Aug 2008, Tommi Virtanen wrote:
>
>> All I'm going to say is that that's not the way you build trustable 
>> software. You take a minimal interface and restrict untrusted users to 
>> that, you don't add a feature to the widest possible interface..
>
> I do not get your point.

With your patch, AAUI, one would put /usr/bin/git as a shell in
passwd. It's pretty clear that someone calling the shell with -c will
get the restriction of git-shell, but I'd hardly guarantee that the
shell in /etc/passwd will never be called without -c. At least, if the
user tries to login, he will execute git without argument (which
fortunately isn't serious, he'll just get the help message for git,
which is unhelpful but not dangerous). My knowledge in Unix isn't
sufficient to be sure there's no way at all to call git in a dangerous
way here. With git-shell, it's much simpler to understand: either you
give -c, and you get the restricted command set, or you don't, and you
get nothing.

-- 
Matthieu
