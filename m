From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-fast-import.xml:732:
 parser error
Date: Sun, 30 Sep 2012 03:32:50 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930033250.f405c079.hesco@campaignfoundations.com>
Reply-To: Hugh Esco <hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIE2B-0001ov-4X
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab2I3Hdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:33:41 -0400
Received: from mail.greens.org ([207.111.216.211]:52954 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab2I3Hdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:33:40 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id 191A6805BF; Sun, 30 Sep 2012 00:33:40 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id BA4B888AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 03:32:50 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740332507130
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206673>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO git-fast-import.1
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-fast-import.xml:732: parser error : Opening and ending tag mismatch: superscript line 732 and literal
<simpara>The <literal><superscript>0</literal> suffix is necessary as fast-impor
                                              ^
/usr/local/git-git-51993a4/Documentation/git-fast-import.xml:734: parser error : Opening and ending tag mismatch: literal line 734 and superscript
m</literal> command is even read from the input.  Adding <literal></superscript>
                                                                               ^
make[1]: *** [git-fast-import.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

Sorry, got a bit ahead of myself and forgot to grab 
a copy I could diff against.  But in short I simply 
removed the superscript tags and that was sufficient 
to making this work.  

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
