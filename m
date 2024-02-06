Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0E1332A1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219156; cv=none; b=OParlkR49cF7qkI9GqxMstS6uQSgtIkWsQWw+3fH1APKi5yVASJflphr4oLtSnNRYwIDCtFk64iQFxGwP20p0xsI5gzh0ZdjuMd/1g/Wvp2Mc1aIpSe2Y1l9JGUF2uvkh3C+B86eEAMNgpMPbK6gL0X5o6bAjicgczngEv59Ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219156; c=relaxed/simple;
	bh=0OgUWsHJq7XS5S9Jt+nia33dwNXYppGw/sZldofzzPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XexcrTXL1FValOHv8nHT1dR1dTeou8incgRSNezUL3ea2ckUVcDIxMdxZ/PvbX4fln3c7MyprJBGQW7Fiu3clz4vl7LEfdgOE66G0PR6V71ZZRJmxPfGBPbkM7EEBXvXa6zV66wUyNrGe12kJiDRECXQKzBJ9H8wTbd+hNklP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=jESFiYlO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="jESFiYlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707219151; x=1707823951; i=oswald.buddenhagen@gmx.de;
	bh=0OgUWsHJq7XS5S9Jt+nia33dwNXYppGw/sZldofzzPw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=jESFiYlOkKESjRew92B9sRfI1HQgGlpxCmhlG1H2q7H4ZTIR94CZnNVh0AXnk1CP
	 kukg+esOh1UVpIcYi1pJWymJjedQj6eMw4C3bsK6nU3DeqoIyR5Iv5ZJ2295JJX4t
	 mh20FU8oR7t3xlKvhsWBgJjAQUT4eEY28YohoRYbZlY4eslblU+YnK1SbIQCqIrWH
	 NGeW0se8VqTVVStBsttnbl6fsD2SesxHuCvxJa0pGpI2P28Rr3Yo269snjft5h0ju
	 UZl/gcS2Dv5oi9Jn5TvKD5vBHEpWGL93ZJ6snjQv5UWaPcJI5kT82Y0ZP+CFa1u4K
	 sBkLs5g5PiXG+7muIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.97]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1qz5Wy2GxD-00bORs; Tue, 06
 Feb 2024 12:32:31 +0100
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rXJgl-vVR-00; Tue, 06 Feb 2024 12:32:31 +0100
Date: Tue, 6 Feb 2024 12:32:31 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: is it a bug that git status show the in-progress 'edit' in an
 interactive rebase as 'done'?
Message-ID: <ZcIYz82iLxPOVR9Q@ugly>
References: <CAC4O8c_oKT+a0hm+tqSOG7d1=AuJJKy5bsh72cJKVsWynvHw+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAC4O8c_oKT+a0hm+tqSOG7d1=AuJJKy5bsh72cJKVsWynvHw+w@mail.gmail.com>
X-Provags-ID: V03:K1:aVFWdBENGGChYqrLXR6Ql7pexHMiJ96PkqgHJNLM75tb3eCXF6J
 yPL4nEWt3qXNsNQjJoF3CTb3KlWBR1dTaKmgcMbCP9UbogT1pI74pRJi7qXGdpnyqy8BJrm
 8PVxNWF7Mc1PA/1aocjfitAg51CDRHceAS4zZyyxqNGGz8coLXs6IV0p1E7G4r1xAUCcMrA
 /sSdjNvf5K2UEeNGPtCuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GDYjdE8RAQ8=;XYDUwcN1QMUV6WPM1KqAVWl27ln
 f6e4vKUEeHXycc0vDOk3LvufDvt1iP834P/Tt3MwC8FZC5HUKOjJlHY2W2uRRZm7kr+f+z9Ai
 9k0VPFaRKqGMXf2MniwPB8T76C6jQCl/NVQBZkAbtFtsjlm9k56CoPGjHGLSNF4YkQ0LoYzoj
 zmNu5LoZkllAsSuCn9CEp5Z/DmyNh6/tMV0PJ1EeAjbJ8DSRJu+wq9EW2XdV7xMi76Nuw1Ysi
 oPQ656LekVgeF+d5xXZMWxZ+vkEwy2K8oN6PCEIrzImRwv9tfmRK+knmwXLoEZXOGpXLa2Dc5
 JyJTxk7D57Dop3zKTsrpbyw4QB6y+0U1d5xjKhKFh+SQBNArVNF81EL8+ZlaYe7DpgxxqflfU
 +fb575LZAK/E4x4e0Xv6BiHNffWDuqKQJS/qUtwuQb/GJTb+uKj1UNtoJI86Jj4+5lzH11MvD
 8Nd/5YPcGSvafb1ASqbHQi2ChwDUbsSBDDtppgnbrRfjsQyqRaDuhunQWBWGhV4PaCdJixImj
 4fdIwUSACLqbf0gLhHUREylnke0Z94ZZN2+rTkiGI7Ij9AW/oGxzq3f7vJKQFlqt1ErZtfoZf
 aV2poqmIkX2E3/PKZyBi9iK4mWbj7TyTw8f/ww9r6zJeBHf/qGTUWCGA74iITXH1i25zwxHfB
 UmlMoKfjfVHvGcwPAJX3+FKlbyhzfYVRiEbIFhhOkmOSzQ3kU2M1fbVrpi28SkC+dBp0K23Mi
 jTTxzxZOEbjqnOddvCOlSLW0CKI6V5wKtqTllL4TGaxLXauz+cTKh9Z/K63XHkoDGUW7ev6VC
 vV7KYDPmFkTxcZM7QWLUSs318MDSIdTyqVlyxNwsvr7BE=
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 01:02:43AM -0900, Britton Kerin wrote:
>>Last command done (1 command done):
>>   edit 71b73de914 message for first commit
>>...
>>You are currently editing a commit while rebasing branch
>>...
>
>This seems wrong, because until git rebase --continue has been done
>the edit operation for the first commit is *ongoing* and it would be
>much clearer for the output of status to accurately say so.
>
it makes a lot of more sense when you decompose 'edit' into 'pick'
followed by 'break', which it essentially is. so from git's perspective,
the command really _is_ already done. note that in this state, you can
do all kinds of crazy things - including adding new commits (possibly by
cherry-picking them) and even dropping already rewritten commits (using
a hard reset). so in a way, the message above is even a bit too
suggestive.
