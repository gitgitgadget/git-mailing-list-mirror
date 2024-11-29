Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE10158531
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865929; cv=none; b=pBDZEMgKwMq+6qSYrPD4U5emOFJkPJmP2A3o58MlC5UdUwJMaV1Hidq6i+hx1Vq+Y5HPV1A3lxffHSCYm+n4DUp2X4aj5nksbA5zLzZawtscb23v8/DMzSuuH77T8pdBmZDJbowGumEBz36KHVOYLC9By+hMrMVFb7acoCMk3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865929; c=relaxed/simple;
	bh=bUexqB8zi0xwiePaxi+hwzlRqXZIBMktG4HkIS22mo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=cHGicqzG3ksu0R02EYQdCju9mex16JDgA+dejU2PpXoVSkE1bkpN0zr4x+quW+uCPOTlfjq21+1vKiLCqbJ6poQY301g0nBv6yH38MEDa1JsHNH9ThJYNA6MdONQgP8BzDwkSxoxTZBvreVjV2mdicRL/WG3t9AC/8M5GNW8rmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Y04mY1jTrzRpKZ;
	Fri, 29 Nov 2024 08:38:36 +0100 (CET)
Message-ID: <d88a5f98-55e3-45dc-8f59-b7089096ba1f@kdbg.org>
Date: Fri, 29 Nov 2024 08:38:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Understanding the diff output in gitk when comparing a commit
 with working tree
To: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
References: <AS2PR08MB82888F1C5AE63BD383E53FE6E1282@AS2PR08MB8288.eurprd08.prod.outlook.com>
 <AS2PR08MB82880324292BB445428393B7E1292@AS2PR08MB8288.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <AS2PR08MB82880324292BB445428393B7E1292@AS2PR08MB8288.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 28.11.24 um 09:27 schrieb tobias.boesch@miele.com:
> I found that when comparing a commit with those changes made in the
> working tree, I don’t understand the following observations I made
> in the diff output for _some_ files:
> 
> - the diff output is not colored in red and green for additions and
> removals, but in red and bold black (still preceded with “++”, “+-“,
> “--“ and so on)

I will assume that there is no merge conflict. Then you see a combined
diff where the "first parent" is the index and the "second parent" is
the commit that you selected.

Without having looked at the code and its history, I guess that this is
an accident that nobody has bothered to fix, because it is not a very
useful way to show differences between the worktree and a selected commit.

-- Hannes

