From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 13:04:26 +0100
Message-ID: <4CEBADCA.3070403@drmicha.warpmail.net>
References: <m2oc9hkurl.fsf@gmail.com>	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>	<m2k4k5ks0b.fsf@gmail.com>	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>	<m2zkt0jsha.fsf@gmail.com> <4CEB9109.4000008@drmicha.warpmail.net>	<m2vd3ojna1.fsf@gmail.com> <4CEBA872.2020001@drmicha.warpmail.net> <m2r5ecjlqd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 13:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKrdv-00029O-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab0KWMGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 07:06:34 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55599 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187Ab0KWMGd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 07:06:33 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DA754AE6;
	Tue, 23 Nov 2010 07:06:32 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 23 Nov 2010 07:06:32 -0500
X-Sasl-enc: lFHJmoeMH0jn21M8HUdmAuYKtuUK8naa3uv+y5fF87fw 1290513992
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 458C6401CBF;
	Tue, 23 Nov 2010 07:06:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <m2r5ecjlqd.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161946>

Francis Moreau venit, vidit, dixit 23.11.2010 12:57:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Francis Moreau venit, vidit, dixit 23.11.2010 12:24:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>
>>>> Francis Moreau venit, vidit, dixit 23.11.2010 10:32:
>>
>>>>>
>>>>>   $ make prefix=/usr/local NO_CURL=1 ASCIIDOC8=y DOCBOOK2X_TEXI=db2x_docbook2texi ASCIIDOC_NO_ROFF=y XMLTO_EXTRA="--skip-validation" V=1 doc
>>>>>   make -C Documentation all
>>>>>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>>>>>   make -C ../  GIT-VERSION-FILE
>>>>>   make[2]: Entering directory `/home/fmoreau/git'
>>>>>   make[2]: `GIT-VERSION-FILE' is up to date.
>>>>>   make[2]: Leaving directory `/home/fmoreau/git'
>>>>>   rm -f git-fetch.1 && \
>>>>>   xmlto -m manpage-normal.xsl --skip-validation man git-fetch.xml
>>>>>   I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>>>   warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
>>>>>   compilation error: file /tmp/xmlto-xsl.A7kzn5 line 4 element import
>>>>>   xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>>>   make[1]: *** [git-fetch.1] Error 1
>>>>>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
>>>>>   make: *** [doc] Error 2
>>>>
>>>> This is weird for several reasons.
>>>>
>>>> Can you wget or curl these files?
>>>
>>> Yes I can.
>>>
>>>>
>>>> Besides, I can build the doc even without network access, even though my
>>>> /tmp/xmlto... has the same import statement.
>>>>
>>>> Can you check with which options your xmlto calls your xsltproc? Mine
>>>> has "--nonet".
>>>
>>> I can see the following ones:
>>>
>>>   --nonet
>>>   --xinclude
>>>
>>>> Do you have libxslt-1.1.26-3.fc14.x86_64, and is your xsltproc the one
>>>> from that package?
>>>
>>>   $ rpm -qa | grep libxslt
>>>   libxslt-devel-1.1.26-3.fc14.x86_64
>>>   libxslt-1.1.26-3.fc14.x86_64
>>>
>>>   $ which xsltproc
>>>   /usr/bin/xsltproc
>>>
>>>   $ rpm -qf /usr/bin/xsltproc
>>>   libxslt-1.1.26-3.fc14.x86_64
>>>
>>
>> I'm pretty stomped then. The only remaining suggestions:
>>
>> - remove xml-commons-resolver and try again
>> - try as a different user
> 
> still fails.
> 
>>
>> Otherwise, an strace of xsltproc might give some hints...
> 
> Here it is:
> 
>   stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
>   stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
>   stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
>   stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
>   open("/tmp/xmlto-xsl.aSCQgY", O_RDONLY) = 3
>   lseek(3, 0, SEEK_CUR)                   = 0
>   read(3, "<?xml version='1.0'?>\n<xsl:style"..., 8192) = 346
>   read(3, "", 7846)                       = 0
>   close(3)                                = 0
>   stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779e50) = -1 ENOENT (No such file or directory)
>   stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779d90) = -1 ENOENT (No such file or directory)
>   stat("/etc/xml/catalog", {st_mode=S_IFREG|0644, st_size=819, ...}) = 0
>   open("/etc/xml/catalog", O_RDONLY)      = 3
>   lseek(3, 0, SEEK_CUR)                   = 0
>   read(3, "<?xml version=\"1.0\"?>\n<!DOCTYPE "..., 8192) = 819
>   read(3, "", 7373)                       = 0
>   close(3)                                = 0
>   stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779d90) = -1 ENOENT (No such file or directory)
>   write(2, "I/O ", 4)                     = 4
>   write(2, "error : ", 8)                 = 8
>   write(2, "Attempt to load network entity h"..., 103) = 103
>   write(2, "warning: ", 9)                = 9
>   write(2, "failed to load external entity \""..., 105) = 105
>   write(2, "compilation error: file /tmp/xml"..., 68) = 68
>   write(2, "xsl:import : unable to load http"..., 100) = 100
> 
> This looks weird, it does stat(2) on an URL...
> 

Sometimes I hate myself for not being able to let go when all
explanations fail. OTOH it comes with my profession...

The stat looks weird but is ok. The difference is what happens then,
after opening the catalog. On my F14:


stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl",
0x7fff633cb2b0) = -1 ENOENT (No such file or directory)
stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl",
0x7fff633cb1f0) = -1 ENOENT (No such file or directory)
stat("/etc/xml/catalog", {st_mode=S_IFREG|0644, st_size=1829, ...}) = 0
open("/etc/xml/catalog", O_RDONLY)      = 3
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "<?xml version=\"1.0\"?>\n<!DOCTYPE "..., 8192) = 1829
read(3, "", 6363)                       = 0
close(3)                                = 0
stat("/usr/share/sgml/docbook/xsl-stylesheets-1.75.2/manpages/docbook.xsl",
{st_mode=S_IFREG|0644, st_size=15170, ...}) = 0
stat("/usr/share/sgml/docbook/xsl-stylesheets-1.75.2/manpages/docbook.xsl",
{st_mode=S_IFREG|0644, st_size=15170, ...}) = 0
stat("/usr/share/sgml/docbook/xsl-stylesheets-1.75.2/manpages/docbook.xsl",
{st_mode=S_IFREG|0644, st_size=15170, ...}) = 0
open("/usr/share/sgml/docbook/xsl-stylesheets-1.75.2/manpages/docbook.xsl",
O_RDONLY) = 3

etc., and all is well. My /etc/xml/catalog:

<?xml version="1.0"?>
<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog
V1.0//EN"
"http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
  <delegatePublic publicIdStartString="-//OASIS//ENTITIES DocBook XML"
catalog="file:///etc/sgml/docbook/xmlcatalog"/>
  <delegatePublic publicIdStartString="-//OASIS//DTD DocBook XML"
catalog="file:///etc/sgml/docbook/xmlcatalog"/>
  <delegatePublic publicIdStartString="ISO 8879:1986"
catalog="file:///etc/sgml/docbook/xmlcatalog"/>
  <delegateSystem
systemIdStartString="http://www.oasis-open.org/docbook/"
catalog="file:///etc/sgml/docbook/xmlcatalog"/>
  <delegateURI uriStartString="http://www.oasis-open.org/docbook/"
catalog="file:///etc/sgml/docbook/xmlcatalog"/>
  <rewriteSystem
systemIdStartString="http://scrollkeeper.sourceforge.net/dtds/scrollkeeper-omf-1.0/scrollkeeper-omf.dtd"
rewritePrefix="/usr/share/xml/scrol
lkeeper/dtds/scrollkeeper-omf.dtd"/>
  <rewriteURI
uriStartString="http://scrollkeeper.sourceforge.net/dtds/scrollkeeper-omf-1.0/scrollkeeper-omf.dtd"
rewritePrefix="/usr/share/xml/scrollkeeper/
dtds/scrollkeeper-omf.dtd"/>
  <rewriteSystem
systemIdStartString="http://docbook.sourceforge.net/release/xsl/1.75.2"
rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2
"/>
  <rewriteURI
uriStartString="http://docbook.sourceforge.net/release/xsl/1.75.2"
rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2"/>
  <rewriteSystem
systemIdStartString="http://docbook.sourceforge.net/release/xsl/current"
rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.
2"/>
  <rewriteURI
uriStartString="http://docbook.sourceforge.net/release/xsl/current"
rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2"/>
</catalog>

(Sorry for the line-breaks)

Michael
