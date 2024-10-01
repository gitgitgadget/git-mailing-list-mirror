Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735141C9EAA
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796587; cv=none; b=l9g1UWl8rN1tmT9VJvaig69VAPCO9pUuW2Iub7ERXiECiOnwVcWVdQ462HdPIDC2dWDbN2QzubAzo/5+JtE6kjfUF5645QdCH95+2J/VYhq2kNonChz8S+WEocCQDamzJGNQyoBNsCRVh4BrbVpMYPoBasWsX66x0N1YM57zXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796587; c=relaxed/simple;
	bh=MeJ5e93U9cYpToOpS15U3n8Yb+w/NZSDdZ00hXNBrrA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld6rid1fTDptHa+uqEJ2YXIEL7NQW5fBmt7hD8fPAMCTy8+tcwIFjhKILK/6BP4Wv3CwvrlfS9VfDNCpoLGnUERYkWXtFeaiFzH/OnXK/BrX3X/uOH2ExON4DwVBKBa/7T9ua8+7Rj25bvaeb3PKYrI7oTZZW014YdaWlDvTtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=WUlrmKvB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="WUlrmKvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727796582; x=1728401382;
	i=oswald.buddenhagen@gmx.de;
	bh=UGjojRhwPyJfPVUX/Lyojp0p65Y6738ogY9+9CPjyY8=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WUlrmKvBcTGy3Yum/bJODGT9hfeRU/cRNJnQg3Oo+qkQ6svqf6RRdyr1Umyo6+v1
	 COd1f15sg6/q8+obmSm5Wyazsi7Bz5iv9MmwGiPN3XyBHhSu8jURP8WvKmFhQk3G+
	 MbGa5wzthgPmJPF9AIk9gJCKdVHwTZ2haRz/oEG2g+QNC3gKs1ZlMSm4Rbf7h2lNm
	 yc1ouh13sA7Ohj5G8iblwf7ItEFrW1EjZTyMzwPHSPxwbPr0liW1fPnJHZ19Iqypx
	 DqxMcR9REmjxvlo9JHhJ7l5bW8IFdOpsM9yyc3ZvtSo6lEaw6oUZtdY3NG4Abov+w
	 LsSmcqEBo7CljLjXCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.121]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1saXIr2ie3-00PMII for
 <git@vger.kernel.org>; Tue, 01 Oct 2024 17:29:42 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1sveoo-UI4-00
	for <git@vger.kernel.org>; Tue, 01 Oct 2024 17:29:42 +0200
Date: Tue, 1 Oct 2024 17:29:42 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <ZvwVZs-HLy0RiP3E@ugly>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240930220352.2461975-2-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K1:7oqixOaRsXiJm70pSpDvPlVOwDurJZ13AMp1LH+HPFQpj+XxLMQ
 Cbv88Hr5tPD51kFpHx4olRefrv31OYAFDnBXZsBtyB7dA70VwoSdkA7PnOvqc2bACkQSSOD
 Xam0GiP8pJpYBwzDYhh9//xAI829TbN+69VCtpXJ2vX68vHPimRFe2er2dYOwUMAcnMEZC1
 Oqbo6gmBLj4SFc0/zTVwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IJQxXkrV8nY=;UH9oM+NKYTS+9GxEDfc9m+3c7Ab
 ddxKSiUKwKrNvHmquo8qMj6bthphLADHYmXjWo5QDs5jZj7rNJGUwJxzw7LqWh8nKvH7wMrfe
 lAr6q08TqSJLEbAF8fy3CGNvPaqo/LtY657pvnurtcNwEUe71IxpV4cGJsXQAPuhbdE+Ovh+X
 X2Kq2DOuLsfvn5JJEvcsIOugFUzBmBoK1LpJevxLvQl7Veje+dTlSp76ImERztIdVwF++7Hs3
 8xi1dTNenfh9MhLBmjrltGrOfiEpqnFkXCPygfrCYcsrwPYePMUvtKIlU+M42dxgMUKOy1v0Y
 NJh3oj3MjYyH4BsJ3eNVqhOzW4QsPCTBGJtCOQipI/ABDWEstgtJKEIFJBPTrhzgMvVyunocX
 Pm4bwXTwESWZG3CBeCWKxhPN6MOwz8PZgT23yJP9uDkS2qCEOpe5kBM87hQ2B3qT0bifCWiv9
 WhuB411PtTAjJOnNj47jaUxu6FTeKwkb+q2Nn15YMqxVAqPs+VcTPC3LpiJzGuxxa4UCZ20B0
 RsBAiOOGllLk9oGLzM2/TbpVcbcG02bRhJK6IW+8Icp99b6B8lQwZeRsQtUIhby/8s2a5ye14
 rPUeDgdCp/ueMvKEg3bRTPQT1LWFd00HD2TE4b5I407ZkniK3+APXPTkG8+QIsxA4ZsvXWy6r
 nOnmSsVnRMpzgnb6nFTL59OgIanb1vvqNOzv7sm2KXx/NCat/PwB1zQrLgsXXAEd1cSN5s2i/
 Oamb+QwB3GRbYEqwVyxYuQ6pkdjvt6WRTnMHTVSNvf336Govrrj9yCqgIgYlB4jljZrRWrJPI
 l9E7+f7xXwL7HIcO3b5c1oNA==
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:03:52PM +0000, brian m. carlson wrote:
>+		case GIT_ERR_MULTIPLE:
>+			strbuf_addf(buf, _("multiple errors:\n"));
>+			for (size_t i =3D 0; i < me->count; i++) {
>+				git_error_strbuf(buf, me->errs[i]);
>+				strbuf_addstr(buf, "\n");
>+			}
>+		}

ah. i was wondering how you'd address this ("this" being non-fatal
errors piling up), as i'm facing the same problem in a project of mine.

the problem is that one can either impose a very rigid formatting (as
you do here), or provide formatting options, which can get arbitrarily
complex. so i wonder whether one shouldn't pursue a hybrid approach
instead: singular return values for low-level functions that either work
or fail fatally, and error callbacks for higher-level functionality?

btw, the switch misses breaks.

