From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 16:39:39 +0100
Message-ID: <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com> <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 16:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtJF2-0005qk-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 16:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3LRPkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 10:40:53 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57160 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab3LRPkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 10:40:52 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm19so818404wib.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 07:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u5anfFFEvIil6avM53PJbQKDxYyPVjYtKeRTY101Juc=;
        b=nwqA8Ld98d7RlYqSRJWYOMS+65eupDr/QUtaBuBOyZa14yNWTYqOjNfXn0naa8SoLA
         +7w36QlgyR+wRV5H86KWgAOtgLYOfMemac0UJghEehX6mdLl7bFtfDAX7N8ljmpMuBQl
         9dt6wRFlrkk1oZxxNUPsyQfB+uocoVugZR9P5UPmEAUVetwfk04aXIVC6luAGQWKbDUh
         plOcYgU2tduyqZssS2A41uqc+cbP/2FmNrdcAO1YZlnv1BdcfPWrVZ0O9dWAl5ZA14yW
         6h96eykgJAOsiwJqQ2f+Uowt8DPYIg8c+eRAkdhgAd1/HlL6egsA36Ekpjm3yz04l7F5
         WYkA==
X-Received: by 10.180.205.205 with SMTP id li13mr8916342wic.12.1387381219099;
 Wed, 18 Dec 2013 07:40:19 -0800 (PST)
Received: by 10.227.86.201 with HTTP; Wed, 18 Dec 2013 07:39:39 -0800 (PST)
In-Reply-To: <20131218002122.GA20152@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239451>

On Wed, Dec 18, 2013 at 1:21 AM, Eric S. Raymond <esr@thyrsus.com> wrot=
e:
> Jakub Nar=C4=99bski <jnareb@gmail.com>:

>>> No, cvs-fast-export does not have --export-marks. It doesn't genera=
te the
>>> SHA1s that would require. Even if it did, it's not clear how that w=
ould help.
>>
>> I was thinking about how the following part of git-fast-export
>> `--import-marks=3D<file>`
>>
>>   Any commits that have already been marked will not be exported aga=
in.
>>   If the backend uses a similar --import-marks file, this allows for=
 incremental
>>   bidirectional exporting of the repository by keeping the marks the=
 same
>>   across runs.
>
> I understand that. But it's not relevant - cvs-fast-import doesn't kn=
ow about
> git SHA1s, and cannot.

It is a bit strange that markfile has explicitly SHA-1 (":markid <SHA-1=
>"),
instead of generic reference to commit, in the case of CVS it would be
commitid (what to do for older repositories, though?), in case of Bazaa=
r
its revision id (GUID), etc.  Can we assume that SCM v1 fast-export and
SCM v2 fast-import markfile uses compatibile commit names in markfile?

>> How cvs-fast-export know where to start exporting from in incrementa=
l mode?
>
> You give it a cutoff date. This is the same way cvsps-2.x and 3.x wor=
ked,
> and it's what the cvsimport wrapper expects to pass down.

Nice to know.

I think it would be possible for remote-helper for cvs-fast-export to f=
ind
this cutoff date automatically (perhaps with some safety margin), for
fetching (incremental import).

>> BTW. does cvs-fast-export support incremental *output*, or does it
>> perform also incremental *work*?
>
> As I tried to explain previously in my response to John Herland, it's
> incremental output only.  There is *no* CVS exporter known to me, or
> him, that supports incremental work.  That would be at best be imprac=
tically
> difficult; given CVS's limitations it may be actually impossible. I w=
ouldn't
> bet against impossible.

Even with saving (or re-calculating from git import) guesses about CVS
history made so far?

Anyway I hope that incremental CVS import would be needed less
and less as CVS is replaced by any more modern version control system.

>> Anyway, that might mean that generic fast-import stream based increm=
ental
>> (i.e. supporting proper thin fetch) remote helper is out of question=
, perhaps
>> writing one for cvs / cvs-fe would bring incremental import from CVS=
 to
>> git?
>
> Sorry, I don't understand that.

I was thinking about creating remote-helper for cvs-fast-export, so tha=
t
git can use local CVS repository as "remote", using e.g. "cvsroot::<pat=
h>"
as repo URL, and using this mechanism for incremental import (aka fetch=
).
(Or even "cvssync::<URL>" for automatic cvssync + cvs-fast-export).

But from what I understand this is not as easy as it seems, even with
remote-helper API having support for fast-import stream.

--=20
Jakub Nar=C4=99bski
