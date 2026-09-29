Received: from smtp26.services.sfr.fr (smtp26.services.sfr.fr [93.17.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C561497382
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686183; cv=none; b=Y18xC15A2JZrsSjEfqkxYM7kjFM2iwPoqNF7wU5ewhdV67FdEObN2k5plf244yqUBvEMfQNp3ZniPoZf6MZpqR70NHtEE19zrOKTNp1WUv1zzYiMb3dkfTw8S/gaDtEC7M7Q+zUpJzmY4QMIoJOTn3HySkt12KUlTA3FCM6RNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686183; c=relaxed/simple;
	bh=EqgVkcp0+kj7CABB523UkjJaO1OIuXsqKJXTD/RjLDA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L+fvaYqR3aWMLNi17oNG8vA65HbHL7+nzRpdRtpazWv3RxKzceTTXxTaTkMnL1pKQ+CFp/8LSbiwDzNCwWIpcFwrNSBCAaoHSKN1jqmt4o1sfMmlOOTRASjhUxZCiUSd9hrRVb12mE2Mh4/P07Bwb98RzitVAUGeO/+oxOSvU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cegetel.net; spf=pass smtp.mailfrom=cegetel.net; dkim=pass (2048-bit key) header.d=cegetel.net header.i=@cegetel.net header.b=R3FBMGDG; arc=none smtp.client-ip=93.17.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cegetel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cegetel.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cegetel.net header.i=@cegetel.net header.b="R3FBMGDG"
X-mail-filterd: {"version":"1.7.1","queueID":"4hvHjK3bbmz1LdQRL","contextId":
 "69b9ef24-2283-4b93-9069-2c7eb61e6d9f"}
Received: from [10.129.36.30] (salsa-15.enst-bretagne.fr [192.108.116.78])
	by msfrf2609.sfr.fr (SMTP Server) with ESMTP id 4hvHjK3bbmz1LdQRL
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 14:36:21 +0200 (CEST)
X-mail-filterd: {"version":"1.7.1","queueID":"4hvHjK2nQLz1LQKcs","contextId":
 "03f80540-afa2-46bb-8985-a868097fd04b"}
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cegetel.net; s=202006;
 t=1790685381; h=Date:To:From:Subject; bh=EqgVkcp0+kj7CABB523UkjJaO1OIuXsqKJXT
  D/RjLDA=; b=R3FBMGDG8wBdmPraEzjELDNiYfitDySltoYquf3rtG9JUvNMhz9if3Av6KTxUi2Y
  NJenzAomo5AcEMQ/HvudqPC1WBKAzi9ccKboHuPXOKD7AUQvbbofyV8vL/70Om/YVhWtyU0OZ+Cp
  B4jZFCQfhqOSkQn2fdLscCPFu4H91XCgi5B4WY+yZkieJL5H9nsFqVpPn7GYHM1xzVFkBwrDgl7O
  DuICNABQW6gvG99hUoihvX/MUgS8k/kh4TFDxTECh+aHicJN/+/KiCrTx6XXZmtT70CxPz8qZzS9
  MuagqRP8TOuHbb/0+pMNRs0aP5uOCYIIQMXXoU/Fanlwynhg2Q==
Received: from [10.129.36.30] (salsa-15.enst-bretagne.fr [192.108.116.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: christophe.lohr@cegetel.net)
	by msfrf2609.sfr.fr (SMTP Server) with ESMTPSA id 4hvHjK2nQLz1LQKcs
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 14:36:21 +0200 (CEST)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=christophe.lohr@cegetel.net
Message-ID: <b93a24c5-7411-4bf0-ad1a-aa5999f107f9@cegetel.net>
Date: Tue, 29 Sep 2026 14:36:20 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: fr
From: Christophe Lohr <christophe.lohr@cegetel.net>
Subject: Confusion with git config list --show-origin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
   The 'git config list --show-origin' command is very useful for 
understanding where the settings come from.
This command lists the files involved, specifying the full path for each 
one,
except for '.git/config'

This gives the impression that there is a '.git/' directory in the 
current working directory, even though it isn't located here but higher 
up in the directory tree.
So, may I suggest, that this command display the full path to the 
.git/config file used by the current git command?

Best regards
Christophe

