From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs in 
	a repository
Date: Tue, 3 Nov 2009 21:41:17 +1100
Message-ID: <19184.2253.656355.506185@cargo.ozlabs.ibm.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
	<19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	<6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	<4AB78910.7010402@viscovery.net>
	<6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	<4AB7A2E7.5000601@viscovery.net>
	<874oqvc0n3.fsf@users.sourceforge.net>
	<7v1vlzvjtg.fsf@alter.siamese.dyndns.org>
	<81b0412b0911030204v46adf54gb9ed65e78ce2b6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy, John" <john.murphy@bankofamerica.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5GuE-0004ha-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 11:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZKCKqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 05:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbZKCKqT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 05:46:19 -0500
Received: from ozlabs.org ([203.10.76.45]:42855 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZKCKqS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 05:46:18 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 29C03B7BE0; Tue,  3 Nov 2009 21:46:23 +1100 (EST)
In-Reply-To: <81b0412b0911030204v46adf54gb9ed65e78ce2b6df@mail.gmail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131963>

Alex Riesen writes:

> On Tue, Sep 22, 2009 at 02:39, Junio C Hamano <gitster@pobox.com> wro=
te:
> > Pat Thoyts <patthoyts@users.sourceforge.net> writes:
> >> =A0 =A0 =A0if {$revs eq {}} {
> >> =A0 =A0 =A0 =A0 set revs HEAD
> >> + =A0 =A0} elseif {$revs eq "--all"} {
> >> + =A0 =A0 =A0 =A0return $revs
> >> =A0 =A0 =A0}
> >
> > That looks like an ugly hack (aka sweeping the issue under the rug)=
=2E
> >
>=20
> And it is a race condition. By the time git log has got --all list of=
 references
> it may look completely different to what gitk has.

Yes, exactly.  Until git log understands --stdin, I think the only
real solution is to disable the view update optimization on windows.

Paul.
