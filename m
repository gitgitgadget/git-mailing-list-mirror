From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:45:04 +0100
Message-ID: <4538A8B0.3080003@shadowen.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>	<200610201157.22348.jnareb@gmail.com> <vpqwt6v1f11.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 12:46:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GartH-0001GT-TG
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWJTKqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWJTKqM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:46:12 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40708 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1161016AbWJTKqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 06:46:11 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GarsA-0002Xp-VF; Fri, 20 Oct 2006 11:45:07 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
In-Reply-To: <vpqwt6v1f11.fsf@ecrins.imag.fr>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29443>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Huh? If you want what changes have been introduced by commit 
>> c3424aebbf722c1f204931bf1c843e8a103ee143, you just do
>>
>> # git diff c3424aebbf722c1f204931bf1c843e8a103ee143
> 
> How does git chose which ancestor to use if this revision has more
> than one in this case?

Well if there is more than one parent, then there are more than one
diff.  For instance this is a merge commit which I asked to 'see'.

This gets shown in the combined diff format, showing the results of the
conflict resolution.

diff --cc this
index fbbafbf,10c8337..43b7af0
--- a/this
+++ b/this
@@@ -1,3 -1,3 +1,4 @@@
  1
+ 2a
 +2b
  3

If you want to know each individual diff in a more 'standard' form you
can ask about the parents specifically.

apw@pinky$ git diff HEAD^1..
diff --git a/this b/this
index fbbafbf..43b7af0 100644
--- a/this
+++ b/this
@@ -1,3 +1,4 @@
 1
+2a
 2b
 3

apw@pinky$ git diff HEAD^2..
diff --git a/bar b/bar
new file mode 100644
index 0000000..8dc5f23
--- /dev/null
+++ b/bar
@@ -0,0 +1 @@
+this that other
diff --git a/this b/this
index 10c8337..43b7af0 100644
--- a/this
+++ b/this
@@ -1,3 +1,4 @@
 1
 2a
+2b
 3
