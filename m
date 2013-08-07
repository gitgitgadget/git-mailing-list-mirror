From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Wed, 07 Aug 2013 23:50:01 +0200
Message-ID: <5202C109.6040209@googlemail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com> <52027B17.7040602@googlemail.com> <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA2AA5969D7E6F91C723BA300"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 23:50:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7BcQ-0002Sx-19
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 23:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933110Ab3HGVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 17:50:04 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:41224 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868Ab3HGVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 17:50:03 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so1147835eek.27
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Qp27nJ8qvFRt4us8cX9ILPhyGcQ8Yx45if3zhrkLHWE=;
        b=WLzJPeYNMbGakjeIF3nkaghZLneDspGFQoyWvQnh2uau2HN9VYjzjsGxQQtfGgR0mT
         C0pq8Zurzsk9QJI6ybeGJ2JXL96505+whMJ0xJ7RO/mibmlvZy7Q4lBkekoTR0Wp1Rby
         UPmPfFKgSBQHXf9Qx6Y1YbVDQetgan3NjRhaedTK+ZuUrrQcoRpT7cy59Qf3rRAoe4wp
         tlrhWl1qgUu0p8Y/b06WuZEYbV9mShmYLIQ6dBPeIpsCIVPmBTm3nIoVuVXeJXwfE4+N
         WFapZk1wnU/295LArPPjaRtX25XD1QotUOO+Q5GPhyDjsdja7S7/5Nm11Xp7hSQbfKV+
         BSNw==
X-Received: by 10.15.21.76 with SMTP id c52mr4986336eeu.135.1375912201413;
        Wed, 07 Aug 2013 14:50:01 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k3sm13328254een.16.2013.08.07.14.49.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 14:50:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231845>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2AA5969D7E6F91C723BA300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/07/2013 07:50 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> I'd deprecate it first for a year or such and remove it then.
>> In the meantime we could implement already remove the code
>> and change it to:
>>
>> + int cmd_whatchanged(int argc, const char **argv, const char *prefix)=

>> + {
>> + 	return cmd_log(argc, argv, prefix)
>> + }
>>
>> Also we should make sure everything git whatchanged can do,
>> can easily be done with git log <options>.
>=20
> That's even worse than "deprecating".
>=20
> Your first step already changes the behaviour for people who really
> use the command, without telling them _why_ the behaviour has
> suddenly changed at all, while not helping *ANYBODY*.
>=20
> The only thing it does is to scratch an irrelevant itch by people
> who peek the codebase and find an old command whose existence does
> not even hurt them.  They may have too much time on their hand, but
> that is not an excuse to waste other people's time by adding extra
> makework on our plate, or changing the behaviour for people who use
> the command without explanation.
>=20
> Feeling irritated somewhat...
>=20

Well if we make sure the whatchanged command can easily be reproduced
with the log command, we could add the missing parameters to it, hence
no change for the user. (git whatchanged =3D=3D git log --raw --no-merges=
 or
git log --wc [to be done yet]).

So I did not mean to introduce a change for users!

But in general I like the idea to *remove* lines of code.

Stefan




--------------enigA2AA5969D7E6F91C723BA300
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAsEJAAoJEJQCPTzLflhqEdQQAIXEA6zI3fgLyWLuBoxDZl1u
gXvUeAQSN6EUyIrjVNgNn5v7/M7/8xMsX3xofMofSplc9b949raT9HPekNYRFclH
muhLiNh4UxA1GGb+O6Wdna2/6Y/6OJhOsf8CprqSYyneHuW9K+JOsWMPxrl1/9EM
hPR4L6pcBWrUdLPpCCwnY6RZrm5xag3FkGvuV/vPK0pFqB1L78hkiPVq0SjZn1rl
dkpd4k040AEJmR50YHNMeYqhmagfR9ViBPG7dFCRFwiwf0em850nvrrF3IBUmPJ2
ftTvSwuZpdo1oA0ncx2nLENjvAWktgzE6G4FQvQSMvjhH9TVvlebMtzkwRuXC6at
MGcMj1pZnZgRSg96UitRlyapaZ33lpDfEWfTRz30tC1K/XgINaqtE5je8RIaHbNl
nKjqHumcZmE8tggSSfysLFzG7yZRQSxHLtVh61MNQykVbqKBKDws8k6Nm9NwO6zM
eqb5pkNZ65m8hAHeYLqzKr5Vsu7ZJgtjxWjoyteYJi8c5+uF+/7KVfAXyr/Gpr75
mxqCylx75aTjb1AbCwCKuzW5NU2LIi+gRbh5aECkprlYAmHhlkfmdQ1sQgSN8tZg
O3s7Q+MxSgpckf0MSR66jWYNBka4DKonfN03Q7Q42j+dK1RuQnis2fD99nRKo2vE
wCPH4tEDA2Swtk1zN8rR
=VKZj
-----END PGP SIGNATURE-----

--------------enigA2AA5969D7E6F91C723BA300--
