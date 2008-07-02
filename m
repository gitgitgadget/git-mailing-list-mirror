From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 04/12] Avoid calling signal(SIGPIPE, ..) for
 MinGW builds.
Date: Wed, 02 Jul 2008 12:03:15 +0200
Message-ID: <486B5263.1060805@storm-olsen.com>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <7vod5gbpza.fsf@gitster.siamese.dyndns.org>
Reply-To: marius@storm-olsen.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig94E121D973D1E12534E9D2EB"
Cc: prohaska@zib.de, Johannes Sixt <johannes.sixt@telecom.at>,  git@vger.kernel.org, msysgit@googlegroups.com,  Marius Storm-Olsen <mstormo_git@storm-olsen.com>
To: Junio C Hamano <junio@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 12:04:50 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDzCg-00018T-15
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 12:04:46 +0200
Received: by wa-out-0708.google.com with SMTP id n36so7053134wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:face:content-type
         :x-spam-checker-version:x-spam-status:x-spam-level:x-dspam-signature
         :x-dspam-probability:x-dspam-confidence:x-spam-score:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=Zybj1wYR7iQTchf4lRiPMUgjfw3hkleM66pFUWGtN9k=;
        b=V/yvdfWtoLqFFx9gAeXsiD/x21Nx5ZjJ5tEzP4UZ28cnnnJZ4jHktQ940fRj8WJHjA
         Vzm1K/4RT/tA8jFvmxa5UrPt9sUICXppAaDE41uPgjNRCeUd22u/Lpr1Ezgl6uVoVsMW
         hWC7onWhjHgHWJ89nlSUvfUb4KCzoCzt 
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:face:content-type
         :x-spam-checker-version:x-spam-status:x-spam-level:x-dspam-signature
         :x-dspam-probability:x-dspam-confidence:x-spam-score:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=VAsn4zXaTQFhaWhm3AU2ykUQONckJZkSwa06lvLyQb2PfFtCpccl3k2uq/ApmLUnzv
         9rM13w5gXipf5D5YlglZ1fRVQWQjUcs3ngpnnyCMhwyMSJ/5Vce4p3IkT3gxyfZx3Gq6
         FzAp2K3qDGSo5AimfYRWyCYKVDm63SkQUcsoo=
Received: by 10.114.171.1 with SMTP id t1mr548502wae.13.1214993026626;
        Wed, 02 Jul 2008 03:03:46 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2562prm.0;
	Wed, 02 Jul 2008 03:03:46 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.92.14 with SMTP id p14mr8905754agb.18.1214993026111; Wed, 02 Jul 2008 03:03:46 -0700 (PDT)
Received: from init.linpro.no (init.linpro.no [87.238.46.2]) by mx.google.com with ESMTP id 22si7899223yxr.2.2008.07.02.03.03.45; Wed, 02 Jul 2008 03:03:46 -0700 (PDT)
Received-SPF: neutral (google.com: 87.238.46.2 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=87.238.46.2;
Authentication-Results: mx.google.com; spf=neutral (google.com: 87.238.46.2 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: from nat0.troll.no ([62.70.27.100] helo=[127.0.0.1]) (Authenticated Sender=marius@storm-olsen.com) by init.linpro.no with esmtpa (Exim 4.50 #1 (Debian)) id 1KDzBK-00077N-7k; Wed, 02 Jul 2008 12:03:22 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vod5gbpza.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1 KOEmUlJISdYPgEgehw+cTZEf6xeF
 yoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on spamtrap
X-Spam-Status: No, hits=-10.2 required=5.0 tests=DSPAM=-10.19694  version=2.63
X-Spam-Level: 
X-DSPAM-Signature: !DSPAM:486b4c65131261230822988!
X-DSPAM-Probability: -2.0000
X-DSPAM-Confidence: 0.9997
X-Spam-Score: -1.4 (-)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87127>


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94E121D973D1E12534E9D2EB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 02.07.2008 11:22:
> Steffen Prohaska <prohaska@zib.de> writes:
>=20
>> From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
>>
>> SIGPIPE isn't supported in MinGW.
>=20
> Shouldn't #ifdef be on SIGPIPE not on __MINGW32__?

That's certainly a good suggestion. :-)

--=20
=2Emarius [@] storm-olsen [.com]
'if you know what you're doing, it's not research'


--------------enig94E121D973D1E12534E9D2EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIa1JkKzzXl/njVP8RAtISAJ9v44OSY9lfDag/PfmD0z+vaTqU2QCgpG/Y
1QvQ/B9anTnQgGG3JN+OP5Q=
=cKBi
-----END PGP SIGNATURE-----

--------------enig94E121D973D1E12534E9D2EB--
