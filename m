From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 10:22:27 -0700
Message-ID: <7vejz0wk6k.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu May 11 19:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeEry-0005jr-DE
	for gcvg-git@gmane.org; Thu, 11 May 2006 19:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWEKRWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 13:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWEKRWb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 13:22:31 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2954 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030385AbWEKRWa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 May 2006 13:22:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060511172229.VMUY15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 May 2006 13:22:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 9 May 2006 12:24:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19906>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 9 May 2006, Junio C Hamano wrote:
>> 
>> If we are shooting for "let's not do this again", I do not think
>> (4) without some quoting convention is good enough.  Today, we
>> are talking about branch names so we could give them artificial
>> limits, which could be weaker than what we already have on the
>> branch names, but we would later regret that, when we start
>> wanting to have other names in the configuration (e.g. people's
>> names).
>
> Here's my suggestion as a patch.
>
> NOTE! This patch could be applied right now, and to all the branches (to
> make 1.x, 1.2.x and 1.3.x all support the _syntax_). Even if nothing 
> actually uses it.

Linus,

I've adjusted this patch, your follow-up patch, and Sean's
"extended section part is case sensitive" patch, along with the
test tweak to "maint" branch.  I also prepared them to be
mergeable to the "master" branch.  Tentatively it is in "next"
for testing.

I'm ready to push out "maint" (not tagged as 1.3.3 yet) and
"next", but have not done so.

I understand the plan is to have 1.3.3 out from this "maint",
and also merge this in "master" about the same time, but I am
expecting I will be offline for the rest of the week most of the
time, so it would happen over the weekend at the earliest.

Does that sound good to you?

I do not think we would need v1.1.7 nor v1.2.7 for this.  People
who have stayed at v1.1.6 or v1.2.6 would need to update if they
are going to use newer git in their repo anyway, and I do not
think of a reason not to update to 1.3.3 but update to 1.1.7 or
1.2.7 in order to stay at the feature level of 1.1.X or 1.2.X
series.  We haven't made incompatible changes as far as I
remember.

Here is what the (adjusted) test case in "next" looks like.
Corresponding one in "maint" lack --list so does not have the
last hunk.  The "maint" and "next" branches I have locally both
passes the test.

-- >8 --

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7090ea9..8260d57 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -229,7 +229,7 @@ test_expect_failure 'invalid key' 'git-r
 test_expect_success 'correct key' 'git-repo-config 123456.a123 987'
 
 test_expect_success 'hierarchical section' \
-	'git-repo-config 1.2.3.alpha beta'
+	'git-repo-config Version.1.2.3eX.Alpha beta'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -241,8 +241,8 @@ # empty line
 	NoNewLine = wow2 for me
 [123456]
 	a123 = 987
-[1.2.3]
-	alpha = beta
+[Version "1.2.3eX"]
+	Alpha = beta
 EOF
 
 test_expect_success 'hierarchical section value' 'cmp .git/config expect'
@@ -251,7 +251,7 @@ cat > expect << EOF
 beta.noindent=sillyValue
 nextsection.nonewline=wow2 for me
 123456.a123=987
-1.2.3.alpha=beta
+version.1.2.3eX.alpha=beta
 EOF
 
 test_expect_success 'working --list' \
