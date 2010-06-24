From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Thu, 24 Jun 2010 18:49:24 -0400
Message-ID: <AANLkTiloAQmjAMVOROzBHkLAAIDj-KNFNcfXC9pdwDf5@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
	<AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
	<7vmxulebr2.fsf@alter.siamese.dyndns.org>
	<7v8w64cguk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 00:49:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORvEj-0008HL-R7
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 00:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab0FXWt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 18:49:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57476 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0FXWt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 18:49:28 -0400
Received: by iwn41 with SMTP id 41so1315646iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hj/QV0im4arAOU16jJeHkLEqT3mmzTZPXbkk0WNZij8=;
        b=NgpYUBMlh7vXA9N41ocXF2yZMj1MhSDk+5KmDAMM+6NMBCosfVyYTr6DqlaP3KA5xC
         8pgyU2GTcOAbMaLRhQ3Lxuy6mWFqLNVjkFVNtYW/mdxRu2osDqQB1mIaeYK6pGhZ8sqd
         S0QHqG9/kIFeUrxwps9VUi0mKoCO7m+ucC5qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SI1uWAckMzTYS8efktMf/6iLHWLFVpJ5AsHe+807GFDp+keyleiPD2SP+jOw3JKImP
         /pVXIlPq+PeBLu0YXum8ZCqTlseuH69vVp+mHTWn6w5taVI2G8m/DTUygtbBcGzQHwnJ
         6N7xkjCKKPy98KhvtH1GTR7ITxhIBkSB+sQo8=
Received: by 10.231.174.201 with SMTP id u9mr11950121ibz.17.1277419764850; 
	Thu, 24 Jun 2010 15:49:24 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Thu, 24 Jun 2010 15:49:24 -0700 (PDT)
In-Reply-To: <7v8w64cguk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149658>

On Thu, Jun 24, 2010 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Heh, this is a totally different operation to compare the tree before=
 and
> after the merge.
>
> What "log merge^..merge^2" does is to list the commits we merged from=
 the
> point of view of the person who did the merge. =C2=A0I haven't found =
the need
> for a short-cut for that myself, but in any case, I think such a feat=
ure
> belongs less to "show" (which is about "inspecting a single object") =
than
> to "log" (which is about "give me the sequence").
>
> You may want to look into merge.log variable if you find yourself wan=
ting
> to do that often with your history, though.

=46amiliar with that and sadly insufficient. My merges often contain
100+ commits which is beyond what merge.log truncates. But more
importantly, I'm often inspecting the commits:

git log ..MERGE_HEAD -Scontent_to_watch_out_for
git log ..MERGE_HEAD -- /path/to/watch/out/for

etc. But sometimes I have to do this type of inspection after the
fact, which is what leads to the merge^..merge^2.

Perhaps the right place for such syntactic sugar would be in
rev-parse. Something like:

o A suffix ^{m..n} (i.e. rev^{1..2}) when rev is a merge commit
expands to rev^m..rev^n and is only valid in contexts that take a
range. 'm' and 'n' may be left out in which case they are assume to be
1 and 2. (i.e rev^{..} is rev^1..rev^2).

But I haven't entirely thought this through. :-)

j.
