From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 12:05:06 -0800
Message-ID: <7vpri8347h.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
 <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
 <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
 <c115fd3c0901271027s61a33273lfe9dd702a66aac6@mail.gmail.com>
 <7vskn4y4zt.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0901271127q2a7f0f58i59ff446060982fd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRuCq-0003Ok-6F
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 21:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbZA0UFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbZA0UFR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 15:05:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZA0UFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 15:05:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ABEFE1B45E;
	Tue, 27 Jan 2009 15:05:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E317E1D67F; Tue,
 27 Jan 2009 15:05:07 -0500 (EST)
In-Reply-To: <c115fd3c0901271127q2a7f0f58i59ff446060982fd7@mail.gmail.com>
 (Tim Visher's message of "Tue, 27 Jan 2009 14:27:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEEBE694-ECAD-11DD-9140-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107387>

Tim Visher <tim.visher@gmail.com> writes:

> On Tue, Jan 27, 2009 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The xml toolchain has a tendency to download dtds from the original source
>> with a way for you (typically your distribution) to tell it to use a
>> locally installed version.  "Can build online, fail when offline" is a
>> sign that it is not using the local copy.
>
> Sounds like we're on the same page.  I'm not familiar enough with any
> of these tools to know how to do anything about that.  Does anyone
> know how to explicitly inform xmlto to use a local DTD?  I have it
> installed, as far as I know, via cygwin (the docbook-xml42 package)
> but I don't know how to tell xmlto about it.
>
> Thanks in advance!

I do not know how Cygwin packages things, but here is an exchange I had
with k.org admin when they updated the machine I prepare the preformatted
documentation pages and I had similar trouble.

-- >8 -- from here -- >8 --
/usr/share/sgml/docbook/xmlcatalog on master.kernel.org is empty:

$ ls -l /usr/share/sgml/docbook/xmlcatalog
-rw-r--r-- 1 root root 236 2008-06-30 06:51 /usr/share/sgml/docbook/xmlcatalog
$ cat /usr/share/sgml/docbook/xmlcatalog
<?xml version="1.0"?>
<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN"
"http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>

On a good machine, however, it is much larger:

$ ls -l /usr/share/sgml/docbook/xmlcatalog
-rw-r--r-- 1 root root 7907 Jul  4 14:08 /usr/share/sgml/docbook/xmlcatalog
$ grep docbookx /usr/share/sgml/docbook/xmlcatalog
  <public publicId="-//OASIS//DTD DocBook XML V4.1.2//EN" uri="xml-dtd-4.1.2-1.0-35.fc9/docbookx.dtd"/>
  <public publicId="-//OASIS//DTD DocBook XML V4.2//EN" uri="xml-dtd-4.2-1.0-35.fc9/docbookx.dtd"/>
  <public publicId="-//OASIS//DTD DocBook XML V4.3//EN" uri="xml-dtd-4.3-1.0-35.fc9/docbookx.dtd"/>
  <public publicId="-//OASIS//DTD DocBook XML V4.4//EN" uri="xml-dtd-4.5-1.0-35.fc9/docbookx.dtd"/>

The lack of these entries seems to cause the processing to go to the
network instead of using the files locally installed.
-- 8< -- to here -- 8< --

and a response I got from them:

-- >8 -- from here -- >8 --

Hmmm tried reinstalling docbook-dtds-1.0-35.fc9.noarch.rpm and things
seem to have showed up like your expecting - clearly a bad dependency in
the rpm.  Anyway give it a whirl.

-- 8< -- to here -- 8< --

After that exchange, things did work much better.

I hope the above (words like "docbook-dtds") has enough hints for you to
find corresponding set of packages on Cygwin to additionally install or
futz with to get the formatting working.
