From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: renames in StGIT
Date: Tue, 24 Oct 2006 10:17:32 +0200
Message-ID: <20061024081732.GA29265@diana.vm.bytemark.co.uk>
References: <20061022013943.GA16341@diana.vm.bytemark.co.uk> <b0943d9e0610230947j79449a4dm8736f480f039c230@mail.gmail.com> <20061023125344.f82426ad.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 10:18:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHUA-0004tS-Cm
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWJXIRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 04:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWJXIRx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:17:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:18702 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1030213AbWJXIRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 04:17:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GcHTY-0007ei-00; Tue, 24 Oct 2006 09:17:32 +0100
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061023125344.f82426ad.seanlkml@sympatico.ca>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29943>

On 2006-10-23 12:53:44 -0400, Sean wrote:

> On Mon, 23 Oct 2006 17:47:06 +0100
> "Catalin Marinas" <catalin.marinas@gmail.com> wrote:
>
> > On 22/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > Should this perhaps be an item in the TODO list?
> >
> > Only if it doesn't drastically affect the performance.
>
> There are some situation where it would be really quite handy. The
> performance of the human having to hand resolve a failed push
> because of renames is often worse ;o) If it does become a
> performance problem, perhaps you could make it an optional parameter
> to "stg push".

Yes, this is my opinion too, both for patch generation and pushing.
Having it always on is a bad idea at least for patch generation for
obvious reasons, and may be a bad idea for pushing for performance
reasons, but I definitely think there should be a flag to enable it.
There are situations when you know your upstream can read git patches,
and being able to retry a failed push with rename detection instead of
having to resolve the conflict manually could save lots of time, as
Sean said. Besides, Linus is always bragging about how fast git
merging is, and we all trust Linus, right? :-)

An optional flag is already available for the very handy "check if
patch was merged upstream" feature, and it's definitely the right
thing to do there. (Though I end up always using that flag even when I
know my patches aren't in upstream, since the extra cost is barely
noticeable.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
