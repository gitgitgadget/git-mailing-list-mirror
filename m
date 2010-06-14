From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Mon, 14 Jun 2010 14:49:35 -0700 (PDT)
Message-ID: <m3631lp9oe.fsf@localhost.localdomain>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 23:49:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOHXN-00036k-J1
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 23:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab0FNVti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 17:49:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35459 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0FNVth convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 17:49:37 -0400
Received: by fxm8 with SMTP id 8so2817407fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=/g5nYmgZE9so/LAwrUBVCHOGIZuBtTsKLowaVloYScA=;
        b=U7j2xHuLDHelrtCKts80igX8BcZXEzEfTc4FsTN/nbQZywm41ui0xRwWF4ywyUpTEl
         yp/seu9zx2aBJRqA+d0nXikoiQKxhJk7Q102lRrrxZkVUQuveBrDqe5r5j96AA2aVPYT
         o1IKT/m5bqWeHLRpRXB6Q3LWCHjvoJ4DPjjec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Zefr4p96iPF87M4xHEFaxokiZaNKGLwD0n6jxsWC15hCtsuymPvrt0CH0hMtXaDhKe
         GhLP5QEY2dODzXrj09udS5MtsRyhYBl6o/FupEv6E/JOGmE3i1skF6g3248qYsAxjnbv
         PJlYgMf5a7Y/yhFHbhRyBdfbdSeKz1AumY9so=
Received: by 10.223.20.216 with SMTP id g24mr6105965fab.63.1276552176069;
        Mon, 14 Jun 2010 14:49:36 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id j23sm13718549faa.2.2010.06.14.14.49.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 14:49:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5ELn679027879;
	Mon, 14 Jun 2010 23:49:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5ELmo0J027863;
	Mon, 14 Jun 2010 23:48:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1276096943-32671-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149138>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> All this series does is slightly adjust the raw text output of our
> tests so that it conforms. to the TAP standard, i.e. instead of this:
>=20
>    $ ./t0005-signals.sh
>    *   ok 1: sigchain works
>    * passed all 1 test(s)
>=20
> We get this:
>=20
>    $ ./t0005-signals.sh
>    ok 1 - sigchain works
>    # passed all 1 test(s)
>    1..1
>=20
> Changing the output format like this gives us the ability to run the
> Git tests with any TAP tool (like prove(1)) at no extra cost. Every
> other existing way of running the tests continues to work, it's just
> easier for machines to read the output now.

This doesn't tell us if the result of running test suite with
'--verbose' and/or with '--debug' changes, and if changes how?  Is it
compatibile with TAP format so that TAP parsers understand it?

It doesn't tell us if (as I assume) after change git test suite still
generates summary of tests in t/test-results/.  Do those results
change, and if change then how?

It doesn't tell us if (as I assume) we still have the same color
output as we had before, and what we should do to have the same color
output e.g. from TAP tests in Perl.


+1

In my opinion it is a good change, because there are many tools that
understand TAP output format (and being able to output tests in Perl
via standard Test::Simple / Test::More is also nice).  Those include
e.g. Smolder and prove(1).

It would be nice to have something like CPAN Testers
(http://cpantesters.org) but for git test suite.  Junio would be able
to submit new version of git and check if it breaks on some uncommon
architecture...


P.S. I wonder who was original designer of git tests output format,
ans why it was chosen this way (and e.g. why not TAP)...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
