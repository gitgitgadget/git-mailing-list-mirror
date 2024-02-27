Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99214601C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046520; cv=none; b=d9PHz13pb+n+Ukapl3Emxkioyrdyg8J+KXS/7eaKrWY4gf2mZMWQ6KB6EPbyBv7RJ75g87Osj7B3W2tNTb0A2JjfPCdMP+hCtv3lE3EBy3FgwTvmS4mYiUoEJ+/ViXro8FKLhtL+Au+RZ5oMNe2C1sdvSm04rowU2FKFSjeUKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046520; c=relaxed/simple;
	bh=e4usUiVCrlf05nkbfUkUxXiwK2Mr8R67mBCKkwTAbuQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jfeUt3jSdyjGCYNh8tclUMqUHMjcU0EkxqRJtkZ/ZzzOsRZ1e7L7Ugio+WKvo51ZAFcnhJHZGByXbDIi8FMsdGK5yEpnTMqMgi4GINL/RPJWpM4r95KWMYEo87dVGmHAB9vkiw0H0PbIGShNygSM12FhcFZObxjXqWz81LinM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BWXD2qGy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BWXD2qGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709046498; x=1709651298; i=johannes.schindelin@gmx.de;
	bh=e4usUiVCrlf05nkbfUkUxXiwK2Mr8R67mBCKkwTAbuQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=BWXD2qGyWglzDukhDyfLHdjWJO+nS3tGSnnBwc1JSyLWQFpjhg1NOT2QmcKesv/7
	 7jtcJPiiihmwHY0gvuvLgRYicBhDv5gf9928XrYmFTkt9G4sNYL9nqAFcOGlxAkw3
	 f4KA0TnaKVifxQSTgyYYFApw9JYMgk+fcs+gM0r2w4i4j0bvrAhBIbsE9ICBZ4O6V
	 I3icBB/dUdNvv8UAP8J+yg3bU1KUHylQxDt4oPk0v9bEHmqmQFk4bDce0DqI7rO06
	 9vCpLJC+p7xeeMX+VvlHCUSaUogsBuUTp4rQIXmexkZ+AzncqB4TpEhOj/bw4RNsB
	 pDYRDPfiNHoXcDQJlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1qjI0p0MEL-00vfh3; Tue, 27
 Feb 2024 16:08:18 +0100
Date: Tue, 27 Feb 2024 16:08:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dirk Gouders <dirk@gouders.net>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 05/11] commit-reach: start reporting errors in
 `paint_down_to_common()`
In-Reply-To: <gh34tenefb.fsf@gouders.net>
Message-ID: <fa8ebbfd-e01f-fbde-c851-54c162b610ff@gmx.de>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com> <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com> <85332b58c37717b5b8b6c826a2a3388dce3b0daa.1709040499.git.gitgitgadget@gmail.com> <gh34tenefb.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5i84nErWoxHGdpXu1LSqAGfy1hZv4+rsoynGsF0lOJjQ4/K0eWU
 po3384db1/7SSDRzZFvhSizJLLTpYIA8T3L2oFpxKFISah0rjUfg/1GiOiHfG/gNk8mHqLR
 flIj1AxYFlR01dPVcvnusr5TeBDWL9lHpy8jqYWOtPnoGHHCDnc1IG8w6tQYNTItmN4SFY1
 eEcN+v8rvONfXVQzF8i1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lrc9PxcqVCc=;A8P/HaRSqMeq5iQpQbL7tfJbtxV
 S2+DbL1pFvZwcOwlfOaNRR/nRHquAWDZiyHVUyo1sHvWsi1yGGZ7SssKlQLzrdLxQYhPtPFzW
 C3S4RvdrS7nC0TpzwsdMKjS5+QNpTsFADDbYhV1uVvjzql/tBLtrp25eahMNBYQ5UR9z9QPNw
 48l8bNNPge99NlWC3kB8IJSw3GiXKv5/SmcYtkw0shZK4J9x8AKl0PQ2rp6z0PDsMjUqyflwk
 yPL0l9KRUcR811SpNwQzO6YVz8t5JMDoqi/id4dsMOQbVLfA0Ae8KRsbUiQDQhtLi2Fw1tibW
 Umq3OqcU+bjSaPJzaut9unKelSEVGLLSMBHdszUkfzQBE9LbL24O3ekmZay7X4iQRZ4saaiDb
 S4IDzHsvMNq3SrpdnhSeLnmzBt2RBjHOoHKOVqw5UymXqCitIWjEMKpWIv/9HA0mZnQ48F9kS
 D/SxkHOTRjKIfGoc6v6lDGzmO+C8nu2OH9cwDrWj1JZzt6Fz6OzPalh4DiNERVctrQjqvfHWj
 5hOtUmF1nmurR/J2X1aDT6FbGr0wJJyRD84v915qtHZ4QxmqFDf4Qsei+4WneY4gWTYWnlJ4c
 8vS9oPXW4fLk+6oxDholf6wHSdcDuQp85FUL9g75Af/UcnNzPnnsFX79LU/i5VFjG1C9pUvuG
 baynR/WMuPFwtfFotthTnLP4orj8tzChPZqA6aK3SW2pX+5fzjBLYbQhwujS6Z1ySmuYPEsua
 wCB/AYLcsd5OFhFJIuI3s24SHz84bLX0v2jDOodF9TUlqLCHMj+ovVuGejrX0b7speW49j0ib
 S4Xqe+JqVbfbGWO8CcaJKX1OCzDexX7HOf5c7UgI4SNWw=
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

On Tue, 27 Feb 2024, Dirk Gouders wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Let's start at the bottom of the stack by teaching the
> > `paint_down_to_common()` function to return an `int`: if negative, it
> > indicates fatal error, if 0 success.
>
> Kind of pedantic but the above doesn't describe the real change, i.e. a
> value !=3D 0 indicates a fatal error:
>
> > -		common =3D paint_down_to_common(r, array[i], filled,
> > -					      work, min_generation, 0);
> > +		if (paint_down_to_common(r, array[i], filled,
> > +					 work, min_generation, 0, &common)) {

The fact that we do not bother to verify that the return value is
negative, but only check for a non-zero one instead, does not change the
fact that in the form this patch leaves the code, `paint_down_to_common()`
returns -1 for fatal errors and 0 for success, as advertised, though.

Is it lazy to omit the `< 0` here? Not actually, the reason why I omitted
it here was to stay under 80 columns per line.

Good eyes, though. If `paint_down_to_common()` _did_ return values other
than -1 and 0, in particular positive ones that would not indicate a fatal
error, the hunk under discussion would have introduced a problematic bug.

Ciao,
Johannes

> > +			clear_commit_marks(array[i], all_flags);
> > +			clear_commit_marks_many(filled, work, all_flags);
> > +			free_commit_list(common);
> > +			free(work);
> > +			free(redundant);
> > +			free(filled_index);
> > +			return -1;
> > +		}
>
> Dirk
>
>
