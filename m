From: Drew Northup <drew.northup@maine.edu>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 15:53:29 -0500
Message-ID: <1290200009.13785.80.camel@drew-northup.unet.maine.edu>
References: <20101117095233.GA23817@basil.fritz.box>
	 <20101117101516.GA12416@burratino>
	 <20101117143855.GA1987@sigill.intra.peff.net>
	 <20101117154829.GE23656@basil.fritz.box>
	 <20101119175424.GA13276@sigill.intra.peff.net>
	 <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
	 <20101119204010.GA18342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXyf-00024o-Ci
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0KSUyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:54:31 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:55724 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab0KSUyb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:54:31 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAJKrZft018052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Nov 2010 15:53:35 -0500
In-Reply-To: <20101119204010.GA18342@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAJKrZft018052
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1290804820.15175@1xmXlCA/vYGrMjwv3rOzdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161785>


On Fri, 2010-11-19 at 15:40 -0500, Jeff King wrote:
> On Fri, Nov 19, 2010 at 03:34:53PM -0500, Drew Northup wrote:
> 
> > > RHEL5 has asciidoc8, but docbook-xsl 1.69, which means it still needs
> > > ASCIIDOC_ROFF enabled. RHEL6 is just out last week. So we are
> > > technically breaking at least RHEL5 people (along with anybody with
> > > ancient systems) until they tweak their knobs.
> > 
> > Once I imported the DocBook XML XSL 4.5 files into my local cache it
> > seemed to make the man pages just fine on my RHEL5 machine even with the
> > posted patch applied.
> > 
> > [root@host ~]# rpm -qi asciidoc
> > Name        : asciidoc                     Relocations: (not relocatable)
> > Version     : 8.6.3                             Vendor: Dag Apt Repository, http://dag.wieers.com/apt/
> > Release     : 1.el5.rf                      Build Date: Thu 18 Nov 2010 08:35:22 AM EST
> > ...
> > [root@host ~]# rpm -qi docbook-utils
> > Name        : docbook-utils                Relocations: (not relocatable)
> > Version     : 0.6.14                            Vendor: Red Hat, Inc.
> > Release     : 5.1                           Build Date: Wed 12 Jul 2006 03:55:00 AM EDT
> > 
> > I didn't inspect each and every one for errors, but I didn't see any
> > problems in the ones I did look at.
> 
> I think the updated XSL files are what's making it work. The stock
> docbook xsl files are:
> 
>   $ yum list | grep docbook-style-xsl
>   docbook-style-xsl.noarch   1.69.1-5.1 rhel-x86_64-server-5

Interestingly enough, without the updated XSL files it seemed to be
working ok, it was just ungodly slow and kicking up a ton of warnings
(it was trying to fetch them off of the hosting web server at such a
high rate it was being limited out).

> and I don't know that we can assume anyone has updated them. However, I
> don't actually build git on my RHEL machines, so I could might be wrong.
> 
> All that being said, I am willing to accept RHEL5 as collateral damage
> if the new defaults Just Work for the majority of other platforms.
> 
> -Peff

I don't personally see this as a stopper. After all, asciidoc wasn't a
default install either.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
