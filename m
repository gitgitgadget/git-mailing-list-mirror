From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 1/2] git-gui: handle non-standard worktree locations
Date: Fri, 20 Feb 2009 01:21:16 +0100
Message-ID: <cb7bb73a0902191621x4e7a66bcj427095906e5a4078@mail.gmail.com>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <alpine.DEB.1.00.0902190307390.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJAG-0005Ns-0c
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbZBTAVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbZBTAVT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:21:19 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:52098 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbZBTAVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:21:18 -0500
Received: by ewy14 with SMTP id 14so638113ewy.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iLOxfRK4h/v25sDxyxstL1Dr9TAE9p6cIJ1xdfiBWjQ=;
        b=PiOFMx1qIFThHotyI7E/WdVIoNVx9gmgOtrWMQXm4FnuwCRUC6StAW1Wjj/cMdYpcq
         Zbm6WTVTYARxIkWHrJ3T5w6fyr9JdgXJPjMJ6pS/zqEGzqTFP8h3okABIS7Z7JRf/JrY
         F1Bfx40bI+evwPJkA323/r1kbUqfQh8vJG0gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mgAmh/w+Xz8zXiHgpP5yvGrGKEoXG0E2swRQKa2YzWqX6cE8A5DbL5yvnSx4MLk+In
         5JprnAhMmXNVKfgpnUWKeljNsi7ns04wyvUA5B5COZ+HI25KSMQ7Nxx+VX0xCG8OdaYS
         /RVt49ItAmker83Z24dZa6IwBTpV8CZznmvIo=
Received: by 10.210.104.20 with SMTP id b20mr128455ebc.85.1235089276080; Thu, 
	19 Feb 2009 16:21:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902190307390.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110770>

On Thu, Feb 19, 2009 at 3:22 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> whenever I read "worktree" I get cautious.
>
> _Very_ cautious.
>
>
> I mean, _VERY_ cautious.  And for a reason.
>
> The whole idea of a worktree was bolted onto Git, so much so that almost
> invariably, every attempt at making it work properly, fails.
>
> Honestly, I think it caused us more pain than any other part of Git,
> _including_ the nasty bugs in git_config_set().

I will refer to this
http://kerneltrap.org/mailarchive/git/2008/8/26/3077314 post from
gitster, in particular, the last paragraph that reads:

"""
I would strongly advocate for keeping the possibility of separating
git-dir and work-tree, and possibly dropping the assumption that
everything "foo.git" is a bare repo. There are config variables for
this. The Tcl/Tk family I mentioned makes even stronger assumptions. I
promise to have a look at these when I find time (oh yeah...).
"""

As it happens, gitk already works pretty fine with 'detatched' git
trees, and git gui is the only tool that can't cope with them
properly.

Also, as it happens, its inability with working with detatched git
trees or other unusual setups is the ONLY thing preventing git gui
from being usable in Zit, the git-based single-file content tracker
I'm working on ( http://git.oblomov.eu/zit )

Since there is NO practical reason NOT to support these unusual
configurations, and since the changes do NOT break standard usage,
your personal dislike for abnormal worktree configurations is scarcely
a meaning obstacle to patch inclusion.

(And please excuse the attitude, but yours is absolutely the worst
I've ever seen on this mailing list, and yes it has been abundantly
discussed.(

> On Thu, 19 Feb 2009, Giuseppe Bilotta wrote:
>
>> Don't
>
> Personally, I prefer a less colloquial (and while at it, a more concise)
> commit message.

Whatever.

>> +# _gitdir exists, so try loading the config
>> +load_config 0
>> +apply_config
>> +# try to set work tree from environment, falling back to core.worktree
>> +if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>> +     set _gitworktree [get_config core.worktree]
>> +}
>>  if {$_prefix ne {}} {
>> -     regsub -all {[^/]+/} $_prefix ../ cdup
>> +     if {$_gitworktree eq {}} {
>> +             regsub -all {[^/]+/} $_prefix ../ cdup
>> +     } else {
>> +             set cdup $_gitworktree
>> +     }
>
> It appears as if you redo a the logic laid out in setup.c.  Don't.
> Instead, teach rev-parse to output the path of the work tree.
>
> Oh, wait, --show-cdup already shows that...

As spearce itself remarked while reviewing the first round of this
patchset, git-gui is currently backwards compatible as far as git
1.5.0. Introducing new features in future versions of git rev-parse is
not going to help here anyway. (Also, I have no idea if this
--show-cdup worked in 1.5.0 or not, I just took the existing code and
adapted it to the possibility of gitworktree being already defined.)


>> @@ -1076,11 +1089,15 @@ if {$_prefix ne {}} {
>>               error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
>>               exit 1
>>       }
>> -     if {[catch {cd [file dirname $_gitdir]} err]} {
>> +     if {$_gitworktree eq {}} {
>> +             set _gitworktree [file dirname $_gitdir]
>> +     }
>
> This is certainly wrong in bare repositories.

It's also totally irrelevant and not less wrong than what the previous
code did, since it used [file dirname $_gitdir] all across the code to
do what I do with $_gitworktree now.

So the current code is correct in all the ways the old code was, plus
in quite a few more ways where the previous code was wrong. And
although there might be a couple of cases that the new approach
doesn't fix, I'd rather prefer you pointed out which cases they where,
how could they fail, and what possible ways you can suggest to work
around them.

>> +     if {[catch {cd $_gitworktree} err]} {
>>               catch {wm withdraw .}
>> -             error_popup [strcat [mc "No working directory"] " [file dirname $_gitdir]:\n\n$err"]
>> +             error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
>>               exit 1
>>       }
>> +     set _gitworktree [pwd]
>
> And why do you have to cd to the worktree?

Because that's what the previous code did, and the intention of this
patch is not to alter the logic of the code unless it's strictly
necessary.

> You might not be able to come back to the GIT_DIR, after all.

How so?

>> @@ -1895,8 +1913,10 @@ proc do_gitk {revs} {
>>               }
>>
>>               set pwd [pwd]
>> -             cd [file dirname [gitdir]]
>> -             set env(GIT_DIR) [file tail [gitdir]]
>> +             if { $_gitworktree ne {} } {
>> +                     cd $_gitworktree
>> +             }
>> +             set env(GIT_DIR) [file normalize [gitdir]]
>>
>>               eval exec $cmd $revs &
>>
>
> Just out of curiosity: what was your method of making sure that you catch
> all sites where the worktree is assumed to be $GIT_DIR/..?

I looked at the code, and tested as many features that interacted with
the worktree as I could think of.

> Besides, have you read about the fallout of making "git rev-parse
> --git-dir" showing absolute paths always?
>
> If yes, why do you ignore it in your patch?

Because I fail to see how this is even remotely relevant.

-- 
Giuseppe "Oblomov" Bilotta
