Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080A2C188
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="tzQWFms1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703267868; x=1703872668; i=tboegi@web.de;
	bh=/d7RRvXnyCRcxqGCmWo3VEx3m5vsgT31+HcTcLLOy6Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=tzQWFms1qf6YoyaX5zo0BEfUR2pqf+j8hLJL37+01br3RFv1Chg/dcMY2BT1JPE4
	 dLVdwXGsfNph0+D43WkNzfaOTZn/ssjSxppwp0vpkmM+9RIKd8em6QCcHY3gvkbcM
	 8ph3N/p0M+u1N2A12lNOIBXn5Nw+VX5KEtKVFZWcu694h6STmWkmolbhqjjAq6d3m
	 RdaemZkaVbJHyffn6oMybG43tD3Rpxlh25ondqnvsDCKctEPGvQillwZ6rN1+kpHa
	 2oNQpKwT+F85norIQ1n6VKnZC/rzzd9chFgASiOC+ktUEYSPh1g+XZvr0SpkXkHox
	 tuwT65eDUmTChi3oRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1rWj9K1cuQ-00GMng; Fri, 22
 Dec 2023 18:57:48 +0100
Date: Fri, 22 Dec 2023 18:57:47 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
Message-ID: <20231222175747.GA2880@tb-raspi4>
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:r+65TV1t9tdl88UO6qqAA2y/hfQ8AZzXOw2opr6HfzoKqKPkklj
 jw3ShP+J7nSp8Nl+ZF3/YdyaG9iaZETzasaTk9iN5UeuvLaw04MyZQzM7Rhhpdtxgk8meat
 CK18h5jCEI7bxxHXng680pxBVptRwI4QomqcVAKhdcz4jig08x1TLs8EDKAA/Qn1PUtQ484
 hmUil4qW3p6n6eJ/zqNuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gJXFmC23xYI=;w5ligThy5yYhtP6ceRtk6ANbGoO
 p0X2dMEjo+iiYzy2Qkfwc0sfCFaJ5sRT+Y1j/S6uNVY6X5Moiu9utQjZugmJXjj2WFJoBa+yJ
 VodBub5xnlBu3+b2gWf+SZnwdt5hvUCtYfZZTTVPYjth3oPMMI3Q2g3sXKF+85dTIP+QMDO5D
 7juPmlBHp6usa4p++4/jPK0L+CRI1iSTYqv6tRW+O+8ybO0LNoF/nL4wFoxz2f1KrTLVE/Vpu
 eqmpFd/6hXeS5/nZNYYN8c4l2AwkCIePUvM3GJ/r+w2E5WB3SjoJdmnkFV4YjqM8OZGqjdN09
 5Hc21VsOXnR+iAGMZC7nJ4+bAUCw3D84+m/DeMyfqBh9BBOmUfVmgCazmorH8idEGDLiXnY6t
 feFvYbpbmIBF8bWzfGmOrpjK9x07wd4ldhO2G02dwYk8ATs47DmQrL68affwNss9V6Cj3f1oF
 7ai8VbxxwUNClrX1v+9reZTV3sKjAGl1pFYb4NAuDugo0ZBkpLafNWmXFuOLnVTa5BDEmaOUI
 6Ym23Y+9MdeUNeIlDjrX0pH66Uz6MuiiHhK6pdGdRNN9OkU20c3txG4qzDyN64Ai771uQqgtu
 8QA7/HKGXClKi5F4bFZIewOLCLANHOR7lS7/Vq+AAKDUin5zea6MoVZO/31yEqu9IpE+MRdmI
 Qa0nzjkb9AzS8SFm1cNlBEkFczK2euhyCzNn7QhVBo5X0PM4d4SHEggmPIuo2bfsnaglp6BMn
 EYUkdjmKa43MJ5rPTjqPdvECyva+f7hf4FEdiaVHUX19TBkav2D5oBdLxSuEerr45uZJK4gbL
 AZ2+/y9qbafV9IL3D5exO+oPKpFYxS0Me1N/+bn1mt4m8pgZNSIhiNAQGA5GxCXVKgJK/xb3A
 4PkDgCaPtXh2KEz7+ytT4vyvtwNp9EmxQlBpzfPnWPn/l5hqSr58isYYXWMWn6qpzviLi7yVg
 vTgjcLG4W75o2Pce3YlTQjqpXsY=
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 05:01:09PM +0000, Chandra Pratap via GitGitGadget =
wrote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Replace int with size_t for clarity and remove the
> 'NEEDSWORK' tag associated with it.
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     sideband.c: replace int with size_t for clarity
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2=
FChand-ra%2Fdusra-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chan=
d-ra/dusra-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1625
>
>  sideband.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 6cbfd391c47..1599e408d1b 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -69,9 +69,8 @@ void list_config_color_sideband_slots(struct string_li=
st *list, const char *pref
>   * of the line. This should be called for a single line only, which is
>   * passed as the first N characters of the SRC array.
>   *
> - * NEEDSWORK: use "size_t n" instead for clarity.
>   */
> -static void maybe_colorize_sideband(struct strbuf *dest, const char *sr=
c, int n)
> +static void maybe_colorize_sideband(struct strbuf *dest, const char *sr=
c, size_t n)
>  {
>  	int i;
>

Thanks for working on this.
There is, however, more potential for improvements.
First of all: the "int i" from above.
Further down, we read
	for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {

However, a size of an array can never be negative, so that
an unsigned data type is a better choice than a signed.
And, arrays can have more elements than an int can address,
at least in theory.
For a reader it makes more sense, to replace
int i;
with
size_t i;


And further down, there is another place for improvments:

		int len =3D strlen(p->keyword);
		if (n < len)
			continue;

Even here, a strlen is never negative. And a size_t is the choice for len,
since all "modern" implementations declare strlen() to return size_t

Do you think that you can have a look at these changes ?

I will be happy to do a review, and possibly other people as well.
