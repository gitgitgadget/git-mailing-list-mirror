From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 15/17] t5300: avoid testing ofs-delta with --packv4
Date: Sat, 21 Sep 2013 22:13:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309212210260.312@syhkavp.arg>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
 <1379771883-10278-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309211237530.312@syhkavp.arg>
 <CACsJy8DBOgkVz_=JFNx88vi7uypcSSBxpwqRMtmwbsdM7q1L3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ekvKk1xsHXl1F5SaxgnnMA)"
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 04:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNZAm-0000zV-GC
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 04:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3IVCNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 22:13:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30306 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3IVCNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 22:13:16 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTI00A2T8U3JW10@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 21 Sep 2013 22:13:15 -0400 (EDT)
In-reply-to: <CACsJy8DBOgkVz_=JFNx88vi7uypcSSBxpwqRMtmwbsdM7q1L3Q@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235154>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ekvKk1xsHXl1F5SaxgnnMA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 22 Sep 2013, Duy Nguyen wrote:

> On Sat, Sep 21, 2013 at 11:46 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sat, 21 Sep 2013, Nguy­n Thái Ng÷c Duy wrote:
> >
> >>
> >> Signed-off-by: Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
> >> ---
> >>  t/t5300-pack-object.sh | 39 ++++++++++++++++++++++-----------------
> >>  1 file changed, 22 insertions(+), 17 deletions(-)
> > [...]
> >
> > This, in combination with patch 10/17, is making the test suite to test
> > either packv4 or non packv4, and never both.  I think this is not a good
> > approach.
> >
> > Instead we should have packv2 specific tests to enforce --pack-version=2
> > when using pack-objects and create a duplicate of those tests for
> > --pack-version=4 when that makes sense.  For tests that are mostly
> > common, the test could be factored out into a function with a pack
> > version argument.  Then, most tests could be always run twice: once for
> > packv2 and again for packv4.  Not doing so makes it more risky to
> > regress packv2 when testing improvements to packv4 support.
> 
> I agree. I wanted to split this (and maybe other t53xx) for v4-only
> tests and update the existing t53xx to test on v2 only. For now I
> think this will do as it will allow us to verify that v4 code works
> (just need to run the test suite twice, with and without --packv4).

OK.

I've queued those patches at the end of the series so they're easily 
replaceable.


Nicolas

--Boundary_(ID_ekvKk1xsHXl1F5SaxgnnMA)--
