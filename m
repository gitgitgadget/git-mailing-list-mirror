From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 1/5] test-lib: Adjust output to be valid TAP format
Date: Thu, 24 Jun 2010 11:39:31 -0700 (PDT)
Message-ID: <m3mxuknumn.fsf@localhost.localdomain>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
	<1277401489-27885-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORrM8-0005xc-1f
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab0FXSjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 14:39:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52398 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0FXSje convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 14:39:34 -0400
Received: by fxm3 with SMTP id 3so558132fxm.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=6yYaztKjFdSJqAPM1J3ajV03rOrnjWyzDx9rvYRWSHA=;
        b=WeR2fqbSTACQc0kZgyP1ZXBysF5Su3qeWAuPTwCHwQwbc1r2IArHQSGRqX0LRMENfO
         VrIkA7Kfk3Neh+jaAK/iO7juL70ycOjvEcKpozBcn61Erdv2UITc9/Vx4U+RAlDF5C8E
         5Aw5TfqIqiTG2fMSqXTSpRlBrRauZz5/1OLYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=utuxfxiTOM9XFsAe0Z1hHFVPBi7RDh5/jBEsipafgiAfPL2MKHYYYTUIlzQeC3/EUd
         ZpY8lNx5xOSXoRCtKF5mu6+u2fygUALsRWovVKnwgvBqgavnDMveXwVAuV3Xb45tdG+I
         NHcBZF4YYyLBCSLcNCg6teOSPmD6UUpu58eZQ=
Received: by 10.223.50.193 with SMTP id a1mr9926912fag.34.1277404772739;
        Thu, 24 Jun 2010 11:39:32 -0700 (PDT)
Received: from localhost.localdomain (abvz51.neoplus.adsl.tpnet.pl [83.8.223.51])
        by mx.google.com with ESMTPS id 1sm967233fax.2.2010.06.24.11.39.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 11:39:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5OIcxLM008345;
	Thu, 24 Jun 2010 20:39:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5OIcfpD008329;
	Thu, 24 Jun 2010 20:38:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1277401489-27885-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149618>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> TAP, the Test Anything Protocol, is a simple text-based interface
> between testing modules in a test harness. test-lib.sh's output was
> already very close to being valid TAP. This change brings it all the
> way there. Before:
>=20
>    $ ./t0005-signals.sh
>    *   ok 1: sigchain works
>    * passed all 1 test(s)
>=20
> And after:
>=20
>    $ ./t0005-signals.sh
>    ok 1 - sigchain works
>    # passed all 1 test(s)
>    1..1

This is incomplete information.  It only tells us how the output is
changed for the case when all test_expect_success tests passes.  This
commit message doesn't tell us how failing tests looks like, and how
test_expect_failure results gets translated.

Take for example a following test script:
-- >8 --
#!/bin/sh

test_description=3D'this is a sample test.

This test is here to see various test outputs.'

=2E ./test-lib.sh

say 'diagnostic message'

test_expect_success 'true  test' 'true'
test_expect_success 'false test' 'false'

test_expect_failure 'true  test (todo)' 'true'
test_expect_failure 'false test (todo)' 'false'

test_debug 'echo "debug message"'

test_done
-- 8< --

This test script output looks like the following (the comments are not
part of output, but denote color of given line of test output):
----
* diagnostic message                      # yellow
*   ok 1: true  test
* FAIL 2: false test                      # bold red
        false
*   FIXED 3: true  test (todo)
*   still broken 4: false test (todo)     # bold green
* fixed 1 known breakage(s)               # green
* still have 1 known breakage(s)          # bold red
* failed 1 among remaining 3 test(s)      # bold red
----

How would the output of this test look like after TAP-ification?
Would it still provide color output when run on terminal?

This test also generates summary of test run in a file in
test-results/ subdirectory.  Currently such file can be e.g. named
test-results/test_test-8030, and consist of
-- >8 --
total 4
success 1
fixed 1
broken 1
failed 1

-- 8< --

Would TAP-ification change that?  Even if there is no change, this is
worth a sentence or a few words in a commit message.

P.S. With current output pass / fail results of test_expect_failure
are justified on ':' separator.  This is not the case of TAP output.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
