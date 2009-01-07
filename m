From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Wed, 07 Jan 2009 01:05:12 -0800
Organization: Slide, Inc.
Message-ID: <1231319112.8870.506.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-WDDWjm5xDB5QoonFK0PA"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 10:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKUNF-0005zr-7n
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 10:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZAGJF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 04:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752598AbZAGJFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 04:05:25 -0500
Received: from mx0.slide.com ([208.76.68.7]:43063 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306AbZAGJFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 04:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=W
	b7QOSJnIeIjQrNooA/8H2pHOaz34oEgyALs7HG1QHY=; b=JrdBib3nrY+woX53y
	YPNGcYmh53Xl4woR6FuMe2qv78y+/8tbc1ZUTO/27wKC+5nhWaz7eFb72dqWcwyo
	lLYtf9CghbB2KvuI/SLdVELjYDQY4HfNwIf1WH1wPh3WI3F6YRkbGElJUqkZ9s7s
	mO1nIwh3IBJiSsW0HJ5ggByWbo=
Received: from nat3.slide.com ([208.76.69.126]:51312 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKULh-0007Sv-1v; Wed, 07 Jan 2009 01:05:13 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 087A7A6F0002;
	Wed,  7 Jan 2009 01:05:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.561
X-Spam-Level: 
X-Spam-Status: No, score=-2.561 tagged_above=-10 required=6.6
	tests=[AWL=-0.062, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJKy9PXQqp+V; Wed,  7 Jan 2009 01:05:12 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 7F212A6F0001;
	Wed,  7 Jan 2009 01:05:12 -0800 (PST)
In-Reply-To: <1231314099.8870.415.camel@starfruit>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104777>


--=-WDDWjm5xDB5QoonFK0PA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-06 at 23:41 -0800, R. Tyler Ballance wrote:

> I did try to do a git-fsck(1), and this is what I got:
>         tyler@grapefruit:~/jburgess_main> /usr/local/bin/git fsck --full
>         [1]    19381 segmentation fault  /usr/local/bin/git fsck --full
>         tyler@grapefruit:~/jburgess_main>=20
> >=20

Disregard this comment, Jan reminded me in IRC of the issue I had with
this repository and the stack-size ulimit. A healthy 32M stack-size
allows for the command to complete:

        tyler@grapefruit:~/jburgess_main> /usr/local/bin/git fsck --full
        dangling blob 6e58a06cd0f027fce1fc8a923a8c81d6b55f1705
        dangling blob 5e87e049f69ee06af1f4f92a3d4ddcd912f8535e
        dangling blob acb8e0937cea3f4068c5c67f60d3b97952654fa1
        dangling blob 8bd540d657027ab12228e0522de86a97d3f8a7a9
        dangling blob 90d93096369df4b2151df3e289952297c5f390dd
        dangling blob aaa4a1bf9e6d39991503b7908ff71605d6632fef
        dangling blob b003e20f06de7d0a7e11a1047fbb39e2deb84899
        dangling blob bf207363786f08e888a725cfb8b2fe4bea11ceab
        dangling blob 642493a1bcf09f74551f0ce5b4c3ccc23acaf3c9
        dangling blob ff80b45e48795d4544d0a5b2f18714123ab21746
        dangling blob e3c0e67e23ec588acab733e2069fb09fa38a235d
        dangling blob 62efa65bcbb6d94f26be9b91dc98d7a7f6fbf602
        dangling blob a6a2c717c230fe26263b9ce002f3f82fdab6f727
        dangling blob d32988875aa90ef728dc1af6b71c130f2c8e8b94
        dangling blob c8aad9fc37a27872bae18af78b1623bfb8f9a9f7
        dangling blob 4cdbe97301e333d89037dc9f4a8440dab9e62049
        dangling blob 2819bbcda3b0efe828709f5b22624712cb9ebdae
        dangling blob b156cba3ee89e1506d02fbb845e8dc0889ff4090
        dangling blob ed658b8beca69ebf6e25ab1ed6217881e27d4e9a
        dangling blob d581cb2fb1cf2b4d15f8f9b90b08a3ebc619414f
        dangling blob a85c2e55d27c9fb1f5874f8bd81c65e597327b4f
        dangling blob 548f3e70c06f9306d71f6b8d11ed24ade581fa31
        dangling blob 7a1c8fa8bc59c4e8fb347426cc11fabf8b0d1639
        tyler@grapefruit:~/jburgess_main>=20
       =20
Cheers

--=20
-R. Tyler Ballance
Slide, Inc.

--=-WDDWjm5xDB5QoonFK0PA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkcEgACgkQFCbH3D9R4W+rWQCghFLAnB3hcciNSU5WUZotDrrg
DmcAnjmIN3Yr8hBPoxomkb0+pD4A4OAm
=gcMZ
-----END PGP SIGNATURE-----

--=-WDDWjm5xDB5QoonFK0PA--
