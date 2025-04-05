Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DCC2EF
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743826350; cv=none; b=n7uSK4T7Ln5t1caVzbuvSuip73NY7LAh5S91r6i22q6Q6Sd+Yw9ZcPb1d29OpMbb5Rgz0/+IlnRz8Hl9QRNdIljR8d5hDH1+vrh2YO+l9VVjTtTDM67/Gbbb6rNy0cvS/koBNsshHfzffEM0PEbT+fkJw+tscZrmqVUP5vZE2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743826350; c=relaxed/simple;
	bh=ScaPZPIUHo6OxNB4PNdLok7cUnwSThMHBmtMF4DWyWk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BC32XelCuuULi47RWTVkyEntvQdcry7Yb79oouIaPZoPN/LD5KnJyVmHdaxKzg46IXDDJ6pYHyds9bjMgRkxtDmQXC8EuEppMblX+Aq06FZyCd88jRO7cXFqzXtSNXjVmv1Ryxivrv4vXE3bNHwzuSCPHb61dmKMke6uuoor9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 5354CR9q038076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 4 Apr 2025 21:12:27 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <edcd6174-e931-4ab9-b61d-8126a6cab740@rawbw.com>
Date: Fri, 4 Apr 2025 21:12:26 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: Make 'git stash list' more informative
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Currently 'git stash list' prints lines like this:
stash@{10}: WIP on main: 3f802b772d88 science/py-pymatgen: update 
2025.1.24 → 2025.2.18


It contains the last commit's subject which often/usually doesn't really 
describe the stash entry.


I propose to amend WIP stash entry descriptions with size, number of 
dirs and files, and time description, so that the above entry might look 
like this:

stash@{10}: WIP on main: 3f802b772d88 science/py-pymatgen: update 
2025.1.24 → 2025.2.18 (+20, -5, 3 dirs, 5 files, 17 days ago)



It would add info about the number of changed lines, number of affected 
directories and files, and how old this stash record is.


This would make WIP stash lines much more informative and they would 
actually describe better what is in them.




Thanks,
Yuri

