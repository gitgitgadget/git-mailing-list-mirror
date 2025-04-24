Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7F18B495
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522433; cv=none; b=GFHURR1sSbVwRX1J4QMNU53wF7VspBK7tMPm9qtqLPmYqFfrt0if/cYwN40kz8LvpMjJBuzmutNxdR9eZDdPlBffAWiP+qQnhQ5sv9NARTbjS00wEKE4aA0Syhyrb81pqmXSAz7SamBzHxYQwjYs/I7IEnOGJmNWcjVuUyfq/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522433; c=relaxed/simple;
	bh=1mDQOEE5EMAslRNSga9bq3PjMINZ7SfwXZaRHwiUvlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0yya0nmLRscjTkZbNjyOG2C1GUUmUTi6YA5TekDowuTjlIwmRnZogklPaFY7AtU5oaiVcU6ajlq+oHXwP0lSY/IW33x9iuoTmfk16iwHZ3MjScXWURoQ0waNa7TwrNv5axnXtbIIvRKRUpA/5BaVhLr5YzHo5Y4uXWWQ4Nntog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mgo4PLkZ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgo4PLkZ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so580184241.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745522430; x=1746127230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3awXKS8gNHHFgbQp/Lp3yn3xN3yltEh0PLwbQS340E=;
        b=Mgo4PLkZppEvvZWDVdU2s0OY1rPqxLy1OUFLLZVmSB3BmrejNpnT05oV46YTdZAbIy
         bHV5Wic6HjEzH/OzUVoZfkePYZUZmv19ArrvFK2UW6CBiFhMytmzLqw8csP3512LCCfV
         MTKUUJW0pcQCXOKFqNuB/xetvtZiuAOuFlpe49Q3Nsgz5tizIiDZtIPJPLPmV6bKdBgd
         w8hS2hnXfYYM/oVoiPwgx9oXcgWmWayYYMl42UFrdNsoQajkUtTE1SHeW+78DSdymfn9
         gCzHm2JWkDlo3E4ijQOSSsWxvzdTVX84Fw+7jUSEwpFRBstZxuWCvTFpJ6P1p96KmGNh
         PAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522430; x=1746127230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3awXKS8gNHHFgbQp/Lp3yn3xN3yltEh0PLwbQS340E=;
        b=MuazaPrGQbS250UkXAIKOJuWrJP06v6a5D9//CCcL+ktnkCnM0M5Suac9Q4UleOiH2
         Zd4ycCAozxye5xRa9XTC0RMij5GyrOKaNsXbhzWQ3pof2HjCbXSNC8HeIld/3JokKE1Z
         e8z6w8VNMLVg8VEuX2g6/EZLfoGtLFjknTWJnoxZYS3VTPyu2g4Jm1AcnagTmJQr4BA+
         GHZamU47RQPVEAB3P/KFsf6IM7NEXCuok8c34xtAJWAj5J3Mq45atZW4fUVf8y3CviZl
         PWiHpifO3VL95SjoOBXCjeGPDdl8ldCNB6pZrytSCWyZm3fbVqKCHgxpekGAEmmUfY5j
         4ztA==
X-Forwarded-Encrypted: i=1; AJvYcCWK3cAdF+4RDfVhAMu/hYOT1eulX5MZdEJs1dY479vnCcyFzICgGVWBH0skhqAmcmLc82k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TylOU4fNe2/bVyWojor+0vhKC60xyMRT8SRZW9F4xiyh/S/k
	NqhitaJ+yyzd9CtEte3QwFj4QsXSX6gfRdNnpBGb2BFRI4BomNYaI5SPtuuBFeLZSjxTUO/AwHQ
	AM7sYL4gKMTuB/U8A70kObVNFcQ==
X-Gm-Gg: ASbGncsYtIawVPVm4SpNYvwAbANX/8VAVoTnjQWqk3H620vkeXdxAB65o4e6jAsHhbC
	3OOfjQwHItleGmS/gvQNK6pxUDBm2ZpoegoaNuNtuYcSQbIrBZV15Rn9FxYnI5b8dgToavFQmrT
	uWqz3m4QNz+hJeW/6V0e31jQ==
X-Google-Smtp-Source: AGHT+IEIY9YuP3lH1rjcNkPeCp9GESE6izUlgnS6cWZszVA2wdtgPxBbmyxwDAFG377f7aW/dmK3CTG55JVSNYqwxFA=
X-Received: by 2002:a05:6122:2503:b0:526:285a:f4b3 with SMTP id
 71dfb90a1353d-52a859cc94bmr1280810e0c.2.1745522430375; Thu, 24 Apr 2025
 12:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com> <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: Erik Huelsmann <ehuels@gmail.com>
Date: Thu, 24 Apr 2025 21:20:18 +0200
X-Gm-Features: ATxdqUHfRmm5wWFSVBXyFMB0UIKFzO6VF5JUgqARqxQaSUBeCHOfeal1wRaeCTY
Message-ID: <CACOoB6ipkWB0FBhWWQgHJpEd-pbPHSx1OZ+btZA=FD4YxC7-6A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>, 
	sandals@crustytoothpaste.net, Shengyu Qu <wiagn233@outlook.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aditya,


On Thu, Apr 24, 2025 at 8:23=E2=80=AFPM Aditya Garg <gargaditya08@live.com>=
 wrote:
>
> Hi Eric
>
> > As I said in https://github.com/gbarr/perl-authen-sasl/issues/18#issuec=
omment-2453040190 <https://github.com/gbarr/perl-authen-sasl/issues/18#issu=
ecomment-2453040190> : I'd love to implement XOAUTH2 and/or OAUTHBEARER, bu=
t I don't have a setup available to test with, so I need someone to provide=
 a patch *and* a description of how to test, preferably against a publicly =
available service so I don't need to go through complex setup myself.
>
> I saw the code of perl-authen-sasl and I miserably failed in porting the =
logic used here to the repo.
>
> Perl is not something I am very strong at, so not really feasible for me =
to work ahead. I do was able to return the formatted base64 encoded string =
as per the logic, but still I got authentication issues.

I took a look at the code you sent XOAUTH2.pm. After a bit of
puzzling, I found what's going wrong: I think you should return the
base64 encoded string from "client_start()" instead of from the first
step. The step function should only be called in case the server
returns an error.

> Currently I aim to have git-send-email working, and a review from an expe=
rienced person is needed.
>
> I would be happy to be able to test any proposed patch though.



> Julian, you might be interested here?
>
> If you are interested, you can checkout my XOAUTH2.pm file, which doesn't=
 authenticate for some reason.
>
> -->8--
>
> package Authen::SASL::Perl::XOAUTH2;
>
> use strict;
> use warnings;
> use MIME::Base64;
> use vars qw($VERSION @ISA);
>
> $VERSION =3D "1.00";
> @ISA     =3D qw(Authen::SASL::Perl);
>
> my %secflags =3D (
>     noanonymous =3D> 1,
> );
>
> sub _order { 1 }
>
> sub _secflags {
>     shift;
>     scalar grep { $secflags{$_} } @_;
> }
>
> sub mechanism { 'XOAUTH2' }
>
> sub client_start {
>     my $self =3D shift;
>     $self->{stage} =3D 0;
>     '';
> }
>
> sub client_step {
>     my ($self, $challenge) =3D @_;
>
>     my $stage =3D ++$self->{stage};
>     if ($stage =3D=3D 1) {

This bit should be in "client_start{}":
>         # Generate the XOAUTH2 authentication string
>         my $username =3D $self->_call('user');
>         my $token    =3D $self->_call('pass'); # OAuth 2.0 access token
>         my $auth_string =3D "user=3D$username\001auth=3DBearer $token\001=
\001";
>         my $encoded_auth_string =3D encode_base64($auth_string, '');
>
>         # Send the encoded authentication string
>         return $encoded_auth_string;
Up until here.

>     } else {
>         # Handle authentication failure by sending a dummy request
>         my $dummy_request =3D encode_base64("\001", '');
>         return $dummy_request;
>     }
> }
> }
>
> 1;
>
> __END__
>
> =3Dhead1 NAME
>
> Authen::SASL::Perl::XOAUTH2 - XOAUTH2 Authentication class
>
> =3Dhead1 SYNOPSIS
>
>   use Authen::SASL qw(Perl);
>
>   $sasl =3D Authen::SASL->new(
>     mechanism =3D> 'XOAUTH2',
>     callback  =3D> {
>       user =3D> $user,
>       pass =3D> $access_token,
>     },
>   );
>
> =3Dhead1 DESCRIPTION
>
> This module implements the client side of the XOAUTH2 SASL mechanism, whi=
ch is used for OAuth 2.0-based authentication.
>
> =3Dhead2 CALLBACK
>
> The callbacks used are:
>
> =3Dhead3 Client
>
> =3Dover 4
>
> =3Ditem user
>
> The username to be used for authentication.
>
> =3Ditem pass
>
> The OAuth 2.0 access token to be used for authentication.
>
> =3Dback
>
> =3Dhead1 SEE ALSO
>
> L<Authen::SASL>,
> L<MIME::Base64>
>
> =3Dhead1 AUTHORS
>
> Written by [Your Name].
>
> =3Dhead1 COPYRIGHT
>
> This program is free software; you can redistribute it and/or modify it u=
nder the same terms as Perl itself.
>
> =3Dcut
>
> ----
> >
> > Please let me know who to talk to to have it added!
> >
> >
> > --
> > Bye,
> >
> > Erik.
> >
> > http://efficito.com <http://efficito.com/> -- Hosted accounting and ERP=
.
> > Robust and Flexible. No vendor lock-in.
>


--=20
Bye,

Erik.

http://efficito.com -- Hosted accounting and ERP.
Robust and Flexible. No vendor lock-in.
