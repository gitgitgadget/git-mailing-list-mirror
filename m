From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH] Added giteditor script to show diff while editing commit
 message.
Date: Wed, 21 Jan 2009 20:46:07 -0500
Message-ID: <4977CFDF.4040200@tedpavlic.com>
References: <1232570841-25641-1-git-send-email-ted@tedpavlic.com> <alpine.DEB.1.00.0901212216310.3586@pacific.mpi-cbg.de> <4977A2C9.1070502@tedpavlic.com> <alpine.DEB.1.00.0901212343100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 02:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPofS-0007i1-OV
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 02:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbZAVBqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 20:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbZAVBqN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 20:46:13 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:57931 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754259AbZAVBqM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 20:46:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 79D4B380D4E0;
	Wed, 21 Jan 2009 20:40:14 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NVFtWMnasWw; Wed, 21 Jan 2009 20:40:14 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 119EB380D4B2;
	Wed, 21 Jan 2009 20:40:14 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <alpine.DEB.1.00.0901212343100.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106712>

>> Thanks for your comments. I've responded below. I just want to
>> top-respond to your comment that the fundamental problem is that the
>> diff is in a separate file. In fact, this is the point of the script. I
>> want to be able to scroll through the diff output independent of the
>> commit message.
> Once again, note that e.g. vi will not cope with the way you try to
> achieve that.

It does for me just fine. In vi, I hit ^W^W and move from commit message 
to diff and back. What's the problem with that? In gvim I'm able to 
click back and forth.

I have been using this method for a long time with hg, and now I've been 
using it with git. This isn't theory --- it's been working in practice 
for me. Am I missing something?

> Why not .git/?  That would be the _natural_ place to put it.

Why doesn't stg do that? I figured stg would be a well-established 
program to pattern behavior off of.

I'll rev-parse the git dir and place the file there.

>>> vi users will hate you, as you do not give them a chance to edit the
>>> message after having seen the diff.
>> I don't see what you mean. I am a vi user (exclusively), and this script
>> works very well for me.
> I cannot go back to the commit message when I said ":n" to get to the
> diff.

vi opens for me and I see two windows. The top window shows the commit 
message and the bottom window shows the diff.

I hit ^W^W (or ^W<Down>) and I find myself scrolling around in the diff. 
I hit ^W^W again (or ^W<Up>) and I find myself scrolling around in the 
commit.

Similarly, gvim lets me mouse around both --- clicking from window to 
window.

If you must use ":n", I don't know why you can't use ":prev" to go back. <?>

>> Is there no value in having the diff in a separate file?
> In my case, no, for 2 reasons:
> - I can always open a new shell (in ssh connections, I use screen) to get
>    the diff, and even better: I can restrict it to certain files, and I can
>    use the nice bookmarks "less" provides; dunno if vi would have them.

vi does.

> - My preference is definitely to look at the diff before committing, to be
>    certain that I did not fsck up.  And nothing would annoy me more than to
>    be in the middle of editing a commit message while I am looking at the
>    diff and telling myself "that is a stupid mistake, let's fix it" knowing
>    that the commit will not pick up the fix.

When giving a detailed message bulletting out everything that goes into 
a commit, sometimes it's nice to have a very nearby look at the diff.

>    So seeing the diff while composing the commit message is definitely too
>    late for me.

Nevertheless, the secondary purpose of the contributed script is to show 
how GIT_EDITOR can be used to wrap around other editors. (that's the 
purpose of Mercurial's distributed "hgeditor" script as well)

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
