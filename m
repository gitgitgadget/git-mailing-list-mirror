Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA02248B0
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061360; cv=none; b=pe8ljTibrhUCfjqJ2K9/FD/zf6w3lrkSXophGJ5OZP7iB7FPlBE7lgmsAD20PJvgUZ1O5V5AW3BeuJ9rDe5ryFIp9qNZQf1CiwFT+wCEaS+kFEFrhXxKDl/GxuNeQyL1ldDkI4frmO0Vlno7HI2ikl2zovVWVLvN3uegS8BaPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061360; c=relaxed/simple;
	bh=WPrGWfhjwsJ7pIHVnwDod/72CoL4HawEXqZ+lIx/KUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AxRW1IdgbZr99I1ULO7BT+G3Okui9AsqJq57Ay0pLR+d73tCv0jopD5cyf9G6QzFUfZa40mt7uDwFf8vhAW06dziCEsKjrUHMB6HYvnwDLsITCUtHnQTZnIpLYHY8Vn6VCAW4I+L2LJUlaEk2SFOE6yrjjq15pt4UdCMeaNytbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OfHCxjM8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OfHCxjM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758061356;
	bh=WPrGWfhjwsJ7pIHVnwDod/72CoL4HawEXqZ+lIx/KUw=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=OfHCxjM8A5YLuEzy64ABBx38mTHgntmCbWDGom3GllbGBlQQJsqU1XznPzQNqhTuR
	 HUO45mtFyq8iY0CLovpymY0dl7/yJAzNq963aGFgF82ju7LS5wVv7xRvKFAfaNjNTm
	 6hKKpIGWwmuQqoHZNOBZgTJX0GkexR3CI78bAtd1Y6xH7S+5GisfivseFfnzEkpnKn
	 XXxqWKlyT+3bEnpp+Jej1dsU54yGbBzZNd/wz9P5C2hGRfU9Q9Ih/ob10E4zyxsrdw
	 rXLLgOhNY4XQdGxdlobzyiUmGIR5HM1RInv8WCuVTZ9xGX7CyLJJOAOL+njIf3wMAS
	 gdKijli8CTVVBOJQBq2ifBUBxjPFdFLRusMSAiMpwLr/59yUzWll6L0av0SVEv8hoX
	 VkkjUp6PXfoY+7zTPkSZAAsW90DFLxoa+pKEZ+R+o7ibTNNo+1jKv1naevxBLHoy39
	 CR886U1/SjHgc62jpHlQZQ8wWkBChv0hflHWZy3RUZ6w7MtOSd4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:838b:b45e:5922:53b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4793920105;
	Tue, 16 Sep 2025 22:22:36 +0000 (UTC)
Date: Tue, 16 Sep 2025 22:22:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: t5564 seems to be failing on Debian unstable
Message-ID: <aMnjKgAcad9_I7qK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+XVShsu78ywapTC"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--U+XVShsu78ywapTC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've recently noticed that t5564 is failing on Debian unstable like so:

    mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-SOCKS_PROXY" &&
    (
            cd "$TRASH_DIRECTORY/prereq-test-dir-SOCKS_PROXY" &&
            test_have_prereq PERL &&
            start_socks "$TRASH_DIRECTORY/%30.sock"
   =20
    )
    prerequisite SOCKS_PROXY ok
    expecting success of 5564.6 'clone via Unix socket':
            test_when_finished "rm -rf clone" &&
            test_config_global http.proxy "socks4://localhost$PWD/%2530.soc=
k" && {
                    {
                            GIT_TRACE_CURL=3D$PWD/trace git clone "$HTTPD_U=
RL/smart/repo.git" clone 2>err &&
                            grep -i "SOCKS4 request granted" trace
                    } ||
                    old_libcurl_error err
            }
   =20
    not ok 6 - clone via Unix socket
    #
    #               test_when_finished "rm -rf clone" &&
    #               test_config_global http.proxy "socks4://localhost$PWD/%=
2530.sock" && {
    #                       {
    #                               GIT_TRACE_CURL=3D$PWD/trace git clone "=
$HTTPD_URL/smart/repo.git" clone 2>err &&
    #                               grep -i "SOCKS4 request granted" trace
    #                       } ||
    #                       old_libcurl_error err
    #               }
    #

It's unclear to me what's going on here, but the output of the
`trace` file is below if that's helpful.  For context, this is libcurl
8.16.0.

----
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info:   Trying 127.0.0.1:5564...
=3D=3D Info: Established connection to 127.0.0.1 (127.0.0.1 port 5564) from=
 127.0.0.1 port 58040
=3D=3D Info: using HTTP/1.x
=3D> Send header, 0000000283 bytes (0x0000011b)
=3D> Send header: GET http://127.0.0.1:5564/smart/repo.git/info/refs?servic=
e=3Dgit-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv header, 0000000044 bytes (0x0000002c)
<=3D Recv header: HTTP/1.1 407 Proxy Authentication Required
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000046 bytes (0x0000002e)
<=3D Recv header: Proxy-Authenticate: Basic realm=3D"proxy-auth"
<=3D Recv header, 0000000021 bytes (0x00000015)
<=3D Recv header: Content-Length: 415
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: Content-Type: text/html; charset=3Diso-8859-1
=3D=3D Info: Ignoring the response-body
=3D=3D Info: setting size while ignoring
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Issue another request to this URL: 'http://127.0.0.1:5564/smar=
t/repo.git/info/refs?service=3Dgit-upload-pack'
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000336 bytes (0x00000150)
=3D> Send header: GET http://127.0.0.1:5564/smart/repo.git/info/refs?servic=
e=3Dgit-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000059 bytes (0x0000003b)
<=3D Recv header: Content-Type: application/x-git-upload-pack-advertisement
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000189 bytes (0x000000bd)
<=3D Recv data: e..000eversion 2...31..0031agent=3Dgit/2.51.0.268.ga483264b=
01.
<=3D Recv data: dirty-Linux...13..0013ls-refs=3Dunborn...4b..0020fetch=3Dsh=
allow
<=3D Recv data:  wait-for-done.0012server-option.0019object-format=3Dsha256=
=2E..
<=3D Recv data: 4..0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000408 bytes (0x00000198)
=3D> Send header: POST http://127.0.0.1:5564/smart/repo.git/git-upload-pack=
 HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 205
=3D> Send header:
=3D> Send data, 0000000205 bytes (0x000000cd)
=3D> Send data: 0014command=3Dls-refs.0030agent=3Dgit/2.51.0.268.ga483264b0=
1.dir
=3D> Send data: ty-Linux0018object-format=3Dsha25600010009peel.000csymrefs.=
000
=3D> Send data: bunborn.001bref-prefix refs/heads/.001aref-prefix refs/tags/
=3D> Send data: .0014ref-prefix HEAD.0000
=3D=3D Info: upload completely sent off: 205 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000287 bytes (0x0000011f)
<=3D Recv data: 118..006ab7ddcba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0
<=3D Recv data: 082627ca379a3 HEAD symref-target:refs/heads/master.0057b7ddc
<=3D Recv data: ba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0082627ca379a3
<=3D Recv data: refs/heads/master.0053b7ddcba2d0055b73b625ed2f8eb921c83aab60
<=3D Recv data: 666730b9ee0d0082627ca379a3 refs/tags/foo.0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000408 bytes (0x00000198)
=3D> Send header: POST http://127.0.0.1:5564/smart/repo.git/git-upload-pack=
 HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 354
=3D> Send header:
=3D> Send data, 0000000354 bytes (0x00000162)
=3D> Send data: 0011command=3Dfetch0030agent=3Dgit/2.51.0.268.ga483264b01.d=
irty-
=3D> Send data: Linux0018object-format=3Dsha2560001000dthin-pack000dofs-del=
ta0
=3D> Send data: 04awant b7ddcba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d00
=3D> Send data: 82627ca379a3.004awant b7ddcba2d0055b73b625ed2f8eb921c83aab60
=3D> Send data: 666730b9ee0d0082627ca379a3.004awant b7ddcba2d0055b73b625ed2f
=3D> Send data: 8eb921c83aab60666730b9ee0d0082627ca379a3.0009done.0000
=3D=3D Info: upload completely sent off: 354 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000018 bytes (0x00000012)
<=3D Recv data: d..000dpackfile...
<=3D Recv data, 0000000169 bytes (0x000000a9)
<=3D Recv data: a3..0040.Enumerating objects: 3, done..Counting objects:  33
<=3D Recv data: % (1/3).0063.Counting objects:  66% (2/3).Counting objects:
<=3D Recv data: 100% (3/3).Counting objects: 100% (3/3), done....
<=3D Recv data, 0000000338 bytes (0x00000152)
<=3D Recv data: 14b..0043.Total 3 (delta 0), reused 0 (delta 0), pack-reused
<=3D Recv data:  0 (from 0).0102.PACK..........x...A..0.@.}N1.Pf&.4.".kq..H.
<=3D Recv data: )..H...U.n.}..6.A..%.1j.%...<.]..H.}..&.c.a......h.......]..
<=3D Recv data: {......v.J..n.R.-..+..........5...'8.........7..7{..x.340031
<=3D Recv data: QH...+ap..f.z...........i.i..#..I.O.E=3D.V....A4x.K........=
Oz
<=3D Recv data: b.l.B.1.....g..Z.Z.g_5..6..'..0006....
<=3D Recv data, 0000000009 bytes (0x00000009)
<=3D Recv data: 4..0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info:   Trying 127.0.0.1:5564...
=3D=3D Info: Established connection to 127.0.0.1 (127.0.0.1 port 5564) from=
 127.0.0.1 port 58064
=3D=3D Info: using HTTP/1.x
=3D> Send header, 0000000283 bytes (0x0000011b)
=3D> Send header: GET http://127.0.0.1:5564/smart/repo.git/info/refs?servic=
e=3Dgit-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv header, 0000000044 bytes (0x0000002c)
<=3D Recv header: HTTP/1.1 407 Proxy Authentication Required
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000046 bytes (0x0000002e)
<=3D Recv header: Proxy-Authenticate: Basic realm=3D"proxy-auth"
<=3D Recv header, 0000000021 bytes (0x00000015)
<=3D Recv header: Content-Length: 415
<=3D Recv header, 0000000045 bytes (0x0000002d)
<=3D Recv header: Content-Type: text/html; charset=3Diso-8859-1
=3D=3D Info: Ignoring the response-body
=3D=3D Info: setting size while ignoring
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Issue another request to this URL: 'http://127.0.0.1:5564/smar=
t/repo.git/info/refs?service=3Dgit-upload-pack'
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000336 bytes (0x00000150)
=3D> Send header: GET http://127.0.0.1:5564/smart/repo.git/info/refs?servic=
e=3Dgit-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000059 bytes (0x0000003b)
<=3D Recv header: Content-Type: application/x-git-upload-pack-advertisement
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000173 bytes (0x000000ad)
<=3D Recv data: 52..000eversion 2.0031agent=3Dgit/2.51.0.268.ga483264b01.di=
rty
<=3D Recv data: -Linux.0013ls-refs=3Dunborn...4f..0020fetch=3Dshallow wait-=
for-d
<=3D Recv data: one.0012server-option.0019object-format=3Dsha256.0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000408 bytes (0x00000198)
=3D> Send header: POST http://127.0.0.1:5564/smart/repo.git/git-upload-pack=
 HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 205
=3D> Send header:
=3D> Send data, 0000000205 bytes (0x000000cd)
=3D> Send data: 0014command=3Dls-refs.0030agent=3Dgit/2.51.0.268.ga483264b0=
1.dir
=3D> Send data: ty-Linux0018object-format=3Dsha25600010009peel.000csymrefs.=
000
=3D> Send data: bunborn.001bref-prefix refs/heads/.001aref-prefix refs/tags/
=3D> Send data: .0014ref-prefix HEAD.0000
=3D=3D Info: upload completely sent off: 205 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000287 bytes (0x0000011f)
<=3D Recv data: 118..006ab7ddcba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0
<=3D Recv data: 082627ca379a3 HEAD symref-target:refs/heads/master.0057b7ddc
<=3D Recv data: ba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0082627ca379a3
<=3D Recv data: refs/heads/master.0053b7ddcba2d0055b73b625ed2f8eb921c83aab60
<=3D Recv data: 666730b9ee0d0082627ca379a3 refs/tags/foo.0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy 127.0.0.1
=3D=3D Info: Proxy auth using Basic with user 'proxuser'
=3D> Send header, 0000000408 bytes (0x00000198)
=3D> Send header: POST http://127.0.0.1:5564/smart/repo.git/git-upload-pack=
 HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: Proxy-Authorization: Basic <redacted>
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Proxy-Connection: Keep-Alive
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 354
=3D> Send header:
=3D> Send data, 0000000354 bytes (0x00000162)
=3D> Send data: 0011command=3Dfetch0030agent=3Dgit/2.51.0.268.ga483264b01.d=
irty-
=3D> Send data: Linux0018object-format=3Dsha2560001000dthin-pack000dofs-del=
ta0
=3D> Send data: 04awant b7ddcba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d00
=3D> Send data: 82627ca379a3.004awant b7ddcba2d0055b73b625ed2f8eb921c83aab60
=3D> Send data: 666730b9ee0d0082627ca379a3.004awant b7ddcba2d0055b73b625ed2f
=3D> Send data: 8eb921c83aab60666730b9ee0d0082627ca379a3.0009done.0000
=3D=3D Info: upload completely sent off: 354 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Tue, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000018 bytes (0x00000012)
<=3D Recv data: d..000dpackfile...
<=3D Recv data, 0000000169 bytes (0x000000a9)
<=3D Recv data: a3..005d.Enumerating objects: 3, done..Counting objects:  33
<=3D Recv data: % (1/3).Counting objects:  66% (2/3).0046.Counting objects:
<=3D Recv data: 100% (3/3).Counting objects: 100% (3/3), done....
<=3D Recv data, 0000000338 bytes (0x00000152)
<=3D Recv data: 14b..0043.Total 3 (delta 0), reused 0 (delta 0), pack-reused
<=3D Recv data:  0 (from 0).0102.PACK..........x...A..0.@.}N1.Pf&.4.".kq..H.
<=3D Recv data: )..H...U.n.}..6.A..%.1j.%...<.]..H.}..&.c.a......h.......]..
<=3D Recv data: {......v.J..n.R.-..+..........5...'8.........7..7{..x.340031
<=3D Recv data: QH...+ap..f.z...........i.i..#..I.O.E=3D.V....A4x.K........=
Oz
<=3D Recv data: b.l.B.1.....g..Z.Z.g_5..6..'..0006....
<=3D Recv data, 0000000009 bytes (0x00000009)
<=3D Recv data: 4..0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host 127.0.0.1:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info:   Trying /home/bmc/checkouts/git/t/trash directory.t55:0...
=3D=3D Info: Opened SOCKS connection from  port 0 to 127.0.0.1 port 5564 (v=
ia /home/bmc/checkouts/git/t/trash directory.t55 port 0)
=3D=3D Info: Established connection to localhost/home/bmc/checkouts/git/t/t=
rash directory.t5564-http-proxy/%30.sock (/home/bmc/checkouts/git/t/trash d=
irectory.t55 port 0) from  port 0
=3D=3D Info: using HTTP/1.x
=3D> Send header, 0000000232 bytes (0x000000e8)
=3D> Send header: GET /smart/repo.git/info/refs?service=3Dgit-upload-pack H=
TTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept: */*
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Pragma: no-cache
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header:
=3D=3D Info: Request completely sent off
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000059 bytes (0x0000003b)
<=3D Recv header: Content-Type: application/x-git-upload-pack-advertisement
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000173 bytes (0x000000ad)
<=3D Recv data: 52..000eversion 2.0031agent=3Dgit/2.51.0.268.ga483264b01.di=
rty
<=3D Recv data: -Linux.0013ls-refs=3Dunborn...4f..0020fetch=3Dshallow wait-=
for-d
<=3D Recv data: one.0012server-option.0019object-format=3Dsha256.0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host localhost/home/bmc/checkouts/git/t/trash=
 directory.t5564-http-proxy/%30.sock:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy localhost/home/bm=
c/checkouts/git/t/trash directory.t5564-http-proxy/%30.sock
=3D> Send header, 0000000304 bytes (0x00000130)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 205
=3D> Send header:
=3D> Send data, 0000000205 bytes (0x000000cd)
=3D> Send data: 0014command=3Dls-refs.0030agent=3Dgit/2.51.0.268.ga483264b0=
1.dir
=3D> Send data: ty-Linux0018object-format=3Dsha25600010009peel.000csymrefs.=
000
=3D> Send data: bunborn.001bref-prefix refs/heads/.001aref-prefix refs/tags/
=3D> Send data: .0014ref-prefix HEAD.0000
=3D=3D Info: upload completely sent off: 205 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000287 bytes (0x0000011f)
<=3D Recv data: 118..006ab7ddcba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0
<=3D Recv data: 082627ca379a3 HEAD symref-target:refs/heads/master.0057b7ddc
<=3D Recv data: ba2d0055b73b625ed2f8eb921c83aab60666730b9ee0d0082627ca379a3
<=3D Recv data: refs/heads/master.0053b7ddcba2d0055b73b625ed2f8eb921c83aab60
<=3D Recv data: 666730b9ee0d0082627ca379a3 refs/tags/foo.0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host localhost/home/bmc/checkouts/git/t/trash=
 directory.t5564-http-proxy/%30.sock:5564 left intact
=3D=3D Info: Couldn't find host 127.0.0.1 in the .netrc file; using defaults
=3D=3D Info: Reusing existing http: connection with proxy localhost/home/bm=
c/checkouts/git/t/trash directory.t5564-http-proxy/%30.sock
=3D> Send header, 0000000304 bytes (0x00000130)
=3D> Send header: POST /smart/repo.git/git-upload-pack HTTP/1.1
=3D> Send header: Host: 127.0.0.1:5564
=3D> Send header: User-Agent: git/2.51.0.268.ga483264b01.dirty
=3D> Send header: Accept-Encoding: deflate, gzip, br, zstd
=3D> Send header: Content-Type: application/x-git-upload-pack-request
=3D> Send header: Accept: application/x-git-upload-pack-result
=3D> Send header: Git-Protocol: version=3D2
=3D> Send header: Content-Length: 369
=3D> Send header:
=3D> Send data, 0000000369 bytes (0x00000171)
=3D> Send data: 0011command=3Dfetch0030agent=3Dgit/2.51.0.268.ga483264b01.d=
irty-
=3D> Send data: Linux0018object-format=3Dsha2560001000dthin-pack000fno-prog=
res
=3D> Send data: s000dofs-delta004awant b7ddcba2d0055b73b625ed2f8eb921c83aab6
=3D> Send data: 0666730b9ee0d0082627ca379a3.004awant b7ddcba2d0055b73b625ed2
=3D> Send data: f8eb921c83aab60666730b9ee0d0082627ca379a3.004awant b7ddcba2d
=3D> Send data: 0055b73b625ed2f8eb921c83aab60666730b9ee0d0082627ca379a3.0009
=3D> Send data: done.0000
=3D=3D Info: upload completely sent off: 369 bytes
<=3D Recv header, 0000000017 bytes (0x00000011)
<=3D Recv header: HTTP/1.1 200 OK
<=3D Recv header, 0000000037 bytes (0x00000025)
<=3D Recv header: Date: Tue, 16 Sep 2025 22:18:55 GMT
<=3D Recv header, 0000000032 bytes (0x00000020)
<=3D Recv header: Server: Apache/2.4.65 (Debian)
<=3D Recv header, 0000000040 bytes (0x00000028)
<=3D Recv header: Expires: Fri, 01 Jan 1980 00:00:00 GMT
<=3D Recv header, 0000000018 bytes (0x00000012)
<=3D Recv header: Pragma: no-cache
<=3D Recv header, 0000000053 bytes (0x00000035)
<=3D Recv header: Cache-Control: no-cache, max-age=3D0, must-revalidate
<=3D Recv header, 0000000028 bytes (0x0000001c)
<=3D Recv header: Transfer-Encoding: chunked
<=3D Recv header, 0000000052 bytes (0x00000034)
<=3D Recv header: Content-Type: application/x-git-upload-pack-result
<=3D Recv header, 0000000002 bytes (0x00000002)
<=3D Recv header:
<=3D Recv data, 0000000018 bytes (0x00000012)
<=3D Recv data: d..000dpackfile...
<=3D Recv data, 0000000271 bytes (0x0000010f)
<=3D Recv data: 108..0102.PACK..........x...A..0.@.}N1.Pf&.4.".kq..H.)..H...
<=3D Recv data: U.n.}..6.A..%.1j.%...<.]..H.}..&.c.a......h.......]..{......
<=3D Recv data: v.J..n.R.-..+..........5...'8.........7..7{..x.340031QH...+a
<=3D Recv data: p..f.z...........i.i..#..I.O.E=3D.V....A4x.K........Ozb.l.B=
=2E1
<=3D Recv data: .....g..Z.Z.g_5..6..'..0006....
<=3D Recv data, 0000000009 bytes (0x00000009)
<=3D Recv data: 4..0000..
<=3D Recv data, 0000000005 bytes (0x00000005)
<=3D Recv data: 0....
=3D=3D Info: Connection #0 to host localhost/home/bmc/checkouts/git/t/trash=
 directory.t5564-http-proxy/%30.sock:5564 left intact
----
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--U+XVShsu78ywapTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMnjKgAKCRB8DEliiIei
gYi7AP9i9JwQsAgzNdFuc8lJ5//5iKaPMEH1XIe+lN2dTTd2ngEAleGcfqov5y+j
p6f3ZgdI1438LvM6EwOMc6kCQU4Ozwc=
=x7sN
-----END PGP SIGNATURE-----

--U+XVShsu78ywapTC--
