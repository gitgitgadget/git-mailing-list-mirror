From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] t9824: fix broken &&-chain in a subshell
Date: Sun, 24 Apr 2016 18:29:26 +0200
Message-ID: <78046710-31FD-43D8-820E-95D56564C3F5@gmail.com>
References: <1461096530-82448-1-git-send-email-larsxschneider@gmail.com> <1461498621-25422-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 24 18:29:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auMud-0001K9-9z
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 18:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbcDXQ3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 12:29:31 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37141 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbcDXQ3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 12:29:30 -0400
Received: by mail-wm0-f54.google.com with SMTP id n3so94035790wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SBO/H/QvadwYtkhfYzayOYcQtapvMROsJBEx7q0sEaU=;
        b=N8vG6Rrpd060sbR0/cgpCF4CPmGql15OzNQL6uEwWpWMXsdfeNgsVOpo1+S5+Gv7dc
         /xygqwMUagPYz/p8znpNAjEceJ0wAXIRwQbLGUcu1TPCwcUBBlEHHE3UjOOCw3c1ux4z
         iJoOsux2J1SO9670Yy7gdY71/N+X498IpfrifRMmgEIrND9sauNdvQwXMu91tBfbmxd8
         BfId7wBUQrBHPQOZa2NZmGo0CLdoWSBUAN1xh3N3ExL1B6uBkuABjCaH23aapnfuPe1q
         AGvz4ecU6Hs5IsoVto0I6vD1NilCMbkxo6UcNbgQMw7bcSjfcm5I86guCgT7WYE1Y2I9
         17uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SBO/H/QvadwYtkhfYzayOYcQtapvMROsJBEx7q0sEaU=;
        b=PQ0v4NhO92fye+MJv/48rG4zjg5F3x3QFfyzUqnUZDZTUHOAk+EPHpbcewN1OfwxUc
         N2G8iycf9SbicAPvpW8mhH30rikU/+hKkG2UCdyVkF9Z8lnHnyoD86zW38CUrTIS+Hni
         YQIKmS1SqF3c0jmsFGSn7OjBgkhiKXfpT+7d7ab0IBN/9ezOag5urWlVgDuKwua3Pea9
         kmZDSg7Z6HiN4H4STzuMA0NHfvRm3X7QjFTT368lT+btmQeNr5p1B5vAaiTAkN6TaB+P
         T2VySBPvxnzlsb7DzcHbEkiUmQgquSe3CZ94Q5G7HStwW/677Lmv6VUseA0vyC5s8+VM
         wziQ==
X-Gm-Message-State: AOPr4FVQvdvVcLkPM79xI7AAknTiarRy6SWo28WVh66IbPnTWaFJGd62yJSX7a77szQrbQ==
X-Received: by 10.28.153.129 with SMTP id b123mr8148104wme.1.1461515369332;
        Sun, 24 Apr 2016 09:29:29 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id h124sm14340248wmf.7.2016.04.24.09.29.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 09:29:28 -0700 (PDT)
In-Reply-To: <1461498621-25422-1-git-send-email-szeder@ira.uka.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292418>


On 24 Apr 2016, at 13:50, SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> ---
>=20
> As far as I can tell after eyeballing the test script, this was the
> only case where the &&-chain was broken.
>=20
> t/t9824-git-p4-git-lfs.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
> index 0b664a377c45..64f8d18216d4 100755
> --- a/t/t9824-git-p4-git-lfs.sh
> +++ b/t/t9824-git-p4-git-lfs.sh
> @@ -265,7 +265,7 @@ test_expect_success 'Add big files to repo and st=
ore files in LFS based on compr
> 		# We only import HEAD here ("@all" is missing!)
> 		git p4 clone --destination=3D"$git" //depot &&
>=20
> -		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZ=
ZZZ"
> +		test_file_in_lfs file6.bin 13 "content 6 bin 39 bytes XXXXXYYYYYZZ=
ZZZ" &&
Thanks! I believe I remember some script/flag to detect broken &&-chain=
s.
Do I imagine that or can anyone point me to it?

Thanks,
Lars


> 		test_file_count_in_dir ".git/lfs/objects" 1 &&
>=20
> 		cat >expect <<-\EOF &&
> --=20
> 2.8.1.99.g5d5236f
>=20
