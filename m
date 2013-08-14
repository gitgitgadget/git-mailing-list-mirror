From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 19:04:37 +0200
Message-ID: <520BB8A5.4010406@googlemail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBA894D87E8BCD7CEE613A0F"
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 19:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9eUy-0000Nl-L5
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760017Ab3HNREg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:04:36 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:49296 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759941Ab3HNREf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:04:35 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so7242991wes.12
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=0YMB4i7YCuApQClNAL/UC4e5wz/u9FqtAD7BGf71ZyE=;
        b=TsmrEBT0xMse+7tohBR5HdhIyyJzgtmL5IXmCkK+QfvKWv6B+/OCHcpfr/GfeFLPfm
         pn0CeDwnW6BM4mdz8XCuLgemaMymEvtWAowdEdQj7AwsRqZ/ctOL4ok5RtppSULMVTYR
         v86RY9MbioPe8botfRmXGCJ+a6gkLeEsnukE8EhD8JMx1o9n2gId3BWOlk6w/EFG2pty
         lyPWDzXMgMhur7uHtkXAc7x59lNpVzWnyh7Sf+Day1ccyWv4/Ll3WQhuu1N0vy+6UvQN
         NdzDtlqVjz2f3rH78ivNJ4XIbibEn7S3yc1EFDxakt/kX+5+Lq9UUz9QK163Xg0TeJXg
         hnow==
X-Received: by 10.194.179.98 with SMTP id df2mr1930wjc.49.1376499873805;
        Wed, 14 Aug 2013 10:04:33 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id li9sm4189362wic.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 10:04:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232298>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBA894D87E8BCD7CEE613A0F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 06:49 PM, Antoine Pelisse wrote:
> On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>>  builtin/repack.c               | 410 ++++++++++++++++++++++++++++++++=
+++++++++
>>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++
>>  git-repack.sh                  | 194 -------------------
>=20
> I'm still not sure I understand the trade-off here.
>=20
> Most of what git-repack does is compute some file paths, (re)move
> those files and call git-pack-objects, and potentially
> git-prune-packed and git-update-server-info.
> Maybe I'm wrong, but I have the feeling that the correct tool for that
> is Shell, rather than C (and I think the code looks less intuitive in
> C for that matter).
> I'm not sure anyone would run that command a thousand times a second,
> so I'm not sure it would make a real-life performance difference.

=46rom IRC:
<iveqy> IIRC repack is one of the most important scripts to port
<iveqy> it's one of the rare times a script is used serverside
<PjotrOrial> heh, I picked it because of its size
<iveqy> (and people want to be able to use git in chrooted enviroments
with few dependencies)

My contributions as of now are very small nit picking things just to
familiarize with the code base, most of the time supported by tools
such as static code checkers.

However I'd like to contribute to the project in a more meaningful way,
but I still have the feeling to not be completely familar with the
projects code base (heh, it sure takes time for such large projects)

So I think the best way to get a feeling for the code base is to
rewrite a shell script in C. I picked the smallest script, to have
only a little task. So I thought at least. The rewriting is larger than
originally assumed.


But apart from my blabbering, I think ivegy made a good point:
The C parts just don't rely on external things, but only libc and
kernel, so it may be nicer than a shell script. Also as it is used
serversided, the performance aspect is not negligible.

I included Jeff King, who maybe could elaborate on git-repack on the
serverside?


>=20
> Last and very less important: I think it's OK to format-patch with -M,
> especially when you move a file.
>=20

Noted, thanks.

> Cheers,
> Antoine
>=20

Stefan



--------------enigCBA894D87E8BCD7CEE613A0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSC7ilAAoJEJQCPTzLflhqROoQAIqhl7UZhJamragetbN/jhv+
Vyblwr8KlCoG1b5vatK3pJfvvb2p7RO0QWVBwCLTUcq3widJH6zHAK+xx6xDSCug
F92TFzKvPlK/gHYcxuNSss0tXi/GQP9jZvQGnCpxsjxY5v9QjErkhg3R4davFW7o
F1c+wILqHjCLTKB0zUrOPsf7eV8MReooWsfi90mDoou9bzf+P+eA9e2t70OXxGJP
eijbY6PN/cWFPGUzL84XAT68COLlzkrOgSPYQOhpNg8It+xSfKQekeJuZ1LDQF+y
s91cnmC/9mGJxJCCn9sb95dm5jTptKMsUazthhnjpjV8B+4lrGn6SdmzlOBwWRLX
DTJLEz6dn0N4j9F4SPax2NBTkN5jhS3wgIqCKmANWUtUruUxL2IXlViXLE5mgpVP
UxnD8lAD0DMrq2FBfFfvtoMzJO25B2t+rKzOnhJWIgwisvY9CU0LUcHHDqc0dVUO
lAevT4jNPpTAyhYdO0kZC3FfVokozlfO6Unl896mAlj4kmdwLh8TSdL94XUsbE2O
qF5JtfsW7YopQ95/1Pen/F2rQlrUN0BT1IrQwIunFETiTbsc0BQ9s/jNgE0c++jv
dRFqvGZpnbZSxW8kYJAIYzAscDdpnxmNNm/6qz6fADynzUy5y7FK4l9p4+l22Gjw
WbmMOx6JpZApJnO265o0
=j9MY
-----END PGP SIGNATURE-----

--------------enigCBA894D87E8BCD7CEE613A0F--
