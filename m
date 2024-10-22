Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014119FA8D
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605832; cv=none; b=rxRnIjIoerqnpcyJDRQb8dSOP3YDjUDe27pvvlc0E9etRt5lqjfJAivnmFMy7lcGJrVKKl4x3b0+5fM4MVtErfOvfOPsrGBTFuqs5K6maOOWohqk5+2CAd9NzbZuyTWqv2FrfbG5IP/+UmVP2FabWpp3mmlPtMhDJ+ga/uAodCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605832; c=relaxed/simple;
	bh=z8IqJo60I2xVoY8TLImSCq6QQl+fVxAUKyfpcnDjFyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1AHUIqeu/uXRXgXe6+heR9tC1o5vNosxm1TkvR6LHA09zq06L1DHz3yTUJsLTZ3JSSJP0oZmH1Ymmkor5KxlYEd3YauIX3WR7iv8Uj64Xj2iKfa+QmJg0wN/xGdk21BtaPXKO50LY+EbiLp7e4FeIjci74mfJSqKxCBj0cmUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HAUqUtrs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HAUqUtrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729605821; x=1730210621; i=tboegi@web.de;
	bh=z8IqJo60I2xVoY8TLImSCq6QQl+fVxAUKyfpcnDjFyw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HAUqUtrsQE90Oki6ZB3Hqup5XcB0FXUNHjXqh+DkvZLqfyl4PAojafShwtoYto5Q
	 b+gfPIjfag3AhBp2hwlU7dtld0Y3usVw6ckwug7J/H/cM8T9rjyVqjh70ZNEklY6Z
	 w4PjXn1p/Qavx1ZQ9FuberhSvEPEyA8xEdtrX8152By8xGTFtucefVIEM15pPC++G
	 ETWHaOct3OFb6WsAp0TQ81IFz7SFIXDik2e43j8H1EzUXpxBPypLDAwmgrqSDPEkc
	 /L4CrCNzrDkI8dOpVLnMRgfibK6K9pwCZTBllLGcYD3ppfrAW3C5ozjYP8fCszq6g
	 RCRVcDAF+pmIbx1ghg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1tUFLW3p78-00UNnH; Tue, 22
 Oct 2024 16:03:40 +0200
Date: Tue, 22 Oct 2024 16:03:40 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: git@vger.kernel.org
Subject: Re: Build failure on RHEL7 with 2.47.0
Message-ID: <20241022140340.GA31399@tb-raspi4>
References: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:kCPhEjMNBc3b0XJPAdWIeZsAXRD1RVPj2WGGuT7MkWZIgd4XJFG
 kNyu1+fcA7DFQIMxeDKquWj373BDWO7OP9LKPIQWsy+W+0saxY2TD/lY19BIH2xwKY2X9C1
 XrLG4Vj3RVMmxabt1IBzleXcOCvREbIlSa/8GYSHo+sM2Tp95t8SQbVBf/zYiQ81ahBRsv7
 m9qs1gi1yVC7CXqXcX/Sw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HUlup3cfIXg=;Ib/vLkEkWun3u372Wk92i7ILVwX
 jF4/c9reGYH4+mNJxzXH7Bhd+mlMIRnfH8814te5g+5SjCYlCc46774ez9dqofZpZQn56YLn6
 T9TQvDouotDzZ8TnE2TqmqlTwhehVBvgl1nKysHy/eSV691tpOYe+o+gB2b01aUTiQ0Kgeqcj
 oogmPc3xOhPswKIb+ci96hTk8KmQbT8f1lYiVm5TLtQ8YpaZj2H9tpajmv236YEBRoQRq7WE4
 43LqwmI1gX2Tb2R4BnRNfKdjppcvgEsqtgZgIiKH/H2sz1Ue51tXbvmP+HSKzZAjjahgY5N2h
 0koEpSn9JOFne16gdFowuBVoWXeneRa3FhWHPuUCdaiJvQl7vgVWJoemJ1MMZcQhOIdqvBgLk
 LsikZ4OLj8BMVHhwv5IVeD/n/ehpS1q9Lmf8OLqhEnAFjVUEF/eNVK4DA6EqpOM8w4CL+WiRs
 IB8ePDvnbTg8enNl4yOTQwZCS31L9T4QLyE0sVgZDK7sWPH6+smDEhmdw+ZD96FmkoJSEOx4e
 bs5wkFpEdNDsDjg9aWeFnm/ho6v2bS2d7cmFCXeHE7jRGzvZklpJwFwIKdM69A/GrUuFOKXo7
 aKVdcdrHOFYR6/m/8w5si9ctMZoKH/Ok35jc5tKbcI9Cq1ZmRvlGzDfvBwNDklxQsHOlFMXXR
 EXW6Nyb6DXUEXJsS97akWY4wV4CfF8hC9Vc2t9FxSogdbTW9ztkZf2sKXEyUkJsJLSyT28uzk
 cNyjvVvNOaPkVCyxqs892gOwFhUiHQL6Tl3xazG2GsmPHbnmYq+iZOzugMEed//UPB8SmCCC6
 4xG+stl0yRtQ1sB/dcJYfIOQ==
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 02:04:52PM +0100, Mike Lothian wrote:
> Hi
>
> I'm seeing build failures on RHEL7 when trying to build 2.47.0 - RHEL8
> seems to be fine
>
>
[]
>
> Have I done something silly or is it just too old?

2 questions, 2 answers: No, yes.
There hasn't been much focus on supporting these/this old platform(s)
the last weeks or months.
Thanks for reporting, I myself can no longer compile Git under centos 7
any more, but I am happy to work on patches.

>
> Thanks
>
> Mike
>
