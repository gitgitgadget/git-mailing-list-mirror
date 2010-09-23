From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH V2] git-send-email.perl: Add --to-cmd
Date: Thu, 23 Sep 2010 23:16:06 +0000
Message-ID: <AANLkTin2YvPxnbCXzWsugfaGvbUUcm6n5LtwkNVxhJfC@mail.gmail.com>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros>
	<20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
	<AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	<1285263993.31572.25.camel@Joe-Laptop>
	<AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	<1285267520.31572.34.camel@Joe-Laptop>
	<7v62xwqe7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joe Perches <joe@perches.com>, Julia Lawall <julia@diku.dk>,
	git <git@vger.kernel.org>, Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 01:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyv1U-0007Cg-1E
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 01:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab0IWXQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 19:16:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49912 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab0IWXQH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 19:16:07 -0400
Received: by iwn5 with SMTP id 5so1818746iwn.19
        for <multiple recipients>; Thu, 23 Sep 2010 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FSFuCJlqMauxA61IEJXb3j6gUK0bi9J5fALrHAZtEHA=;
        b=oV1C9txOXPMn2bcc2AO7NC3GRVT4hGoYJAsERFY1HfG7PTj7IXfH4soOhlC0b1Edwh
         c1YO2ma8IdNQ4CgKcYrv1IJtviAoq1GzbJpnVaa0Z9+eUtiGj4tXtuzxQXP74zkNp8tX
         rSbnp4u4FW+glRjQhMt1/2i0K+sQW6s1nmrzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xswMoWsdKYAg8REWTtxzkjiCT6TBXEKp2/yYCe7rwKmbaGYlGBPoLe3sOtfBaTX+t9
         RptVMmrQCKx5reqnV2xq+a+xw9LZ96QSXTdDzxQ8Cdry5/bvWMLGmY/Buh14lUHpm2H4
         WYmGkg0q6emT99Cbmx8Hmcv0J32uEdwc4ccEw=
Received: by 10.231.157.11 with SMTP id z11mr2698530ibw.147.1285283766528;
 Thu, 23 Sep 2010 16:16:06 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 16:16:06 -0700 (PDT)
In-Reply-To: <7v62xwqe7i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156925>

On Thu, Sep 23, 2010 at 22:37, Junio C Hamano <gitster@pobox.com> wrote=
:
> Joe Perches <joe@perches.com> writes:
>
>> + =C2=A0 =C2=A0 if (defined $to_cmd) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(F, "$to_cmd \Q$t\E =
|")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 or die "(to-cmd) Could not execute '$to_cmd'";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while(<F>) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 my $t =3D $_;
>
> "my $t" masks another $t in the outer scope; technically not a bug, b=
ut
> questionable as a style.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 $t =3D~ s/^\s*//g;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 $t =3D~ s/\n$//g;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 next if ($t eq $sender and $suppress_from);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 push @to, parse_address_line($t)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if defined $t; # sanitized/validated later
>
> This "if defined $t" makes my head hurt. =C2=A0Why?
>
> =C2=A0* The "while (<F>)" loop wouldn't have given you an undef in $t=
 in the
> =C2=A0 first place;
>
> =C2=A0* You would have got "Use of uninitialized value" warning at th=
ese two
> =C2=A0 s/// statements if $t were undef; and
>
> =C2=A0* Even if $t were undef, these two s/// statements would have m=
ade $t a
> =C2=A0 defined, empty string.

Well spotted. Also it *can't* be undef here by definition. Since $t is
taken from the $_ value which comes from the <> operator. That just
wraps readline(), which will exit the loop when it hit EOF (at which
point readline() *would* return undef).

So this whole business of checking for the definedness of $t doesn't
make any sense.
