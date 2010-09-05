From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the object store
Date: Sun, 5 Sep 2010 01:28:11 -0500
Message-ID: <AANLkTimqMJ1vHaJL65RZ4PuxONtg1evn4vBdPks_odqq@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino> <20100905060854.GA15511@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:28:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os8id-0001gz-4k
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab0IEG2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:28:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50671 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab0IEG2c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 02:28:32 -0400
Received: by gyd8 with SMTP id 8so1322530gyd.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xEzQuqkZ0QhXxLNTWuykBQJppmyvG2oH/xRY/GHyrOw=;
        b=uyffp1P5GYqMkHmEX1gH+UWQwfMf/PPjJXbxFd6OVO7DHdMXRim+B30jxcdCSW4Y7C
         3uzl8z3V8XW0n/uWMioLUK/C9PWb032v0z6RiDS19M75kIOowt4RkuNtpc86GGb2x8Yo
         x0q1cxf4O2ZKV+O1zfRT63HgNxWigy2fYvlds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=clEtVG+9GmEA6k0PyTIaCnLtaI+auA96zBrMLOurcHI0tFzWtoQNsZYEJGaR0ErSK1
         3be23Na6aDncrqvtWitQyGy13PEkoHCwqHlHbDxHTuRR4nqIsNXZH55mwvh/faPdzFbE
         9x61U6mQUiBXezxmMMUaGM2L7OEZPHl/hlaXs=
Received: by 10.150.182.8 with SMTP id e8mr146026ybf.424.1283668111257; Sat,
 04 Sep 2010 23:28:31 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Sat, 4 Sep 2010 23:28:11 -0700 (PDT)
In-Reply-To: <20100905060854.GA15511@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155425>

Heya,

On Sun, Sep 5, 2010 at 01:08, Ramkumar Ramachandra <artagnon@gmail.com>=
 wrote:
>> Another possible concern is that this is very much git specific.
>> Other fast-import backends are just not going to be able to do
>> it with the same format. =C2=A0Is there a convention for naming
>> options like that?
>
> Why is this a concern? We aren't even breaking backward
> compatibility. This bidi interface should only be used by SVN-like
> frontends.

I don't agree, imagine implementing hg-remote-svn (or the conceptual
equivalent at least), it would require the same functionality, yes?
You need to retrieve something from fast-import that you previously
gave it.

> We'll get ideas to improve this as svn-fe gets built up. On a related
> note, we should probably extend the git-remote-testgit helper to use
> this feature in future to facilitate writing unittests.

Hmmm, that would be somewhat difficult I suspect, the reason
git-remote-testgit was so easy to write is because git-fast-export and
git-fast-import do exactly what I wanted to test. You'd have to teach
munge the fast-export stream even more to insert this feature somehow,
I suspect that'll be a non-trivial feat. Of course, you will need to
test it somehow, I suspect that Jonathan's current approach (using
hardcoded streams) might be the easiest.

--=20
Cheers,

Sverre Rabbelier
