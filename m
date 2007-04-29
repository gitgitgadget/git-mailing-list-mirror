From: Jakub Narebski <jnareb@gmail.com>
Subject: "Producting Open Source Software" book and distributed SCMs
Date: Mon, 30 Apr 2007 01:20:42 +0200
Message-ID: <200704300120.42576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 01:26:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiImg-00057e-LT
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 01:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161552AbXD2X0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161556AbXD2X0T
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 19:26:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161552AbXD2X0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 19:26:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1186458uga
        for <git@vger.kernel.org>; Sun, 29 Apr 2007 16:26:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=c1ORPpbX3e6j9cDZ/gVAnE+UEV2Y3d1ScKHYj2YWNwz0H+ZyONPwBnLSFWMGr4rNu1jdOYHY+Z+mNovMvnpsvsIGwgjMgWIJn57nDbuB8/cNdV8UdrJ6AGM48mj045gGANcSoDBvgtnsbuNzf90OCrKQWi5rGs+Zq0q9EEahtSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=nr0m0C0QM68tkBbHkBJxp4XTPnM6eNteYkmnZc6n7ghGwioDnrTwhgY5WD/lLTpUNAwXJIWxr9kBXjpiSH8Vb61/uto2i6UaFPt/pR7fIpU8DTQHxFZuYuBlh0rmxy0V8zrtGPabiU0CwqeRILLxtfbIWEjneI7+Kqj8Nv7m/x8=
Received: by 10.67.23.5 with SMTP id a5mr4934144ugj.1177889176943;
        Sun, 29 Apr 2007 16:26:16 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e1sm5640636ugf.2007.04.29.16.26.12;
        Sun, 29 Apr 2007 16:26:15 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45849>

I have read lately classic book "Producing Open Source Software. How to 
Run a Successful Free Software Project" by Karl Fogel (2005).

Among others, author advocates using version control system as a basis 
for running a project. In "Choosing a Version Contol System" he writes:

  As of this writing, the version control system of choice in the free
  software world is the Concurrent Versions System or CVS.

Further on much of examples of managing project and managing volunteers 
revolves around the idea of "commit access", and it is assumed 
implicitely that version control system is centralized. It is 
understandable, as in 2005 there were (according to Linus) no good 
distributed version control systems (SCMs). Also Karl Fogel writes in 
preface that much of material came from the five years of working with 
the Subversion project, and Subversion is centralized SCM meant as 
"better CVS" and used itself as revision control system; any experience 
described had to be with centralized SCM.

The distributed SCM is mentioned in footnote in section "Comitters" in 
Chapter 8, Managing Volunteers:

 http://producingoss.com/producingoss.html#ftn.id284130

  [22] Note that the commit access means something a bit different in
  decentralized version control systems, where anyone can set up a
  repository that is linked into the project, and give themselves commit
  access to that repository. Nevertheless, the concept of commit access
  still applies: "commit access" is shorthand for "the right to make
  changes to the code that will ship in the group's next release of the
  software." In centralized version control systems, this means having
  direct commit access; in decentralized ones, it means having one's
  changes pulled into the main distribution by default. It is the same
  idea either way; the mechanics by which it is realized are not
  terribly important.


I'm interested in your experience with managing projects using 
distributed SCM, or even better first centralized then distributed SCM: 
is the above difference the only one? Linus has said that fully 
distributed SCM improves forkability: 

 "Re: If merging that is really fast forwarding creates new commit"
 Message-ID: <Pine.LNX.4.64.0611070841580.3667@g5.osdl.org>
 http://permalink.gmane.org/gmane.comp.version-control.git/31078

  Time for some purely philosophical arguments on why it's wrong to have 
  "special people" encoded in the tools:

  I think that "forking" is what keeps people honest. The _biggest_
  downside with CVS is actually that a central repository gets so much
  _political_ clout, that it's effectively impossible to fork the
  project: the maintainers of a central repo have huge powers over
  everybody else, and it's practically impossible for anybody else to
  say "you're wrong, and I'll show how wrong you are by competing fairly
  and being better".

According to "Producting Open Source Software" it is very important 
feature for an OSS project. See section "Forkability" of Chapter 4, 
Social and Political Infrastructure (beginning of chapter):

 http://producingoss.com/producingoss.html#forkability

  The indispensable ingredient that binds developers together on a free
  software project, and makes them willing to compromise when necessary,
  is the code's _forkability_: the ability of anyone to take a copy of
  the source code and use it to start a competing project, known as
  a fork.  The paradoxical thing is that the _possibility_ of forks is
  usually a much greater force in free software projects than actual
  forks, which are very rare.  Because a fork is bad for everyone (for
  reasons examined in detail in the section called "Forks" in Chapter 8,
  Managing Volunteers, http://producingoss.com/producingoss.html#forks),
  the more serious the threat of a fork becomes, the more willing people
  are to compromise to avoid it.


Besides that, what are the differences between managing project using 
centralized SCM and one using distributed SCM? What is equivalent of 
committers, giving full and partial commit access, revoking commit 
access? How good support for tagging and branching influences creating 
code and build procedure? Is distributed SCM better geared towards 
"benovolent dictator" model than "consensus-based democracy" model, as 
described in OSSbook?

Thanks in advance for all responses
-- 
Jakub Narebski
ShadeHawk on #git
Poland
