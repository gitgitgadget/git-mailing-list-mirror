Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794431519A6
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576604; cv=none; b=bcMAqW0ooUT3LkUDFcCW7VRD6lMujCKWgfD6xNbeGfE0IgFQwqUEe8EtkFhJblDikYltK9lVFyDZmFCtWNecIKn4daX1PQ14N1l3uaXIm9H2ypJ55wXDZda8TiWbseGe8CkWFSWkglkqFXNhC5xeeLdqn+TkIY7UVu/VYyr9k/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576604; c=relaxed/simple;
	bh=ustd0nDVY+5IvaRNiwo80kzLP2/LZnQYja1/6tO2cew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtnRCDR5Z+HKuvxqja9giTX3zw7C0lfk994snEw1s86ACdnwn9eZbHApWugQdf8qWn+mod7REpbsc1vx/dD+oqDPKmJ0QBb1uIzuH6JVN6yfCGvmde2+DndVqAirvIJfJU3h0zLo8N3sJkQamdMANXcMA3enpw2jVfdfHUcJQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=LFALYVW7; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="LFALYVW7"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 601C7DF9189
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 08:49:52 +0200 (CEST)
Received: from [192.168.3.191] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 82EC67804FD;
	Wed,  2 Apr 2025 08:49:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1743576585;
	bh=ustd0nDVY+5IvaRNiwo80kzLP2/LZnQYja1/6tO2cew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LFALYVW70SPiJ9Hv+EeSzqOVrwIFDK1YyPToXAbFuLaVK8YLHi5k/ZUzFQr+qc4Jv
	 rAjlLRec+xMS9M3ynoy4hFuLgMYOZuxrgHiUWzlJQDqWULQfH3QxRjWFlnBbwdzVnq
	 FEJSL80k4Nca2i1163zaJd41fT28nnIoTc01c8j3Mt8KikaD7KLW73tl2lsvV/a7Yw
	 Spv8h4iNlaASvDlh6emAAdAtjUrHUPG5ExsHCopbym4SpnAh511b4LmniRl3lz8Ppr
	 Ye4gbCVHE5euCewa1rRn3F9E3OmEITaliaUu2efX+yF9G0MMeX/EYUNJFdD+R8bbGv
	 e49WTIOlXLosA==
Message-ID: <dfe21538-e70c-4d19-a90f-2c3cf8d3d377@free.fr>
Date: Wed, 2 Apr 2025 08:49:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix asciidoctor synopsis processing of triple-dots
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>,
 git@vger.kernel.org
References: <Z+rUsCW0zEb8kAK8@szeder.dev>
 <20250401110811.117851-1-jn.avila@free.fr> <xmqqecyba6zz.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <xmqqecyba6zz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 01/04/2025 à 23:48, Junio C Hamano a écrit :
> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
>> The processing of triple dot notation is tricky because it can be
>> mis-interpreted as an ellipsis.
>>
>> Another issue is that the formatting of synopsis paragraph in
>> Asciidoctor spits out another asciidoc formatted text where verbatim
>> text formatted with backquotes must have surrounding separators in
>> order to be properly detected, even if they are sticking to another
>> text.
>>
>> The special processing of the ellipsis is now complete and takes into
>> account the case of `git-mv <source>... <dest>`
>>
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>>  Documentation/asciidoctor-extensions.rb.in | 8 +++++---
>>  Documentation/diff-generate-patch.adoc     | 2 +-
>>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> The .gsub() changes seem to interact with your "doc: fix synopsis
> analysis logic" in the series that updates reset/mv/rm documentation
> mark-up.
> 
> 

I will incorporate this patch in the reset/mv/rm series.


