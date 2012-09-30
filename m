From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-stash.xml:116: parser
 error
Date: Sun, 30 Sep 2012 04:17:44 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930041744.fbdec9c8.hesco@campaignfoundations.com>
Reply-To: Hugh Esco <hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 10:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEjf-0002DE-V2
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 10:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2I3ISg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 04:18:36 -0400
Received: from mail.greens.org ([207.111.216.211]:45925 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab2I3ISe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 04:18:34 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id 192A5805BC; Sun, 30 Sep 2012 01:18:34 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id DAE2B88AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 04:17:44 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740417447335
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206682>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO git-stash.1
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-stash.xml:116: parser error : Opening and ending tag mismatch: literal line 115 and simpara
</simpara>
          ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:117: parser error : Opening and ending tag mismatch: simpara line 111 and listitem
</listitem>
           ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:118: parser error : Opening and ending tag mismatch: listitem line 110 and varlistentry
</varlistentry>
               ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:211: parser error : Opening and ending tag mismatch: varlistentry line 106 and variablelist
</variablelist>
               ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:212: parser error : Opening and ending tag mismatch: variablelist line 49 and refsect1
</refsect1>
           ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:348: parser error : Opening and ending tag mismatch: refsect1 line 47 and refentry
</refentry>
           ^
/usr/local/git-git-51993a4/Documentation/git-stash.xml:349: parser error : Premature end of data in tag refentry line 3

^
make[1]: *** [git-stash.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

115c115
<         it will accept any format known to <emphasis>git diff</emphasis> (e.g., git stash show
---
>         it will accept any format known to <emphasis>git diff</emphasis> (e.g., <literal>git stash show


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
