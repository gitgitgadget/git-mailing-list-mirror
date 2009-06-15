From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Mon, 15 Jun 2009 22:25:02 +0100
Message-ID: <e5bfff550906151425p2dacdcdasbae09af4ce34813d@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
	 <200906131333.57725.markus.heidelberg@web.de>
	 <200906152313.20002.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jun 15 23:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJgH-0006lM-GS
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935420AbZFOVZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760400AbZFOVZF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:25:05 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:39812 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935154AbZFOVZB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 17:25:01 -0400
Received: by ewy6 with SMTP id 6so5399590ewy.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jCZmeM/Qbp02KdjoYqCVIsa+Y3xfAeGRVIJ9OIPPMu0=;
        b=m0fWrfe/Vr6X/pUNDSkyQpvs9JpZhUedPq56LdVYrkbMaLykd9JUsnMZNSPQjG7r4I
         5Mq1L0n5nrSJFsKGxjyDlOlkXk4qB0C7mQf1z2Xth4nhqP5FzO6K5aN9GtuozZRZ+Cak
         TvX6g3w8ieMzsp7Yz1P6nyfX0QIga/bSMuN1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MCOgO+J8myObx9V77NpIY2Uww3kyuN3Zto4SCpK44ogDvFvrGFKonOj9mdfJPSGzgY
         YvDKByXEJLjfehuajZpvU3zgJwZEy4P956jQci6LfAeleBRXoKyKy5yRsaqZmvO2xJVP
         OggWme9xnlNDmlW4TVrAjWh2WkuCAd++3sDHg=
Received: by 10.216.26.70 with SMTP id b48mr2522667wea.141.1245101102882; Mon, 
	15 Jun 2009 14:25:02 -0700 (PDT)
In-Reply-To: <200906152313.20002.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121626>

On Mon, Jun 15, 2009 at 22:13, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
> Markus Heidelberg, 13.06.2009:
>>
>> I tested with the latest qgit.git and with QGit 2.2 from my
>> distribution. All on Gentoo Linux.
>>
>> I just built QGit 2.3, this has the same problems.
>>
>> [...]
>>
>> I will try to reproduce on Windows, probably after this weekend.
>
> Some news, tested with the 4 commits in git.git around v1.6.3 as befo=
re:
>
> It works correctly with QGit-2.3 installed from the Windows installer
> (http://sourceforge.net/projects/qgit).
>
> It works reversed when using a self-compiled qgit.
> gcc: mingw-gcc 3.4.5
> Qt: 4.4.1
>
> Reversed means, git-format-patch is invoked like this:
> =C2=A0 =C2=A0git format-patch v1.6.3..v1.6.3~3^
> and doesn't produce patch files, instead of:
> =C2=A0 =C2=A0git format-patch v1.6.3~3^..v1.6.3
>
> The strange behaviour of getting only 2 patches on Linux, I couldn't
> reproduce on Windows.
>
> You use MSVC, don't you? Can you please try with mingw? It would be
> really helpful, if you could reproduce it.
>
> Markus
>
>

This is really strange !

Yes I use MSVC, I cannot try mingw-gcc because I should recompile all
Qt with gcc.

But I can test on Linux tomorrow evening and see what's happens
there...but there is _nothing_ in the code that is platform dependent,
see Git::formatPatch() in git.cpp
