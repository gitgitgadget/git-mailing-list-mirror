From: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Tue, 8 Mar 2011 23:25:04 +0200
Message-ID: <AANLkTim9juvhBJKraHBkV8AC=zY75xt_1BnyhTDTcoUZ@mail.gmail.com>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
	<4D6A6291.8050206@drmicha.warpmail.net>
	<7v7hclulz0.fsf@alter.siamese.dyndns.org>
	<7v39n9uldp.fsf@alter.siamese.dyndns.org>
	<4D6B4F6B.1040209@drmicha.warpmail.net>
	<20110228121726.GA5197@sigill.intra.peff.net>
	<20110228122335.GB5197@sigill.intra.peff.net>
	<7vy650hvwa.fsf@alter.siamese.dyndns.org>
	<20110228222352.GC5854@sigill.intra.peff.net>
	<7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
	<7vy64zg0ms.fsf@alter.siamese.dyndns.org>
	<AANLkTinBTWPrAOq9BOkBJc5GOhFkzsr__9wqEWnWdwYR@mail.gmail.com>
	<7vipvte6jc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:25:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4P3-0008Jt-QF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab1CHVZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 16:25:07 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62711 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1CHVZF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 16:25:05 -0500
Received: by qyg14 with SMTP id 14so5056411qyg.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sYjJsp8Ng42cKAo+WbGFXhBUczXWmuKIqAX3Hy3C+m0=;
        b=nX1kxwaVjGcOQMvC1dAQ/ghvzC6lDNp8FrGtnUGRWfbldTuopQEab7TEYBhbopOvB8
         a/iqidccVa+MSUFK5mkK/si0aOohJt+8uQSr9Wrqx7KTqJLbjhcCyZjfAkRCPKcoa/w6
         FoHhCeuOA7fgLwacl0wvH1YaYn9pvjuXAG9P8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vVLnIi0n2DLIdwHhdknVm/c20GAMcxTtbpFs7zz4x8NshXGDu7RAUBERSggbq0ECMd
         9ZXH6qjSyGjyXHdOETwtoDacCnEtGyAy7ASXQSV9tA4bJceTnoEHwFW9acOLT2jEqjYP
         IUmdX7qyGifd7p6Vw+wNvfCnnS5wQP6YisOMY=
Received: by 10.229.126.210 with SMTP id d18mr4409125qcs.179.1299619505067;
 Tue, 08 Mar 2011 13:25:05 -0800 (PST)
Received: by 10.229.98.133 with HTTP; Tue, 8 Mar 2011 13:25:04 -0800 (PST)
In-Reply-To: <7vipvte6jc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168698>

On Tue, Mar 8, 2011 at 9:49 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Mart S=F5mermaa <mrts.pydev@gmail.com> writes:
>
>> On Tue, Mar 1, 2011 at 2:11 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> In any case, a minimum patch to give what Mart wanted to see would
>>> probably look like this. =A0I'll leave bugfixes, documentation and =
tests to
>>> the readers ;-).
>>
>> The minimum looks to be the optimum -- IMHO this is entirely suffici=
ent,
>
> I suspect not, as I don't think I ever did anything to the codepath f=
or -B
> output, and I also recall spending some time thinking about this issu=
e in
> an earlier message that I mentioned -B besides "deletion", none of th=
e
> suggestions in which I don't think I tried to implement.

Your suggestion is as follows:

"It also might make sense to apply the similar principle to shorten the=
 output
with -B when a rewrite patch is expressed as a single hunk patch that r=
emoves
everything old and then adds everthing new."

I have to admit that I've never used -B, only -M, so please don't mind =
that
its semantics and exact behavior are a bit foreign to me.

After running t/t4130-apply-criss-cross-rename.sh,
`git diff -M -B` outputs the following:

diff --git a/file2 b/file1
similarity index 100%
rename from file2
rename to file1
diff --git a/file1 b/file2
similarity index 100%
rename from file1
rename to file2

Can you bring a similar example of changes in the output after
the above-mentioned similar principle has been implemented for -B?

> I also vaguely recall that I suspected that the output may not have t=
he
> usual "index deadbeaf..000000 mode" line and that I chose to ignore i=
t.

'deadbeaf' is present:

$ ../git/bin-wrappers/git diff -D HEAD
diff --git a/foo.txt b/foo.txt
deleted file mode 100644
index 257cc56..0000000

Can we perhaps consider the -B behavior orthogonal to -D (unless I am m=
issing
something very important here)?

Best regards,
MS
