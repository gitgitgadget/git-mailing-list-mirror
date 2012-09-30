From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-filter-branch.xml:463:
 parser error
Date: Sun, 30 Sep 2012 03:39:21 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930033921.ea2625dc.hesco@campaignfoundations.com>
Reply-To: Hugh Esco <hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:40:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIE8X-0004DU-QI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2I3HkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:40:12 -0400
Received: from mail.greens.org ([207.111.216.211]:43112 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab2I3HkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:40:11 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id 377A0805CC; Sun, 30 Sep 2012 00:40:11 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id C4E9988AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 03:39:21 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740339217164
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206675>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO git-filter-branch.1
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : Unescaped '<' not allowed in attributes values
Clone it with <literal>git clone <ulink url="file:///path/to/repo</literal">file
                                                                 ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : attributes construct error
Clone it with <literal>git clone <ulink url="file:///path/to/repo</literal">file
                                                                 ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : Couldn't find end of Start Tag ulink line 463
Clone it with <literal>git clone <ulink url="file:///path/to/repo</literal">file
                                                                 ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : expected '>'
Clone it with <literal>git clone <ulink url="file:///path/to/repo</literal">file
                                                                          ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : expected '>'
t clone <ulink url="file:///path/to/repo</literal">file:///path/to/repo</literal
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : Opening and ending tag mismatch: simpara line 462 and literal
t clone <ulink url="file:///path/to/repo</literal">file:///path/to/repo</literal
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:463: parser error : Opening and ending tag mismatch: listitem line 461 and ulink
<ulink url="file:///path/to/repo</literal">file:///path/to/repo</literal</ulink>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:468: parser error : Opening and ending tag mismatch: itemizedlist line 460 and simpara
</simpara>
          ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:469: parser error : Opening and ending tag mismatch: refsect1 line 433 and listitem
</listitem>
           ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:470: parser error : Opening and ending tag mismatch: refentry line 3 and itemizedlist
</itemizedlist>
               ^
/usr/local/git-git-51993a4/Documentation/git-filter-branch.xml:471: parser error : Extra content at the end of the document
<simpara>If you really don't want to clone it, for whatever reasons, check the
^
make[1]: *** [git-filter-branch.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

463c463
> Clone it with <literal>git clone <ulink url="file:///path/to/repo">file:///path/to/repo</ulink></literal>.  The clone
---
< Clone it with <literal>git clone <ulink url="file:///path/to/repo</literal">file:///path/to/repo</literal</ulink>>.  The clone

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
