From: rh <richard_hubbe11@lavabit.com>
Subject: [PATCH] gitweb.perl: fix %highlight_ext
Date: Mon, 29 Oct 2012 09:42:07 -0700
Message-ID: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 17:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSsL0-0008Cs-FP
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 17:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851Ab2J2QhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 12:37:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:46954 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932816Ab2J2QhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 12:37:03 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TSsKr-00082E-Ku
	for git@vger.kernel.org; Mon, 29 Oct 2012 17:37:09 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 17:37:09 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 17:37:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Received: from slem by 1.1 with local
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208628>

I also consolidated exts where applicable.
i.e. c and h maps to c


-- 

diff --git a/a/gitweb.cgi b/b/gitweb.cgi
index 060db27..155b238 100755
--- a/a/gitweb.cgi
+++ b/b/gitweb.cgi
@@ -246,19 +246,19 @@ our %highlight_basename = (
        'Makefile' => 'make',
 );
 # match by extension
+
 our %highlight_ext = (
        # main extensions, defining name of syntax;
        # see files in /usr/share/highlight/langDefs/ directory
-       map { $_ => $_ }
-               qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
+       (map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
        # alternate extensions, see /etc/highlight/filetypes.conf
-       'h' => 'c',
-       map { $_ => 'sh'  } qw(bash zsh ksh),
-       map { $_ => 'cpp' } qw(cxx c++ cc),
-       map { $_ => 'php' } qw(php3 php4 php5 phps),
-       map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
-       map { $_ => 'make'} qw(mak mk),
-       map { $_ => 'xml' } qw(xhtml html htm),
+       (map { $_ => 'c'   } qw(c h)),
+       (map { $_ => 'sh'  } qw(sh bash zsh ksh)),
+       (map { $_ => 'cpp' } qw(cpp cxx c++ cc)),
+       (map { $_ => 'php' } qw(php php3 php4 php5 phps)),
+       (map { $_ => 'pl'  } qw(pl perl pm)), # perhaps also 'cgi'
+       (map { $_ => 'make'} qw(make mak mk)),
+       (map { $_ => 'xml' } qw(xml xhtml html htm)),
 );
 
 # You define site-wide feature defaults here; override them with
