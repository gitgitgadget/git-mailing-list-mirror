Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A5175D5D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742049906; cv=none; b=PbsAh10V9HQSlY0DE/oGORnfUsZmVhILNorVJqXFzEMKOfLADSMzymMiyaGHQvQi3QH2SmjXsL0rWas5TC9TOcMoMuQzimpEFzzZQqTg/qEVaxEBxGOF1+9LYORSdqpSwKTCOsGebuQu+3RBPp4Mo2y1Yx5w7DcIngL+6JfRh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742049906; c=relaxed/simple;
	bh=wXTcYysXegITPpBKLlf4MM04rf4NzdJEZKEepxSwfEY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ni/TVAaYhgWs5V2+ZDPB1iSy/Vye3wVObn7+6l+9N3uH3GXkLQddbQ71AaJX1TUlDY0m+Edt21NItIG8lvg3of+3IW5UOj88S66jZ6sUBiDggJrpZ+5U9U8LK34OyyDPYk5ciRNrsUj1LWe7uPimQE4sGbgH/WQZkifR0L3Vpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=h7oW7IB+; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="h7oW7IB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742049902; x=1742654702;
	i=oswald.buddenhagen@gmx.de;
	bh=LFjNWNm3+R1EMu4hIe8gkJdxZJZIWXHTsIYj1vBvyuU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h7oW7IB++ooMGvM+kDCoxaBzjJXB/+KlU/QUvIS5kHk02vSXMMh5F/Tp8r5SF0tJ
	 ClwQNeODbclzKAkwVXgcqj+cCxlBDRIYHMKC7gj7gWC8AQ+61+vx8zzENR+zIf68E
	 1U3wcVRtnKDvz/Q+oTDcO/Y4KdpoGTdZayYpDbyD57iGZHovWxDn+jL7SVCX5XsOP
	 pv4axmokqO77yVeDab/hSZDpi951EMWhN6H8J1TznhSxo04wiUZKlVFYZAquvmUPv
	 jar8AMAekqaFM31u3IRC8UrOPf5R/svW+gU/mFLulVm0LVl84wk/WpcMcC8YfUprG
	 aRUtBKqbs69xK7iHFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.111]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1tIT360P98-00bGaN for
 <git@vger.kernel.org>; Sat, 15 Mar 2025 15:45:02 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ttSl3-RHg-00
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 15:45:01 +0100
Date: Sat, 15 Mar 2025 15:45:01 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Subject: path-restricted log vs. subtree merges
Message-ID: <Z9WSbUQw4VBQiOqi@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Provags-ID: V03:K1:C4w4MQgK4ET5uFMKFcnYUdVCbsVUZORMrkkT+QEIuJ2Gxkc+uSM
 yCduPBPIpA8B63/C3wubogd+tScgsnxfMQ9oewxbK43CczxWRFWaMQUlRKtOD7prevLixIZ
 iYqoDXc5h9UfTBRRejhOUWjEHtsba3FUE0MGR53HBEiBCx3TShFxAozDUqeQvDCQwcfgwbX
 PXkZ+z0FnBbkLmjgiVlAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dStiQO8kWI8=;D0suPrbLjzQ5Q5mjWbUHjUMeruP
 CajH3tklf7bNqtfG5+3RmUGulGMjOg3vg77ROHrDH9uBdpwsq2d/6qVX2XaSc8gn7BmxZNMrX
 tq9lowZJGeXqfXOuqj00MAwwJRbEB1jtwaj9FeuXFYfYfGpCrcp5sSBKfJ6rDoE9wfnIaIIkV
 IbHIOp6jhYd4LqbNzOTwUU8lOheI6Dv8hgOfbmtMvOOXAZFOEjgLIlQKg+zdKH189USUyyjEi
 vg/TZVp70AzKxdYTWAYi1iHpc8r5bSVB6eEDbWgjQNvATOGGPkl8tOPvfV9fllyfHIM8Z+oYl
 S25DKvpOB8VGV13A9mw0WuKZJVdf/2Ff8oQxfJmfoARa/MAihNKXGHvxVIlKYwM1j3ZEx43od
 tYCW6m8PvDbVKu+D9VqgiRET6rwxGhe5VBz7SvP82rgWQT+ffuit7rCLwApWmAfSlg/P9S6/A
 4fbWvNdEP3GmV+P72tWnH/Vwp+XS/yoHQxRA1zUKWwSbJI7VNSC2d0qQCPszFx4UJIMM0s2bn
 bjUUEIpMxk//zw6hSY2i2UZFtpqqqyAFI2QPaMGdeJ24jU3TFVTLYsCDseX0s3DagDvTVOqsT
 F4wbxqMEPFF5PCxeDpSOi6Uk8EmqOelS7qiH4R4A7A2IzjGZIjyY3nzhJT9vJddO5Fz4oq7qu
 07aJM9vp4VOUPGZrolm+jSWFVQgQHJ78iM9CLXCv01MwA6eQC4Zu+QYNunLV6+SwlAB0fbfcq
 YLWvvexpmtS0F4MMfaR8nn4P+bKN1AQZELkdUNhYRDrYeLbGatmV/zj/liN3TeJ7a7WoHhh6e
 +T0sG5VRzVUZC3fvS0pHA6vumb3Bh0rMdtD/D+73TP3mzkWxv45zRhvNeUvYHGus5nnbA+nTk
 97H1FeveEieTVT9F44SQcmrlXO3EOYhaAzLby3ab4dSK7GW5IvLJCXHkbMDkuQChCUwMYOKN9
 fOt068DEJysOdTAxocA7VXqw5m8Jb1zyNvx4OQHTRyoMVVYC1ARtROuFEUwcqKGhO0WQ4YiKH
 s96pZdzc3LbKbjtUfts+hMjISnG9L9PVpIrA2ck/aUV4WB1Gy5X4mdVd++w0VFDMvNOP6FRrp
 v0rbRwLhDrGLVfmvObkaHdCAqOrqilMUjeQm+muCYeGh99kb/9+X8AdvSSC36ns+cXF7F2Lzh
 DFnx3Spy4nrM463ub+bRLADWU+j6kN+AKoEAdWktMy2W96k0khwwlB9yva+/tOyVOvqERjJsB
 vlVom4Iy59C2/2tpLoSETW0FWI3WY9G3okXYCzvPYKeYc1oDIM0APCPLQmQKYpfOyWo+lcHgM
 Wn7pVM5dhdHMgy/2jVcFfTS0AdRYFZLsbLwdEjpxCY4IjjtzyPNWfsVo7Ql4RaAiqbiOotGJ1
 CKLNCdLY5x6GafWq/vbwcGmmfSr3V6hDirQhDVj+xURRNXeYbDOP4Gl1JE2G/tkRuz2txJr92
 k1OBxLtb14AEqnhfYXYuXKAK2kZQ=
Content-Transfer-Encoding: quoted-printable

in my quest to prepare for hacking git-gui, i ran

   cd .../git/git-gui
   git log .

the result is ... unhelpful. apart from a few commits that were done
directly in the git repo, there are only merges. notably, there is no
trace of the commits that are being merged (and the way gitk presents
this partial log is even more unhelpful).

i'm speculating that this is the result of git log not handling the
subtree merges in any way, with somewhat predictable consequences.

i suppose there is overlap with the fact that --follow works only for a
single file, which is also unfortunate. (a recent test case in the repo
would be templates/hooks.)
