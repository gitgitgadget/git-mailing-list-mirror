Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B0314A7A
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208136; cv=none; b=OkUVH7yoYH3BKONCfQL9+3Gfi4lzruABmTEibx6yv5OIPlKoyLQjEyzCsJ0vDCL+Px+SSbx8Mp9X5RIGos/jgTq3w4HC8RMBtvjCTaCpkngizLCZuNrF64LHXE/vXnPNFKKcUma9yXMxqfAe6mSKhkqBEpiAO8n6K1LvVefK1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208136; c=relaxed/simple;
	bh=JnXxMHea+DWg9XuOa+z699hxjibZoAskSZQwDkyPBg0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cp115kywH9DovPeRKhBfNrxhOQYrXvWa0XYcH0mni5FuxuW/4azLobO7jfY3l601lYOe++Skd4lV4qyL8AcVZPEZUm8fwOHm8cGrme8AGLYNdGu4fENnKStKOijnJBgKvFRMK8e0+Om3vKSzKDPFthQk302xDOf2Z0osE46b/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=QgIq7h69; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="QgIq7h69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Transfer-Encoding:Content-Type:Message-ID:
	References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UAx9wVMoI5WruKIEMzecyLV/egwLXgd24f1AGOcqlJQ=; b=QgIq7h69V6JyAnHN57q+F2B1BK
	rlZVqrzJ5pfv5mmB7HxvSHpyP3DRpT3Alz6mUzSp7YQQYXdLo5sh8riWyERg7WRHcaFUuiTtfM6Tx
	kj7Z07spvc7jP2JqsouIHGRGUl4mWu4qpmjg5B66IRd2YxM2aIju+LyDLB0FI9C5qztPzKM/zDWzp
	dfeVCVnl7oCwKkw777lo/OWvEvZwJY3k3dIKVN5x2/c6fJlQA0sqhQ0Y1ntUn+9eLnsUyb3IaTf8s
	2pzOZJdG/QVBYyJWwptxyLuadHdIxaa+6+8KGHhn9fBewe286RIerbSJzdGdd2udK56e2Wlnv6jx9
	Y+2ikW8Q==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50] helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1vnbWz-0000000768F-1KQe;
	Wed, 04 Feb 2026 12:58:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Feb 2026 12:58:05 +0100
From: Peter Krefting <peter@softwolves.pp.se>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada
 <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI
 <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, =?UTF-8?Q?V=C5=A9_T?=
 =?UTF-8?Q?i=E1=BA=BFn_H=C6=B0ng?= <newcomerminecraft@gmail.com>, Teng Long
 <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, Jordi Mas
 <jmas@softcatala.org>, =?UTF-8?Q?Matthias_R=C3=BCster?=
 <matthias.ruester@gmail.com>, Phillip Szelat <phillip.szelat@gmail.com>,
 =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, insolor
 <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>,
 =?UTF-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= <vnwildman@gmail.com>,
 =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= <pclouds@gmail.com>,
 Ray Chen <oldsharp@gmail.com>, =?UTF-8?Q?=E4=BE=9D=E4=BA=91?=
 <lilydjwg@gmail.com>, Fangyi Zhou <me@fangyi.io>, Franklin Weng
 <franklin@goodhorse.idv.tw>, Git List <git@vger.kernel.org>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
In-Reply-To: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
Message-ID: <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
X-Sender: peter@softwolves.pp.se
Organization: /universe/earth/europe/norway/oslo
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: peter@softwolves.pp.se

2026-02-04 10:31 skrev Jiang Xin:

> Please try using AI coding tools to update translations in po/XX.po or
> review historical translations, following the prompts below:

No.

Please disable this altogether for the Swedish localization. 
"Translation" using stochastic parrots is not mature and just creates 
gibberish that takes more time to clean up than to do the translation 
from scratch manually.

-- 
\\// Peter - http://www.softwolves.pp.se/
