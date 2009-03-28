From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How do I force git to forget about merging a binary file that is 
	to stay deleted on the target branch?
Date: Sat, 28 Mar 2009 08:21:06 -0700
Message-ID: <e38bce640903280821k79aa241fqded9fc454e266353@mail.gmail.com>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
	 <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
	 <7viqltvg7n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 16:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnaMp-0007rn-Lx
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 16:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305AbZC1PVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 11:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZC1PVI
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 11:21:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:46159 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902AbZC1PVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 11:21:07 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1748788rvb.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=75EgI05AabkO8YqnhUA5wfIm/hm5wlEjLGCeivVClY4=;
        b=abc0G9lBE1ngLYnReVhaidSHPKME5NwjP5jaMUpv1LfgjVtCq0pgP9FJ7i24R7ykev
         9Mo5SfCXswNwh2XXQndKfefzUmopUyqpItepJlhDNQszkybsZYyThuK8dzKqvechoL/k
         2sIXsmme2QTUmePMcjFqjS0fj09D+roKwrqhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u0fzvP97xAHspOaypSrDCx37XQttJVFAtZgP9pPDcnuOuwQy1pg5FpQUZ1KEg8t29T
         3UGSaXtKFLvYLAYU48u+jHWKGFFOvSsrJFCXQEnS2m2X46hEkEPmD1Di+9RS2xbq2/pM
         l5+JI0E5rDbVbdmUjdSxWTCzLLc6BfYieug1Q=
Received: by 10.141.176.4 with SMTP id d4mr1721330rvp.109.1238253666072; Sat, 
	28 Mar 2009 08:21:06 -0700 (PDT)
In-Reply-To: <7viqltvg7n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114962>

On Sat, Mar 28, 2009 at 8:07 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> You can resolve this merge conflict by running
>> $ git rm TimeSheets/Timesheet\ Exempt.XLS
>>
>> which will make git delete the file from your working copy and the
>> index, at which point you can then make a commit that does not inclu=
de
>> this file.
>
> But is this what you really want to do? =A0After doing such a "remove=
 it"
> merge resolution at Home, wouldn't merging it back to Work remove the
> file?

Yes, and I've not told the full story.  Each time I do a merge in
between the two branches, I have a script that resets certain files
that I don't want cross-pollinated between the two branches. Then I do
the commit.  Most of the time (on non-binary files, and/or on files I
only change on the work branch and not on the home branch), this works
just fine.

My desire to avoid doing the above drove my earlier post asking
whether there as a facility to exclude certain files from
participating in merges. But the answer was "no" to that, hence my ad
hoc workaround above.

bg
