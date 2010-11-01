From: Olivier Verdier <zelbier@gmail.com>
Subject: git stash and manually edited chunks
Date: Mon, 1 Nov 2010 08:27:04 +0100
Message-ID: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 08:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCond-0005Vb-5f
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 08:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab0KAH1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 03:27:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50755 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab0KAH1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 03:27:06 -0400
Received: by wwe15 with SMTP id 15so5717119wwe.1
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=S2FP0CXsSOwB2uPOumaEtPj15UgGVfc35i3xlZJOqco=;
        b=OvhnOZaRsOZlmu8CeqkqbUAgFCVirBhdKj8ZuDRE//bu+O0kRmktnaQIfslpcJhDXl
         gJSm4b7qYHl10Be9HGhqFVh8bEcufxiPptdgC7sPjaaF7fpox4RTpkZLtvxKc1irucK6
         bR5BHIhQcZp9kmwRCahi6e6i27p2sQDlcgZ+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=l8HVhpHcZFpZyTh2VObnuwAQQwQutFhcglY/xkSKTQyEKWz2WkOWlkmqNU+W43sCRO
         3/cVPBcwr/cWBZa6Ju7WrgrI5/moOIPe9WsL+G3lQwqNBHlRY2qRPSo31O41WeeYZw8o
         4Ih4q94OXEypjGP9XU8BpWpc/P3czUZpm3Jmc=
Received: by 10.227.133.132 with SMTP id f4mr11484984wbt.60.1288596424570;
 Mon, 01 Nov 2010 00:27:04 -0700 (PDT)
Received: by 10.227.157.197 with HTTP; Mon, 1 Nov 2010 00:27:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160467>

Hi!
I asked a question on stackoverflow
(http://stackoverflow.com/questions/4058372/git-stash-and-edited-chunks=
)
and someone suggested it might be a bug...
=46or convenience, I reproduce the question here:

=C2=A0I occasionally have the following problem, which is reproduced by=
 the
following sequence of commands:

* git add -p my_file
* I=C2=A0edit a chunk *manually*=C2=A0(using=C2=A0e)
* git stash --keep-index
* git stash pop

Now the problem occurs: the file=C2=A0my_file=C2=A0is now considered as
conflicted, and git has completely messed with my edited chunk, so I
have to edit the file, remove the merge marks, and run=C2=A0git add my_=
file
followed by=C2=A0git reset HEAD

I'm puzzled because this happens only when editing a chunk manually. I
don't see how this should make any difference at all.

I'm using version 1.7.3.1 on Mac OS X.

Thanks!!
