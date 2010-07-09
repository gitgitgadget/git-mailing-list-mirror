From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] test-lib: TAP compliance for skipping tests on request
Date: Fri, 9 Jul 2010 19:36:47 +0000
Message-ID: <AANLkTiml1lQlSBDGgUg9scsvsaffDT2n405USmsSIm1n@mail.gmail.com>
References: <97f41d49b6e374d3e66908f3c62844da27312501.1278673984.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 21:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXJNX-00009U-6b
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 21:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab0GITgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 15:36:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37894 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab0GITgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 15:36:49 -0400
Received: by iwn7 with SMTP id 7so2531842iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A83UtJ1ALI0l6D4kyonegTzvGgO6iNNwbOQt5Frc3Zo=;
        b=cLmGkiR+vKLux8VB7TxL24xrvWurbsKT2taEQVRwB7Q/Hn/guxgHblWKkIkMSAC/9R
         k8V+n7CZemFJwwDQwIcAPAjwR7PRod8ofUYt+MxNTPaNcWxzIIQFgDpk6Rh9EBEvbZPo
         Xko2n86ZWFjQQBCJcAdedyID7J9s2qvNCw2qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NhoolnOUVh2yOOHsE81rafYJWcayViPmrxyvxWnKTLKyaqaUcPr9R2xtT09wtB/otu
         BHQ2XGquHzVDdqn9Z3+rNIw4+ClbylXpZiFgWvOiVzEpPVsPNYHcnT2I6lAM9IIqOxYT
         j6wmCoCQfN1ZU1ROPcOODnB9RTqg9AtIu3x5c=
Received: by 10.231.32.129 with SMTP id c1mr10600180ibd.112.1278704207771; 
	Fri, 09 Jul 2010 12:36:47 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 9 Jul 2010 12:36:47 -0700 (PDT)
In-Reply-To: <97f41d49b6e374d3e66908f3c62844da27312501.1278673984.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150684>

On Fri, Jul 9, 2010 at 11:15, Michael J Gruber <git@drmicha.warpmail.ne=
t> wrote:
> Make the output TAP compliant for tests skipped on request (GI_SKIP_T=
ESTS).

That "GI_SKIP_TESTS" has a T-deficit.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> We may want to better spell out the reasons, but I think
> it's good enough like this for *explicitly* skipped tests.
>
> =C2=A0t/test-lib.sh | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8e3de53..2076271 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -395,7 +395,7 @@ test_skip () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$to_skip" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0say_color skip=
 >&3 "skipping test: $@"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say_color skip "ok=
 $test_count: # skip $1"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say_color skip "ok=
 $test_count # SKIP $1"

Good catch with the s/://, but I think the lower-case "skip" should
stay that way. At least that's what Test::More does:

    $ perl -MTest::More=3Dtests,2 -E 'SKIP: { skip "no can do", 1 } pas=
s "can do"'
    1..2
    ok 1 # skip no can do
    ok 2 - can do

It only uses upper-case on skip-all. I.e. when part of the plan line:

    $ perl -MTest::More=3Dskip_all,"this platform sucks" -e1
    1..0 # SKIP this platform sucks

Maybe I've missed something, or Test::More has a bug.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: true
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*)
> @@ -838,7 +838,7 @@ done
> =C2=A0case "$to_skip" in
> =C2=A0t)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0say_color skip >&3 "skipping test $this_te=
st altogether"
> - =C2=A0 =C2=A0 =C2=A0 say_color skip "skip all tests in $this_test"
> + =C2=A0 =C2=A0 =C2=A0 skip_all=3D"skip all tests in $this_test"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_done
> =C2=A0esac

Good catch. I missed that (again) in my "tests: Use skip_all=3D<reason>
to skip tests" patch.
