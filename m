From: Tim Visher <tim.visher@gmail.com>
Subject: Issues building docs on an offline box again.
Date: Mon, 23 Feb 2009 18:07:54 -0500
Message-ID: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 00:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbjvT-0002H1-8u
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 00:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbZBWXH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbZBWXH5
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 18:07:57 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:39470 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbZBWXH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 18:07:56 -0500
Received: by an-out-0708.google.com with SMTP id c2so945984anc.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=SPkImEZtMFWyuUNuwBpZ0bf/rT9X7BwQUMQ++YK+bSU=;
        b=LQxOq0EdUYbih9YzYLXGHeFtKH3g6RhIJsCxG3KNHbINjl/DnBM63NgSn5bFqTfjjX
         RaCRyR3e1ZrJY/o1tUeg7K6eoJ+yW6XApu2hMaiDq7AdvT1dEv0VnaOBCr/TgfIGJtp5
         /dmgyDLQdilVLn28LLbs2Zp6si38LX2SFqsOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UsEb3ZKWy1RqPKDDOsobA2tz6zDRxuhv/qUGS7+siSq5OyguWE6hKLJSG1zJt1Z9+B
         bRvyQ6KFEkkOyPBGXoyUqxKvbqAruj3bt85//zUb/M84HzvyaCjoSNT66U3relEWyeF0
         xfxfUZubmVPf/+ADcKutohFHtS07hC2AdwWEo=
Received: by 10.100.11.3 with SMTP id 3mr4856523ank.123.1235430474409; Mon, 23 
	Feb 2009 15:07:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111179>

Hello all,

I'm having a strange issue build the man pages again on my offline box.

I have a copy of cygwin installed on both my online and offline box
with the same configuration.  On my online box, the man pages build
fine.  On my offline box I get the following dump:

$ make install-man
rm -f doc.dep+ doc.dep
/usr/bin/perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make -C ../ GIT-VERSION-FILE
make[1]: Entering directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
GIT_VERSION = 1.6.2.rc1.25.g2d602e
make[1]: Leaving directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
make[1]: Entering directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
make[1]: `GIT-VERSION-FILE' is up to date.
make[1]: Leaving directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
make -C ../ GIT-VERSION-FILE
make[1]: Entering directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
make[1]: `GIT-VERSION-FILE' is up to date.
make[1]: Leaving directory `/cygdrive/c/Documents and
Settings/tvishe01/My Documents/git'
rm -f git-add.xml+ git-add.xml
asciidoc -b docbook -d manpage -f asciidoc.conf \
                 -agit_version=1.6.2.rc1.25.g2d602e -o git-add.xml+ git-add.txt
mv git-add.xml+ git-add.xml
rm -f git-add.1
xmlto -m callouts.xsl man git-add.xml
I/O error : Attempt to load network entity
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
compilation error: file /tmp/xmlto-xsl.f254nC line 4 element import
xsl:import : unable to load
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
make: *** [git-add.1] Error 1

Strange thing is that I thought I had gotten these to build offline
before with the exact same configuration.  Any thoughts?

My current solution is to build them on the online box and then copy
them over the sneaker net to the offline box.  But, this is kludgey,
so not cool. :)

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
