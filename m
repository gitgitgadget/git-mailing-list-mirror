From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 14:20:29 -0400
Message-ID: <BANLkTikLWuENTpCF9BXPJWawLUpKW0077A@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DF08D30.7070603@alum.mit.edu>
	<20110609161832.GB25885@sigill.intra.peff.net>
	<BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
	<7vd3imykj1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:20:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUjqO-0003hM-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 20:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1FISUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 14:20:31 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49083 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab1FISUb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 14:20:31 -0400
Received: by yie30 with SMTP id 30so944993yie.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cYTG85fEqhPThX7Sg3Q0LCNy6Nv7ViLw+dsXfzgrqN4=;
        b=A4ULNs1Tgli770Ji9EOBul/GFJekqyC0nC6EcDM1jsgH7SbG1QEC5KfFaKTJswSG0D
         kNj06m0j+/ZrWfkDnjGh2T04xC5t5wyXeLq1bkV+WzmXXypZplO6ExQWmusZ0bG/mSYz
         uT82na9V3cBbI4BPqd7wXtM1vryz4rEE3pVNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=omstWhH87Fe6aMzUQh63oBQKo1Dzmkut9PjwUOallz/tfCZkRgHxOi0tP2jod7kMuL
         10SkG7Zz3mPQRhebRAA0fORk0gg7Tk0/1DIQEMgWzN/m5WXfNH5aozh+ylER7VZfnLxv
         2ugHlYpmSAEuGvJqxwxRNn2FHj9p3Y4sD0MVE=
Received: by 10.236.78.193 with SMTP id g41mr1380640yhe.468.1307643629769;
 Thu, 09 Jun 2011 11:20:29 -0700 (PDT)
Received: by 10.147.169.1 with HTTP; Thu, 9 Jun 2011 11:20:29 -0700 (PDT)
In-Reply-To: <7vd3imykj1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175565>

On Thu, Jun 9, 2011 at 1:36 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> In fact, my first step after a conflicted merge is:
>>
>> =C2=A0 $ git tag -f ours HEAD
>> =C2=A0 $ git tag -f theirs MERGE_HEAD
>> =C2=A0 $ git tag -f base $(git merge-base HEAD MERGE_HEAD)
>
> That looks like quite a convoluted set-up, I would think, than
> necessary. You only need to remember these:

My merges are fairly complex, involving a code base of 20k+ files with
merges bringing several hundred commits at a time. So, they require
lots of amending after conflict resolution to get into shape, where I
often have to look at either side of the merge. I prefer to tag at the
time of the merge so that I can use ours, theirs, and before and after
the merge (otherwise it's HEAD MERGE_HEAD vs HEAD^ and HEAD^2).

> =C2=A0# what does the result look if I said "commit -a" now?
> =C2=A0$ git diff HEAD

I never use commit -a.

> =C2=A0# I want to also see comparison with the original
> =C2=A0$ git checkout --conflict=3Ddiff3 <conflicted paths>...
> =C2=A0$ git diff

I have merge.conflictstyle diff3 in my .gitconfig.

> =C2=A0# What did they do since they forked from my history?
> =C2=A0$ git diff ...MERGE_HEAD
>
> =C2=A0# What did I do since I forked from them?
> =C2=A0$ git diff MERGE_HEAD...

Sure, I already suggested that, but if I want to do the same after the
merge I can use the tags I've already set up.

> =C2=A0# I want step-by-step explanation of how these paths were touch=
ed
> =C2=A0$ git log -p --left-right --merge [<conflicted paths>...]

Now that's one I haven't used before. I usually use log ..MERGE_HEAD
and log MERGE_HEAD.. on the paths.

j.
