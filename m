From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 3 Mar 2006 15:13:29 +0100
Message-ID: <20060303141329.GA16456@diana.vm.bytemark.co.uk>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <44037A5C.6080409@gmail.com> <b0943d9e0602281445w7160d915y@mail.gmail.com> <4405DC41.8020700@citi.umich.edu> <b0943d9e0603010953iccf64a4v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Mar 03 15:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFB2L-0001vF-Gp
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 15:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWCCONf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Mar 2006 09:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCCONf
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 09:13:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:39946 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751154AbWCCONe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 09:13:34 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FFB29-0004Jw-00
	for <git@vger.kernel.org>; Fri, 03 Mar 2006 14:13:29 +0000
To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b0943d9e0603010953iccf64a4v@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17153>

On 2006-03-01 17:53:53 +0000, Catalin Marinas wrote:

> This won't solve the problem since testing whether patch "a" was
> merged upstream will fail because its reverse won't apply cleanly
> onto the upstream HEAD. Of course, you can try combination of
> upstream commits and local patches but it's not really feasible.
>
> As I said, this method doesn't solve all the upstream merge
> situations but it is OK for most of them.

We could perhaps do a little better. Instead of just noting whether
the patch vanishes when reverse-applied, save the top and bottom of
the patch as reverse-applied, and then replace the patch with the
reverse of that. If the patch vanishes, this does what your patch does
right now. If the patch does not vanish, all that remains is the parts
that upstream didn't accept. (And as before, if the patch didn't
reverse-apply cleanly, assume upstream hasn't accepted it at all yet.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
