From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/6] Make test-lib.sh emit valid TAP format
Date: Fri, 07 May 2010 13:17:49 -0700 (PDT)
Message-ID: <m37hnffow2.fsf@localhost.localdomain>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:17:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATzi-00032l-Lh
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990Ab0EGURx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:17:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37626 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab0EGURw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:17:52 -0400
Received: by fxm10 with SMTP id 10so1065031fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=4LuDH1f7hIZYTqQ0D2/T7FDZgea2tykrTkzZowjQX1I=;
        b=hZa4xRJfL58hMZ1wTB0dNRXMZhxevU4QDNUyop7QbvUS3dVn+/wCR8Lxm1mTZoG1Kl
         ukwzhIGgpuqVBp6Dxuz3x3urpao49DlnbPZQYOhJhNBsNOXdr64MUallECu79BgfihIa
         //OvQ7alRNuaEUSWSIWLVmhYXmuqhUvfzaZtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=iJU/Iu1/5dNeAXcNfiLh7etQ1oaygGABo+34nSRb6Y8xmuLE9tdNKIVGpUOcdKFML8
         QRKvTC8LHbFj3ZY3rKUht41J5eZGIQe8LjfbY2ZF7OpZTHq88TX+bLnJ84zpBE2FiHMh
         E+SYS82eQfG73rAaRlCaLE5wb5K6FYXsNPn/4=
Received: by 10.223.161.211 with SMTP id s19mr606127fax.47.1273263470696;
        Fri, 07 May 2010 13:17:50 -0700 (PDT)
Received: from localhost.localdomain (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id g10sm8131248fai.0.2010.05.07.13.17.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:17:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o47KHMZR012520;
	Fri, 7 May 2010 22:17:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o47KH2Yu012516;
	Fri, 7 May 2010 22:17:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1273261025-31523-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146582>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> TAP, the the Test Anything Protocol, is a simple text-based interface
> between testing modules in a test harness. test-lib.sh's output was
> already very close to being valid TAP. This change brings it all the
> way there.
>=20
> The advantage of using TAP is that any program that reads the format
> (a "test harness") can run the tests. The most popular of these is th=
e
> prove(1) utility that comes with Perl. It can run tests in parallel,
> display colored output, format the output to console, file, HTML etc.=
,
> and much more.
>=20
> On my quad Xeon server running the test suite with `make test` takes
> 21 minutes. Running it with `prove -j 15 ./t[0-9]*.sh` takes just ove=
r
> 5 minutes.
>=20
> With parallel tests the whole test suite doesn't have to stall becaus=
e
> tests like t3404-rebase-interactive.sh take a long time.

I would have thought that it would be better for git test suite to
enable TAP output with --tap switch.  On the other hand changing
output to TAP, replacing old format, would be less code to maintain.


I am not sure if testing with 'prove' and TAP output is compatibile
with all current git test suite options, i.e. --debug, --tee,
--verbose and --immediate, and with GIT_SKIP_TESTS environmental
variable.  Also valuable way of checking where the error occurs in the
test, namely 'sh -x ./tXXXX-test.sh' would not work, I think, with
'prove'.

Note also that having Perl (and 'prove') installed is not requirement
for git runnig, and I think it should not be requirement for git
development.


P.S. I think that such series would be better with the cover letter.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
