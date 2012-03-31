From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Purging old history
Date: Sat, 31 Mar 2012 10:13:43 +0530
Message-ID: <CALkWK0=mcQR3CBMpa5P1f+JwqNMqUs3D4=tVPx4c_4R+TXCKbw@mail.gmail.com>
References: <17650-1333167969-40275@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 06:44:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDqAf-00010A-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 06:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab2CaEoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 00:44:07 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41497 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2CaEoG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 00:44:06 -0400
Received: by wgbdr13 with SMTP id dr13so1129871wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 21:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XInccFdG6uUYYZ6rVOs7wJkIB0p+T4smQveSUiaTbEA=;
        b=fo1U+b6KKPNtqVxAj0pvJYHZK7jvJbnaJw54InbQdEC2qJOyQMZagHSYNnvWCYzG5O
         D3QF709bzzLjvh+3Dganm22IHem6bXRipQp6GEHjK/36QikOTwoBE4o2rpPuXrEtr9iT
         oJKDkIWzsGFYVlAeS33eIC0D/9iYYS/b3EuhM3Hbn9lvHpesfb6pquim6JoRZ5ZGS4IG
         TM5argZEMYntZXQ5MwzY3hwyOlv9Y6pNpvCbrglHqlB+Gtw6T9xcZmku/NpexhajalVR
         A6h6o11Wnsodcq0RvaU/WjPC40dWT4dPL1Vh2+bnGntkElTNHXacZHeNve/M5SHcABsh
         i1lg==
Received: by 10.180.102.129 with SMTP id fo1mr3062022wib.6.1333169044008; Fri,
 30 Mar 2012 21:44:04 -0700 (PDT)
Received: by 10.216.11.199 with HTTP; Fri, 30 Mar 2012 21:43:43 -0700 (PDT)
In-Reply-To: <17650-1333167969-40275@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194432>

Hi John,

John M. Dlugosz wrote:
> Is there a simple way to delete old commits, say beyond a certain age=
,
> before putting it on the server? =C2=A0The ancient stuff is not relev=
ant and
> there are a lot of binaries. =C2=A0Some users may have trouble with a=
n extensive
> download when syncing the first time.

Yes, although your terminology is wrong: it's not about "deleting"
commits; simply create a fresh root commit and rebase your work on top
of it.  As an example, let's say you want to squash history from the
67afe1 (the old root) to 7ef42b on the master branch:

$ git checkout -b newroot 7ef42b
$ git reset 67afe1
$ git add .
$ git commit --amend
$ git checkout master
$ git rebase --onto newroot 7ef42b

    Ram
