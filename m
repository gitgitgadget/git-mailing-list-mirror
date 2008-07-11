From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Fri, 11 Jul 2008 23:52:02 +0200
Message-ID: <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQYB-0001Fv-R8
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbYGKVwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbYGKVwO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:52:14 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:33840 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYGKVwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:52:13 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1985027ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ciYqsTJGQDjYMujGxe1RwdurENo7hUHHCcTSQv0MSv0=;
        b=Rv5tvO/s8mnCa8xE0+Uo3d9IEh65GU4aCgRvXi+P/jPOKglGvAPYOxDSjoTe2bMU7+
         eirsqVzHuAfENbWYtA9G3EHQOZro/7YPOqO4qsWR0oFDNd38+aDF4hi0a3uZ1vmmNn/Y
         Y423cQUfh94ocTlrd+pEoinZn3sf79/vNYXb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=X6vDWoWhjaz8h3Ea4FqVAmzuK0ikrLtpPt02Iw/luccOI6OWQH3op97OS4ShDg2FGB
         bIj0d3Zn3UsfHIGTIg8t7iBz9tKCYO3odWpiAVNnEiZ4gSCDDXJHji7eO6LKFEk0PAYs
         YQyOdmyOUvZbihhQOe4nKeiOM1Ey6gDPNh38g=
Received: by 10.150.49.1 with SMTP id w1mr16689691ybw.24.1215813122426;
        Fri, 11 Jul 2008 14:52:02 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 14:52:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807112215050.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88183>

On Fri, Jul 11, 2008 at 11:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 11 Jul 2008, Sverre Rabbelier wrote:
>
>> I temporarily modified the code to output %04d instead of %4d so that I
>> could do the following:
>>
>>        $ stats.py author -a > full_activity_sortable.txt
>
> You might be delighted to read up on the "-n" switch to sort(1).

Heh, yes, very much so :). I probably shouldof known there is such an
option, but having the source at hand the change to '%4d' was the
first thing that came to mind.

>> A few highlights from the sorted file:
>>
>> $ cat full_activity_sortable.txt | sort | tail -n 20
>
> More intuitive would have been "sort -r | head -n 20", I guess.

Since that wouldof put the 'number one' at the top? Yeah, I guess it
wouldof, nice one.

>> 0170:  2721+  1060- = refs.c
>
> I guess that 170 is the total number of commit touching that file, the "+"
> and "-" numbers the changes respectively?

Correct, I probably should have explain that. The +es are how many
lines were added and the -es are the total amount of lines that were
deleted, yup.

> I think quite a lot of our changes do code moves; this should be accounted
> for differently.

Yeah, I wish 'git log -C -C -M --numstat --sacrifice-chicken
--pretty=format:%ae --' would take care of that... That is, a
git-blame like mechanism that would detect such moves on a per-commit
basis and report them would be very useful to me.

>> For some reason you people can't seem to make up your mind about a
>> file that's not even 1500 lines in size ;).
>
> Heh.  We might need to change it once or twice, in the future.

*chuckles*, I'm curious why the Makefile is such a hard file to get right :).

>> A note is in order here, this data was mined with "git log --num-stat"
>> so things like moving files and copying files are not accounted for.
>
> In my opinion it would be even more interesting to see code moves (i.e.
> not whole files).  For example, we moved some stuff from builtins into the
> library.  The real change here is not in the lines added and deleted.

Very much so, but the former I figure can be easily done with 'git log
-C -C -M' I discovered (I need to parse it's output though, and also
determine what to do with moves statistics wise. Should changes made
due to moves just be ignored?)

>> I thought about using git-blame to gather this info before, but it is
>> not the right tool for the job. If anyone else has any idea's on what
>> would be better please let me know and I'll happily dig into it :).
>
> I think that you need to analyze the diff directly.  One possible (quick
> 'n dirty) way would be to cut out long consecutive "+" parts of the hunks,
> replace the "-" by "+", and use "git diff --no-index" to do the hard part
> of searching for that code in the "-" part of the original diff.

That sounds interesting, I won't need to actually do that though, I
already have a diff parser that gives me the lines added VS lines
deleted on a hunk-by-hunk basis. If it is a true move (e.g., code
removed in file X and added in file Y) it should be trivial to detect
that.
Something along the lines of:
for hunk in added:
  if hunk in deleted:
    print("Over here!!")

> Just an idea,

Much appreciated! I will look into this.

-- 
Cheers,

Sverre Rabbelier
