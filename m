From: Scott Chacon <schacon@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Tue, 25 Jan 2011 19:42:11 -0800
Message-ID: <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
	<AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
	<20110121222440.GA1837@sigill.intra.peff.net>
	<20110123141417.GA6133@mew.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Montellese <emontellese@gmail.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 04:42:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhwGy-0000dc-GM
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 04:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab1AZDmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 22:42:13 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56560 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab1AZDmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 22:42:12 -0500
Received: by ewy5 with SMTP id 5so3002424ewy.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 19:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PdUGttFVd6zXIiOkNhAFgE25CzLFrHQ18uf0kISKhMU=;
        b=JV5xZzysvtfGwHsm6EMQWAhmcSZ+tNpajAwENRH5GHK4sbXIrRxi4uWRYHe/HS56vl
         LUCJS6WsPXWFMFoYhKgw2EdbUx6iFjFvXAwiOWLejg57BQWXjyFuSMP8CUBnrahryUfH
         hS5ulElhtZs15wR2e02sjMvjaUvB2Fy7h+/d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dm8Dypy1CNbIeKkOay2hQ06Nysw8MBDOccmxIMOyLzKcDhbeU2L43Rth4veU917ApR
         ct8+xHdJQ7WGOsR55tGJ7MiI2q1DXjSoNgE+lSBB/v7QeF+76TsOlm6wTZHW9pjCo1+t
         5boakIwkvVet2B5EezKSNm0NpID25Ox/hlRBE=
Received: by 10.14.37.7 with SMTP id x7mr6951569eea.48.1296013331245; Tue, 25
 Jan 2011 19:42:11 -0800 (PST)
Received: by 10.14.48.77 with HTTP; Tue, 25 Jan 2011 19:42:11 -0800 (PST)
In-Reply-To: <20110123141417.GA6133@mew.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165499>

Hey,

Sorry to come in a bit late to this, but in addition to git-annex, I
wrote something called 'git-media' a long time ago that works in a
similar manner to what you both are discussing.

Much like what peff was talking about, it uses the smudge and clean
filters to automatically redirect content into a .git/media directory
instead of into Git itself while keeping the SHA in Git.  One of the
cool thing is that it can use S3, scp or a local directory to transfer
the big files to and from.

Check it out if interested:

https://github.com/schacon/git-media

On Sun, Jan 23, 2011 at 6:14 AM, Pete Wyckoff <pw@padd.com> wrote:
> peff@peff.net wrote on Fri, 21 Jan 2011 17:24 -0500:
>
> Just a quick aside. =C2=A0Since (a2b665d, 2011-01-05) you can provide
> the filename as an argument to the filter script:
>
> =C2=A0 =C2=A0git config --global filter.huge.clean huge-clean %f
>

This is amazing.  I absolutely did not know you could do this, and it
would make parts of git-media way better if I re-implemented it using
this.  Thanks for pointing this out.

Scott
