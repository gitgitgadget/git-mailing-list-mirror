From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Sat, 12 Feb 2011 21:55:46 +0100
Message-ID: <AANLkTinewf-TopnV9vzGrMqNMeBhH+O+0J68ueaoh8HB@mail.gmail.com>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
	<7vipwpxbam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 21:56:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoMVe-0003pi-BY
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 21:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082Ab1BLUzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 15:55:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57510 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1BLUzs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 15:55:48 -0500
Received: by bwz15 with SMTP id 15so4324835bwz.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FaTSMLnRO15SYs3u8Qh55Ds5+fncq2JhwLfo/aOUMVM=;
        b=DI+ND/jGncnJJUf3xcLRB/JBz5FZyrs2miYGgQ802QhYKzvbku4Q9IJ9kPD8ScZlX3
         7THX4rebfOFu2HabZ+ZVCk4sWBcZnzVrWhBZOvNoeSIc9w4GyMCCSyEjtKQQ6SntO91z
         qQR6wbKrOZdFWsOUY5M/jNrZQkXk2oV+A+hs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h+2WuNeHFb7p1VzwaDXfI/yuUwjzdleugzx6caRX8TKvmao3YPmCM1b5hEg/faxgTV
         +VNLDNb/NxuXb3HaGAxXcwhnoMaTJaUuZ7Yn5KKzx/OvKI3HRvBI8jmoY/XBaoOdfwTp
         7pBL40pgOq9AvDkkrvAMXIqz4iM3kewTppQh4=
Received: by 10.204.98.130 with SMTP id q2mr1835223bkn.31.1297544146910; Sat,
 12 Feb 2011 12:55:46 -0800 (PST)
Received: by 10.204.52.135 with HTTP; Sat, 12 Feb 2011 12:55:46 -0800 (PST)
In-Reply-To: <7vipwpxbam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166622>

On Sat, Feb 12, 2011 at 21:12, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Hi both. I've been on a hiatus from Git development, so I haven't
>> picked up ab/i18n again, but I still plan to and to get it included =
in
>> Git.
>
> Thanks.
>
>> =C2=A0 =C2=A0 *** TODO Introduce a skeleton no-op gettext, just the
>> infrastructure minus the interesting stuff
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 I.e. just add:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define N_(s) (s)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #define _(s) (s)
>>
>> =C2=A0 =C2=A0 *** TODO Add no-op C gettextize patches
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This will change "foo" to _("foo") every=
where, but will be a no-op
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 due to it being macroed out.
>
> It would be best to get this as early as possible while not many topi=
cs
> are in 'next'; it is preferrable if we can rebase other topics in 'pu=
' on
> top of the result of this step.
>
>> =C2=A0 =C2=A0 *** TODO Add no-op Shell/Perl gettextize patches
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Due to the nature of these languages the=
se can't be macroed out,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 but it's still easy to have a no-op wrap=
per function.
>
> Yes. =C2=A0After the above two steps are done, we can pretty much ind=
ependently
> advance and tweak i18n topic from other changes.
>
>> =C2=A0 =C2=A0 *** TODO Add po/README etc.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 The documentation about how to add trans=
lations etc.
>>
>> =C2=A0 =C2=A0 *** TODO Add translations
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Add the po/*.po files. Since we have no-=
op translations everywhere
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 we can translate git with xgettext + po =
editing, even though the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 translations aren't being used yet.
>>
>> =C2=A0 =C2=A0 *** TODO Introduce the real gettext in a later patch +=
 tests
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Once the rest is all in this will be a m=
uch smaller change.
>
> The last two could probably be swapped, but I think we are on the sam=
e
> page as to the overall steps and direction.

Right, good to hear we're on the same page.

I'll be doing a Perl release on the 20th, and I'm traveling around,
but I hope to get around to this sooner rather than later.
