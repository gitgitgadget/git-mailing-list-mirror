From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Test failures in pu: 4046, 950[012]
Date: Fri, 5 Nov 2010 09:20:04 +0700
Message-ID: <AANLkTinZJFb_sAH6AGD+ZMwj5boERAU3-NDkA3ve1+=F@mail.gmail.com>
References: <201010201148.51551.trast@student.ethz.ch> <7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
 <201010201856.54756.trast@student.ethz.ch> <201011042237.01801.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Nov 05 03:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEBur-0004Y9-LJ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 03:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0KECU2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 22:20:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57889 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab0KECU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 22:20:27 -0400
Received: by wyb36 with SMTP id 36so619678wyb.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LRKoJgz3tp/KsR4vWenb9Eeh2req2gWAmHZHEqjtLkg=;
        b=l5ZaOoQfXmMmAZR5cl0i5OxdvBQOFGjBRPn9N4MlyaTx0K168GaVmefzm2ZHkPCNZA
         JlTfStJif0/bU5tm6FLvbN3nXPZuqtsc1LRiony8kEXf57dds5mma9Dkqw0De7pDTZJt
         4ZvS6vYghEyMaZefsXMlz6/1vrOUY59DaDv1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rJpIhZAeREtfbTB0P3Zc0p5OZ1BKBhdBKbwHot1ILUibFMl/0hz0HOg5guH5M1RKsd
         jOugwaKrAAJRbvXEZu2omLrA+AbAjiamRhTNLfjHVNrOicsUBoRysvJs5tuMDrV2Cc8P
         ueDJImPLOJ+JlRsfWLcU/CCLoAKD8Aw07Ga9w=
Received: by 10.216.47.19 with SMTP id s19mr587255web.56.1288923625939; Thu,
 04 Nov 2010 19:20:25 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Thu, 4 Nov 2010 19:20:04 -0700 (PDT)
In-Reply-To: <201011042237.01801.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160798>

2010/11/5 Thomas Rast <trast@student.ethz.ch>:
> * 950[012]: these are very strange.
>
> Running them interactively appears to work ok, so maybe it is some
> environment bug. =C2=A0They appear to be "can't happen" style failure=
s

Can you rerun it with GIT_TRACE=3D"$TRASH_DIRECTORY/trace" set on the
failed tests?

> though, since they all look like (this one is from 9502)
>
> =C2=A0Initialized empty Git repository in /local/home/trast/git/t/tra=
sh directory.t9502-gitweb-standalone-parse-output/.git/
> =C2=A0expecting success:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit first foo &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git branch xx/test &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FULL_ID=3D$(git rev-parse --verify =
HEAD) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SHORT_ID=3D$(git rev-parse --verify=
 --short=3D7 HEAD)
>
> =C2=A0fatal: This operation must be run in a work tree
> =C2=A0not ok - 1 setup

This test is OK for me, although the next ones fail (pu db22585). How
do I debug gitweb.perl? t9502.2 shows

=46ULL_ID  =3D 1005c80cc11c531d327b12195027cbbb4ff9e3cb
SHORT_ID =3D 1005c80
expecting success:
        gitweb_run "p=3D.git;a=3Dsnapshot;h=3D$FULL_ID;sf=3Dtar" &&
        check_snapshot ".git-$SHORT_ID"

basename=3D.git-1005c80
tar: This does not look like a tar archive
tar: Exiting with failure status due to previous errors
not ok - 2 snapshot: full sha1

Not very helpful.

On t9500.1, I get

[Fri Nov  5 02:09:15 2010] gitweb.perl: Undefined subroutine
&main::cache_fetch called at
/home/pclouds/w/git/t/../gitweb/gitweb.perl line 1124.

Setting PERLLIB makes it work, but shouldn't the test script have done
that already?
--=20
Duy
