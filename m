From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 03:28:46 -0700
Message-ID: <cfd18e0f0809170328pb039331m1c4dc42fd398a4d@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
	 <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
	 <20080917011816.GL28210@dpotapov.dyndns.org>
	 <c49095e30809162216m5c7885dbibbb022e65f43231c@mail.gmail.com>
	 <48D0AA1A.5060209@op5.se>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael Kerrisk" <michael.kerrisk@googlemail.com>,
	"Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	michael.kerrisk@gmail.com,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 17 12:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfuIG-0001qM-RA
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYIQK2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYIQK2s
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:28:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:23601 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYIQK2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:28:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3122662rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rvxfsL3BV4fTJBkPlWDI9lS8Nh3PKEKIcE9g7ORxpiQ=;
        b=SN+/GqA9IJ2kXcWESkX/kxn2sJlj8L0tqevVyIyQpGl4rDrtkLrVkRqvoQPxbIwu3v
         Ts1om0F1eb4fnvzZ4xVUwqZUgJ5KXUUi7Sqb51OggsLyU4uMKTpXNZ8zqWN9Yf9hn3ko
         4h6gTXlbZtCe2OOd16kXItNVZYeAgcKsNobd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=qS0MpXq9+j+gGQoT4LuFAx4dHDO9uOjxJfUWATIjG2EhYmSc7RGlIpdKUlBvFsh4uZ
         bopVyDJcLMQuAPhVI4gJJxBzOlVDXId1Iz4Yq8QZLaFcSP5Tn2zv2lOsDfypBdpwXWMK
         WV+4e+AW2d/XkL1wcuRtzMwWv8DvMPsPCosk8=
Received: by 10.141.198.9 with SMTP id a9mr6403689rvq.108.1221647326891;
        Wed, 17 Sep 2008 03:28:46 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Wed, 17 Sep 2008 03:28:46 -0700 (PDT)
In-Reply-To: <48D0AA1A.5060209@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96083>

Hi Andreas,

On Tue, Sep 16, 2008 at 11:56 PM, Andreas Ericsson <ae@op5.se> wrote:
> Michael Kerrisk wrote:
>>
>> Hi Dimitry,
>>
>> On Tue, Sep 16, 2008 at 6:18 PM, Dmitry Potapov <dpotapov@gmail.com>
>> wrote:
>>>
>>> On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
>>>>
>>>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b
>>>> branches
>>>>
>>>> takes about half an hour to run, the other command (which I already
>>>> started yesterday) seems to be taking (far) more than a day!
>>>
>>> What version of Git do you use?
>>
>> 1.5.4.5, on Linux.
>>
>
> An upgrade would do you good.

But, is it going to make this much difference to the run time?  By
now, the import using

$ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
trunk/man-pages -b branches

has been running for over 2 days (and I still don't know if it will
give the layout I want), and seems to be slowing down exponentially as
it gets further along in the import process, so at this rate it looks
like it would take several more days to complete, whereas

$ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches

which doesn't give the layout I want, takes less than an hour.  We're
talking about a factor of at least 100 x in the speed difference for
the two imports.

>>> If you use a version earlier than 1.5.6
>>> than you can notice *considerable* speed up by upgrading to the latest
>>
>> How much is "considerable"?  My import is *still* running.
>>
>
> The greatest factor will usually be network round trip time, so if
> this is a one-shot conversion, rsync the repository to somewhere
> close and run the import over a local network. I've had some "fun"
> trying to import sourceforge svn repositories that were large-ish
> but not huge (same seat you're in, basically), but since I get up
> to 800ms round trip time from sweden, conversion took forever.

Perhaps I should have stated earleir, that the import is from a local
svn repo (note the 'file:///' in the 'git svn init'...).  176 MB, land
less than 5000 commits.

Cheers,

Michael

>>>> Therefore, so far, I have not had a chance to run the command to
>>>> completion to see if it gives the desired result.  The greatly
>>>> increased tun time also made me suspicious about whether the command
>>>> was going to do the right thing.  And, I end up with a lot of strange
>>>> looking tags in the (as yet incompletely) imported tree:
>>>>
>>>> $ git branch -a
>>>>  tags/man-pages-2.00
>>>>  tags/man-pages-2.00@117
>>>>  tags/man-pages-2.01
>>>>  tags/man-pages-2.01@145
>>>>  tags/man-pages-2.02
>>>>  tags/man-pages-2.02@184
>>>>  tags/man-pages-2.03
>>>>  tags/man-pages-2.03@232
>>>>  tags/man-pages-2.04
>>>>  tags/man-pages-2.04@283
>>>>
>>>> What are the @nnn tags about?
>>>
>>> I have never encounted them. Are you sure that you import into a clean
>>> Git repo?
>>
>> Yes.  It's a clean repo in a new directory.
>>
>
> I've seen such tags before. They were added by an automatic build bot
> as a marker to say "hey, I just built this".
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
