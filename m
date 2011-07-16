From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git commit generation numbers
Date: Sat, 16 Jul 2011 11:16:45 +0200
Message-ID: <CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com>
References: <20110714190844.GA26918@sigill.intra.peff.net>
	<CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	<20110714200144.GE26918@sigill.intra.peff.net>
	<69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	<20110714203141.GA28548@sigill.intra.peff.net>
	<CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
	<20110715074656.GA31301@sigill.intra.peff.net>
	<CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
	<CAJo=hJtuxNLhSjn_sDJxG7xu5k2wbJ_QLf_n+Z1E=o2AndAuJQ@mail.gmail.com>
	<CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>
	<20110715184211.GH8453@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 16 11:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi0zi-0007sC-Os
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 11:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1GPJQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jul 2011 05:16:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39181 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab1GPJQq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2011 05:16:46 -0400
Received: by ywe9 with SMTP id 9so831341ywe.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 02:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+0iyImTY9qIh3LHeP3KASdfaGSgPogq7lteoYt0AbuY=;
        b=gALqwOoCiiWhRIzhXrqDxDSYUpt2RPh6H8NPOp28yec14oLEt6tNpFlxnIaHP37h+v
         PLNpFdbGE1N/qkk/FLwqQlzCT0m8GUT5tQb9Ls53hF7ZxtCEmmuEkm0XZL6kAVJvZPcq
         b/whQdRFYPwH+z+OECAeq0HPwlB2ctxr71g3c=
Received: by 10.236.9.40 with SMTP id 28mr1772850yhs.136.1310807805784; Sat,
 16 Jul 2011 02:16:45 -0700 (PDT)
Received: by 10.146.86.2 with HTTP; Sat, 16 Jul 2011 02:16:45 -0700 (PDT)
In-Reply-To: <20110715184211.GH8453@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177251>

On Fri, Jul 15, 2011 at 8:42 PM, Ted Ts'o <tytso@mit.edu> wrote:
> On Fri, Jul 15, 2011 at 09:44:21AM -0700, Linus Torvalds wrote:
>> So I would like to repeat: I think our commit-date based hack has be=
en
>> pretty successful. We've lived with it for years and years. Even the
>> "let's try to fix it by adding slop" code is from three years ago
>> (commit 7d004199d1), which means that for three years we never reall=
y
>> saw any serious problems. I forget what problem we actually did see =
-
>> I have this dim memory of it being Ted that had problems with a merg=
e
>> because git picked a crap merge base, but that may just be my
>> Alzheimer's speaking.
>
> My original main issue was simply that "git tag --contains" and "git
> branch --contains" was either (a) incorrect, or (b) slower than
> popping up gitk and pulling the information out of the GUI. =A0The
> reason for (b) is because of gitk.cache.
>
> Maybe the answer then is creating a command-line tool (it doesn't hav=
e to
> be in "core" of git) which just pulls the dammned information out of
> gitk.cache....
>
> (Yes, it's gross, but I'm not worrying about the long-term
> architecture of git or anything high-falutin' like that. =A0I'm just =
a
> poor dumb user who just wants git tag --contains and git branch
> --contains to be fast and accurate...)

If  "git tag --contains" and "git branch --contains" give incorrect
answers because the commiter date is wrong in some commits, then why
not use "git replace" to "change" the commiter date in the commits
that have a wrong date? Is it because you don't want to use "git
replace", or because there is no script to do it automatically, or is
there another reason?

Thanks,
Christian.
