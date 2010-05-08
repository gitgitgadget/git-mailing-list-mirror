From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 20:31:50 -0400
Message-ID: <i2l32541b131005071731j11085ab4zf325fad96381ce35@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 02:32:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAXxv-0002fp-Oy
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 02:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab0EHAcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 20:32:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53991 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0EHAcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 20:32:11 -0400
Received: by gwj19 with SMTP id 19so993992gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+n5DzX+7VbI6t5BtlvOJYQsGusjtplwdqhLqoLAJ7CA=;
        b=cwv8bKDsBDDGC45WTwMuAeJSmSUrc8TVXzvqzv+AmyA4m7FSEI65JQZXUNfe79UL/f
         AIuwIvBBNFzrDGIu2jK4XzEQvXnWCNqo1DMOWapetrwTAXQN3QtyiRSnejzr2bk+H8mI
         jloDRJJgFpJuJNv3SSbu/mdGRZk263qet2ITg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TWbG9CZK88ailxPz1kfFIhPtP/gfTY/78JDUKGYGWfcIwTfEwqlO2YGZgkDQ3f7D+P
         Dl65TXqIueaB4UYdb6WWj5kZYoID4chGGulyflYjPX/A/jCU+pMWqZKH76QwQAO8xZne
         TZfo/oYjaOUaJ3pCDJVkx+6ZV8mEKCbPc10uI=
Received: by 10.150.112.23 with SMTP id k23mr4099700ybc.308.1273278730106; 
	Fri, 07 May 2010 17:32:10 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 17:31:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146623>

On Fri, May 7, 2010 at 7:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> Maybe we should rethink this from the top. =A0Imagine that we curren=
tly
>> have no crlf options whatsoever. =A0What *should* it look like? =A0I
>> suggest the following:
>>
>> Config:
>> =A0 =A0core.eolOverride =3D lf / crlf / auto / binary / input
>> =A0 =A0core.eolDefault =3D lf / crlf / auto / binary / input
>
> Ugh. Hell no. What an ugly format. What does that crazy "override vs
> default" even _mean_?

That's easy:

 - if "override" is set, it overrides any attribute setting.
 - if "default" is set, we use it when there's no attribute or override=
 setting.

We can argue about whether having two config options is strictly
necessary from a formal truth table point of view, and you'll probably
win the argument because it all makes my head spin.  My argument is
simpler: if it makes my head spin, it probably makes other people's
heads spin.  The way I described is simple enough for anyone to
understand.

> Plus the above is confused anyway. The only reason to ever support 'l=
f' is
> if you're a total moron of a SCM, and you save files you know are tex=
t in
> CRLF format internally. That's just f*cking stupid.

What I meant by "lf" is just what we currently mean by "crlf=3Dfalse".
It's more clear for the average person to say "eol=3Dlf" than
"crlf=3Dfalse", because "crlf=3Dfalse" doesn't say what you *do* want, =
it
only says what you *don't* want.

Clearly any repo storing some other weird line ending, then converting
it to LF, is not what we want here.

> =A0- disabling all "text" issues, and considering everything to be pu=
re
> =A0 binary. This is the "I know I'm sane and unix" option, or the "do=
ing
> =A0 any conversion is always wrong" option.
>
> =A0 We'd call this "binary" or "off" or "false".

Sure, that's what I called "binary" above.

> =A0- if you recognize a text-file, and consider it text and different=
 from
> =A0 binary, at a _minimum_ it needs what we call "input". Anything el=
se is
> =A0 crazy-talk. We don't save the same text-file in different formats=
, and
> =A0 we know that CRLF (or CR) is just a stupid format for text.
>
> =A0 So there are zero options for the input side. If we don't do CRLF=
 -> LF
> =A0 conversion on input, it's worthless even _talking_ about text vs =
binary.

That sounds good to me.  So this was a mistake in the original
implementation of autocrlf; let's just correct it, and make all text
modes do input conversion.

Note that, in prior threads on this topic, there was some objection to
doing crlf=3Danything by default because it wastes CPU in the common
case that people are running on Unix and aren't doing screwy things
with line endings.  Defaulting to crlf=3Dinput would require us to wast=
e
CPU here.  Is that ok?

> =A0- For output, there are exactly three choices: "do nothing" (aka j=
ust
> =A0 "input", aka "LF"), output in native format (CRLF on Windows, LF =
on
> =A0 UNIX), or "force CRLF" regardless of any defaults (and the last
> =A0 probably doesn't make sense in practice, but is good for test-sui=
tes,
> =A0 so that you can get CRLF output even on sane platforms.
>
> So I think the _only_ sane choices are basically
>
> =A0 =A0 =A0 =A0core.crlf=3D[off|input|on|force]

One nice thing about my suggestion is that it completely avoids the
concept of a "native CRLF format."  Because nowadays, that's just not
very useful.  On Unix sometimes I need crlf files; on Windows
sometimes I need lf files.  Yes, we can still implement that in terms
of "native" terminology, but it seems to a roundabout way of stating
what I want.

> And the above is basically what we have. Except that for historical
> reasons (ie we didn't even _have_ any attributes) it got mixed it up =
with
> "do we want to do this automatically", so "autocrlf=3Don" actually en=
ds up
> being "yes, do automatic detection" _and_ what I'd call "core.crlf=3D=
force"
> above.

=46unctionally, yes, we have this already.  Your new proposal is
essentially to make crlf=3Dauto (=3D unspecified) to actually always
include crlf=3Dinput behaviour, which sounds good to me, but may be
backwards incompatible in some important way.  (I wouldn't think
anybody would want the non-fixing-stuff behaviour.  But I wonder what
it would do to git-svn... maybe it could just check everything in as
if it were crlf=3Dbinary, if it doesn't already.)

My suggestion doesn't much change this functionality, but attempts to
straighten out the terminology so normal humans can understand what
will happen.  Not sure if that's worth it, given that we'll probably
have to support the old attribute names forever anyhow, and adding a
second set of words might confuse normal humans all the more.  But I
would much rather teach people to use it using my terminology than
crlf=3Dtrue/false/binary terminology.  What does "crlf=3Dbinary" mean?

Have fun,

Avery
