From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 16:06:15 +0200
Message-ID: <EE0A3DAA-DFE8-4F70-B321-0B1CA63B1341@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain>  <4CBFFD79.1010808@alum.mit.edu> <1287660007.24161.10.camel@drew-northup.unet.maine.edu> <968F09BD-2B2D-44C4-9C0F-BF7BD20041F0@gmail.com> <1287665760.24161.33.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8vmk-0007CA-RR
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321Ab0JUOGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 10:06:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59767 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab0JUOGV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 10:06:21 -0400
Received: by ewy7 with SMTP id 7so119922ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=BAlVGdxw1qOGAD1zDnWOquQ/pUJEO0cwB+hWOsZR0dE=;
        b=xCjJB941sOOAyo+RBk+HqM8/siZ5/0U3oRjdqY0oe20H2I/G14Hkv4oKtzd6/cahId
         GPVZBLdWCZGUzB6iu6demqNzw7hwVEKHq1BL3OCWfJaEnjCOKcMSf/QlHBEkBz0EEMPu
         22XRYhgoCH8dVk/TTTyiMotm0V1Py0yR2zIw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=bSvPVFNv+BOPofv91rt/OaNnLnJ33v1LvizZg/fLGnryM/4VVq2w3u4xbr03pCnNJw
         mgTL/dpq3u+2YJzb6yZyQlB2y6YKaz17aJL0GhLj9+L0IC8y2hBfROhbyAGcGzlpHqBS
         EAZoltT3jOfM0jdKCneSh2A2/zdJ8wlN+iY8E=
Received: by 10.213.2.200 with SMTP id 8mr1706233ebk.73.1287669980206;
        Thu, 21 Oct 2010 07:06:20 -0700 (PDT)
Received: from thoremba.cs.lth.se (thoremba.cs.lth.se [130.235.16.114])
        by mx.google.com with ESMTPS id b52sm1823492eei.7.2010.10.21.07.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 07:06:19 -0700 (PDT)
In-Reply-To: <1287665760.24161.33.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159507>

On 21 Oct 2010, at 14:56, Drew Northup wrote:

> That's not what I asked.
> [... good, concrete example omitted...]
>=20
> $ vim A.txt
> $ git stage A.txt
> $ git commit
> $ vim C.txt
> $ vim A.txt
> $ git stage A.txt
> $ git stage C.txt
>=20
> Should the last two commands fail?

No, not for me. (Is this in reaction to Jakub=92s suggestion that an =93=
untracked file=94, like C.txt, cannot be staged before explicitly track=
ed?)

Maybe this is what should happen:

$ git stage C.txt
git stage: Contents of previously untracked file C.txt staged for next =
commit

> Now, if "git stage" were an outright replacement for "git add"
> there might be more use (but I'd still not be happy about the corrupt=
ion
> of the idiom).

I tend to agree. But look at, e.g., Figure 2.1 in the Pro Git book http=
://progit.org/book/ch2-2.html . That view strongly enforces that someth=
ing special happens to the new =93pink=94 file, different from what hap=
pens to a =93yellow=94 file. After this helpful discussion, I don=92t l=
ike figure 2.1 so much anymore. A red arrow should go from =93pink=94 t=
o =93blue=94 with text =93stage the file=94.