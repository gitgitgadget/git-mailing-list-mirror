From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: show notes in shortlog view
Date: Sat, 6 Feb 2010 10:24:39 +0100
Message-ID: <cb7bb73a1002060124s7f9bc4f7y9c2cb418e4802f64@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1265300338-25021-3-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002060118.21137.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 10:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndgud-0002qg-V1
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 10:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab0BFJZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 04:25:05 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:44959 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab0BFJZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 04:25:00 -0500
Received: by ewy28 with SMTP id 28so832960ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=o8ARla79xaOTD4CP1MRDEz5sKQ/xxGvL7VcejnaQIpE=;
        b=JgXYgup3ExdHd+zoDRfjS6dSCccIvHJpg3dLX3kaKJ4665EmD9mmUV8XuyXiLqAZz3
         ll94cPG8D23T4ddKOjj/rsaKHyNkObXySc1D5fHF7IsuJJArsrrRqXXjQ82YhFDdxHlv
         93pZTgVHNM3wMLp1vCoj2MREFGuTsDG0MZFCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=clmIZfrs/9gHMMzUHM2diRioe2hm8eVHBWuXMn05w1IoSxrJIg6hUuanLyBSe55/8X
         am7Oy6mHft14P0TruospQu2By9WJU9eCbc135MRTyS+dZmtQkVNtor0uSw/DL1sjQYAm
         aUJR6slNiV+Gvn2pwlIaIvJKAtx3xnPVNEWBw=
Received: by 10.213.100.68 with SMTP id x4mr1603272ebn.33.1265448299119; Sat, 
	06 Feb 2010 01:24:59 -0800 (PST)
In-Reply-To: <201002060118.21137.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139152>

2010/2/6 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
>
>> Subject: [PATCH 2/4] gitweb: show notes in shortlog view
>
> Is it RFC?

See reply to comments on 1/4 8-/

> Why it is only for 'shortlog' view, and not also for 'history' which =
is
> also shortlog-like view? =A0Or is there reason why it is not present =
for
> 'history' view?

I always forget about history view, probably because I never use it.

>> The presence of the note is shown by a small icon, hovering on which
>> reveals the actual note content.
>
> Signoff?

A-hem. (whistles innocently)

>> +
>> +span.notes span.note-container:before {
>> + =A0 =A0 content: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUg=
AAAAgAAAAIAgMAAAC5YVYYAAAAAXNSR0IArs4c6QAAAAlQTFRFAABnybuD//+t5rXizQAAA=
AF0Uk5TAEDm2GYAAAABYktHRACIBR1IAAAAGElEQVQI12MIDWXIWglDQHYIQ1YAQ6gDAFWP=
BrAKFe0fAAAAAElFTkSuQmCC');
>> +}
>
> Not all web browsers support ':before' pseudo-element, and 'content'
> (pseudo-)property.

I know it's neither good form nor good webdesigner attitude, but I
stopped caring about IE a long time ago. I understand however that
some ancient versions of Mozilla browsers might have the same issue
too.

> Not all web browsers support 'data:' URI schema in CSS; also such ima=
ge
> cannot be cached (on the other hand it doesn't require extra TCP
> connection on first access, and CSS file is cached anyway).
>
> On the other hand adding extra images to gitweb would probably requir=
e
> additional (yet another) build time parameter to tell where static
> images are (besides logo and favicon).
>
> So perhaps it is good solution, at least for a first attempt.

A possible alternative could maybe do without images and just use
borders and backgrounds of an 8x8 fixed-size element. Wouldn't look as
nice, probably, but should render decently in everything that supports
CSS1.

>> +# display notes next to a commit
>> +sub format_notes_html {
>> + =A0 =A0 my %notes =3D %{$_[0]};
>
> Why not use 'my $notes =3D shift;', and later '%$notes'?

No particular reason. I didn't check for syntax preferences regarding
this in gitweb, or I would have noticed there was a preference for the
one you mention.

>> + =A0 =A0 my $ret =3D "";
>
> Perhaps $return or $result would be a better name, to better distingu=
ish
> it from visually similar $ref (see $ref vs $res);

Yep, good point.

>> + =A0 =A0 while (my ($ref, $text) =3D each %notes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 # remove 'refs/notes/' and an optional fin=
al s
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ref =3D~ s/^refs\/notes\///;
>
> You can use different delimiter than / to avoid 'leaning toothpick'
> syndrome, e.g.: $ref =3D~ s!^refs/notes/!!;

Indeed I should.

>> + =A0 =A0 =A0 =A0 =A0 =A0 $ref =3D~ s/s$//;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 # double markup is needed to allow pure CS=
S cross-browser 'popup'
>> + =A0 =A0 =A0 =A0 =A0 =A0 # of the note
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<span title=3D'$ref' class=3D'n=
ote-container $ref'>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<span title=3D'$ref' class=3D'n=
ote $ref'>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 foreach my $line (split /\n/, $text) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D esc_html($line) =
=2E "<br/>";
>
> Probably would want
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$ret .=3D esc_html($li=
ne) . "<br/>\n";
>
> here. =A0Or do we want single string here?

It's within a span element so I was trying to stick to single line in
the HTML source.

> Also, do you want/need final <br>? =A0If not, perhaps
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0join("<br/>", map { esc_html($_) } spl=
it(/\n/, $text);
>
> would be a better solution (you can always add final "<br/>" later)?

I did notice that the final br didn't seem to affect the box height,
so I didn't bother looking at ways to do without it, but it's probably
nicer to not have it.

--=20
Giuseppe "Oblomov" Bilotta
