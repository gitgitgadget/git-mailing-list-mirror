From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 23:20:33 +0100
Message-ID: <733410BB-7075-4799-B129-EAD5E64652B3@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com> <E042F4D9-79DF-4AEF-8EDE-41BA9E5FB9EC@quendi.de> <CADgNjanBm5bj7_jY5WrUXUENr7r6zMxve822OYKcyBpWGZv-SA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 23:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFB5m-0008V7-2N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3CKWUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 18:20:47 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:43815 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752994Ab3CKWUr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 18:20:47 -0400
Received: from mailgw52.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 23:20:41 +0100
Received: from merkur.hrz.uni-giessen.de (merkur.hrz.uni-giessen.de [134.176.2.12])
	by mailgw52.hrz.uni-giessen.de (Postfix) with ESMTP id EA8EB1A00009A;
	Mon, 11 Mar 2013 23:20:34 +0100 (CET)
Received: from [134.176.2.12] by merkur.hrz.uni-giessen.de with ESMTP; Mon, 11 Mar 2013 23:20:34 +0100
In-Reply-To: <CADgNjanBm5bj7_jY5WrUXUENr7r6zMxve822OYKcyBpWGZv-SA@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217920>


On 11.03.2013, at 22:34, Andrew Wong wrote:

> On 3/11/13, Max Horn <max@quendi.de> wrote:
>> So I tried this:
>> 
>>  git rebase branches/stable-4.6  # ... which leads to the error
>>  git ls-files -m
>> 
>> but got nothing. Perhaps you had something else in mind, though, but I am
>> not quite sure what... sorry for being dense, but if you let me know what
>> exactly you meant, I'll be happy to try that. As for the stat command:
> 
> I'm still digesting the information form the email. Just want to
> quickly mention that the "ls-files" command should be:
>    $ git ls-files --debug file1 file2
> 
> You should always get output. It prints out stat-like information for
> files in the index.

Aha, I see. I inserted that into git-am, once right before git-merge-recursive and once right after it (just before a call to rerere).


This is what I got;


Applying: COMMIT X
error: BAD-FILE: does not match index
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
GOOD-FILE
  ctime: 1362921639:0
  mtime: 1362921639:0
  dev: 234881028	ino: 18665879
  uid: 502	gid: 20
  size: 25429	flags: 0
BAD-FILE
  ctime: 1363040264:0
  mtime: 1363040264:0
  dev: 234881028	ino: 19170773
  uid: 502	gid: 20
  size: 52906	flags: 0
error: Your local changes to the following files would be overwritten by merge:
	BAD-FILE
Please, commit your changes or stash them before you can merge.
Aborting
GOOD-FILE
  ctime: 1362921639:0
  mtime: 1362921639:0
  dev: 234881028	ino: 18665879
  uid: 502	gid: 20
  size: 25429	flags: 0
BAD-FILE
  ctime: 1363040264:0
  mtime: 1363040264:0
  dev: 234881028	ino: 19170773
  uid: 502	gid: 20
  size: 52906	flags: 0
Failed to merge in the changes.
Patch failed at 0015 COMMIT X
...

So the ctime/mtine for the BAD-FILE do not differ.
After this, I also run "ls-files" on the command line, and got:

GOOD-FILE gd
  ctime: 1362921639:0
  mtime: 1362921639:0
  dev: 234881028	ino: 18665879
  uid: 502	gid: 20
  size: 25429	flags: 0
BAD-FILE
  ctime: 1363040266:0
  mtime: 1363040264:0
  dev: 234881028	ino: 19170773
  uid: 502	gid: 20
  size: 52906	flags: 0

So now the ctime of the bad file is more recent than the mtime.


Max