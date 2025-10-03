Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0D2475CB
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759478209; cv=pass; b=i9L/McuAe6NuVA34YjZKz6DVWOvYFneuP0hP139Tjm/jE5cwuHeZqLY4g2D3pFVELr9SV63ATxOe30AjGjFdmcZgTSc1PhvY6a6uBAASJuouBRrUf9RgohEX4LdnmZzlXYfotTF4nUd1nCknoB7FLIvCXT4WRydnk/IQowqwczE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759478209; c=relaxed/simple;
	bh=8CKa8uZzreXIuceZDZhNjLn4L3oUMIBrNUMxuTnzJvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TK3w/UaH3zuboHub6Fc6AxBEuhCgfIfQLO1vlXyG5YqsUCtolyGroOu/xIkqoDOJiIePuaGc2MMFCScDgToJA4VTiT6mTqCUXBwenAaP/vOn1DemO6iaHWUPmNyPffzYlcfVbDInzRM+brkd1HfAYYa7hIA6wEyYVkx2YL4GuvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MRDqlUeS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MRDqlUeS"
ARC-Seal: i=1; a=rsa-sha256; t=1759478187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jljsc590tLDHYNUgS9QyDd/LR7YyH+loWh4XeGObv/5GezBJyXIB1crI8pFO8fl0lu6SoPp9xObZsudQGzPYhtFXPAyUDONkYlu4kJf6Hmq1EAHgi7U6mIOEp4tUFjwXB6KrpLE2gDNvYGEYXK8Xd47bDCB8QWBLMWB7zwGhpb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759478187; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EUZKTsrZRuW/2SXjT/3d5KtX17sWxrXC3dEjp0ZuhMk=; 
	b=B2jgB9VwGk4ifOJGvKwWjO9pMOyrLFFfp/2GzhIbz9mrEYSBsxv5q0xMXqz06lyraTkxTfhmug3enC7vspz57Gnd1aIlM5ECo1l4E0351PJ6+i58yaZK9oIokvFguHj60QugdyEIsyRhFsQVIEp6K0dqTIRfuV6bdvIY6otsrz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759478187;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=EUZKTsrZRuW/2SXjT/3d5KtX17sWxrXC3dEjp0ZuhMk=;
	b=MRDqlUeSneSrcACpXC63+JBZwenPV+FOPQ6UI9R2XoycyR0OlnuB4+AfCKLZGqpc
	VLdYme8mvzVuSr3p6QT58ZN06/+IWOeQTvkz+KL52J3O++ASiiQl6iCjFXukau185S/
	scsfegrBkJPctLTAtPnb9oXyyqV1FeFWNRnZWKTg=
Received: by mx.zohomail.com with SMTPS id 1759478185098682.0390298360945;
	Fri, 3 Oct 2025 00:56:25 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 08/10] submodule: remove validate_submodule_git_dir()
In-Reply-To: <9c313e46-805e-4b10-b8f9-6e2d5bf0ccf1@app.fastmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-9-adrian.ratiu@collabora.com>
 <9c313e46-805e-4b10-b8f9-6e2d5bf0ccf1@app.fastmail.com>
Date: Fri, 03 Oct 2025 10:56:20 +0300
Message-ID: <87wm5cbeqj.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 30 Sep 2025, "Kristoffer Haugsbakk" 
<kristofferhaugsbakk@fastmail.com> wrote:
> On Mon, Sep 8, 2025, at 16:01, Adrian Ratiu wrote: 
>> The validate_submodule_git_dir test is not very useful anymore, 
>> after submodule names are encoded to resolve gitdir path 
>> conflicts. 
>> 
>> In other words, the purpouse of gitdir path encoding is 
>> precisely to 
> 
> s/purpouse/purpose/ 

Thanks, I'll send v3 with these typos fixed very soon.
