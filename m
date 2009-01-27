From: Tim Visher <tim.visher@gmail.com>
Subject: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 10:41:23 -0500
Message-ID: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRq5r-0003iq-FX
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbZA0Pl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbZA0Pl0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:41:26 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:57180 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZA0PlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:41:25 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2785200ywe.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bE7Wog8QV+wQRJQ9cNvYapwNWVoJ+UpvTtDUE3VrLI0=;
        b=MSFKXs4Qlsw6oOXo9xYfMEHsCYyZtdW5fXi/nuZpVoiKbCrF/LTczTU2zz+dRNHD5I
         ltiuGUkRFcd0su4/XGHgZgr4v632sWv6FJ27j050NMLpZsQ0fyW8HVK7xLbHGv13KdU+
         wEXOR4cR6KRrByyAfAiwNVw8BDYiiV5ScuMh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YUMbPZqIxSt8LDs5VByl77dCGV4jgL4ztC/GNgMBgfa310yIrFGSHxbPd6y2nfaZFQ
         O5kyjKOYdceLcvgXpbFU+fPYQYCKbto+1MmqxpL3JNuJGiaYTHKpFnxHPvTAd4sWufwU
         /N9dDGyvC5RxGmbhNUh12biB/dFSDyWNifN44=
Received: by 10.100.134.10 with SMTP id h10mr133416and.150.1233070883662; Tue, 
	27 Jan 2009 07:41:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107357>

Hey Everyone,

I've asked this question here before but unfortunately I can't find
the answer in any of the archives.  I'm trying to build the
documentation on Windows in Cygwin.  Git builds fine, the html docs
build fine, but when I get to the man pages, I get the following
error:

    $ make install-man
    rm -f doc.dep+ doc.dep
    /usr/bin/perl ./build-docdep.perl >doc.dep+
    mv doc.dep+ doc.dep
    make -C ../ GIT-VERSION-FILE
    make[1]: Entering directory `/cygdrive/c/Documents and
Settings/tvishe01/Desktop/Projects/git'
    make[1]: `GIT-VERSION-FILE' is up to date.
    make[1]: Leaving directory `/cygdrive/c/Documents and
Settings/tvishe01/Desktop/Projects/git'
    make -C ../ GIT-VERSION-FILE
    make[1]: Entering directory `/cygdrive/c/Documents and
Settings/tvishe01/Desktop/Projects/git'
    make[1]: `GIT-VERSION-FILE' is up to date.
    make[1]: Leaving directory `/cygdrive/c/Documents and
Settings/tvishe01/Desktop/Projects/git'
    rm -f git-add.xml+ git-add.xml
    asciidoc -b docbook -d manpage -f asciidoc.conf \
                     -agit_version=1.6.1.1.230.gdfb04 -o git-add.xml+
git-add.txt
    mv git-add.xml+ git-add.xml
    rm -f git-add.1
    xmlto -m callouts.xsl man git-add.xml
    xmlto: input does not validate (status 3)
    error : Operation not permitted
    /home/tvishe01/projects/git/Documentation/git-add.xml:2: warning:
failed to load external entity
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
    D DocBook XML V4.2//EN"
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"

            ^
    error : Operation not permitted
    warning: failed to load external entity
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
    Could not load the external subset
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
    Document /home/tvishe01/projects/git/Documentation/git-add.xml
does not validate
    make: *** [git-add.1] Error 3

I've fixed this before but I've been thwarted all morning on the
Googles trying to find out what to do.  I remember it having something
to do with explicitly telling xmlto not to try to download doctypes or
something.  Also, I remember there being pre-built man pages somewhere
that I could download and just manually install.

Anyway, I'm not opposed to either of those routes, I just can't figure
out how to do it personally.

Thanks in advance!

--

http://five.sentenc.es/ - Spend less time on e-mail.
Written using [Emacs](http://www.gnu.org/software/emacs/).
