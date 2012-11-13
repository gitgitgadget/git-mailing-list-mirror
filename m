From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Tue, 13 Nov 2012 19:15:59 +0100
Message-ID: <CAMP44s18diic3KQtH5weCv-sVJXj4Pv-QnAaTeHTbrxk-=+3Gw@mail.gmail.com>
References: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<20121111171518.GA20115@sigill.intra.peff.net>
	<CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
	<20121111181406.GA21654@sigill.intra.peff.net>
	<CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com>
	<20121112214127.GA10531@sigill.intra.peff.net>
	<CAMP44s1gA1P-Lr1M=7RDRqFQmvQAtNnB+yAJfKC1gk3XUjbfCQ@mail.gmail.com>
	<50A21DB9.7070700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:16:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYL2E-0007pN-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab2KMSQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:16:01 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57814 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab2KMSQA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:16:00 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7712883oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IV3UkqNNg6/f4eZezuSSIv6Zm83cNghEdIdJG3ORdFk=;
        b=ofo4cyIVkM28t5ebhIRfw9l/ZbUH/6qhDY4XJnYtHxDKNQkVMi4ShDHGNwx/EP9urz
         FfNG7rUO4/6BwM8d8wM2bUnSXDqD2ViEDP6Rau15Gki/Pe95p+FKMRYElsRpslM95RrS
         jIhQasAkYfE4XfpOTRgNNLn9aszwPiVb34F7i/u9GE6B8lyemU9aNij9+s95zdkxo73n
         AY0n7HM7uTFy6WK5EU1jzuXmRQvAyloHdmo1NkDSU9xN/HPz7DgoWKyD9cL2xMc8qQEe
         pXnCVUjrgNDCD4AfLfxRahsid/IAJPj4i+nXLb/bOQsC8mCdLJOh4g/MQLSrYlaFuVJx
         ThWA==
Received: by 10.60.26.234 with SMTP id o10mr17681806oeg.85.1352830559584; Tue,
 13 Nov 2012 10:15:59 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Tue, 13 Nov 2012 10:15:59 -0800 (PST)
In-Reply-To: <50A21DB9.7070700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209652>

On Tue, Nov 13, 2012 at 11:15 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 12.11.2012 23:47:
>> On Mon, Nov 12, 2012 at 10:41 PM, Jeff King <peff@peff.net> wrote:
>>> On Sun, Nov 11, 2012 at 07:48:14PM +0100, Felipe Contreras wrote:
>>>
>>>>>   3. Exporters should not use it if they have any broken-down
>>>>>      representation at all. Even knowing that the first half is a human
>>>>>      name and the second half is something else would give it a better
>>>>>      shot at cleaning than fast-import would get.
>>>>
>>>> I'm not sure what you mean by this. If they have name and email, then
>>>> sure, it's easy.
>>>
>>> But not as easy as just printing it. What if you have this:
>>>
>>>   name="Peff <angle brackets> King"
>>>   email="<peff@peff.net>"
>>>
>>> Concatenating them does not produce a valid git author name. Sending the
>>> concatenation through fast-import's cleanup function would lose
>>> information (namely, the location of the boundary between name and
>>> email).
>>
>> Right. Unfortunately I'm not aware of any DSCM that does that.
>>
>>> Similarly, one might have other structured data (e.g., CVS username)
>>> where the structure is a useful hint, but some conversion to name+email
>>> is still necessary.
>>
>> CVS might be the only one that has such structured data. I think in
>> subversion the username has no meaning. A 'felipec' subversion
>> username is as bad as a mercurial 'felipec' username.
>
> In subversion, the username has the clearly defined meaning of being a
> username on the subversion host. If the host is, e.g., a sourceforge
> site then I can easily look up the user profile and convert the username
> into a valid e-mail address (<username>@users.sf.net). That is the
> advantage that the exporter (together with user knowledge) has over the
> importer.
>
> If the initial clone process aborts after every single "unknown" user
> it's no fun, of course. On the other hand, if an incremental clone
> (fetch) let's commits with unknown author sneak in it's no fun either
> (because I may want to fetch in crontab and publish that converted beast
> automatically). That is why I proposed neither approach.
>
> Most conveniently, the export side of a remote helper would
>
> - do "obvious" automatic lossless transformations
> - use an author map for other names

This should be done by fast-import. It doesn't make any sense that
every remote helper and fast-exporter out there have their own way of
mapping authors (or none).

> - For names not covered by the above (or having an empty map entry):
> Stop exporting commits but continue parsing commits and amend the author
> map with any unknown usernames (empty entry), and warn the user.
> (crontab script can notify me based on the return code.)

Stop exporting commits but continue parsing commits? I don't know what
that means.

fast-import should try it's best to clean it up, warn the user, sure,
but also store the missing entry on a file, so that it can be filed
later (if the user so wishes).

> If the cloning involves a "foreign clone" (like the hg clone behind the
> scene) then the runtime of the second pass should be much smaller. In
> principle, one could even store all blobs and trees on the first run and
> skip that step on the second, but that would rely on immutability on the
> foreign side, so I dunno. (And to check the sha1, we have to get the
> blob anyways.)

No. There's no concept of partial clones... Either you clone, or you don't.

Wait if the remote helper didn't notice that the author was bad?
fast-import could just just leave everything up to that point, warn
abut what happened, and exit, but the exporter side would die in the
middle of exporting, and it might end up in a bad state, not saving
marks, or who knows what.

It wouldn't work.

The cloning should be full, and the bad authors stored in a scaffold author map.

> As for the format for incomplete entries (foo <some@where>), a technical
> guideline should suffice for those that follow guidelines.

fast-import should do that.

Cheers.

-- 
Felipe Contreras
