Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889FF4EE
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371128; cv=none; b=Eo4WT/jKd+g8SubhPP9UW4AAGWasEHkhyEP7p+MqK4e2T9zJlvbK2KJZIH9wN910QdXYSrNSHT++z8BziDBpx0wUIxsdC+UmdwSG90nFS48JDp/urqIU9LgqBh6DrXd/dRp1/PlZVtxrSlPYCJPuELBSPcC/1TT0l1aNt0qcKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371128; c=relaxed/simple;
	bh=xCar2wpx8j5MOYQlOyyv1wuVlVnAFjHu/7woRCTF9lI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kRLQYIanNYFAJJlwAxmUDplCB5rzFTrSy0imlf9Mx9iIIG15f/66F/3I9E5bRMHeMYlsB3oWKa2HqGsQNUvMYWBxAkHQOiPV726afgWFVqFVQxEmz59JuQiucLUtUPESZ/w9fDz/zb0IM93Co39l9ZLsc1LqWna9z5WtVnKlapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bS4KpYw1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bS4KpYw1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714371124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H631fAVJJO/H9q/hCGbjVfgseDV8HZfbx2/8HcxGwQo=;
	b=bS4KpYw1U5pfb6ZOSauf1V1sYIFKuRNoWdtYBmHLwq6jKr50VUV9UOBfMn9kT+BRS+Dg10
	JdWeWCWdA3r/AjMY4dcodC3dJ4or7DxayD+IEvWqwq6QMppe+klRnovk/3ucD9R9JDnTZv
	Rcfz1hipz2z2oM4F7xEZ28o3cwS0LSVrZCoF4b7qfGDsWoYu/0eSiGdpzJS7/nwVrx2V99
	Vpiv+2PdPn7Q2evV16q4/mBeGVtZl1OL7dzLcX8C8MfUZaN9g0MxFfbvZM/elgjG/n1/2U
	Oi2HNDzzgS7dz1hpSOyZ4upVWrDj3XpDq3AFpQzJVJ8jH2tSyGQij3fEikgMKQ==
Date: Mon, 29 Apr 2024 08:12:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <CAPig+cRQVD9ZrvBd=49S6=9WsWWNdUWp1u9pADSv17bh_vJGTQ@mail.gmail.com>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
 <809a1452fb18a6c03d9e8ed516d5c9c0@manjaro.org>
 <4991578233e75f5a9f096b701c4b5efd@manjaro.org>
 <CAPig+cRQVD9ZrvBd=49S6=9WsWWNdUWp1u9pADSv17bh_vJGTQ@mail.gmail.com>
Message-ID: <058934338d2ec673958951ae98d55f87@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-04-29 08:04, Eric Sunshine wrote:
> On Mon, Apr 29, 2024 at 2:00 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-04-29 07:36, Dragan Simic wrote:
>> > Regarding what to do if those two options are both supplied,
>> > it's simple, just error out with an appropriate error message.
>> > There are already similar situations in the code, e.g. with
>> > the -k and --rfc options for git-format-patch(1).
>> 
>> Actually, the -p/--paginate and -P/--no-pager options can
>> currently be supplied together, which isn't the expected
>> behavior.  I'm preparing a patch that will cover this as
>> a case of the mutual option exclusivity.
> 
> Please don't.
> 
> "Last wins" is an intentionally-supported mode of operation for many
> Git options. It allows you to override an option which may have been
> supplied by some other entity/mechanism. For instance, you may have a
> Git alias, say `git mylog`, which employs --paginate, but you want to
> avoid pagination on a particular run, so you invoke it as `git mylog
> --no-pager`.

Ah, I see, thanks for pointing this out.  Makes perfect sense.
