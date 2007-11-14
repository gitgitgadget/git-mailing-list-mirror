From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 10:49:23 +0100
Message-ID: <vpqbq9xw40s.fsf@bauges.imag.fr>
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
	<vpqzlxiiii6.fsf@bauges.imag.fr>
	<7vir46t2cc.fsf@gitster.siamese.dyndns.org>
	<vpqd4ud6c0z.fsf@bauges.imag.fr>
	<7vejetr7vn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 10:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEvC-0002Kf-1x
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbXKNJwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 04:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbXKNJwR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:52:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:45646 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbXKNJwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:52:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAE9nPSA008610
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Nov 2007 10:49:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IsEs7-0005aq-9Y; Wed, 14 Nov 2007 10:49:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IsEs7-0004Ve-6r; Wed, 14 Nov 2007 10:49:23 +0100
In-Reply-To: <7vejetr7vn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 13 Nov 2007 16\:25\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 14 Nov 2007 10:49:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64974>

Junio C Hamano <gitster@pobox.com> writes:

> If your publishing repo is local like the above, then

In my case, it's more often a "backed-up and slow NFS disk" Vs "local
disk" than a matter of publishing, but the result is similar.

>  $ mkdir /tmp/junk && cd /tmp/junk
>  $ git init; tar xf /tmp/project.tar; git add .; ... populate ... 
>  $ git commit -m initial
>  $ cd /else/where/to/publish
>  $ git clone --bare /tmp/junk myproject.git
>  $ rm -fr /tmp/junk
>
> would be enough to get your published repository started, isn't
> it?  Then wouldn't:
>
>  $ cd $HOME
>  $ git clone /else/where/to/publish/myproject.git myproject
>
> set up your ~/myproject exactly the same way as other people who
> will work with that published repository?

Sure, it definitely works. But that (creating a temporary repository,
and right after, delete it) also is an extra step. Not a huge one, but
still an extra step.

Take the same with bzr for example:

$ bzr init ~/repo
$ bzr checkout ~/repo ~/local/work/
$ cd ~/local/work/
<put files, bzr add, bzr commit>
<continue working in ~/local/work/, commit, whatever>

(bzr checkout is a bit different from git clone, but the difference it
not totally relevant here).

I litterally have just two bzr commands before I can start working
normally.

-- 
Matthieu
