From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 07/16] t3600 (rm): add lots of missing &&
Date: Fri, 24 Sep 2010 22:58:32 +0000
Message-ID: <AANLkTinqEfUukP_R=vwN+JvqNqB+NQMeLCv_4wONnX3h@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:58:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzHED-0003W1-N9
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403Ab0IXW6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 18:58:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab0IXW6d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 18:58:33 -0400
Received: by iwn5 with SMTP id 5so2744417iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A3Em0zqTBc/yr0h1e+LcfgkyUZZ1Yo2wS/PJYZEwtFc=;
        b=KSCQQN1dine+dybT/XHqd5RNk2rG7QLBXBa5Z2YtZWY2lhLUOVDDx2QjpgahfVGzYC
         75sfv3ECGSV492Yqa9UC0Dd5lJ8yKOvvTiseLYWl9Yo+jl3Hxi+GQbZSG5fKb8f5GdqR
         1EDBP99UMvtsbQ8a9ZSO8zbW94x2T6Dua6d6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eoJpftdQPjjY05mm/WlavCuRnN4NwKy387oVbNJhA2SVGToHK3AbgaQazWUY+wJ9OO
         JJmlbN594C3p9c0GdwLAThaCMV5KemGv9qPC+SieYd2sUGpc2caMG2rhrHuYHGlQWJVA
         lyZco8wlixvs1okhwo9AtHZJEwtTLUaxU3nSA=
Received: by 10.231.184.71 with SMTP id cj7mr4493055ibb.159.1285369112680;
 Fri, 24 Sep 2010 15:58:32 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:58:32 -0700 (PDT)
In-Reply-To: <1285366976-22216-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157097>

On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wrote:
> FIXME: I had to modify a few of the tests to make them pass again. =C2=
=A0Are my
> modifications okay? =C2=A0Would a different method be preferred?

> =C2=A0test_expect_success \
> =C2=A0 =C2=A0 'Test that git rm --cached foo succeeds if the index ma=
tches the file' \
> - =C2=A0 =C2=A0'echo content > foo
> - =C2=A0 =C2=A0 git add foo
> - =C2=A0 =C2=A0 git commit -m foo
> - =C2=A0 =C2=A0 echo "other content" > foo
> + =C2=A0 =C2=A0'echo content > foo &&
> + =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 git commit -m foo &&
> + =C2=A0 =C2=A0 echo "other content" > foo &&
> =C2=A0 =C2=A0 =C2=A0git rm --cached foo'
>
> =C2=A0test_expect_success \
> =C2=A0 =C2=A0 'Test that git rm --cached foo fails if the index match=
es neither the file nor HEAD' '
> - =C2=A0 =C2=A0 echo content > foo
> - =C2=A0 =C2=A0 git add foo
> - =C2=A0 =C2=A0 git commit -m foo
> - =C2=A0 =C2=A0 echo "other content" > foo
> - =C2=A0 =C2=A0 git add foo
> - =C2=A0 =C2=A0 echo "yet another content" > foo
> + =C2=A0 =C2=A0 git checkout HEAD -- foo &&
> + =C2=A0 =C2=A0 echo "other content" > foo &&
> + =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 echo "yet another content" > foo &&
> =C2=A0 =C2=A0 =C2=A0test_must_fail git rm --cached foo
> =C2=A0'

Shouldn't that be:

    test_when_finished "git checkout HEAD -- foo" &&
    git rm --cached foo

In the above test? Then you don't have to clean up after someone
else's mess, and the tests are more self-contained.
