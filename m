From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git gc error - cannot lock ref 'RENAMED-REF..1'
Date: Sat, 3 Apr 2010 23:52:35 -0400
Message-ID: <v2i76c5b8581004032052q950584e1y603319ec6f341542@mail.gmail.com>
References: <j2k76c5b8581004011037rb81d80cdu1a4713cde31d4b56@mail.gmail.com>
	 <g2x76c5b8581004011908r35cbaf3au545b7f11bd6db8fc@mail.gmail.com>
	 <u2s76c5b8581004022038rf8aa0017l5dea55689c738fd9@mail.gmail.com>
	 <20100403042211.GA22150@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 05:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyGtI-0001Ru-8y
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 05:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0DDDwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 23:52:37 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:39393 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab0DDDwf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Apr 2010 23:52:35 -0400
Received: by iwn35 with SMTP id 35so634479iwn.21
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=cUdWMbhD6ZgqFPhxbOLpOR79KMPjyZHqROYO32aXSUg=;
        b=XSBVvjSySoR5a9T/y7I3Da9KswavdOqNbwQXZlYdhkx95ySzmwFx9IlY//F9Ctx4d+
         YqlunOF/IDl30cIF/PUKpsAvedeoyVa3oK6Mc0JZ+kmvCF+1F5bD0SYQju+UxJQuvTVm
         6Npxx6JnbFiL/DsrMeunVq1iakpgX5ns5yjM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Wk/gYLhPy0DJV+Ub9P4HWw3yqt0BOm91gvxeon4eVibDOs2MsW2PnVr8tZ92vOOfOI
         vwLnrvQ14VmeTwzjg0HWjazcExnBIZE74YpO9CZiqrkKQdmw1sPGoJk28befYDTevgLD
         /bM0ccknGNxzrVfs4eyiqOGhOFfIAezThFTRE=
Received: by 10.231.155.143 with HTTP; Sat, 3 Apr 2010 20:52:35 -0700 (PDT)
In-Reply-To: <20100403042211.GA22150@coredump.intra.peff.net>
Received: by 10.231.146.66 with SMTP id g2mr1831913ibv.60.1270353155069; Sat, 
	03 Apr 2010 20:52:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143913>

On Sat, Apr 3, 2010 at 12:22 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 02, 2010 at 11:38:03PM -0400, Eugene Sajine wrote:
>
>> On Thu, Apr 1, 2010 at 10:08 PM, Eugene Sajine <euguess@gmail.com> w=
rote:
>> > Hi,
>> >
>> > I was running git gc weekly on my machine and today for some reaso=
n it
>> > failed on one of my repos with an error saying
>> >
>> > Error: cannot lock ref =E2=80=98RENAMED-REF..1=E2=80=99
>> > Error: failed to run ref-log
>> >
>> > The problem is I have no idea what it is talking about=E2=80=A6 =E2=
=80=9Cgit show-ref=E2=80=9D
>> > doesn=E2=80=99t show anything even close to this name. Fools day j=
oke?;)
>> > Any advice?
>
> If you look in the .git directory, is there a file named RENAMED-REF.=
=2E1?
> I have no idea how you would create such a ref, nor why it would fail=
 to
> lock (perhaps because of the funny name?), but removing it should
> probably clear up your problem at least.
>
> The name "RENAMED-REF" is only used by git during ref renames, and th=
ose
> only happen when renaming branches (via "git branch -m") or remotes (=
via
> "git remote rename"). So presumably the source of the problem is rela=
ted
> to one of those operations.
>
> -Peff
>

Thanks Jeff,

i will take a look if i will be able to find this ref. The problem
though is that i don't remeber doing any renaming of branches or
remote in this repo. Probably somebody did and pushed it to the
mainline where i got it from by pull... I'll tyr to check this out.

Thanks,
Eugene
