From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: man pages are littered with .ft C and others
Date: Sat, 02 Feb 2008 10:49:41 -0800 (PST)
Message-ID: <m34pcr6vnm.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLNRS-0001ob-AO
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYBBStr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYBBStq
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:49:46 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:5228 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbYBBStp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:49:45 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1445403fkz.5
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=dTyJC1o1z2IeFnND8aoj1hwaX9VhLmelteg5xn05S+I=;
        b=MEUi2trfDn+484y9aYWwpdJ9F2/c0J2f5w357sG3MSS9Mluwy/Vqw3UC8L7mIKQCWKI0E4pCqy7Ro6ChWDPx0zRHcpsAz2qopy1Hq1vBywWiLEIWdKDIIPp4oQ5uuW0X0hYLCtdmsYNEa7z0mzuKj2GkI4YmYmd1u+W1yzIW98w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=RufI/V8On/VnurnKgzU8lXEDDSFcq60+MgimFtriGlXN7tbi+6f3NgcGHT6gFaNKGLD+JqQ3EwQ5G+wzX6HmBk6MEbDMP5995HzTLtq4PXexdVF7xjJHTi+uObwc5sSdUGQFdy0Fetwn1nyqoANFL1dmf/MER5x+j++T3dbKhFQ=
Received: by 10.78.166.7 with SMTP id o7mr8885067hue.31.1201978183685;
        Sat, 02 Feb 2008 10:49:43 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id f4sm2635806nfh.31.2008.02.02.10.49.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 10:49:41 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m12InZDS007460;
	Sat, 2 Feb 2008 19:49:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m12InXic007457;
	Sat, 2 Feb 2008 19:49:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72298>

Adam Flott <adam@npjh.com> writes:

> I do remember at one point the man pages looking correctly (just tested
> v1.5.3.8 and it shows the same problem). Therefore it is probably
> some package I'm missing on my system.

Or perhaps lack of configuration during build.

I have simply build git from original source RPM; this SRPM
does not use pre-compiled manpages (as it could), neither uses
configure to do autodetection of features (which might have
detected and fixed some build configuration needed).

Makefile has ASCIIDOC8 (set automatically by configure)
and DOCBOOK_XSL_172 (which is not autodetected).
 
> And now, I see this scattered all over:
> 
> For example:
> 
>       .ft C
>       $ git checkout master             \fB(1)\fR
>       $ git checkout master~2 Makefile  \fB(2)\fR
>       $ rm -f hello.c
>       $ git checkout hello.c            \fB(3)\fR
>       .ft
> 
> Seems that "------------" and <n>, and a few others aren't being
> translated. Note: I'm not at all familiar with the layout of man pages
> so I have no idea how to fix it or even diagnose it further.

I see the same error in manpages, for example in git-diff-tree(1)

       Example:

       .ft C
       :100644 100644 5be4a4...... 000000...... M file.c
       .ft

> Version info:
> up to date Kubuntu 7.10

Old Aurox Linux 11.1 (based on Fedora Core 4 + some updates)

> asciidoc/gutsy uptodate 8.2.1-2
> docbook-dsssl/gutsy uptodate 1.79-4
> docbook-utils/gutsy uptodate 0.6.14-1
> docbook-xml/gutsy uptodate 4.5-4
> docbook-xsl-doc-html/gutsy uptodate 1.72.0.dfsg.1-2
> docbook-xsl/gutsy uptodate 1.72.0.dfsg.1-2
> xmlto/gutsy uptodate 0.0.18-5.1build1

asciidoc-7.1.2-2.fc3.rf
docbook-dtds-1.0-26
docbook-style-dsssl-1.79-1
docbook-style-xsl-1.68.1-1
docbook-utils-0.6.14-4
docbook-utils-pdf-0.6.14-4
xmlto-0.0.18-6
 
$ asciidoc --version
asciidoc 7.1.2
$ xmlto --version
xmlto version 0.0.18

>From VERSION file in docbook-style-xsl:
<fm:project>
  <fm:Project>DocBook</fm:Project>
  <fm:Branch>XSL Stylesheets</fm:Branch>
  <fm:Version>1.68.1</fm:Version>

> Anyone else seeing this?

I'm also seeing this.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
