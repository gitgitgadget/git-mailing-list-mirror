From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 17:26:41 +0530
Message-ID: <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYCTBpVQHRJrzq2VjCQ@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
 <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com> <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 13:57:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQzP-0001ZD-G8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 13:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966254Ab3DQL5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 07:57:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58631 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966143Ab3DQL5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 07:57:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so1786290ied.33
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3w813R7NNQDR0wyBY8X8dMQ/DQev/6TrIp11SfPqyZE=;
        b=aCSeu3Tfj62PETFtBJKA9XBMoUC9/eFu4wzw9siDLtHw1QGZPUSWAecS2T6qDG5Vl5
         0L10iOBMpNZBmXAMEAekhcue1y4TFZ44FbqhJHqC/tv3Rt7UsZbEsh2PoxA+3UJc48fk
         9eHY40OeQ/zmrDF28S8IqKLLyBFbptV5wbkhFFvchWTf8Itek0JAlBaCPWaizZ2oFCse
         YaqmHi46kzGp/mSOP/dQrdo6PqpSEvzT6Deu2KSiHka+UoFgug8ncGUKZeKXOJcw6kWr
         J711pncVQxz73wjtjdOuVPJ8Widu2Lyt0X/4672CkK4cNFF9sw6Wta42KSJM626e9YIU
         kopg==
X-Received: by 10.50.17.166 with SMTP id p6mr10401972igd.12.1366199841945;
 Wed, 17 Apr 2013 04:57:21 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 04:56:41 -0700 (PDT)
In-Reply-To: <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221538>

Duy Nguyen wrote:
> Include me to those everyone. url feels like a local thing that should
> not stay in object database (another way of looking at it is like an
> email address: the primary one fixed in stone in commits with .mailmap
> for future substitution).

We've been over this several times in earlier emails.  That's like
saying that a blob should not be stored in the object database,
because it is not "fixed in stone" (my OBJ_LINK is just a special kind
of blob, as I've repeated many times already).  I don't rely on what I
"feel", which is why I started out by posting an implementation: the
implementation seems to indicate that getting an OBJ_LINK will
simplify a lot of things.  And that is my primary criterion for
deciding: if the implementation is simple and elegant, it must clearly
be doing something right.

Again, I'm not saying that my approach is Correct and Final.  What I'm
saying is: "Here's what I've done.  Something interesting is going on.
 It's probably worth a look?"

> Other attributes like .update,
> .fetchRecursiveSubmodules... definitely should not be stored in object
> database.

"Coffee and other beverages definitely should be served cold."
All very nice to say, but I don't see any rationale.

> I think if they are stored in the submodule's config file,
> then the manual move problem above will go away.

What?  The submodule's .git/config?  Why should a submodule repository
know that it is being used as a submodule?  What inherent properties
of a git repository change if it is being used as a submodule?

> And if you're dead set on storing some submodule state in object
> database,

I'm not.  I'm just saying that it seems to be an interesting
alternative approach.  Considering that nobody else brought up a real
alternative approach, and chose to just keep defending .gitmodules to
the death, it's the only other approach we have.

> why not reuse tag object with some nea header lines?

Or a unified blob, which is currently what we have.  The point is to
have structured parseable information that the object-parsing code of
git code and easily slurp and give to the rest of git-core.

Please clear your reading backlog to avoid bringing up the same points
over and over again.
