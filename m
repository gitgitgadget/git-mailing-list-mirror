From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Sat, 28 Nov 2009 13:08:20 +0100
Message-ID: <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
	 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
	 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 13:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEM6G-0006cv-I4
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 13:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbZK1MIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2009 07:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbZK1MIQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 07:08:16 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41402 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbZK1MIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2009 07:08:15 -0500
Received: by fxm5 with SMTP id 5so2271636fxm.28
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CBJNRRzmsVFZjn9AN5wJt5tW7EowYl3VJMn4Ap/0N0U=;
        b=OzMBAd490X1NMI2xWz+sdbEZG+qQZ6PuMblhJxL+p+Odv4DTRnofrx/nt4OVnFGmA6
         9b5QtvF3JI4TOjELBWw+9GOoZ9ghz07xJRqrR0unR6EwarLh6mrVTqVEnUbKJgoS07zN
         ikSlLsMTX67yoLM3C2O3jQdsO9j4CGgVs5AOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ACsUhNL5CLPYcWzJ8Dlqd0C3A0sbHOnUS/AitSSVrNifWNRaSF5pFQX8ISSd60L9dj
         PzSIBnZpgzWbDOXU+1FTAInPK7BIZNZ3jczxIi3ZFEcTU9DVtca2NAn/pmBD8FRPEh8w
         xObfe+YXTOy99RGM3Br866mhxXGHTa2mdg1M8=
Received: by 10.223.25.27 with SMTP id x27mr339737fab.7.1259410100858; Sat, 28 
	Nov 2009 04:08:20 -0800 (PST)
In-Reply-To: <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133960>

On Sat, Nov 28, 2009 at 06:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> =C2=A0diff.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 64 +++++++++++++++++++++++++++++++++++++++++++--
>> ...
>> @@ -344,6 +347,63 @@ static void emit_add_line(const char *reset,
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> +static void emit_hunk_line(struct emit_callback *ecbdata,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *line, int len)
>> +{
>> + =C2=A0 =C2=A0 const char *plain =3D diff_get_color(ecbdata->color_=
diff, DIFF_PLAIN);
>> + =C2=A0 =C2=A0 const char *frag =3D diff_get_color(ecbdata->color_d=
iff, DIFF_FRAGINFO);
>> + =C2=A0 =C2=A0 const char *func =3D diff_get_color(ecbdata->color_d=
iff, DIFF_FUNCINFO);
>> + =C2=A0 =C2=A0 const char *reset =3D diff_get_color(ecbdata->color_=
diff, DIFF_RESET);
>> + =C2=A0 =C2=A0 const char *orig_line =3D line;
>> + =C2=A0 =C2=A0 int orig_len =3D len;
>> + =C2=A0 =C2=A0 const char *frag_start;
>> + =C2=A0 =C2=A0 int frag_len;
>> + =C2=A0 =C2=A0 const char *part_end =3D NULL;
>> + =C2=A0 =C2=A0 int part_len =3D 0;
>> +
>> + =C2=A0 =C2=A0 /* determine length of @ */
>> + =C2=A0 =C2=A0 while (part_len < len && line[part_len] =3D=3D '@')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_len++;
>> +
>> + =C2=A0 =C2=A0 /* find end of frag, (Ie. find second @@) */
>> + =C2=A0 =C2=A0 part_end =3D memmem(line + part_len, len - part_len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 line, part_len);
>
> This is not incorrect per-se, but probably is overkill; this codepath=
 only
> deals with two-way diff and we know we are looking at "@@ -..., +... =
@@"
> at this point.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0part_end =3D memmem(line + 2, len - 2, "@@=
", 2);
>
> would be sufficient.
Thats right, I made it generic by purpose.

>
>> + =C2=A0 =C2=A0 if (!part_end)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return emit_line(ecbdata=
->file, frag, reset, line, len);
>> + =C2=A0 =C2=A0 /* calculate total length of frag */
>> + =C2=A0 =C2=A0 part_len =3D (part_end + part_len) - line;
>> +
>> + =C2=A0 =C2=A0 /* remember frag part, we emit only if we find a spa=
ce separator */
>> + =C2=A0 =C2=A0 frag_start =3D line;
>> + =C2=A0 =C2=A0 frag_len =3D part_len;
>> +
>> + =C2=A0 =C2=A0 /* consume hunk header */
>> + =C2=A0 =C2=A0 len -=3D part_len;
>> + =C2=A0 =C2=A0 line +=3D part_len;
>> +
>> + =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0* for empty reminder or empty space sequence (=
exclusive any newlines
>> + =C2=A0 =C2=A0 =C2=A0* or carriage returns) emit complete original =
line as FRAGINFO
>> + =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 if (!len || !(part_len =3D strspn(line, " \t")))
>
> Slightly worrisome is what guarantees this strspn() won't step outsid=
e
> len.
Thats a valid concern and should be addressed.

>
> I would probably write the function like this instead.
>
> -- >8 --
>
> static void emit_hunk_header(struct emit_callback *ecbdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *line, int len)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *plain =3D diff_get_color(ecbda=
ta->color_diff, DIFF_PLAIN);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *frag =3D diff_get_color(ecbdat=
a->color_diff, DIFF_FRAGINFO);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *func =3D diff_get_color(ecbdat=
a->color_diff, DIFF_FUNCINFO);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *reset =3D diff_get_color(ecbda=
ta->color_diff, DIFF_RESET);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char atat[2] =3D { '@', '@' }=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *cp, *ep;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * As a hunk header must begin with "@@ -<=
old>, +<new> @@",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * it always is at least 10 bytes long.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len < 10 ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcmp(line, atat, 2) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(ep =3D memmem(line + 2, le=
n - 2, atat, 2))) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_line(ecbd=
ata->file, plain, reset, line, len);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ep +=3D 2; /* skip over the second @@ */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The hunk header in fraginfo color */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_line(ecbdata->file, frag, reset, line=
, ep - line);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* blank before the func header */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (cp =3D ep; ep - line < len; ep++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*ep !=3D '=
 ' && *ep !=3D 't')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ep !=3D cp)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_line(ecbd=
ata->file, plain, reset, cp, ep - cp);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ep < line + len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emit_line(ecbd=
ata->file, func, reset, ep, line + len - ep);
> }
Please check that its really an *ep !=3D '\t'. Its wrong in this mail, =
I
see only an *ep !=3D 't'. Otherwise:

Acked-by: Bert.Wesarg@googlemail.com
>
>
