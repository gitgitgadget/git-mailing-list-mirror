From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Mon, 27 Feb 2006 14:09:17 +0100
Message-ID: <20060227130917.GA22933@diana.vm.bytemark.co.uk>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk> <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com> <43F53C76.6080902@vilain.net> <20060217042108.GB28114@diana.vm.bytemark.co.uk> <20060227121108.GA22398@diana.vm.bytemark.co.uk> <1141043391.3438.66.camel@pc1117>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 14:09:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDi7t-0003Ic-TV
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 14:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWB0NJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 08:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWB0NJT
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 08:09:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:30725 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751091AbWB0NJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 08:09:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FDi7p-00063y-00; Mon, 27 Feb 2006 13:09:17 +0000
To: catalin.marinas@gmail.com
Content-Disposition: inline
In-Reply-To: <1141043391.3438.66.camel@pc1117>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16843>

On 2006-02-27 12:29:51 +0000, Catalin Marinas wrote:

> On Mon, 2006-02-27 at 13:11 +0100, Karl Hasselstr=F6m wrote:
>
> > There was a bug here after all: I just tried "stg pick
> > multi@kha/patches" (to pick a patch named "multi" from the branch
> > "kha/patches"), and StGIT tried to pick the patch from branch
> > "kha".
>
> I haven't applied your patch yet (too busy to properly review it).

And as I just demonstrated, it certainly needed reviewing! (Actually,
I believe I said that back when I posted the patch, too.)

> > Looking closer, I realized that the complete patch specification
> > syntax is "patchname@branchname/bottom", not
> > "patchname/bottom@branchname" as I had assumed. This is obviously
> > hard to reconcile with branch names containing /.
>
> I don't have any strong opinion on either. Maybe we should use the
> latter if it makes things easier for supporting branch names with
> /'s.

The problem is that the current from is better (bottom is a modifier
to patch@branch, not just patch). And using the other form will break
when someone decides that patches with slashes in their names are a
good idea (not a joke).

Perhaps change /bottom to #bottom (making the complete form
patchname@branchname#bottom), and for backward compatibility accept
patchname@branchname/bottom as well when no branch called
"branchname/bottom" exists.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
