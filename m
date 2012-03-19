From: Shawn Pearce <spearce@spearce.org>
Subject: Re: link user-name with ssh-login
Date: Mon, 19 Mar 2012 14:56:04 -0700
Message-ID: <CAJo=hJvqr2pKVje490g2k2Wxdf2rrQYsrWQ2eN6bPn84fRxLEQ@mail.gmail.com>
References: <4F6765D0.5060706@gmail.com> <7v7gygbdxg.fsf@alter.siamese.dyndns.org>
 <20120319205747.GB3039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Roberto <mrgreiner@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kZ5-0000nu-5g
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab2CSV40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 17:56:26 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33707 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347Ab2CSV4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 17:56:25 -0400
Received: by dajr28 with SMTP id r28so10451209daj.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aU4QH5EYqQkZhzits6yxsGuwVfU3JmV/Ap9spXEZCYk=;
        b=RjL1JlkqMlVlnaehdc2VYILfWOgwmV6ac0/S877OPT7JXl6lmLi0046rOmA4Unsz5I
         AWu2AqvNClGvwQnmtlUHxwHFI27JAfahy7f3bqMUfmAtslzsOkvWex0nwcGx1+RvmZfe
         Kpjh7k1rK7P1k8JEx/ozyVIxG6+kshwq0PRb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=aU4QH5EYqQkZhzits6yxsGuwVfU3JmV/Ap9spXEZCYk=;
        b=KcmGhOREuw8yfOn2718VTp12RH5QrBQMTz124pH3gBX2aeDcsnPkTlf6JLsph7kPaR
         DSpdAS8GNZPi4FZc9olsnTnpJOAJk8moxZEwIAdTbilaAbQMIHfpRDeUKTGOCpRbfwG5
         0BQ5EXeqjs2H54GDMHWHmtzN/00ndv0/9HfejclbwusHxAqIZicVkA4ZBzhfAlChnfur
         cg9wSS4GhD1gQUe3WEX9d0Xi+Zqm9rAPlvBtEacUT1h6oip8UkHVtdYueuwl5lIgT5Jr
         5mpxm8hg0Yp4KKPMlzXH6Y3ReT/ApKrSfmhSq4GY5dHYCNuDt5febqJXwmhQOcX63JMG
         ELvA==
Received: by 10.68.230.195 with SMTP id ta3mr43439682pbc.149.1332194184633;
 Mon, 19 Mar 2012 14:56:24 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Mon, 19 Mar 2012 14:56:04 -0700 (PDT)
In-Reply-To: <20120319205747.GB3039@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQn0GnoMoq9HHdaZ1OZelv6KhdKMFM3x29UI2tHW2pCgWFgcwh/jFcg5Dx/nsdlkcYyo6Fir
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193465>

On Mon, Mar 19, 2012 at 13:57, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 19, 2012 at 12:15:07PM -0700, Junio C Hamano wrote:
>
>> A pre-receive hook that lists the author names of the commits, along=
 the
>> lines of "git log --format=3D'%an <%ae>' $OLD_HEAD..$NEW_HEAD" and c=
ompares
>> against the name of the user authenticated against your SSH server w=
ould
>> be a way to do this.
>>
>> But that would mean you are forbidding people to accept patches from
>> others, inspect the patches for validity and vouch for them, while g=
iving
>> the credit to them by recoding the author names of the patch authors=
=2E
>>
>> Perhaps checking the committer name would suit your situation better=
=2E =A0I
>> dunno.
>
> Then you would be forbidding merges of other people's work, no? Even =
if
> the other person's commits are available in the upstream repo, they
> might be hitting this ref for the first time, and would be generally =
be
> checked by such a hook.

Most hooks that are trying to do this use "$NEW_HEAD --not --all" to
only examine commits that would be newly reachable. Already reachable
commits are presumed valid. If you want to merge someone else's
commits, just make sure they have already pushed their commits to a
branch somewhere, like a refs/heads/$USER/ sandbox space or something.
