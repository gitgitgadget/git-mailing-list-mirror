From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Remove unnecessary
 URL quoting
Date: Mon, 23 Mar 2009 00:20:10 +0100
Message-ID: <200903230020.10128.johan@herland.net>
References: <200903200012.10454.johan@herland.net>
 <200903201619.56600.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:21:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWzE-0006hs-HT
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733AbZCVXUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbZCVXUP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:20:15 -0400
Received: from mx.getmail.no ([84.208.15.66]:36969 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756597AbZCVXUO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 19:20:14 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX006JCKTNA310@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 00:20:11 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGX00A9MKTMD580@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 00:20:11 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.22.230720
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903201619.56600.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114202>

On Friday 20 March 2009, Thomas Rast wrote:
> Johan Herland wrote:
> > Embedding the URL in '+++' causes AsciiDoc (v8.4.1) to generate invalid
> > XML. None of the other URLs in Git's documentation are quoted in this
> > manner. There's no reason to treat this URL differently.
>
> [...]
>
> > -* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
> > +* Clone it with `git clone file:///path/to/repo`.  The clone
>
> I deliberately wrote it that way because *not* quoting it, at least on
> my box, formats the entire paragraph in monospace.  Apparently it
> treats the ` as part of an autodetected URL or some such.  This is
> independent of my choice of ASCIIDOC8 or DOCBOOK_XSL_172 settings.  Am
> I missing another flag that avoids this problem?

No, I think this is due to version differences in AsciiDoc.

> I have these packages installed from opensuse:
>   asciidoc-8.2.7-29.10

I use AsciiDoc v8.4.1 (from Arch Linux), and according to 
http://www.methods.co.nz/asciidoc/CHANGELOG.html there are some regression 
issues regarding backtick quoting and "inline literal passthrough"s when 
upgrading to v8.4.1. According to the changelog I should be able to revert 
AsciiDoc to the old behaviour by putting

  [attributes]
  no-inline-literal=

in my Documentation/asciidoc.conf. However, with this in place, I _still_ 
get invalid XML generated for git-filter-branch.txt... :(

So, it seems to be an AsciiDoc versioning issue. I'm not sure which of these 
AsciiDoc versions are preferable, of if it is possible to format the text in 
such a manner that it'll work in both versions.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
