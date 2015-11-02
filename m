From: Kaz Kylheku <kaz@kylheku.com>
Subject: Re: [Savannah-users] Anonymous commit (empty Author and Committer)
Date: Mon, 02 Nov 2015 08:37:00 -0800
Message-ID: <4da05191ce7780bed3a0e00f25b09bc9@mail.kylheku.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
 <5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
 <20151030205955.GC21923@csclub.uwaterloo.ca> <56345076.30207@gmail.com>
 <20151102151123.GF21923@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
Cc: The development of GNU GRUB <grub-devel@gnu.org>,
	savannah-users@gnu.org, git@vger.kernel.org,
	savannah-users-bounces+kaz=kylheku.com@gnu.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtI6a-00050J-1F
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 17:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbbKBQhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 11:37:07 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:42282 "EHLO
	smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbbKBQhG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 11:37:06 -0500
Received: from kylheku.com ([24.85.175.81])
	by shaw.ca with SMTP
	id tI6QZvEmMT2votI6RZIj0T; Mon, 02 Nov 2015 09:37:04 -0700
X-Authority-Analysis: v=2.1 cv=NrEbCZpJ c=1 sm=1 tr=0
 a=WiYoHcCliNeVponEdG0Ckg==:117 a=WiYoHcCliNeVponEdG0Ckg==:17 a=2KUf1mbJAAAA:8
 a=IkcTkHD0fZMA:10 a=SMorJkV_YP8A:10 a=qtqOOiqGOCEA:10
 a=tDTS4VjBM6bxtzLHNtIA:9 a=QEXdDO2ut3YA:10
Received: from www-data by kylheku.com with local (Exim 4.72)
	(envelope-from <kaz@kylheku.com>)
	id 1ZtI6O-0002Xh-MI; Mon, 02 Nov 2015 08:37:00 -0800
X-PHP-Originating-Script: 501:rcmail.php
In-Reply-To: <20151102151123.GF21923@csclub.uwaterloo.ca>
X-Sender: kaz@kylheku.com
User-Agent: Roundcube Webmail/0.9.2
X-CMAE-Envelope: MS4wfIJh/ypHEJkHXIHrua+KJ/BafI7Z0OEEedCb+fdSuID15T7E1L3XnkDtecDyZSB1l3ZN6CpAdMcMJVwr1UeBxHupt4vxmwt1Yaj5+WApskjFViVhCUYa1DIKLgZduTzdsVbbKa5X9EslzxWWy0zDUxMzxAUIhSJIrxCo62pWlLd3/DYC49Zgl/gxBH57uBs38fAtuhmLbpwsAcP7tGACcgrserESwNVQHtxK58EqJ4U3VIWTmQL3ETIVTMBNsrPhhEgolKygCf3VfPLhK6CwRCSpNFLv7QLubE+uzRmGgxXiPRrZ0Fk2QjigMfebrG4hUgHFVT1E7tPgu1fwdJzBMOI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280697>

On 02.11.2015 07:11, Lennart Sorensen wrote:
> On Sat, Oct 31, 2015 at 08:24:06AM +0300, Andrei Borzenkov wrote:
>> If we decide to fix this commit it is better done now, while it is the 
>> last
>> one. It is annoying but do you have suggestion how it can be done
>> differently?
> 
> Well the only options are:
> 
> 1) Leave it alone
> 2) Break the tree of anyone that already pulled.  (Posting instructions 
> on
> how to fix it would at least be nice then).
> 
> Not sure how many people regularly pull the tree.

This is silly FUD. There is no ever any "broken tree".

Firstly, people who have no local changes do not experience any ill 
effect.
They just have to do

   $ git fetch

   # oops, upstream and local branch have diverged
   # but I have absolutely no local work to preserve;
   # just "warp" HEAD to the new one:

   $ git reset --hard origin/master

   # done!

Those who have outstanding local work never have any expectation of 
non-breakage!
*All* fetches are "non-fast-forward" with regard to unpublished
local work, because they occur to a prior version of the work, 
underneath your
changes.

In *all* cases you can do this:

   # Fast-forward or not, I don't care!
   $ git fetch

   # Take my 13 unpublished commits (or whatever number), rebase them 
over the
   # latest upstream master, and make the result my local master branch:

   $ git rebase HEAD~13 --onto origin/master
