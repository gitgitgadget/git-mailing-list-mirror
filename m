From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 11:38:42 -0700
Message-ID: <CA+P7+xp9bMeQF2TvNoGTcL4H5Ap0vHcDhJ0o4WCpaAJaFmQmeA@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com> <18979417.pyyHNUINeQ@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	repo-discuss@googlegroups.com
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6kX-0002c9-0o
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbIJSjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:39:04 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34902 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbbIJSjD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:39:03 -0400
Received: by ioiz6 with SMTP id z6so71421062ioi.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GdcRwa7lBNvjuJrUIH7eHbahRzvWqQvhHZ/suxsZ3+I=;
        b=ymLnqKpmugD5h/+VtLv4vZMXdWP8USkJlAzfKJ79qqruK0T+JTiWOiY/c/9f1nqRQo
         Kb3yWi6Vnmb4AsMaTSjE7inBVBUx9NdE0vtaYuiamIbDQvS6OAJ/OvJbc2Ot9dFlzn+b
         T8bHlnKeSrAAAPGPHJ08SK6H5eWdgMHiJ//Sls+8JZ9r8tHhhmuewMwIVNb/s9SuhJVo
         tORhWPneVqfmA4aptYe/fkQplKnEv64FYD9W6p7bCM7Li+dun0uX3KSrMeAemGZSYIax
         B1L3qA9/abee8i3HYvIaTw+uxSoNnmTrpYcr0zGw97b5BnOn4W08wMhvCnGVokNPEPAS
         F2kw==
X-Received: by 10.107.166.201 with SMTP id p192mr30046765ioe.0.1441910342062;
 Thu, 10 Sep 2015 11:39:02 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 11:38:42 -0700 (PDT)
In-Reply-To: <18979417.pyyHNUINeQ@mfick1-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277623>

On Thu, Sep 10, 2015 at 11:02 AM, Martin Fick <mfick@codeaurora.org> wrote:
> On Thursday, September 10, 2015 10:41:54 AM Junio C Hamano
> wrote:
>>
>> I think "should" is too strong here.  Yes, you could
>> implement that way.  It is debatable if it is better, or
>> a flat file kept in a directory (my-topic/ in the example
>> above) across rerolls is more flexible, lightweight and
>> with less mental burden to the users. --
>
> As a Gerrit developer and user, I would like a way to
> see/review cover letters in Gerrit.  We have had many
> internal proposals, most based on git notes, but we have
> also used the empty commit trick.  It would be nice if there
> were some standard git way to do this so that Gerrit and
> other tools could benefit from this standard.  I am not
> suggesting that git need to be modified to do this, but
> rather that at least some convention be established.
>
> -Martin
>

Having used gerrit, this would be useful as well. The "empty commit
message" thing sort of works, but has issues.

I don't know if this could be solved for gerrit at all without
modification to git, since you'd need something that can be sent to
the gerrit server and received by the client.

Some form of git-notes might work, ie: a git-notes on the first
commit, stored in some "standard" refs/notes/cover or similar.. but
this would depend on implementation of a standard way to share notes.

One alternative as well is to use a --no-ff merge commit which forces
the merge between the base and the tip of the series and contains the
contents.. but I don't believe gerrit really works well with merge
commits.

But again, Junio's solution will work great for emails workflow, which
is my primary usage.
