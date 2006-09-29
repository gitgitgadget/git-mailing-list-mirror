From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Thu, 28 Sep 2006 23:06:32 -0700
Message-ID: <7vmz8jp5p3.fsf@assigned-by-dhcp.cox.net>
References: <20060928185232.96094.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 08:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBW9-00036G-AE
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWI2GGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWI2GGe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:06:34 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10409 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932069AbWI2GGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 02:06:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929060633.MCED2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 02:06:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U66V1V0081kojtg0000000
	Fri, 29 Sep 2006 02:06:29 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060928185232.96094.qmail@web31802.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 28 Sep 2006 11:52:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28091>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> > > Agreed, we should always refer to the commit-ish, for obvious
>> > > reasons.
>> > >
>> > > This patch doesn't make this decision though.  It simply
>> > > sets hash_base to HEAD if not defined.
>> > >
>> > > Now, since "git-ls-tree" works on both commit-ish and
>> > > tree-ish, we are ok.
>> > 
>> > I think so, too.  Jakub?
>> 
>> Status?  I see Jakub hasn't objected, and it is really important
>> for us to be able to link to "latest" binary blob -- for example
>> a PDF spec file.
>
> Junio,
>
> What are the objections to this patch?

No objections from me --- rather lack of objections from Jakub ;-)

But the fragments do not appear to apply anymore.

@@ -1625,7 +1625,7 @@ sub git_print_tree_entry {
 			              "history");
 		}
 		print " | " .
-			$cgi->a({-href => href(action=>"blob_plain", hash_base=>"HEAD",
+			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
 					       file_name=>"$basedir$t->{'name'}")},
 				"raw");
 		print "</td>\n";

There is no call to create blob_plain link with hash_base
hardcoded to "HEAD" in git-print-tree-entry.

Care to re-spin?
