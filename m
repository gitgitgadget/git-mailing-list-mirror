From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [StGit PATCH] compressed import v3
Date: Fri, 13 Jun 2008 09:53:49 -0500
Message-ID: <485289FD.50808@gmail.com>
References: <48519602.2090103@gmail.com> <20080613051127.GA24245@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Afz-0002GQ-Br
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbYFMOx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755956AbYFMOx5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:53:57 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:30848 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954AbYFMOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:53:56 -0400
Received: by an-out-0708.google.com with SMTP id d40so984834and.103
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=ulDk13eTJDoBhw7xc2qvrE8v/ON+KhGODBaPMAXgPSA=;
        b=LLXS8kP781I+82crl1CkS1R0Ov/BI2I19F60gZCUteSVkVCBCVLUZ/9FMfXDBH6ZT1
         5sjLgtuN4tmBeSm9CfOXzlJqEgQg7POCnlgjwWhLGlVzA0UZ1ebkcMB59sj2+nvQBaRp
         kbhkNYOwCEqA4Htc87AvZ+dHjuGbihL0jSir0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=iU9RMdqb/CUyts+B0RmAilLCaLvSHE+6WeCaiNUM19r4761RNafL+QLIF7disAX8UO
         I3rnVYuQODjzwe+ga+HvMfLKUC9XYZKkC5dttBgDHl2pqjkCsgz+NHeyRwLLM9lEuC3d
         CTtxYwVgAueRar+zyIDYH9Jp+H6CN74YCSKgk=
Received: by 10.100.131.3 with SMTP id e3mr4412299and.4.1213368835713;
        Fri, 13 Jun 2008 07:53:55 -0700 (PDT)
Received: from ?172.16.17.168? ( [66.187.231.200])
        by mx.google.com with ESMTPS id 39sm3122299wrl.29.2008.06.13.07.53.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 07:53:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <20080613051127.GA24245@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84888>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=B6m wrote:
> On 2008-06-12 16:32:50 -0500, Clark Williams wrote:
>=20
>> Attached is my latest stab at StGit importing patches from
>> compressed files. This version doesn't try to differentiate by the
>> file extension; it just tries to open gzip or bz2 files and if those
>> fail it reverts to text.
>=20
> Very good!
>=20
>> I'm not completely happy with it, but I've spent about as much time
>> on it as I can afford to (for this week anyway).
>=20
> Heh. I see an opportunity for condensing the code a bit in
> __gethandleandname(), and you intented the "pass"es funny, but I'll
> take care of it (or not, seeing as they're kind of minor nits -- in
> any case, I'll just take the patch off your hands and stop tormenting
> you about it).
>=20

Ugh, I missed that on the pass'es. I had some other logic in there, att=
empting to
make sure that the IOError was in fact because the input was uncompress=
ed, but I
punted that and forgot to unindent the pass. I can't believe emacs didn=
't catch that
for me :)

I'm interested to hear how you'd condense the code in __gethandleandnam=
e().

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhSif0ACgkQqA4JVb61b9dA1gCeMVvcY4GobZLp+k7qskLVgozN
vsAAmQFoTxf2xxohyzCnCrRQRs1Gdf+O
=3DlBEr
-----END PGP SIGNATURE-----
