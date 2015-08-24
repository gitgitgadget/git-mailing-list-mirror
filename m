From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Mon, 24 Aug 2015 10:22:09 +0200
Message-ID: <5D227DCB-E19F-4612-9E39-DA952891B2CE@gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com> <xmqqmvxk5xm9.fsf@gitster.dls.corp.google.com> <D3B14EF1-C005-43CE-A3FF-2ABEF879CA01@gmail.com> <xmqqtwrp5h6q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, pw@padd.com,
	torarvid@gmail.com, ksaitoh560@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 10:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTn1H-0003pK-CC
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 10:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbbHXIWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 04:22:14 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38071 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbHXIWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 04:22:13 -0400
Received: by wicja10 with SMTP id ja10so64583480wic.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sFMlTU2Bic8RjCoTlUXQ4Kow9MteId89sIrz9CKp7sw=;
        b=tYnK3MbLkWQe6DfOvOnJifhy04ogmDtQIkW/0Bqze3W0N5JbweECIqk70j7luhgU2r
         uR+q8Eia46DObWUOt1QhFTdipu2yMB4D1t5SEtIIBrBLRjgDTM2h8V6RW/geqOew2Sb9
         h/vl+ypk2vzq0By49emwCyUue0KHreJ0wwdV2lieilrbBX2oL5I+amBP/rT+3TlHbPF4
         DevTBGtIJPV55KKcaZ8m3jZ/GhJ29jkD/c79cYaHokFNctauQTsvcUMerE6o60YaUiqL
         ORYWE08SmZfwSHXTcYD/Bj1Q4eLI1woTeNWjqocYqTBHNOn5p8A8yFc8gMGMASsxrB9S
         zulg==
X-Received: by 10.180.81.70 with SMTP id y6mr12161968wix.36.1440404531324;
        Mon, 24 Aug 2015 01:22:11 -0700 (PDT)
Received: from [10.146.248.55] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ul1sm22000746wjc.30.2015.08.24.01.22.10
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Aug 2015 01:22:10 -0700 (PDT)
In-Reply-To: <xmqqtwrp5h6q.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276439>

On 24 Aug 2015, at 08:33, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> - Have you checked "git log" on our history and notice how nobody
>>>  says "PROBLEM:" and "SOLUTION:" in capital letters?  Don't try to
>>>  be original in the form; your contributions are already original
>>>  and valuable in the substance ;-)
>> haha ok. I will make them lower case :-)
>=20
> I cannot tell if you are joking or not, but just in case you are
> serious, please check "git log" for recent history again.  We do not
> mark our paragraphs with noisy labels like "PROBLEM" and "SOLUTION",
> regardless of case.  Typically, our description outlines the current
> status (which prepares the reader's mind to understand what you are
> going to talk about), highlight what is problematic in that current
> status, and then explains what change the patch does and justifies
> why it is the right change, in this order.  So those who read your
> description can tell PROBLEM and SOLUTION apart without being told
> with labels.
I wasn=92t joking. I got your point and I am going to change it. Sorry =
for the confusion.

>=20
>>> - I think I saw v3 yesterday.  It would be nice to see a brief
>>>  description of what has been updated in this version.
>> I discovered an optimization. In v3 I fixed the paths of *all* files
>> that are underneath of a given P4 clone path. In v4 I fix only the
>> paths that are visible on the client via client-spec (P4 can perform
>> partial checkouts via =93client-views=94). I was wondering how to co=
nvey
>> this change. Would have been a cover letter for v4 the correct way o=
r
>> should I have made another commit on top of my v3 change?
>=20
> Often people do this with either
>=20
> (1) a cover letter for v4, that shows the "git diff" output to go
>     from the result of applying v3 to the result of applying v4 to
>     the same initial state; or
>=20
> (2) a textual description after three-dash line of v4 that explains
>     what has changed relative to v3.
>=20
> The latter is often done when the change between v3 and v4 is small
> enough.
Ok. Thanks!

>=20
>> Yes, that is PEP-8 style and I will change it
>> accordingly. Unfortunately git-p4.py does not follow a style guide.
>> e.g. line 2369: def commit(self, details, files, branch, parent =3D =
""):
>=20
> OK, just as I suspected.  Then do not worry too much about it for
> now, as fixes to existing style violations should be done outside of
> this change, perhaps after the dust settles (or if you prefer, you
> can do so as a preliminary clean-up patch, that does not change
> anything but style, and then build your fix on top of it).
>=20
>> More annoyingly (to me at least) is that git-p4 mixes CamelCase with
>> snake_case even within classes/functions. I think I read somewhere
>> that these kind of refactorings are discouraged. I assume that appli=
es
>> here, too?
>=20
> If you are doing something other than style fixes (call that
> "meaningful work"), it is strongly discouraged to fix existing style
> violations in the same commit.  If you are going to do meaningful
> work on an otherwise dormant part of the system (you can judge it by
> checking the recent history of the files you are going to touch,
> e.g. "git log --no-merges pu -- git-p4.py"), you are encouraged to
> first do the style fixes in separate patches as preliminary clean-ups
> without changing anything else and then build your meaningful work
> on top of it.
>=20
> What is discouraged is a change that tries to only do style fixes
> etc. to parts of the system that are actively being modified by
> other people for their meaningful work.
Ok. Thanks for the explanation.

>=20
>>> You are verifying what the set of "canonical" paths should be by
>>> checking ls-files output.  I think that is what you intended to do
>>> (i.e. I am saying "I think the code is more correct than the earlie=
r
>>> round that used find"), but I just am double checking.
>> I agree that =93ls-files=94 is better because it reflects what ends =
up
>> in the Git repository and how it ends up there.
>=20
> Thanks. I wanted to double-check that the problem you saw was not
> about what is left in the filesystem but more about what is recorded
> in the Git history.  "ls-files" check is absolutely the right approac=
h
> in that case.
Cool!
