From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sun, 25 Oct 2009 12:06:16 +0300
Message-ID: <94a0d4530910250206v4827941cs12b88ec75975224e@mail.gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
	 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
	 <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
	 <7vtyxoymfa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 10:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1z3O-0002eU-Qp
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 10:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZJYJGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbZJYJGN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 05:06:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:39674 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbZJYJGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 05:06:12 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4533491fgg.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sVsLs3KXdRmVviQ22+Ssa4Ssn7plg+3SiO+ha6TXgl0=;
        b=f+GDvOK63pA7R54mohEc7fNiplF+7MH51vIaMwJaa0q5wCzU8y1pT2n6/vduYMLitx
         S+/4N3kuawGqt4WTYSOYZe1qjZ7m7tGAoqYS7s6eO1qBMZBHrheYcnvFyy3bx1Aa/+OJ
         M4SmgWc1yGJvmy31ucYFAe6LBwHIvN7OeQTQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hdUIKPQrtb34pEGATqQmv4TSjKzNRiYxX8jKhaiaUKAGX2Fvr9ZERzLz0R5TCK2Wr+
         bVmOGA5j+RCVzoLrTasmZwFvex/JQPGpXRIJKM03rCndGHKu1OR0VZMPCBAgRIx5IfN4
         G6pOFZTprAMUglVPVALhkcSK9dZXom1CKpJCo=
Received: by 10.86.226.5 with SMTP id y5mr7212496fgg.36.1256461576561; Sun, 25 
	Oct 2009 02:06:16 -0700 (PDT)
In-Reply-To: <7vtyxoymfa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131196>

On Sun, Oct 25, 2009 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> I'll queue your patch with the following interdiff for now.
>
> =C2=A0* user-manual.txt: do not change emphasis (typography) in this =
patch---if
> =C2=A0 it needs to be changed, that should be a separate patch.
>
> =C2=A0* builtin-fetch.c: an instance of "non fast-forward" was left
> =C2=A0 unconverted; fix it.
>
> =C2=A0* contrib/hooks/post-receive-email: likewise.
>
> =C2=A0 By the way, in Documentation/git-init.txt there also is anothe=
r "non
> =C2=A0 fast-forward"; since it is not a fix-up to this patch, I left =
it as-is.
> =C2=A0 We may want to change it as well while we are at it.
>
> =C2=A0* git-gui: this is a straight revert of your patch, so that Sha=
wn can
> =C2=A0 apply an undated version of this patch to his tree first, and =
then I
> =C2=A0 can pull the result from him.
>
> =C2=A0 $ git grep -i -n -e 'fast forward' -- git-gui/
>
> =C2=A0 will show what need to be changed. =C2=A0This is a key string =
of "mc", so
> =C2=A0 msgid in *.po files and git-gui.pot file need to consistently =
change,
> =C2=A0 even though the translated strings in *.po files may stay as b=
efore.
>
> If you spot misconversions in here (or other "fast forward" that need=
 to be
> converted but I missed), please holler.

It's fine by me :)

--=20
=46elipe Contreras
