From: Duane Murphy <duanemurphy@mac.com>
Subject: Re: git p4 diff-tree ambiguous argument error
Date: Sat, 12 Jul 2014 12:19:17 -0700
Message-ID: <C7987A96-1BC3-4551-BC35-2040A96D20A5@mac.com>
References: <1405013428825-7614774.post@n2.nabble.com>
 <53BED67D.8080006@diamand.org> <4EECAC73-DACA-4C0F-AE97-944F0DEE490B@mac.com>
 <BEE93DDF-7F3E-423D-AA3F-0D72E8FD08B3@mac.com>
 <20140712181034.GB26857@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 21:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X62pi-0002Cw-7g
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 21:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbaGLTTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 15:19:37 -0400
Received: from st11p02mm-asmtp002.mac.com ([17.172.220.237]:58481 "EHLO
	st11p02mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613AbaGLTTg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2014 15:19:36 -0400
Received: from [192.168.1.26]
 (70-36-184-217.dsl.static.sonic.net [70.36.184.217])
 by st11p02mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.10(7.0.4.27.9) 64bit (built Jun
  6 2014)) with ESMTPSA id <0N8M005LE5MU6910@st11p02mm-asmtp002.mac.com> for
 git@vger.kernel.org; Sat, 12 Jul 2014 19:19:19 +0000 (GMT)
In-reply-to: <20140712181034.GB26857@padd.com>
X-Mailer: Apple Mail (2.1878.6)
X-MANTSH: 1TEIXWV4bG1oaGkdHB0lGUkdDRl5PWBoaHREKTEMXGx0EGx0YBBIZBBsTEBseGh8
	aEQpYTRdLEQptfhcaEQpMWRcbGhsbEQpZSRcRClleF2hjeREKQ04XSxseGmJCH2lhGEd+GXhzB
	xxpGxMbE2ARCkVDFxZpHRMSHWsTHAcbaGkZBx4fHxsHaGkZHwcYGh4aaxMcbhgaax9qR0tJBEl
	FRxQRClhcFxkEGgQbHgdNThwTGhodEwUbHQQbHRgEEhkEGxMQGx4aHxsRCl5ZF2ETUx15EQpMR
	hdia2sRCkNaFx0aBBkcBBsSHgQYGx0RCkRYFxgRCkRJFxsRCkJFF2FaQn1yW0NHZRhFEQpCThd
	oRkJAH0h5HUcfZBEKQkwXYUF4YXtISVMZWHkRCkJsF3p/TmMBSHhFUl9DEQpCQBdmbW9NXktOY
	XpaZBEKcGgXbVMZUGdgQR9zfxsRCnBoF2IeaUVJQ1IcHF57EQpwaBd6H2JITHoSYRJzZhEKcGg
	XbXJvR0Bdf2xBAV4RCnBoF2lbQUgZRlliTBxCEQpwbBdiUB9bW0thXX9lcBEKcEwXYgUdG0gdQ
	kNPbwER
X-CLX-Spam: false
X-CLX-Score: 1011
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.12.52,1.0.14,0.0.0000
 definitions=2014-07-12_02:2014-07-11,2014-07-12,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=3 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1407120262
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253399>

On Jul 12, 2014, at 11:10 AM, Pete Wyckoff <pw@padd.com> wrote:

>> Some additional investigation. 
>> 
>> I am working in a copy of a repository that was originally used to pull the data 
>> from Perforce. As part of my experiments to figure out this problem, I deleted 
>> the contents of .git/git-p4-tmp/. 
>> 
>> I noticed that git-p4 would continue if those files were present. I have now 
>> copied the files that were in .git/git-p4-tmp/ from the other repository. 
>> 
>> git-p4 is not crashing now, but I also noticed that none of the dates on these files
>> have changed. These files should have been touched each time that a branch is taken,
>> but these files have not changed while the sync is running.
>> 
>> That seems significant. 
>> 
>> I expect git-p4 to crash again on a new commit that is not in .git/git-p4-tmp/. 
>> Then I have to start the 8-12 hour process over again (did I mention 70k commits?).
> 
> Bizarre.  That directory is really supposed to be temporary, and
> live only during a single git p4 invocation.  It's just a bunch
> of branch heads for the temporary commits.  I don't know why
> those branches, and the git-p4-tmp directory, hang around after
> you run git p4.  Might be worth your investigation.

The reason the files are still there is because git-p4 crashes (exits with an error) and doesn't clean them up.

When git-p4 exits cleanly, the directory is fine. My experience is that git-p4 exists abnormally often enough. 

> The second weirdness is why a new run doesn't create the branch.
> This maybe points to self.checkpoint() not really checkpointing.
> It does send a "checkpoint" down the git fast-import stream,
> which is supposed to make it write the branches out.  You might
> consider grabbing the fast-import process in a debugger and see
> why it's not writing out the branch head.

I started looking at the code for fast-import. There's a lot of code there, so didn't go down that path.

I've posted another message indicating that I sincerely believe the problem is in git-fast-import. My current working theory is that 
because the file matches another commit (that's the point of writing the commit) git-fast-import doesn't flush the file. I've clearly 
stopped git-p4 immediately after the checkpoint and there is no file. When the program exits (abnormally of course), the file appears
(thanks to the file system). Seems like a flush problem somewhere.

I was hoping someone who knows git-fast-import would have a clue as to the problem.

> There's lots of changes since v1.7.12.4, but nothing obvious I
> can see that would cause this.  Sorry,

Thanks for taking a look.
