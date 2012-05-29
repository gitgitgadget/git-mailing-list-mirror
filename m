From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Vietnamese l10n pull request problems
Date: Tue, 29 May 2012 12:46:08 +0800
Message-ID: <CANYiYbFBqv_rGZJfiiTd6iNiDtK1cG32nWJS93_kPeKqNi5-dw@mail.gmail.com>
References: <CANYiYbGkHn7NgKgi2SG11fWV7kzuLPH_vhgOrhow17s9JzqBNg@mail.gmail.com>
	<4fc33949.24ef440a.22da.fffff905@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 06:46:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZEKX-0007CH-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 06:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab2E2EqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 00:46:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64683 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2E2EqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 00:46:10 -0400
Received: by yenm10 with SMTP id m10so1753303yen.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n/dKNUoRzUuTFCSM02MMaHLfxYAPSYps99giH+RIs5k=;
        b=TPkiAm28OMJKAR3Y7Gh+DjLujAMb4KH7xxdTV/++slpsuc76iBQXzI9zPZs+XWiosC
         aLbaDyk9hpV46B3oa2xph6EPoVorQxokqC2I+B2pv1z+b+RwCPrZ1nn7HLFbWOyjRcDe
         D9AaR6pG9xSgg3oEJUJ6hbavmVjnGvGde4xdK1S4I8ClWHdRANBeWcrQHh3Ag17oXORw
         aIQmsU/ParAj2W15bvs8YqP1JndBoImEvQoxgwo2qlMIE1Yw6PV/lPCB+O+vNx43hamx
         StXWkYnwqprL+25mps2IUyB8y6fm0uknN1YzNO+0OZ+f6gNN3+fY27ZX36qjAbsxA4WX
         MPWA==
Received: by 10.50.159.202 with SMTP id xe10mr5868404igb.66.1338266768870;
 Mon, 28 May 2012 21:46:08 -0700 (PDT)
Received: by 10.50.82.105 with HTTP; Mon, 28 May 2012 21:46:08 -0700 (PDT)
In-Reply-To: <4fc33949.24ef440a.22da.fffff905@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198730>

2012/5/28 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>:
> done! And also translated some tring.

Your commit log still not quite sane. I update the po-helper.sh script,
which can help you checking your commit log.

1. Checkout po/po-helper.sh script, using:

    $ git remote add git-l10n git://github.com/git-l10n/git-po.git
    $ git fetch git-l10n
    $ git checkout git-l10n/po-helper -- po/po-helper.sh

2. Check your commit with this helper script:

    $ po/po-helper.sh check commits 6f6731e HEAD

3. You will get the following error mesage:

    $ po/po-helper.sh check commits 6f6731e HEAD
    Error: in commit 024e5d89d764edccf76fcf480ac4b2c5d2a2f95d, subject
should not end with a punctuation.
           "Fix conflick in vnwildman/git repository."
    Error: in commit 024e5d89d764edccf76fcf480ac4b2c5d2a2f95d,
multiple lines found in subject.
    Error: in commit 17c1d44fffbb0c4454215015a85791f548900a85, subject
should not end with a punctuation.
           "Continue translate Vietnamese translation."
    Error: in commit dd58f041707cdbdefccca4282c3afaa6c7138cf2, subject
should not end with a punctuation.
           "Init translation for Vietnamese."

4. Currently, this helper script check:

    * Subject line no more than 50 characters.
    * Subject line should not end with a dot (punctuation), this waste
is unnecessary.
    * Insert a blank line between the one line subject and other descri=
ptions.
    * Long descriptions must line wrap at 72 characters.
    * Must add a Signed-off-by line if the commit is not a merge commit=
=2E

This script does not perform grammer check, you should check by yoursel=
f.
Squash the three commit into one maybe a solution. Your commits  are:

$ git log -3
commit 024e5d89d764edccf76fcf480ac4b2c5d2a2f95d
Author: Tran Ngoc Quan <vnwildman@gmail.com>
Date:   Mon May 28 15:29:02 2012 +0700

    Fix conflick in vnwildman/git repository.
    Transtate more 6% into Vietnamese.
    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>

commit 17c1d44fffbb0c4454215015a85791f548900a85
Author: Tran Ngoc Quan <vnwildman@gmail.com>
Date:   Fri May 25 14:32:44 2012 +0700

    Continue translate Vietnamese translation.

    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>

commit dd58f041707cdbdefccca4282c3afaa6c7138cf2
Author: Tran Ngoc Quan <vnwildman@gmail.com>
Date:   Sun May 6 09:42:49 2012 +0700

    Init translation for Vietnamese.

    Signed-off-by: Tran Ngoc Quan <vnwildman@gmail.com>
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>


--=20
Jiang Xin
