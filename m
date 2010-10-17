From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Sun, 17 Oct 2010 12:33:56 +0000
Message-ID: <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<7vwrph4eeb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 14:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7SRI-00005V-V2
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 14:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0JQMd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 08:33:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55726 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0JQMd5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Oct 2010 08:33:57 -0400
Received: by fxm4 with SMTP id 4so1478574fxm.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t32zPc/Ff1yKhzT/hQpvOtrOl+DwPtsBl1NiEMgJANc=;
        b=UIhrJuIjvPt1f5cX5vINYGwzUyRWrMwXqPpw9LJ5a3IAUA6SAJuJ+B5Tl1Pv0E0jJo
         Z5NuM5F+yBNYixmIUtHsChf4R72OwIdvn44Wc92iqRIZBykjy8WcU7p9tkkgOJu6OD8I
         AZ3vIA4Ndxoo2cM/IRd0sQXErmJKD1/EDKyE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G21DYHMJW1OgRxLKkHSAq/v4u9AzGIJFXakhWEkrMD6Sa+qZkl4EmxiG0gp04Thdr+
         4Rg0UHaK4VL5x69c10G3D3E9Sj7VBCN26JVZkZdFGMpmQgLWHAeytqIXeJXA+nQJGnxk
         uwTfCCXZW9R78nh0l63XEFjKnLIWNh2kMAZwM=
Received: by 10.223.106.204 with SMTP id y12mr168899fao.9.1287318836283; Sun,
 17 Oct 2010 05:33:56 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Sun, 17 Oct 2010 05:33:56 -0700 (PDT)
In-Reply-To: <7vwrph4eeb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159205>

On Sun, Oct 17, 2010 at 04:44, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> Could you please pick up the 160 commit version of this at:
>>>
>>> =C2=A0 =C2=A0 git://github.com/avar/git.git ab/i18n
>>
>> This is a "give an inch and they'll ask for a mile" sort of thing, b=
ut
>> would it be possible to maintain a stable branch with the i18n
>> infrastructure that only gets rebased when there is reorganization
>> going on?
>
> People might have noticed that I've refrained to take other topics th=
at
> may add new messages to 'next'. =C2=A0I would wanted to merge ab/i18n=
 early in
> the cycle soon after dust has settled after 1.7.3 release. =C2=A0And =
I still
> do.

Good to hear. I didn't know that before, and that's really all I
wanted to know.

> Having said that, there are different classes of risks associated wit=
h
> i18n effort.
>
> (1) Regressions that even hit a NO_I18N build.
> (2) Regressions that hit LC_ALL=3DC execution in a !NO_I18N build.
> (3) Regressions that hit plumbing run in a non-C locale.
>
> =C2=A0. i18n needs not just marking strings with _("string") but also=
 needs to
> =C2=A0 fix code that manually formulates messages by series of strcat=
(). =C2=A0It
> =C2=A0 may need to start using allocations on the heap, with potentia=
l risk of
> =C2=A0 usual bugs (leaks, use-after-free, etc.) and performance degra=
dation.
>
> =C2=A0. Messages left unmarked with _("string"), or messages that are=
 marked
> =C2=A0 with _("string") that shouldn't have, won't be serious issues =
for the
> =C2=A0 first two classes. =C2=A0The latter is a serious regression fo=
r the
> =C2=A0 plumbing.
>
> We are all human, and misconversion during this process is possible, =
even
> though the above classes of regressions are unacceptable. =C2=A0On th=
e other
> hand, as long as the above three classes of regressions are minimum a=
nd
> quickly fixed/fixable, issues in non-C locale Porcelains are tolerabl=
e
> during the initial cut.
>
> I've looked at the patches in the series, and plan to take another lo=
ok.
> I'm sure others on the list have checked the series, some with fine c=
ombs,
> too, and hopefully =C3=86var has fixed any such regression that has b=
een
> reported and plans to do so for the ones discovered in the future. =C2=
=A0As
> long as we are sure that we have done a reasonable effort to eyeball =
the
> patches, the logical next step would be to merge the series to 'next'=
 for
> further testing.

Right. I'll have time to deal with any bugs that crop up, and I'm
reasonably sure it's OK as-is.

> (4) Incomplete *.po file, and languages without *.po file.
>
> Once we are sure that the series does not have the first two classes =
of
> issues, we can ask everybody to mark new strings in their series, iow=
,
> merge the i18n part to 'master'. =C2=A0If we can do that sooner, it w=
ould be
> better, and we do not need specific l10n part from the series during =
that
> stage.
>
> A language that already has *.po file may lack necessary translation;
> there may be languages that do not have *.po file. =C2=A0They can be =
added with
> a lot smaller risk later without unstabilizing the codebase.

Do you mean to re-arrange it so that there's a patch at the front of
the series that introduces gettext.h with only the fallbacks:

    #define _(s) (s)
    #define N_(s) (s)

And then merge the ~120 gettextize patches first and do the
infrastructure later?

That could be done, but just merging the whole 160 patch series and
turning it off by default would have pretty much the same effect. And
since I thought this was going to get merged soon-ish anyway I didn't
spend time on something like that.

> So where are we now? =C2=A0I think a constantly rebased 160-patch ser=
ies that
> has infrastructure bits and l10n bits mixed together is not very frie=
ndly
> to review for the first three classes of regressions (which are all I=
 care
> about at this point) to help the series hit 'master' sooner.

I think we're basically at a point where merging it down to next ->
master is the logical next step.

> In any case, the branch merged to 'pu' has been replaced with the tip=
 of
> the said branch from =C3=86var's repository now.

Thanks.
