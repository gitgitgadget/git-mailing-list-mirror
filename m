From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 18:34:55 -0400
Message-ID: <h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> 
	<576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 00:35:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAW8i-0003CE-H0
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab0EGWfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 18:35:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58473 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0EGWfQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:35:16 -0400
Received: by gyg13 with SMTP id 13so942039gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=h3Tfw5ZnqBkjVGwzp5oo97/k6/Qbb1Rxy95nW3+r/Lg=;
        b=XUFHhrx1Y/Kh8t5PDL2FFZfEde5tYvVJXFk05vO4gARjest6vujXkD9eX19U2SzslC
         xvnc4W4A5/WUHKHUGXGc28cmFopKk22rYtsuFXGFQYn2ju2rEBxdJb21+8IYK72VX9Ia
         bsgQXeew1L0aqgsGx9HX8TdJV/49cDGXqSIWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UOjrjI/jTd0hjc1BSj+Qm0AwlNUVfjfMcr5oZjgTUySF2LQKoeCLbHmStjSGzD20Io
         psM8hzRsRHEGEOH4gVtmzZZ1AbEYbB1UjWx7CoHYPT9IW2z5/+yLGy52vrwiAr0nVMfR
         onKTaOxK2tk5lcOUlWBkWaHRv8Zt1FbGGkA8c=
Received: by 10.151.4.17 with SMTP id g17mr2248394ybi.430.1273271715333; Fri, 
	07 May 2010 15:35:15 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 15:34:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146613>

On Fri, May 7, 2010 at 6:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Linus Torvalds wrote:
>> =A0 =A0 =A0IOW, if you really want to say "do automatic crlf for thi=
s set of
>> =A0 =A0 =A0paths", the natural syntax for that would be
>>
>> =A0 =A0 =A0 * crlf=3Dauto
>
> Btw, since we're discussing this, I do think that our current "crlf=3D=
input"
> syntax for .gitattributes is pretty dubious.
>
> I don't really see why it should be a path-dependent thing on whether=
 you
> do crlf conversion on just input or on checkout too.

Me neither.  However, in the name of sanity, it sure would be great to
have the global configuration options exactly parallel the per-project
and per-file configuration options.  From that point of view, 'input'
exists just to keep things nice and symmetrical.  And considering how
complicated this discussion already is (compared to what a simple
concept CRLF conversion is), that's probably worth something in
itself.

Part of the confusion comes from the way the options are currently
declared.  set vs. unset vs. unspecified vs. "input" vs. "auto" for an
option named "crlf" is just very, very, unfriendly.  None of the words
*mean* anything.

Maybe we should rethink this from the top.  Imagine that we currently
have no crlf options whatsoever.  What *should* it look like?  I
suggest the following:

Config:
   core.eolOverride =3D lf / crlf / auto / binary / input
   core.eolDefault =3D lf / crlf / auto / binary / input

Attribute:
   eol =3D lf / crlf / auto / binary / input

If eolOverride is not "auto" or unspecified, we ignore eolDefault or
any attributes.

If the attribute is not "auto" or unspecified, we ignore eolDefault.

=46or all entries, unspecified is equivalent to "auto".

Of course the eol attribute could be named "crlf", but that might not
increase the sanity as much as we would like.

And "input" means "auto, but strip CR when committing."  Or maybe the
problem is that it doesn't belong here at all: maybe it should be an
entirely separate attribute that takes effect whenever the eol
attribute/config resolves to "auto."

Or maybe I'm just not thinking about it the right way?

Avery
