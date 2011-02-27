From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/3] mergetool--lib: Add the proper executable name for ECMerge
Date: Sun, 27 Feb 2011 11:37:39 +0100
Message-ID: <AANLkTi=CuyNLNuuootcd8_H9Zh=WqAwiS+S6PJjPAfcw@mail.gmail.com>
References: <4D68DAC4.9060100@gmail.com>
	<4D68DBB0.2020909@gmail.com>
	<4D69E628.5040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, charles@hashpling.org,
	Junio C Hamano <gitster@pobox.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 11:37:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pte0h-00083D-LB
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 11:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab1B0Khl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 05:37:41 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65056 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1B0Khk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 05:37:40 -0500
Received: by qwd7 with SMTP id 7so2203205qwd.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 02:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h4KhF4wx/GWafl4iFb20bBFkK0pt5DDput0QKwZJ+zE=;
        b=AICtMqGfs1WVRb634fQc4E2UDmK77tPtJ2gWY6alsjV8SOpsqqGyFoI99qKgH4Yz84
         hmKLXD+lV1oTV4f7NthY43S2qgTVM68dAfoy+usZILXMMjZADmbZrqdh/Oc0Ddh9/Ntr
         KBxdMeKgewOlkb1g0GS4rCD7VPIOZ88NedvmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VD+rTiq4hB7RD7ydPdapBjWyqayD6YAVlLZgJyqmv+zRVN+4wPin7uAn+Kn6zmFbmX
         WIgnkDbXpB7qMkdVPyoLJsnQw1uq+6rMSsslL+utZqMsFeQXHwRpX83y4NoZGAiUv2Zf
         aIse2FX8hKnp3CbCMs9aq877OiqpxchWBbYBs=
Received: by 10.229.185.210 with SMTP id cp18mr3128199qcb.187.1298803059718;
 Sun, 27 Feb 2011 02:37:39 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 02:37:39 -0800 (PST)
In-Reply-To: <4D69E628.5040007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168020>

On Sun, Feb 27, 2011 at 06:50, Chris Packham <judge.packham@gmail.com> =
wrote:

>> + =C2=A0 =C2=A0 ecmerge)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo guimerge
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 emerge)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo emacs
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>
> I think this is another case of linux/windows versions of the
> application having different executable names.
>
> chrisp@laptop:~> tar -tf Download/ecmerge-2.3.123.linux.x86.tbz
> /usr/local/bin/ecmerge
> /opt/elliecomputing/ecmerge/guimerge
> /opt/elliecomputing/ecmerge/guimerge.exe

Indeed, well except that Linux has both "ecmerge" and "guimerge",
whereas Windows only has "guimerge", which is why I went with the
latter. Giving it a second thought, my patch is a little inconvenient
for Linux users, as it will stop making ecmerge work out of the box
(without first setting mergetool.ecmerge.path), whereas Windows users
need to set mergetool.ecmerge.path anyway.

I've also contacted the makers of ECMerge and asked them to unify the
naming across platforms. Maybe we should just drop this patch until
they did.

Chris, what do you think?

--=20
Sebastian Schuberth
