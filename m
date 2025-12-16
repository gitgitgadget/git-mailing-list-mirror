Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830B223323
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879307; cv=pass; b=AxmtvsA9ZHSABRMkSGTnB0TXOfAPmLZJjdMdeLCP+PyEhypCBDgy9/J8/Exz/6xyiyGZO2uwo7sMdi22dtQ3pbjQbu3kn1IXX4OMWFgV90BN1rc/zYfiM6YqTjmYDZPCClRexuDE+iefygJUQMApI5YLeQ7f1YBePMea/A+OK5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879307; c=relaxed/simple;
	bh=cKbJF/fdNlAmrJBHaH/NwGsPJeF2F/3Eef2HQkMKT+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSwk5BTn0nUehOnKR/Ar144mgeCYPCuTiP6QkyZ8GwSuIXKQVnoSQ4hhcAvL9Gd+hJuLeGCjUxX68MEoRuWL72ueWYBduK+bvntpYhG3UOwi8LvE0lzP3Yv/Gkz06+9wKG8/zekkDW0H4d/Uh4mh12ppidItuxN0w6hzNYMVO8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=a874BFB0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="a874BFB0"
ARC-Seal: i=1; a=rsa-sha256; t=1765879289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b2rnZpWPyKAm1AeKGf8fgu6QwqLuU2eiNHwQoXRrEbYX5udW2y3aFirMoA2OYnx1cfcHpQNRmQkZ8zfV+t4jqwd/jlYjqtafx8Zn+m2xh76BdZJQpHFADJHvPBAzeBkAPG0yqCsAGPYQiY7XFiXIOJmma95us+9EcoapOvcAKgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765879289; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cKbJF/fdNlAmrJBHaH/NwGsPJeF2F/3Eef2HQkMKT+I=; 
	b=Dp18g75ZInTIpsHMYL502PHHZNxdTqLwT9+is66vJGtNT/+Xl+VUKnB9C4m1EhST9t7/uJEDP+gJS12Gq08YcWHnnSMHnKqhkloD+inJ6wlwCCwrLQQ9F+WoVGdjpNxC5G1yEdT+kCw0GuyHIOgSGHlebdRAXIcvOh3ucZSc15Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765879289;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=cKbJF/fdNlAmrJBHaH/NwGsPJeF2F/3Eef2HQkMKT+I=;
	b=a874BFB0HiilmZ8H5XFRyI5wV7QlNN6mENCAmDIxNIbLfdVWmDwNgLYI/P2RtDoa
	+k2huHbWGLu0S52xSEFZ2mHuhf0yqOcnwW2v6a/Je3sQfmIK2GUw22mlVKJbA8uNYTq
	bSBnE1R3WAo3Nz7T1Kye45Lfwuf/7EAq6Arlg/cE=
Received: by mx.zohomail.com with SMTPS id 1765879286604322.67561674176204;
	Tue, 16 Dec 2025 02:01:26 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 05/10] submodule: allow runtime enabling
 extensions.submodulePathConfig
In-Reply-To: <aUEh3X7Vy4yhOC4B@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-6-adrian.ratiu@collabora.com>
 <aUEh3X7Vy4yhOC4B@pks.im>
Date: Tue, 16 Dec 2025 12:01:21 +0200
Message-ID: <871pkuhhji.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Sat, Dec 13, 2025 at 10:08:11AM +0200, Adrian Ratiu wrote:
>> This adds the ability to enable the new extension via a runtime
>> config to avoid having to enable it in each repo configuration.
>
> I think this doesn't quite match what Junio and I suggested.
>
> As far as I understand, this new runtime option will default-enable the
> repository extension in _all_ repositories. But this isn't really
> something that we should be doing, as it means that Git may now respect
> the gitconfig even though the extension isn't enabled. Other
> implementations of Git that don't understand the global configuration
> will thus start to misbehave in that case.
>
> The second issue is that the option will cause all existing repositories
> that have submodules to be broken, as we don't have the "gitdir" config
> key yet.
>
> My suggestion was thus to have a global configuration that causes both
> git-init(1) and git-clone(1) to automatically set the repository
> extension for _new_ repositories. This allows developers not worry about
> this in the future anymore, but it means that they will have to migrate
> existing repositories, at least if they care about the extension. Which
> I think is a fair tradeoff.

Right, I misunderstood what you asked for. Will fix.
