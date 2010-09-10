From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t4018: avoid two unnecessary sub-shell invocations
Date: Fri, 10 Sep 2010 17:25:56 +0000
Message-ID: <AANLkTindP1KiyFjF+7EVhKDciBr-g_cg3jfHCRB0Qfxo@mail.gmail.com>
References: <20100909195904.GE1146@sigill.intra.peff.net>
	<rl_Fe3GvwRHMfzdMCqwnBhdCJhaaE21fdWY64ux0ATvXGt5hFA80h-4iMktgWtjAQ_54uD09KJc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 10 19:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou7Mc-0005e0-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 19:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab0IJRZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 13:25:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60908 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab0IJRZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 13:25:57 -0400
Received: by iwn5 with SMTP id 5so2384546iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pVlh49Q80x/kUz3xQ13nEIhSrknC5cy3QCzPF9yQvMY=;
        b=ov4D84jH6Oe2PYeL8UlcSzTot2r7fkANX3Qo8c9V769I3pElJIXaWM5eEmdwjNVvdO
         x/10kvl8pcnx4mROjuSxSPg0V+Q39Cmx/B+PXgny+ha3drcCfFwXuSbwdjPjl/XnySpd
         6t/OE7peJzzxsxsoNFvbAYC9bIVw9fR8TFXgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rYOVmzIG4dEpuaTP4ogVZE7l47t3nlQ7+XoFwfFGE5AD/qSGr7oHoBM1hte6eejxDJ
         KZmqNTFNmF5+IasfSqLCYcPXEgciyr2HgLmM+6Co8mLD//QmD7Nb6EWUdjdKRVyaapQ1
         NzwIjoMrPux+UcYVHFefC80a/57LRF/tFQx9U=
Received: by 10.231.146.141 with SMTP id h13mr1354230ibv.1.1284139556197; Fri,
 10 Sep 2010 10:25:56 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 10:25:56 -0700 (PDT)
In-Reply-To: <rl_Fe3GvwRHMfzdMCqwnBhdCJhaaE21fdWY64ux0ATvXGt5hFA80h-4iMktgWtjAQ_54uD09KJc@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155949>

On Fri, Sep 10, 2010 at 16:13, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:
> From: Brandon Casey <drafnel@gmail.com>
>
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> Thanks again Jeff for your, as always, very valuable review.
>
>
> =C2=A0t/t4018-diff-funcname.sh | =C2=A0 =C2=A08 ++++----
> =C2=A01 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 620cd02..c8e1937 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -37,13 +37,13 @@ for p in $builtin_patterns
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success "builtin $p pattern co=
mpiles" '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "*.java d=
iff=3D$p" > .gitattributes &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! ( git diff --no-=
index Beer.java Beer-correct.java 2>&1 |
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 grep "fatal" > /dev/null )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! { git diff --no-=
index Beer.java Beer-correct.java 2>&1 |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 grep "fatal" > /dev/null; }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_expect_success "builtin $p wordRegex =
pattern compiles" '
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! ( git diff --no-=
index --word-diff \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! { git diff --no-=
index --word-diff \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Beer.java Beer-correct.java 2>&1 |
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 grep "fatal" > /dev/null )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 grep "fatal" > /dev/null; }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'
> =C2=A0done

=46WIW (but don't think you need to change 'em) I'd do these as
(untested):

test_expect_success "builtin $p wordRegex pattern compiles" '
    git diff --no-index --word-diff >out 2>err &&
    # Or whatever out should be..
    ! test -s out &&
    grep fatal err
'

It's much easier to debug tests that use intermediate files with
--immediate --debug when they break, because you can just check out
what out and err contain. You can't do that if the output was
forgotten in some pipe.

Maybe I should add a bit into t/README about this ...
