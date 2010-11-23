From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 08:13:10 -0500
Message-ID: <1290517990.10366.17.camel@drew-northup.unet.maine.edu>
References: <m2oc9hkurl.fsf@gmail.com>
	 <1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	 <m2k4k5ks0b.fsf@gmail.com>
	 <1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	 <m2bp5glbrp.fsf@gmail.com>  <4CEB7F1F.809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:15:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsiA-000168-0s
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab0KWNOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 08:14:50 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:58921 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0KWNOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 08:14:49 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oANDDGCA029287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Nov 2010 08:13:21 -0500
In-Reply-To: <4CEB7F1F.809@drmicha.warpmail.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oANDDGCA029287
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291122832.38928@FTynFviXr244KHJfIM4M+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161957>


On Tue, 2010-11-23 at 09:45 +0100, Michael J Gruber wrote:
> Francis Moreau venit, vidit, dixit 23.11.2010 08:50:
> > Drew Northup <drew.northup@maine.edu> writes:
> > 
> > [...]
> > 
> >> Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
> >> check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
> >> correct. If it is it will contain a line an awful lot like the
> >> following:
> >> <public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>
> > 
> > It doesn't seem so:
> > 
> >   $ cat /usr/share/sgml/docbook/xmlcatalog
> >   <?xml version="1.0"?>
> >   <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
> >   <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>

Ok, before we get too far down the rabbit hole, is that EVERYTHING in
your xmlcatalog? If it is then you have an install error (I downloaded
the spec file and read it extra closely just to be sure). In FC14 the
xmlcatalog file is not provided as whole cloth but it is built by the
post-install script. If that script failed to run to completion you will
have missing parts to your docbook-dtds package installation.


> > This file belongs to xml-common-0.6.3-33.fc14.noarch which sounds pretty
> > uptodate for a Fedora distribution.

Yes, it is the latest in the FC git repo collection for that package as
well.

> > 
> > Here's a list of some packages installed on my system that might be
> > relevant:
> > 
> >   asciidoc-8.4.5-5.fc14.noarch
> >   docbook-utils-0.6.14-26.fc14.noarch
> >   docbook-style-xsl-1.75.2-6.fc14.noarch
> >   docbook-style-dsssl-1.79-11.fc14.noarch
> >   docbook-dtds-1.0-53.fc14.noarch
> >   xml-commons-resolver-1.2-4.fc14.noarch
> >   xmlto-0.0.23-3.fc13.x86_64
> >   xmltex-20020625-16.fc13.noarch
> >   libxml2-devel-2.7.7-2.fc14.x86_64
> >   libxml2-python-2.7.7-2.fc14.x86_64
> >   libxml++-2.30.1-1.fc14.x86_64
> >   libxml2-2.7.7-2.fc14.i686
> >   libxml++-2.30.1-1.fc14.i686
> >   xml-common-0.6.3-33.fc14.noarch
> >   xml-commons-apis-1.4.01-1.fc13.noarch
> > 
> 
> I have no problems building the doc on F14 with
> 
> ASCIIDOC8=y
> ASCIIDOC_NO_ROFF=y
> DOCBOOK2X_TEXI=db2x_docbook2texi
> 
> in my config.mak (besides other stuff), with these versions:
> 
> asciidoc-8.4.5-5.fc14.noarch
> docbook2X-0.8.8-7.fc14.x86_64
> docbook-dtds-1.0-53.fc14.noarch
> docbook-style-dsssl-1.79-11.fc14.noarch
> docbook-style-xsl-1.75.2-6.fc14.noarch
> docbook-utils-0.6.14-26.fc14.noarch
> libxml2-2.7.7-2.fc14.x86_64
> libxml++-2.32.0-1.fc14.x86_64
> libxml2-python-2.7.7-2.fc14.x86_64
> python-lxml-2.2.8-1.fc14.x86_64
> xml-common-0.6.3-33.fc14.noarch
> xmlto-0.0.23-3.fc13.x86_64
> 
> (libxml is irrelevant)
> 
> Are you sure you have no other xmlto (type -a xmlto) and no tinkering
> with the default style sheet config?
> 
> Michael

Before you get too much further along chasing phantoms, please have a
look back into the mailing list at the problems I had just enumerated
with respect to building the man pages when missing the docbook 4.5
declarations and files in my local xmlcatalog. I got EXACTLY THE SAME
ERRORS ORIGINALLY NOTED. That's why I answered the original query to the
list.

I recommend re-installing the docbook-dtds package alone and in
isolation from other Yum/RPM transactions. If the xmlcatalog file is
correctly regenerated AND the docbook files are there AND you have
(re)run ./configure prior to running make AND you don't have filesystem
errors THEN you should have a successful build. (Barring something that
crawls up out of the rabbit hole--other than a rabbit.)

Fix the most obvious possible problems first before seeking
off-the-beaten-path solutions or worse blaming somebody.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
