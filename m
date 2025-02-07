Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA390154C05
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926397; cv=none; b=T03CFC73RSWXjvCiizSFDlvDtbyNS4yX4GEsNHc/p0aegYdLZujnQfmhWInwIGcMVjhd7EZyq/5HQaCWzZXQ8tm8KkbAsqrnmxJ+xK+sj7U7WL2kykQ6qFCFFXy5TjkVLh4QKqwetvePGVkZ3dSabj7hGQ7GUa6Zs2iBX1KZsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926397; c=relaxed/simple;
	bh=lau4bKl1ZDZZ9+JX7QoqAUtNFkqhng01Z9E2/ypp9Jg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ApPIaRoFXhYTxM2iYJdOc37mIh1m2/KsHKzvhVJWeQjd06FDwL1bO0xw1JdzLp7J6kXYId5rZVlhL1YCNVjv4uwM6rV1wyBchNMW4KMS+ihG80Yjgl9IcYFLs4Lp9vnBYJbAxGouVqo4k84AmWrOV+VFBa++uu3zMnr+bBIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=B0PZE2xA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="B0PZE2xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738926386; x=1739531186; i=tboegi@web.de;
	bh=VfzjVtHZUtQILGHW/Cc47KiVcv5X+PMr7gnULteWhCk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B0PZE2xArllvMB4owqOtOOlxAO4xKIfX4Ds+2vEChicIfYUcT7HLdwwySRrADNLJ
	 aaIzm4xJzQgJ5PeuymaOowIygRr+JfnFAZiAaKIOGcZFx/z7vfDER0iYrWrmrw5nh
	 LzwIfsi20+YpNtmK8GCY3psGs0B14QsHphkYEgiVPe8NuBTSr5zUZ5mDRC3Q6lxiD
	 rzAtL4oSN3laped1kmOjn+XHVL7xvrzh4fa4TERqXx+hUTblppZPQqvxJPhcycJf9
	 xrDAvBzkhHk40ejn3ZqupFjT8ZDtp6CRTcSpdEoSIp9VU9RpXuLoosG8RI40JcIDI
	 hFnV/3edzyPeeSnvCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1tmQCC2WJK-00DkLB; Fri, 07
 Feb 2025 12:06:26 +0100
Date: Fri, 7 Feb 2025 12:06:26 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250207110625.GA28576@tb-raspi4>
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
 <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207104510.GE30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:sDDcrUH/NFZe5qOy2FaruUQ2omX4T9Jrx/fZhYNvVjwcMbWgw0r
 VQMuabmpT5yWZxCg5pvjbtA0CRCOXMLz+NVhTkt/bUXq0ClqkF/bWOTfphXjUu//tz0Fe6h
 FIf9aySVC266GeWpAykA9wGgsEEuyARBEpLDW+RhysqYOqrYTgsj3MepfeCMyB7GL8Hfe/2
 juP678iUEpEUy/5Gb/1HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9nfuneZMjMI=;9c6YdOFGlKwu4Brh6ElrqWIFfVk
 qw1JqSpHk+c5lLTsuFlOATJcSmfGZz+qF8r7kFwDZsKK3TfX1AwvP3Kd3hyR37QWF8qYdnx6j
 FVEjHxU8Gh8LZr3rfl6j0PKyOyfQq2fYer1ufi9QXvkuDS91xurQtFpxgneyn5QpjH6Zd/UYl
 B4osbOCWevolCosqlhgLSTjgGm1KXccWq/xzJL3cZ1ahQElLv0/aLelfGoCLNz2YIsIAH8Siw
 UUjWmQxq08pPuQlqUwhdNuFVk90OaRwgswpCeLhYaSy/d0+mhpi8ivnPSojNs0mG3wbK1vQWI
 86PuGWyV3DoiabFm4YWQbFtYJhFU3FAfIOOLLo7szHWKwb3znbCdFTcp950+g3CL0INYuGHOS
 9jsUeHMT0M2wBNxNpejSC5VEuHZYM9lP1FeN53/FVyXQAac1RKYcPV0VsDqo/xgI4QPvaNFSp
 /M2eQORq4ZBqp+l5u1Xv3hsMNIpjrWp2s8d1GY3/PThckhtql5qbDu7tH1ACnYEO6QtyRmBxo
 vZCYb0AI6eTlhSV3KqMyM4NsFBiQVCsXpCFg46yMZNn53VSbW63HtR2ndgsGdXyqiO8UXXWXT
 2Wiz4nPBYBiAkNLLsf8vv/92t+KcJksmRxSxcPVC5OvL/rwvhu4JNOAu03JJpZYY66Zp75xXR
 tFeEu36uHv03cq0Ny+7B6iL5Bm31PJHqvcoBIDdoE4wXFUgjOCnkXOAk4kjk3H5Xsatnzys+O
 NxUuKCylruX4ow/VU531suMC/PsrOjG/PGkIty0K59HGDmx1Yug3AkqlWd3ErVoCetebFuQUL
 MynHULA2VFdRruioPZlZElu0FylQ9HCnIXAvBR7YjK5BAtYmp5OXRU053DyClgctXkVz6wjeA
 ybmgMKMSEV3CkD4hW6JznrWRfwMqDIwQT0omIFhyxD3Tx+UR3OdeFrr+q9duIX5pPxs/8ZJwJ
 l0P7bfMSBt/bi7VpuAwhZQRl01tJAj0kfRipBm6thdGhf9Zi1xFA7FXkp+5SfsvYMxgh1+8uK
 FowEP1H9GDtf+MOYuP0fGU+pwGf2Lf4NLQhd6UUDRnib8ijJsY2X+6JGaLqX+ysyy22f2wyw7
 iPM/T8o1UMI4IpsITdtKc+I6Mf1ao4xX7yiSxkz+rfK/rjn7gQ8CYCMJaYLVypyVAI+EZaaUU
 SzbJd6RJ6iH+/YSdcgkDOnHH9WUhS0PhGuw4PCqsLCRwJ797/Ryd6rJBXLNz27VtkisuO4P8C
 h257idof9Pn3yiG5V2dSaroGEZr3/kElJUYmn1HREdVUEHvXwVqg9yL6Jswr/eHXiNKt7O929
 2Jj6iJbh7Wk9rB5mtKqOdcC99Vi7AGiWTnmc9MrcN5Oo64n6BuOXsG3uhkhqVLCAVxep6CF/n
 32UuKv1cU7xchHKRgvjpqGNEoy0poMDojUsaj6cZTwSPzJPGVY3jh0oWbV
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2025 at 11:45:10AM +0100, Josef Wolf wrote:
> On Thu, Feb 06, 2025 at 10:10:26PM -0800, Chris Torek wrote:
> > [First]
> >
> > > On Thu, Feb 06, 2025 at 02:40:06PM +0100, Josef Wolf wrote:
[]
> Ummm... That's far beyond my git expertise...
>
> I completely fail to understand why git insists to operate on smudged fi=
les in
> many situations.
>
> IIUC, once clean/smudge are installed, all internal operations should be=
 done
> on clean files. So why do I need this "git add --renormalize ." at all a=
nd (in
> the case of cherry-pick) there is not even any way to renormalize before
> picking.
>
> But maybe my understanding is too simplicistic here...

Now, well, there is a lot of history here.
Why things work, and what is working.
The short version:
The '--renormalize' functionality came into Git much later then
all other commands, if I simplify things.

There had been different answers here in this thread, and I try to
be helpful.

In general, this could work, fully untested:

Take the first commit from your svn import.
Check out a branch.
Add a proper (!) .gitattributes file.
run 'git add --renornormalize .'
'git commit'

Now the fun starts. From what I understand, the following could work:

  foreach $commit original-branch-commits
       git merge  -X renormalize $commit

However, I don't have such a repo to test things.
