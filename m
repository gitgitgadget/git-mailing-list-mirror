From: Stephen Hemminger <shemminger@vyatta.com>
Subject: git svn perl issues
Date: Wed, 23 Mar 2011 08:52:37 -0700
Organization: Vyatta
Message-ID: <20110323085237.1a52ab7e@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 16:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QMa-0001ig-KB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab1CWPwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:52:42 -0400
Received: from mail.vyatta.com ([76.74.103.46]:60434 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752Ab1CWPwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:52:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 6AC0E182910D
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 08:52:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at tahiti.vyatta.com
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BnvNVv6MU11w for <git@vger.kernel.org>;
	Wed, 23 Mar 2011 08:52:40 -0700 (PDT)
Received: from nehalam (unknown [10.250.0.106])
	by mail.vyatta.com (Postfix) with ESMTPSA id 341601829103
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 08:52:40 -0700 (PDT)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169845>

1. The following needs to be fixed:

$ git svn clone 
Use of uninitialized value $_[0] in substitution (s///) at /usr/share/perl/5.10.1/File/Basename.pm line 341.
fileparse(): need a valid pathname at /usr/lib/git-core/git-svn line 403


2. The git-svn perl script does not follow Perl Best Practices.
If you run the perlcritic script on it, all the following warnings/errors
are generated:

$ perlcritic /usr/lib/git-core/git-svn 
Code before strictures are enabled at line 2, column 10.  See page 429 of PBP.  (Severity: 5)
Variable declared in conditional statement at line 18, column 1.  Declare variables outside of the condition.  (Severity: 5)
Subroutine prototypes used at line 39, column 1.  See page 194 of PBP.  (Severity: 5)
Stricture disabled at line 65, column 2.  See page 429 of PBP.  (Severity: 5)
Variable declared in conditional statement at line 287, column 1.  Declare variables outside of the condition.  (Severity: 5)
Variable declared in conditional statement at line 533, column 2.  Declare variables outside of the condition.  (Severity: 5)
Bareword file handle opened at line 851, column 3.  See pages 202,204 of PBP.  (Severity: 5)
Bareword file handle opened at line 1169, column 4.  See pages 202,204 of PBP.  (Severity: 5)
Variable declared in conditional statement at line 1571, column 3.  Declare variables outside of the condition.  (Severity: 5)
Stricture disabled at line 1682, column 2.  See page 429 of PBP.  (Severity: 5)
Don't modify $_ in list functions at line 1815, column 11.  See page 114 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 1891, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 1969, column 2.  See page 199 of PBP.  (Severity: 5)
Variable declared in conditional statement at line 1990, column 3.  Declare variables outside of the condition.  (Severity: 5)
Nested named subroutine at line 2135, column 2.  Declaring a named sub inside another named sub does not prevent the inner sub from being global.  (Severity: 5)
"return" statement with explicit "undef" at line 2140, column 3.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 2663, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 2671, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 2682, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 2753, column 2.  See page 199 of PBP.  (Severity: 5)
Nested named subroutine at line 2789, column 2.  Declaring a named sub inside another named sub does not prevent the inner sub from being global.  (Severity: 5)
"return" statement with explicit "undef" at line 3373, column 3.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 3707, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 3723, column 3.  See page 199 of PBP.  (Severity: 5)
Bareword file handle opened at line 3977, column 3.  See pages 202,204 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4116, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4119, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4204, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4212, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4220, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4228, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4244, column 2.  See page 199 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 4291, column 2.  See page 199 of PBP.  (Severity: 5)
Nested named subroutine at line 4463, column 2.  Declaring a named sub inside another named sub does not prevent the inner sub from being global.  (Severity: 5)
Subroutine prototypes used at line 4707, column 1.  See page 194 of PBP.  (Severity: 5)
Stricture disabled at line 4817, column 2.  See page 429 of PBP.  (Severity: 5)
Subroutine prototypes used at line 4831, column 1.  See page 194 of PBP.  (Severity: 5)
Nested named subroutine at line 5160, column 3.  Declaring a named sub inside another named sub does not prevent the inner sub from being global.  (Severity: 5)
Nested named subroutine at line 5271, column 2.  Declaring a named sub inside another named sub does not prevent the inner sub from being global.  (Severity: 5)
Use IO::Interactive::is_interactive() instead of -t at line 5477, column 8.  See page 218 of PBP.  (Severity: 5)
"return" statement with explicit "undef" at line 5823, column 2.  See page 199 of PBP.  (Severity: 5)
Glob written as <...> at line 5904, column 11.  See page 167 of PBP.  (Severity: 5)
