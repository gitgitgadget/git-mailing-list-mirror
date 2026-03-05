Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A6361645
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712240; cv=pass; b=OTNIWtCuqpHtmeRtclDs+JzFy2+/DVCiM6gu0xRBeKe3n/I0oRdLuAZJd3a86SzwoLweOefpJsbjiMGnsXYKQ1e+KexPGj1hfmri3G1mocBBLrNkw5j181zPnyZDx425v8IAeQM9Qn9AdvUXNCymcYB0utp51rVSE6OYeJBY7nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712240; c=relaxed/simple;
	bh=oDN4A5u/mpeQFmpHtWeNZfepQvLkn5yJ4zaNM780F34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4dUoDGB3ZGrCATAuQh6gkiODufu4Iks4vmVMyAQ/QSF843FQ9oM4pQzIhjHFMAOEEbfrylJbAJ6sEI6I31CtIZESH1XePbgNNjiUAgBw+EVZPyuBWctQMcSv5eWTCcS6qUuVgUpc1OmGmAF463iqxUyUOYjvpK3uO09nNHKfac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hC78ynqj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hC78ynqj"
ARC-Seal: i=1; a=rsa-sha256; t=1772712231; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K78j9Ww4Q6YsXMMb9IkwESZF6QzGQ3ALgu7f6H6IsR7gUJJ/MYgtsn9K4BCJMqDUdwR5T7MzJj5P0LWJLXcpS57brrSI2rDlVefW1LG3Z3s0cixa8Ne8IsvDGR9kbRD5SdWYkiofDCI+y1Tkbc319BuH9VmCxelar59kURESjqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772712231; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q+bwnd1S9aAw6soCx82fDUsZhIWMcx2iW646BRU3SJ4=; 
	b=BU5ecP9X8GSoX+7sKSNnZnV2aV6RKPa+f8mfDHfB9NLx8uDkyTz/clf8ox9cG/k/lwWbZbOvKTXGPnbgQZs494xbeR/gr5K7W3desKNSm7ddKHAhFLqbeMM2jWgTuyN/Vasap8YnlmiX7TgPem1vZhCi/sYWSVWoIXjRwJpeXbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772712231;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=q+bwnd1S9aAw6soCx82fDUsZhIWMcx2iW646BRU3SJ4=;
	b=hC78ynqjWHCBCBlRkjc3CGWbUTSgqSW9Bw+01yKDYvZo0gSw2yQxFtlST88uf5Pz
	4husgxMR2gAOpQSxLObzh6JceKJeqzyQOCR446pbaoWXMjk5tFkDBiDEAFZZpKTnEuD
	YhJiIfFU2gQfhElYMMAdij1Vg7ndaXZC8UP5o9q4=
Received: by mx.zohomail.com with SMTPS id 1772712228736594.8976531698527;
	Thu, 5 Mar 2026 04:03:48 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Chandra Kethi-Reddy
 <chandrakr@pm.me>, Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH v4] add: support pre-add hook
In-Reply-To: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
References: <pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
 <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 14:03:44 +0200
Message-ID: <87seaexz33.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

Hi Chandra,

On Thu, 05 Mar 2026, "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> @@ -576,6 +582,11 @@ int cmd_add(int argc,
>  		string_list_clear(&only_match_skip_worktree, 0);
>  	}
>  
> +	if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
> +		run_pre_add = 1;
> +		orig_index_path = absolute_pathdup(repo_get_index_file(repo));
> +	}
> +

Please use hook_exists() instead of find_hook() because that works with
hooks defined via config files. Otherwise your hooks API usage is great.

Maybe add a test or two which define the pre-add hook via configs to
verify it works?

(regarding find_hook(), we sholud mark it as deprecated or convert all
its remaining uses and remove it, however that's outside the scope of
your series, no worries)
