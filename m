Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DB14B084
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363417; cv=none; b=cc3H/dx6+G80hT2sL3JLUz2BgNPX1vD5/+6GeflKoPnY1k3agx/BJdLvdcxY9DCKkdmup3ZprNLfoyMMTcoS0uO5th6ltbrvs2x6KAifLOY4C5j4DNlQ1B+8rw49p4dbDrwr3g4YCel8S4BPv0HWLijZ7j+uibTpUg+tWoPDr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363417; c=relaxed/simple;
	bh=RbfFdeL0xXtSBcLLBo9M2gqBkVlLzLoRNthLfJ4rZ0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GHhvRpy+n6LMZyTq7x13vUwv6G0+A/UIPH7Lsm6yvmut9+XDEfHC20X5mZFmdpedXdIK1PBkQ2NLDrzY7IOwNajAbDO5O6TUy63Z50StlitWpsEx0G7eDLRxFKGUoLBAkuHRj7B11SIZuym/vTe7wUCOPbGENlygUVy+h5MFx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=mike.fink@gmx.de header.b=sBwwF2vI; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=mike.fink@gmx.de header.b="sBwwF2vI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730363412; x=1730968212; i=mike.fink@gmx.de;
	bh=POODQKEu79VLUXCiXbHMmex2WXxq79rnTGS1c9bx/wY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sBwwF2vIJ2mqF9ClO4wRAxKMUuA/1UdNiVpUVWgSqa2mjxWOhdbWVYKArOxKBdNc
	 dhw+V4Ev9/5+w2bebcyp0HcmoS3RJWyASUPU4Qe29aMsn1YiQcc2jSIVzTFAHAnF7
	 2CeUwqNJ7DJJ8b3nF8gDSVuqsE1pu/DNvB8AkzO0lBPG/HGVCuB3sTU70bcKfZvf2
	 PFQop0iwUIFktp+869f0WPlFRn+QWgX7i7dZJdm00j3CaFXoyIxtNiyhRXK4haDmU
	 WNWNcDXF7Vq6XfTQsiWxmN/i/Sx41BiLOdznjJPqUGoJwe5AVOz/hT+6V+C1sSOMM
	 /zncNqXGJGmwGoFcoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.110] ([77.179.151.144]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1t8MVp0wjx-007mTf; Thu, 31
 Oct 2024 09:30:12 +0100
Message-ID: <17601d47-5d44-4516-b4a0-052a0023d537@gmx.de>
Date: Thu, 31 Oct 2024 09:30:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to checkout branch that has a new submodule with
 submodule.recurse
To: Dennis Lubert <plasmahh@gmx.net>, git@vger.kernel.org
References: <0218f6c7486cb6747a61db4a9d4990eab11f313f.camel@gmx.net>
Content-Language: de-DE
From: Mike Fink <mike.fink@gmx.de>
In-Reply-To: <0218f6c7486cb6747a61db4a9d4990eab11f313f.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wSf/wnsOiTmiqWTh7suwm9HBQVJizS5vRsFH57aMM861hzA39X/
 qArsmxDsysbSw5yuQSbt5vM4eXZEGtgsGepAV0+lfgKYad3ZluERaDxaQ33JItmmHutZUtS
 FYzG5BAxG9HMpAdspdM31cw59KchvPbzVrrazbiDDN0pTtdjm2m7GOE0QhP0HTw3jOx8IyY
 FfIxOGo04COiIFZ2ojvXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G5KaDLJxMT8=;Nk5T7pTBx4pR0Bg8UrHF+bzYFym
 xnA9fxTiCq93MQeKCtwKCPzUu7RaUCWhH7mtXLfT2r6lQ0EiouYwx6CWrKdZ7ntoUGkyQVSZw
 Rl9PIc0LFPKw85WgqTe18Tl6GO4tx+e7qRx5rD1YsB3XD4GYN1jj25r/+ZZo+2hpN8XtdFW8v
 AllWkZtwi1xZH6DpxnmJBVFS5sgmoDXXKyVtHoyHyWqHFvpwmlUKqEUqNn1tZxXGzDEWC+1cG
 hNVfMSWjYcsxOJzrRlloXkUlAjnrQNoQw2R9Yrq4YKhQvChscB9P0MGhSAnmcpC2y1oDaWg6t
 tlEaWNAoERpFWNZU9QnDvgO/p7L7dFzjGo42pjod7pyecbzZF6M+eGuJafbuYILKRFzLNP/ic
 KCHW6xDVet2+lOdPS2Rc89otl5PfhAYqbB45I9vH5xiX25I1kUi5wW+nLz03WVFNHEUlS46uR
 upGk1x+yEmxQvpiIuiKOj40EzsR8qWJ4CuMWJOKGLFMz1d4C6n0ADkBb88JmBWCzOVQKi165M
 yCqtIZy43vs02wgG7RCN+HUTBifz09wGc4JuJn1n3fqTkucUpi7gNIg3ZLXg8Q/3a+ZTrmAUG
 y0mKGRzEiuuFLC7ni4V8fbufAIqXCUTv033i7Ip0EamhfAhL7gbIv+BHqtB1rxyC0mlh7hvJ9
 tNr4LAZZum7fgy2cZvjNAhvrWnr88alE6lRtvIk2I4TQqB23HCVAV+m0OA38XztRrVKYh0Vfn
 wO84KDPpDcdhD2TLm7cf2LycfUW7PdavtYmFfwTlb7jMD8AJOfLIVy+Mw2d1Jy5JUjpLEI5G4
 JD8qQV1DGMcVRhBnCNcERfmw==

Hi, comments see inline.
KR, Mike.

On 20.09.24 12:24, Dennis Lubert wrote:
> Hello World,
>
> for years now this has been bothering me. From time to time there is a
> new submodule in a branch and when checking that one out with my
> standard setup I get something like:
>
>> git checkout branchname
>
> fatal: not a git repository: ../.git/modules/submodule_new
> fatal: could not reset submodule index
>
> (this happens on all versions up to 2.46.1 and OS and whatnot I have
> access to)

I do experience the same problem with the current git for windows version.
$ git --version
git version 2.47.0.windows.2

>
> While the workaround is clear (either clone with the desired branch
> right away or dont use --recurse-submodules and do update --init
> yourself), this is quite unfortunate for people in teams that work
> mostly with git integration or gui, also because when this happens it
> leaves the repo in an annoying state that needs  a bit more manual
> cleanup than --reset hard sometimes and especially for people that just
> use the basics this can be overwhelming.
>
> It seems that there is something wrong going on with the order of
> creation of the .git file and .git/modules/submodule/config entries,
> but I am not deep enough in the details to comment more on that.
>
> To help reproduce the problem reliably (hopefully) I have attached a
> shell script. You can run it in an empty directory (please review it
> before you do, I hacked it together, it might delete the wrong thing
> accidentally). It will need local ssh access (though I think modifying
> it to use local repos as submodules could be the same).
>
> greets
>
> Dennis

