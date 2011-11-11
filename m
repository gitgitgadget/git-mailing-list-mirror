From: Jvsrvcs <jvsrvcs@gmail.com>
Subject: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 12:55:04 -0800 (PST)
Message-ID: <1321044904175-6986736.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 21:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROy81-0007kG-4X
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 21:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891Ab1KKUzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 15:55:06 -0500
Received: from sam.nabble.com ([216.139.236.26]:47782 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab1KKUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 15:55:04 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <jvsrvcs@gmail.com>)
	id 1ROy7s-0007C1-69
	for git@vger.kernel.org; Fri, 11 Nov 2011 12:55:04 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185284>

Unexpected git behaviour

---
# First create a local git repo

$mkdir gitexample
$git config --global user.name "my name"
$git config --global user.email "me@me.com"
$git init
$git add .
$git commit -m 'initial commit'

# Create/Edit an empty file
$vi readme.txt

# add a single line: "this was added in the master branch."
$git commit -a

# create and checkout a new branch (from master)
$git branch test
$git checkout test

# edit the readme.txt file and do not commit
# add the text:  "this was added in the test branch.", save and exit
$vi readme.txt

#now switch back to master
$git checkout master
$cat readme.txt

#You will see both lines in the master.  

Question #1:
	Why was this line added in the *master branch?


--- even further surprising
In the master branch, now do a commit
$git commit -a

cat readme.txt ( you will see the line in the master now that was added in
the test branch )

Question #2:
	Why did this happen?

# Now switch back to the test branch
$git checkout test
$cat readme.txt

You will only see the one line: "This was added in the master branch"

Question #3:
	Why did this happen?

and NOT the line added in that branch: "this was added in the test branch"
<= this line is gone

What is the reason for this?

1) Why do I see uncommitted changes in the branches made off master in the
master branch?
2) Why, if I commit them in the master, do the disappear in the branch in
which they were made?

This is confusing, I would think the * master branch would be left
untouched.  This would solve issue #2.


--
View this message in context: http://git.661346.n2.nabble.com/Git-Unexpected-behaviour-tp6986736p6986736.html
Sent from the git mailing list archive at Nabble.com.
