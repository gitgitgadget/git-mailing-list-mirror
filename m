From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with 
	gettext
Date: Wed, 2 Jun 2010 09:29:27 +0000
Message-ID: <AANLkTilClUTkrpnMhBTlcBZC-r2OemT4m22bDnc6fRPy@mail.gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
	<1275440764-26153-2-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jun 02 11:29:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJkGU-0002Ed-57
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 11:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab0FBJ33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 05:29:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59614 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab0FBJ32 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 05:29:28 -0400
Received: by iwn6 with SMTP id 6so1227567iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lr4VAds8FaGX4DQ5oXS2oG0j4wy7YGUkR8oAca0YMCc=;
        b=jVlIMQNnVM5YxKsupd4b6UFCxWM4auuGxXeDL02Wcq/UB8ke6oz6T5eF0NyZ50rTsr
         RRORJUEBnE18BMXYDGfiFz2CteedNSZDrufK2E03sQxnSpC04LS7hr2OAvZAe9BJF126
         n9UymPS+sriaUgI276E1HfxVx0PsibX8TzNKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VfffOENOqjC70yDfoKg5qtnRp8MOAPJx56e1FpgnyJXzwk6Sz8fe9v2dAOURTgMrVh
         Reqt4h9cgFsC51in1DJBSIkfukalHmeHgL4egp02jIOInp3vyPNrwjKOHlBm4ok1yi+a
         uZmIdsTyU7TvfSjX4brv+C5eWiQOlTxj/m4P8=
Received: by 10.231.125.129 with SMTP id y1mr9500309ibr.96.1275470967127; Wed, 
	02 Jun 2010 02:29:27 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 02:29:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148233>

On Wed, Jun 2, 2010 at 09:12, Peter Krefting <peter@softwolves.pp.se> w=
rote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, c, _("# =C2=A0 (use \"git rm --cached
>> <file>...\" to unstage)"));
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("# =C2=A0 (use \=
"git add/rm <file>...\" as
>> appropriate to mark resolution)"));
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("#"));
>
> This is a multi-line string, and should be translated as such.
>
> The trailing "#" should either be part of the translated multi-line s=
tring,
> or be added explicitely, and untranslated, at the end.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, c, _("# =C2=A0 (use \"git rm --cached
>> <file>...\" to unstage)"));
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("#"));
>
> Determine how to handle the trailing "#" as above.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, c, _("# =C2=A0 (use \"git add/rm
>> <file>...\" to update what will be committed)"));
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("# =C2=A0 (use \=
"git checkout --
>> <file>...\" to discard changes in working directory)"));
>
> Multi-line.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, c, _("# =C2=A0 (commit or discard the
>> untracked or modified content in submodules)"));
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("#"));
>
> Trailing "#".
>
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("# =C2=A0 (use \=
"git %s <file>...\" to
>> include in what will be committed)"), how);
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(s->fp, c, _("#"));
>
> Ditto.
>
>> + =C2=A0 =C2=A0 =C2=A0 case 1: how =3D _("both deleted:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 2: how =3D _("added by us:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 3: how =3D _("deleted by them:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 4: how =3D _("added by them:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 5: how =3D _("deleted by us:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 6: how =3D _("both added:"); break;
>> + =C2=A0 =C2=A0 =C2=A0 case 7: how =3D _("both modified:"); break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> - =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, c, "%-20s%s\n", how, one=
);
>> + =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->fp, c, _("%-20s%s\n"), how, =
one);
>
> does color_fprintf() gracefully handle cutting text for multi-byte
> encodings, and text width? Otherwise I can see this bite us for all
> non-ASCII locales in general (if long translated are needed), and for=
 CJK
> locales in particular (for variable character widths).
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->=
fp, color(WT_STATUS_HEADER, s), "%s",
>> extra.buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf(s->=
fp, color(WT_STATUS_HEADER, s), _("%s"),
>> extra.buf);
>
> Should not be in _()
>
>> - =C2=A0 =C2=A0 =C2=A0 fprintf(s->fp, "\n");
>> + =C2=A0 =C2=A0 =C2=A0 fprintf(s->fp, _("\n"));
>
> Ditto.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, color(WT_STATUS_HEADER, s),
>> _("#"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, color(WT_STATUS_HEADER, s), _("#
>> Initial commit"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_fprintf_ln(=
s->fp, color(WT_STATUS_HEADER, s),
>> _("#"));
>
> Either a multi-line string, or untranslate the "#"s.

All of the points you raised are correct. This is a bad way to do
things.

It was added in Jeff in his original WIP patch as an example of
translation being possible, but I should just remove it. It's not
ready to go in for the reasons you cited.

I'll just remove the wt-status.c chunk out of the patch completely in
the next submission, and instead translate a few select strings in
some C program well.

Making things like wt-status.c translatable is going to be hard to do
properly. It uses a lot of lego (sticking strings incrementally
together), and due to the coloring of output this'll be particularly
hard to convert.

(Also, for reference, here's a general guide on how to translate C
programs well):

    http://gnu.april.org/software/automake/manual/gettext/Preparing-Str=
ings.html
