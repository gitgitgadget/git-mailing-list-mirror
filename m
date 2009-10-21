From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [Foundation-l] Wikipedia meets git
Date: Wed, 21 Oct 2009 16:31:20 -0400
Message-ID: <32541b130910211331n4f65c2d4ga76ac90816fe45d@mail.gmail.com>
References: <ee9cc730910151155w307a87f0w7bba5c4039bb1ef9@mail.gmail.com> 
	<71cd4dd90910170705o7c61e06fuacba41f447571b45@mail.gmail.com> 
	<deea21830910170804s61786d8ewae0bc9390baaed71@mail.gmail.com> 
	<71cd4dd90910170823o3f58b8c2x1d39040e7582634@mail.gmail.com> 
	<ee9cc730910170939m6e83ad2fy5f22a541c3679638@mail.gmail.com> 
	<deea21830910170953o33823dd3rd7a9305f9ea794d@mail.gmail.com> 
	<ee9cc730910171011l1b68a1a0q7096a93c36362959@mail.gmail.com> 
	<e405c96a0910190830y51009225lc72942a703575042@mail.gmail.com> 
	<5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com> 
	<1256154567.1477.87.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Klein <meta.sj@gmail.com>,
	Wikimedia Foundation Mailing List 
	<foundation-l@lists.wikimedia.org>, git <git@vger.kernel.org>
To: Bernie Innocenti <bernie@codewiz.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:31:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hqU-0002fz-AX
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbZJUUbg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbZJUUbg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:31:36 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39922 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbZJUUbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 16:31:35 -0400
Received: by yxe17 with SMTP id 17so6409590yxe.33
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kpgiyBUbkF1D7H1soUGOu7ZTa9IqzFhQcF+jJYBAUNo=;
        b=Qz2BwnmjXnqe3QU9tTnwD/cOg7T1+Ays30yIdqpT/VtGVBXVF6APOg5s7aWyNnXzsD
         +8Qz9/6nfMxcbPHvz6g6iYQL4LBKxLaHhBQQIENbd9atk2OzQI7RelAk7c+M44uiGOVy
         dQthLOEfGI7OqE/VoR0/exvtFs0IIoft/EJic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nk2t8zv5FzYM8Wgf8RxXC121WDgJzw96ew06xl7XPqf8zViKclj/DDD7P6u2gLuBow
         xRRnCJnxIiQC00D54AcpqVm6NGv/HWHGffTUWwjwv7N/Ky42W0x5pd5tDqQKxP7yUTyw
         MrHsi24T1TzQ68C2pJoh5tU5PoE6KvHTT2isQ=
Received: by 10.150.114.1 with SMTP id m1mr13874992ybc.182.1256157100139; Wed, 
	21 Oct 2009 13:31:40 -0700 (PDT)
In-Reply-To: <1256154567.1477.87.camel@giskard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130960>

On Wed, Oct 21, 2009 at 3:49 PM, Bernie Innocenti <bernie@codewiz.org> =
wrote:
> And here's the the catch: the history of individual files is not
> directly represented in a git repository. It is typically scattered
> across thousands of commit objects, with no direct links to help find
> them. If you want to retrieve the log of a file that was changed only=
 6
> times in the entire history of the Linux kernel, you'd have to dig
> through *all* of the 170K revisions in the "master" branch.
>
> And it takes some time even if git is blazingly fast:
>
> =A0bernie@giskard:~/src/kernel/linux-2.6$ time git log =A0--pretty=3D=
oneline REPORTING-BUGS =A0| wc -l
> =A06
>
> =A0real =A0 0m1.668s
> =A0user =A0 0m1.416s
> =A0sys =A0 =A00m0.210s
>
> (my laptop has a low-power CPU. A fast server would be 8-10x faster).
>
>
> Now, the English Wikipedia seems to have slightly more than 3M articl=
es,
> with--how many? tenths of millions of revisions for sure. Going throu=
gh
> them *every time* one needs to consult the history of a file would be
> 100x slower. Tens of seconds. Not acceptable, uh?

I think this slowness could be overcome using a simple cache of
filename -> commitid list, right?

That is, you run some variant of "git log --name-only" and, for each
file changed by each commit, add an element to the commit list for
that file.  When committing in the future, use a hook that updates the
cache.  When you want to view the history of a particular file, simply
retrieve exactly the list of commits in that file's commitlist, not
other commits.

It sounds like such a cache could be implemented quite easily outside
of git itself.

Would that help?

That said, I'll bet you find other performance glitches when you
import millions of files and tens/hundreds of millions of commits.
But we probably won't know what those problems are until someone
imports them :)

Have fun,

Avery
