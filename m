From: Frank Li <lznuaa@gmail.com>
Subject: Re: [RFC] Common library for Git GUIs
Date: Wed, 18 Feb 2009 09:38:42 +0800
Message-ID: <1976ea660902171738j777e0af3mbd3b8aae8d1e7aaf@mail.gmail.com>
References: <20090216212459.GA25046@efreet.light.src>
	 <74161B7F-A178-49CB-990D-DF7299235C58@frim.nl>
	 <20090217212145.GC2216@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pieter@frim.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <fonseca@diku.dk>,
	Marco Costalba <mcostalba@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Abhijit Bhopatkar <bain@devslashzero.com>,
	Henk <henk_westhuis@hotmail.com>,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Feb 18 02:40:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbQ7-0003YR-Lr
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 02:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZBRBip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZBRBip
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:38:45 -0500
Received: from mail-gx0-f163.google.com ([209.85.217.163]:38351 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZBRBin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:38:43 -0500
Received: by gxk7 with SMTP id 7so2278760gxk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 17:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UkmRP/U/is5O8Mw1ym9Wivr1Dw+ho7gRtPgI5/NsBjU=;
        b=PsiL2QXK2Wb40s8GeB90hWL7AbK4msRdLs53PHaTkLW6bqwyeQS5yvb5hXPU1xUoF8
         x/9iN0PojnuDJkW4MvEB2qECRKG++uEAvhlLiq/jGigBKkA8QOACRosQccK1Djgl6Ufp
         g2Qgu3k5QqsAjikiottHLTLAqoBgRqsAq8SNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oMiWTjAvRGBo1rUSbKTlOLgIgYdUG37VuUQPUAIVRcXntUfrjSwb5Ko1JxArbzmx6g
         DqeQU6p/EKB2inhb5M3DpCdSCczfLot9CrLOTgDRs25Y2P9Qyr9LEotpeym+ASs/XweD
         nlcjQc2GU23geLk7YGiF7C2xXEavVhR9OQu6o=
Received: by 10.150.177.20 with SMTP id z20mr4093813ybe.88.1234921122144; Tue, 
	17 Feb 2009 17:38:42 -0800 (PST)
In-Reply-To: <20090217212145.GC2216@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110492>

I think TortoiseGit need C\C++ git library, which should be also used
by git itself. Otherwise, it is difficult sync with git.

2009/2/18 Jan Hudec <bulb@ucw.cz>:
> On Tue, Feb 17, 2009 at 20:08:23 +0000, Pieter de Bie wrote:
>> On Feb 16, 2009, at 9:24 PM, Jan Hudec wrote:
>>> What it should use:
>>> - It should probably be in C++ or C, with bindings for at least Perl,
>>>   Python, Ruby, C#(CLR) and Java. The bindings can be done either with
>>>   Swig, or using some base library that already has them.
>> It should be either C++ or C. If you want git devvers to work on it too,
>> you'll probably want to go with C.
>
> I don't think the really core devs need to work on this -- their time is best
> spent on the core. And many of the existing guis are in C++. For me, it
> depends on the user portable runtime more than anything else.
>
>>>    - Bindings for languages. We can use Swig, but it has e.g. no  support
>>>      for callbacks, so having portable runtime with already existing
>>>      bindings that support this would be an advantage.
>> I'd say bindings are pretty easy to create yourself.
>
> The advantage of swing is, that one definition with a few typedefs would
> generate Python, Perl, Ruby, CLR, Java and a few more bindings. GObject would
> need more language-specific work, but would nicely solve integration into the
> garbage collector. You know, I want to save as much work as possible.
>
>>> Portable runtime options:
>>> So what do you people think would be best? I see several options:
>>> - QtCore
>>> - Glib
>>> - STL + Boost
>> None of these, if you want any GUI's to use it. Noone is going to
>> create a Gtk / Cocoa / Windows app that depends on Qt. Nobody wants
>> to use Boost in any situation and Glib, while being smaller than the
>> rest, is also difficult as it isn't shipped with many OS's, for example
>> OS X.
>
> I fully agree that nobody will want to depend on Qt -- QtCore is now
> a separate library, but the sources are not shipped separately AFAIK, so it'd
> be a pain. I would not think the case is as strong against boost and glib,
> though. People would either be getting binaries, in which case we can just
> bundle whatever dependency along, or building it and than one extra source
> tree (that can also be bundled for convenience) is not so much pain.
>
>>> - POSIX + Msys on Windows
>> I think lightweight is the way to go. If you go for C++, you can also use
>> the STL.
>
> STL does not have any support for threads, event loop nor signals. Though
> thinking about it, we may not actually need them.
>  - we only need threads if our event loop can't be integrated into gui's one
>   and the gui can start our in thread itself -- it's not too much code.
>  - we only need file descriptors in the event loop and it needs to be
>   integratable into the gui's one anyway.
>  - simple callback is quite likely good enough for us -- the gui will need
>   multiple callbacks, but it will need to connect in it's own signal system
>   anyway.
> So the shell invocation remains and that's little enough we can cut&paste
> that from glib.
>
>> But, isn't this time spent better on getting libgit2 off the ground?
>
> No, because what I have in mind is orthogonal to libgit2. libgit2 is supposed
> to be generic API for git, while I am proposing a specifically gui-oriented
> interface, which should implement all logic of a gui except opening dialogs
> and the widgets themselves, allowing the guis built on top of it to be
> totally dumb. Actually part of my idea is to create something, that can be
> later ported to libgit2 and immediately benefit many git interfaces.
>
> --
>                                                 Jan 'Bulb' Hudec <bulb@ucw.cz>
>
