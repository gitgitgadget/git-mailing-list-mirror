From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 18 Dec 2012 21:30:22 -0500
Message-ID: <CACh33Fo=FqvVf-P6-FTdv3aXAQMDEN4sVdE8dm_49fnSMreAWA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
	<20121212033043.GA24937@thyrsus.com>
	<CACh33Fpk8_ZXw8Ladx83J+rmdRYf7ruYAMMkqOKcoH3OApKPJQ@mail.gmail.com>
	<20121212124306.GC25981@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 03:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl9Vn-0003kv-2k
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 03:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab2LSCfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 21:35:41 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48188 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab2LSCfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 21:35:40 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so1478727oag.30
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 18:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=iUDF5az6OIKI9bGLnnNLDQ5gpaZenY03HZxDc2FwniY=;
        b=j45PDtcQE2d/zjt34XMArMSqnpHLJizkf6859Hg3j/OcfMt++cbJLNt4mO3Hx4LjIw
         /MS4KtOjXb1YhRhURm7ExCXyyfJ4kW0KlJakp8pS92K79PG442b9MytHOnZ5iRW4BGKp
         hkHbdGtDT+75z7pkVUOoJnvuXQB2Bx/NTzYM0QgP+HWYz/p+O0bv84I3w6ZfqUAUaBTQ
         OHR0PIGZPAPZ6NlZ1dSN+6hhrPu1axsa8VlRMHbDN5TTWpiq2H6DSZnENfhIdGcvEfiW
         BHMZaYaf4irEaeZ97wNV+m8OIPN+6gzntbj2rDML0pJGcuREPPu4WUqys4is2p1OW5ID
         UtGA==
Received: by 10.60.2.135 with SMTP id 7mr3511304oeu.127.1355884223039; Tue, 18
 Dec 2012 18:30:23 -0800 (PST)
Received: by 10.76.13.234 with HTTP; Tue, 18 Dec 2012 18:30:22 -0800 (PST)
In-Reply-To: <20121212124306.GC25981@thyrsus.com>
X-Gm-Message-State: ALoCoQl7cSdmhJLV5K2Wgp4TKQETAFXFsrRBJy9FxiE0RZ6Bu+9L0Y6rXFqaV6BqxsNiFZXW6jZo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211798>

On Wed, Dec 12, 2012 at 7:43 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Patrick Donnelly <batrick@batbytes.com>:
>>        How would another language (e.g. Python) mitigate this?
>
> The way you mitigate this sort of problem is to have a good set of
> high-level bindings for standard services (like socket I/O) built in
> your extension language and using its abstractions, so you don't get a
> proliferation of low-level semi-custom APIs for doing the same stuff.
>
> I have elsewhere referred to this as "the harsh lesson of Perl", which
> I do not love but which was the first scripting language to get this
> right.  There is a reason Tcl and a couple of earlier designs like csh
> that we would now call "scripting languages" were displaced by Python
> and Perl; this is it.

Okay, I understand what you were trying to say earlier.

I'm not going to say Lua is a silver bullet for all embedded language
needs. If you seriously need an exotic suite of libraries built into
the language, then Lua is not really going to work well for you. In
reality though, many projects that require an extension language do
not need all the system programming facilities thrown in. In fact,
many don't want them due to bloat or security considerations. So, you
take on a hyperopic viewpoint by ruling out Lua simply because it
lacks a suite of system libraries.

With Jeff's response:

> As for "interacting with the outside world", I was specifically thinking
> of stuff like git-send-email (currently in perl) and git-imap-send
> (written in C). They need to open network sockets and speak standard
> protocols. I suspect Lua would need a module or custom bindings to do
> the former at all, and certainly the code would be much simpler if we
> re-used standard modules for speaking SMTP and IMAP (which of course
>increases our dependencies again...).

I would think this can perhaps be exported into another script Lua
could exec as needed. Or luasocket may be sufficient. These
dependencies would need to be examined in detail. I wouldn't recommend
selecting a language because of one odd network protocol dependency
satisfied by an obscure built-in library (I realize Jeff's example was
exactly that, an example).

On Wed, Dec 12, 2012 at 7:43 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> I don't see how these languages are more appropriate based on your concerns.
>
> Your previous exchange with Jeff King indicates that you don't
> understand glue scripting very well.  Your puzzlement here just
> confirms that.  Trust both of us on this, it's important.  And
> reread my previous three paragraphs.

What I didn't understand coming into this thread was Git's ecosystem.
I understand embedded scripting languages very well and have been
working with Lua for years.

What does puzzle me is your dismissal of Lua because it doesn't have
the library suite Python does. Lua is not a system programming
language and I could argue Python is not really an embedded language.
I came here to try to stimulate discussion about what Git actually
needs/wants from a higher level language. If a small embedded language
would fit well, the Lua should be a candidate for consideration.

--
- Patrick Donnelly
