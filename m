Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BF10E0
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666477; cv=pass; b=QapdhpfOxZ9jq7d0+JWYyXpRsLrMepzKt7odFUIv1c7yfyh5WdmKwb12wYYzwkpzQjyLnooAIA5yzdb4bVr1NV42Oz+luff4UxsbGPbhSxIjM1g/jl5V8zPuCI1lJn8W1/JAXmpaNnDaIFkz1xCIGRH0DtuL0ojGd7RWJF13I10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666477; c=relaxed/simple;
	bh=YVcDWzzyzVlt3VpMCcIR+E894uh1MVT9I01aAouWr9Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cngrnaWRZt1LxFEO6b9+kTb+SxiRMXsWA7TqEm/n0lc2r3zjY71apc7rEOOLyzNEjJbewsZDZlaCLQyS5ta4KcW/2zGDj8qqHaNflYczOQcYDAfuZ3QFZo4vCf2ANg0nd+qgQVwtM7So5wNEEO2IbHGZDqUsjZw7kglPjdK23CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jowil.de; spf=none smtp.mailfrom=jowil.de; dkim=pass (2048-bit key) header.d=jowil.de header.i=@jowil.de header.b=YFQhzXvw; dkim=permerror (0-bit key) header.d=jowil.de header.i=@jowil.de header.b=Li+2hmQl; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jowil.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jowil.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jowil.de header.i=@jowil.de header.b="YFQhzXvw";
	dkim=permerror (0-bit key) header.d=jowil.de header.i=@jowil.de header.b="Li+2hmQl"
ARC-Seal: i=1; a=rsa-sha256; t=1732666466; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sQeSA1UDcWsXRRHGbJCYuiqlHQIkT+TvHR8bhjvwmu0w7s3mmvZY9Oi087X+GBhRQo
    qtHN4XGVkHFgKRliud7rT7pqgwNq4Ald102ogtT+mYPVcAz2Z8oJc1gqa6wY7dlu6CYZ
    WVyLQZ6kb6j4cHBO5wAGLWTSgy0jl5pJSRaKi+SdpWa/Zi48BJNKfjXnlCAtahmHCAnj
    GdXvPFaAbIf9A55sJttvtAbALv1T8K+/6kH9aIeXdkoDI1cQSrdQTICj054Jzr18BDUF
    7FTbfX2tH2QhQKOxGvREe/SipXbdxvPTAW8AZtwlOTg1kCXqnbyFFZGrbSL5QC/ImxAU
    bnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1732666466;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=YVcDWzzyzVlt3VpMCcIR+E894uh1MVT9I01aAouWr9Y=;
    b=JjrNU7qa77Q+j7td3dmVKw52ACIXy7uqZp9xI+UaEWKqie3af9S6jv0x9Rc40ujsaI
    0519K4k0MVEW5ZWvZClSAsoYLOYq2ylTcbIzzdxiooxsnF1CHoUZFqayhFNJ53C1ZLMz
    sIqtslHKDs5+LL7XpwAEkxhEsN9+DZccIcUqkYR6JcB03iLc2EqQqGpFMCJFMEisjeEs
    LUgty76GcjNydR9XV8yZMdFwAKxP4JDLi1zhSCqtYJWkoEBvXnxrS7k9vqsEdQjiGnGI
    6OXnz8VWgdpEnr45CICetofCH7FsKRAadiynQ3SAvy5HohHzoOAwzfUnmt4ZivGmbgbZ
    mE7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1732666466;
    s=strato-dkim-0002; d=jowil.de;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=YVcDWzzyzVlt3VpMCcIR+E894uh1MVT9I01aAouWr9Y=;
    b=YFQhzXvwy6/T1g24S0Pvt7Ore5Yy3iCXGp9uq4YfZqhAzNSIk+YTJD8xvoiomkzunD
    i0btuts9uIC8gJ/YvJ4ZklkdDDNzYrrHS+UJRx9xOTPu0DGABHz71OLGz3q37SRu/Kcd
    XHfSHnlkOh6kpUUDENAxSLmCVxZBEURsP5oR41Q27fiZCBgoZqU6aXq+Q+rV9PIlSp9/
    hJ5vI0tInclqG/1W9GOHLNskOsZF3gRRZaOgRDjQoWl/EqXTOedH0OToS/U4w95JIAvV
    oHK8WsIXgL7eV5kWHxmwOT9fbE992TCspUCpl6N2nrO1ab7WQirf32oYsSBOni+DJo1t
    njQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1732666466;
    s=strato-dkim-0003; d=jowil.de;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=YVcDWzzyzVlt3VpMCcIR+E894uh1MVT9I01aAouWr9Y=;
    b=Li+2hmQldltGSm5r/Zv4AFOjRp/TJzQwqTvCBlWY4IfRFUm4hLyQs1W5++Gkasns8k
    77SQq7DV+o0B2clJjLDw==
X-RZG-AUTH: ":O2kGeEG7b/pS1Ee2XHa/x/0PfOBp0F+S94BI8alalDrSRffTf9qKUbgxxbU6qAho0g=="
Received: from [192.168.178.46]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id Yb664a0AR0EQCJx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <git@vger.kernel.org>;
    Wed, 27 Nov 2024 01:14:26 +0100 (CET)
Message-ID: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>
Date: Wed, 27 Nov 2024 01:14:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: git@jowil.de
Subject: git tag -a HEAD leads to ambiguous branch name
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 241126-4, 11/26/2024), Outbound message
X-Antivirus-Status: Clean

Good evening,
today I encountered a warning using  git version 2.39.0.windows.2:
/warning: refname 'HEAD' is ambiguous./
It turned out, having written
/git tag -a HEAD -m "Some message."/
was the culprit.
As
/git branch HEAD/
yields the following error
/fatal: 'HEAD' is not a valid branch name/
I wanted to aks, whether a similar check should  be applied to tag names.
Best regards
Johannes Wilde

