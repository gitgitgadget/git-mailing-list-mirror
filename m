From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] setup: update the right file in multiple checkouts
Date: Mon, 31 Aug 2015 17:29:05 +0700
Message-ID: <CACsJy8AegVLNkQ9fnxXeLKdh0PaU2EKAU2ti2G7qutdtAu-xag@mail.gmail.com>
References: <CACsJy8A2sUEcaY2JryTHj3hvES-VDJt_eMgogP5WjVA3FiXDsg@mail.gmail.com>
 <1440498646-25663-1-git-send-email-pclouds@gmail.com> <xmqqlhcz1fy8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWMLM-00073g-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbbHaK3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 06:29:36 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34083 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbHaK3f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2015 06:29:35 -0400
Received: by igui7 with SMTP id i7so53007020igu.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EUnZERc+mSPIZHkWSB9MZyAEAt24MMjUk/nntr1TcH8=;
        b=n5evJbedLyvlu/N964IRsASM5o0W7Nng0l7Xbeig4iWpDup3a+KcjzUKb+bz2zMdcJ
         oPBHW3nGb2ThUtwQ15Br0A9Ciy1aZackZnpgD5JxZisG4kfIQ7pqT+7RH9Y+42gMdAn+
         igCgfqQvaHgxdjht+PZ83PQ1Qn+asmX0qXfLEjOU2nrs6qScltlN4zu8ZJUiS00P0DY+
         xUN59JWvVO2bNvu3PEinK9gyWy1+ZTOFo3OQPT33l17f9RZQ/EvlLjeWfOwCth1PZQVq
         5sFHLjg3CAgnw2xzA3DregsQQYtqvHlZqFlkSyG46SKCNQiTU828E4ph2p4B5aYuMw3K
         OjuA==
X-Received: by 10.50.59.211 with SMTP id b19mr12914088igr.42.1441016975288;
 Mon, 31 Aug 2015 03:29:35 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:29:05 -0700 (PDT)
In-Reply-To: <xmqqlhcz1fy8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276871>

On Tue, Aug 25, 2015 at 11:38 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This code is introduced in 23af91d (prune: strategies for linked
>> checkouts - 2014-11-30), and it's supposed to implement this rule fr=
om
>> that commit's message:
>>
>>  - linked checkouts are supposed to keep its location in $R/gitdir u=
p
>>    to date. The use case is auto fixup after a manual checkout move.
>>
>> Note the name, "$R/gitdir", not "$R/gitfile". Correct the path to be
>> updated accordingly.
>>
>> While at there, make sure I/O errors are not silently dropped.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  The code was right in v2 [1] and became "gitfile" since v3 [2]. I
>>  need to reconsider my code quality after this :(
>
> Heh, don't sweat it.  Everybody makes mistakes and sometimes becomes
> sloppy.
>
> Thanks for double checking and correcting.  Perhaps this could have
> caught if we had some test coverage, I wonder?

There's tests to check this prune functionality. They just don't
exercise this function. Instead they manipulate "gitdir" file
directly. I'll add a test to move repo around to make sure this code
is exercised in the test suite.
--=20
Duy
