From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-grep.xml:601: element
 literal: validity error
Date: Sun, 30 Sep 2012 03:44:51 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930034451.f725b457.hesco@campaignfoundations.com>
Reply-To: Hugh Esco <hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEER-0006S0-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2I3Hpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:45:41 -0400
Received: from mail.greens.org ([207.111.216.211]:52009 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab2I3Hpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:45:40 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id 7E284805CC; Sun, 30 Sep 2012 00:45:40 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id 6506988AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 03:44:51 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740344517190
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206676>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

   XMLTO git-grep.1
xmlto: input does not validate (status 3)
/usr/local/git-git-51993a4/Documentation/git-grep.xml:601: element literal: validity error : Element emphasis is not declared in literal list of possible children
/usr/local/git-git-51993a4/Documentation/git-grep.xml:601: element literal: validity error : Element emphasis is not declared in literal list of possible children
/usr/local/git-git-51993a4/Documentation/git-grep.xml:612: element literal: validity error : Element emphasis is not declared in literal list of possible children
Document /usr/local/git-git-51993a4/Documentation/git-grep.xml does not validate
make[1]: *** [git-grep.1] Error 3
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

601c601
> <literal>git grep time_t &#8212; *.[ch]</literal>
---
< <literal>git grep <emphasis>time_t</emphasis> &#8212; <emphasis>*.[ch]</emphasis></literal>
612c612
< <literal>git grep -e #define --and \( -e MAX_PATH -e PATH_MAX \)</literal>
---
> <literal>git grep -e <emphasis>#define</emphasis> --and \( -e MAX_PATH -e PATH_MAX \)</literal>

-- 
Hugh Esco 
skype: hresco3_ ; 678-921-8186 x21 
http://www.CampaignFoundations.com/
Providing Application Hosting, Telephony, 
Custom Development and Consulting Services 
to Green Candidates, Green Parties and
the non profits working for a just and sustainable future.

if( $insurance->rationing() ) { $people->die(); }
if( isa_ok($self,'Troy::Davis') =~ m/^ok/) { $people->are_whole(); }
