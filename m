Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312D2D2481
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366406; cv=none; b=M0ZnaDJ56+wv9UFJZb+J0CCVdwjMhdhimguct9rt5LZ+uoQ8DG4Wj4lAdkQVLuqoYrECckBbwQIgXtAsiyN/9Kbz4FThd3fdpZbFdNcJ9PqaFX5x42d/T4Un3cpeliwK26v12QXFeAMrxPkrp6UCt+YXWawD4cis1BtJM6sfW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366406; c=relaxed/simple;
	bh=FDmli3jMkxIWIwr9hYI/egMSheKLS0HK2xquYV/TMCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhNZ41RQps61r3NAEwe8XH6G5oVl0Jf2/KGif3PARPSPbdPkujUkqDjY+JkKvZ2hfCxarG4yKKkmi2w965UPcv2fmjiBAVURvVDT46B3dkXJVEveKVshcDA6fz7GaIieYahxLBle+iAnZzciR3RHs/DBa0q7C8iV3i+CqRFaqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=NmyVpNJb; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="NmyVpNJb"
Date: Tue, 17 Feb 2026 23:13:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771366403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FDmli3jMkxIWIwr9hYI/egMSheKLS0HK2xquYV/TMCs=;
	b=NmyVpNJb6Ee/yXB3Vocf3K3YWKkB1VlGYBTD3kvtKfle6j0Z2Dl3SzdV64IwAKGQz+HuKL
	h9tGGmQsvb3deKSpKLaCVAEpmG92RbxhqPc4OeZBa0wQwKYHNNT9sRAsg1xsXDCGXnFlmv
	KRZX9QdyXchv/175qGJ4Al5xCT/J+zwUnAr7npsDFQvpWR8BDm+ifpNxGzPEkmvZcw8Tva
	jxnfujoIdY7Qeg+WnBsSIqAPm141Jnhqyd8Dc2HquTXq24V+wraRRGULnDvQGcojEiLuiE
	rqyl87ksuqTbCKF3Dzo0TPx1yJXVfjZcnj1j7qaBAPeqK8t5U5Q4rWhaFZi1UQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] format-patch: fix From header in cover letter
Message-ID: <aZTnmXcLm1MNcIxO@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=66; i=mroik@delayed.space;
 h=from:subject:message-id; bh=FDmli3jMkxIWIwr9hYI/egMSheKLS0HK2xquYV/TMCs=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplOflnyf0IoiDtB4IPjNr1ndaa4GOWu5yLNUK/
 mvxjwNhoFyJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZTn5QAKCRBIeX6hnBm+
 0cYoD/9UrGdgfTaf/jttQZdeJHsbZ5fWWVNLLF0Upcp9TXjN4m+eXAzfm4qL68yWqCSudN3HvWF
 g3gU5DpUujta0mmInHYHUE6kRNF+bl5fgExQpS9xz5warY7O1qn2U9W7s13/FnVXd0kwTazh8FE
 1NxdnK0/p/TUzwqONguPj+juJWz4jtUak0Hh+KE3oBej3g2MsAayTyjYUI23CjPdny5yBS64cJE
 zQT4/zZf0uEdH/VbdCOrMdmGQ3DLS+o8437Zr+rF89XOMQjxkaN23KcR/bdAPhvuXVs7ylokXDG
 /pIQEMXyjdgTSOdJ2EQuqMJby3vw3tf35mg4rtQb+2GIkJ7j3ZUyE9JCW2yBqiIrQjfTwwqpXgv
 RIbcWPYJFYBDxyL4prCXj/yrFK2g4GhPARAh6wBUJU66Bx+TLslvIQqvgR06v7vf1Oif6A4DQRD
 u800UjwT/xV6OGLzgCfOug+0Dv6BNypKzbPSmL4sfFYYBYdDyMsnnpXqfVFjpHr5BayendIhIhO
 nMC6386lztx7alxdw2KhNDK7LO1SpdqDsj2g8OfXQqaF8/k1o7JYgNF5D0aKZuKo7G9S4nrbBse
 hw7dx488ho0FZLfVy0UtTrJP8NR4QEjfHISwDGOb7b9FCIOvnYQX4zySxKtBvxKCcm9T38Tqk6N
 /Ub9c1EUFpsXK0A==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260216152730.37478-1-mroik@delayed.space>
 <20260217220515.14127-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217220515.14127-1-mroik@delayed.space>
X-Spamd-Bar: -

I'm sorry, I forgot to mark as v3 and to change the sender name.
