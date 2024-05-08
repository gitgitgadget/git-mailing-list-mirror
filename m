Received: from relay01.gameloft.com (relay01.gameloft.com [208.71.184.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBEEA23
	for <git@vger.kernel.org>; Wed,  8 May 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.71.184.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212397; cv=none; b=ZGOmkkL+fGAxHlcjDWJh89OOphuxIpFDX8CkFkAk4N5a32aMw6hmBOTWG9nEDeEJpvcIiMaUn2oDuVzSWDn42szOTf0L3jC+owELM1j9x2qc8hijT/X47xWRT+FlsWSGYhsnRVg6ytbVS7boOVwBnWI2Mf+YF6BEleiF2fP7RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212397; c=relaxed/simple;
	bh=/M0eT6C2kUdaeaPB6zCqXdsnmWX92p/fjRtRHygIt8k=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To; b=mLc0O/1N0YZGvuU9lJEAklSrXGpl0oV8WvLTVAcW5DrK0Hu54M47+TfQ5eGxwTUfFe+MQv0999nGkxz2D1bYpzSf0xKJUPipOUDIg4orz5epT2fBLt/HYYj9e0h0D0UCXiD6WVR5Vc0HrPjWUMIZUJTxT1fWZJd1J5EAfHY9O6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gameloft.com; spf=pass smtp.mailfrom=gameloft.com; dkim=pass (1024-bit key) header.d=gameloft.com header.i=@gameloft.com header.b=Qhrgp8q9; arc=none smtp.client-ip=208.71.184.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gameloft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gameloft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gameloft.com header.i=@gameloft.com header.b="Qhrgp8q9"
X-Gameloft-MailScanner-From: martin.veilleux@gameloft.com
X-Gameloft-MailScanner: Found to be clean
X-Gameloft-MailScanner-ID: 3F1F12265C.A9198
Received: from mdc-ex04.gameloft.org (mdc-ex04.gameloft.org [10.136.3.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay01.gameloft.com (Postfix) with ESMTPS id 3F1F12265C
	for <git@vger.kernel.org>; Wed,  8 May 2024 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gameloft.com;
	s=gameloft; t=1715211904;
	bh=/M0eT6C2kUdaeaPB6zCqXdsnmWX92p/fjRtRHygIt8k=;
	h=Date:From:Subject:To;
	b=Qhrgp8q91LAHFyRN4q0yz0TrW91m2Ota3HngqsU+Ex3tZVXCs9ZxSx4s+DaP1y5Kb
	 N5HQ/cMjkbbol+LlMwmT9lKVx9/UHj1Jq/pIA+nl6iyzPwu0ijqua3BAjBs8vZjxQt
	 qNJzOa5Ghl5KILZ4GjfQcoFomelGGqolirQTk3nw=
Received: from mdc-ex04.gameloft.org (10.136.3.57) by mdc-ex04.gameloft.org
 (10.136.3.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 19:45:04 -0400
Received: from inf-p-oms001.sds.gameloft.org (10.136.1.152) by
 mdc-ex04.gameloft.org (10.136.3.57) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Wed, 8 May 2024 19:45:04 -0400
Received: by inf-p-oms001.sds.gameloft.org (Postfix, from userid 65534)
	id F26138028B; Wed,  8 May 2024 23:45:03 +0000 (UTC)
Received: from [10.137.10.87] (MTLWKS0186.sds.gameloft.org [10.137.10.87])
	(Authenticated sender: martin.veilleux@gameloft.com)
	by inf-p-oms001.sds.gameloft.org (Postfix) with ESMTPSA id D944780194
	for <git@vger.kernel.org>; Wed,  8 May 2024 23:45:03 +0000 (UTC)
Content-Type: multipart/mixed;
	boundary="------------wCKnUKM8c93ji28pDR53hIO7"
Message-ID: <8c53a956-13e9-4c7e-9359-2c86c9dd9908@gameloft.com>
Date: Wed, 8 May 2024 19:45:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Martin Veilleux <martin.veilleux@gameloft.com>
Subject: [BUG] fetch error when arbitrary branch changes a submodule url
Organization: Gameloft
To: <git@vger.kernel.org>
X-Virus-Scanned: clamav-milter 0.101.5 at inf-p-oms001
X-Virus-Status: Clean

--------------wCKnUKM8c93ji28pDR53hIO7
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

issue: fetch will give a fatal error once when a new arbitrary branch on 
the remote contains a submodule url change with updated sha

This was an issue I originally opened on git-for-windows a while back. 
(https://github.com/git-for-windows/git/issues/3404)

But it's actually reproducible on Linux

Seems to be a regression since I could not repro on version 1.9

Issue still present on version 2.45.0.31.gd4cc1ec35f

Local repro steps (complete test script attached)
- create repo A with a commit on master
- create repo B with a commit on master
- create repo X and add a submodule S1 pointing to A, commit to master.
- clone repo X with submodules to repo Z
- in repo X, create branch X1 from master. Change submodule S1 url to 
repo B and commit on X1.
- in repo Z, fetch and notice the fatal error "upload-pack: not our ref SHA"

 From there, you can then quickly repro the error like so:
- in repo Z , delete branch origin/X1 and then fetch again.

Current workaround is to set submodule.recurse to false

-- 

Martin

--------------wCKnUKM8c93ji28pDR53hIO7
Content-Type: text/plain; charset="UTF-8"; name="repro_git_bug.sh"
Content-Disposition: attachment; filename="repro_git_bug.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCmRpZSgpCnsKICAgIGVjaG8gIkZBVEFMIHByb2dyYW0gZXJyb3IiCiAg
ICBleGl0IDEKfQoKZ2l0VHJ5KCkKewogICAgZWNobyAiZ2l0ICQqIgogICAgZ2l0ICQqCn0K
CmdpdE5vRmFpbCgpCnsKICAgIGVjaG8gImdpdCAkKiIKICAgIGdpdCAkKiB8fCBkaWUKfQoK
Y3JlYXRlUmVwbygpCnsKICAgIGxvY2FsIG5hbWU9JDEKICAgIFtbIC1uICIkbmFtZSIgXV0g
fHwgZGllCiAgICBta2RpciAkbmFtZSB8fCBkaWUKICAgIHB1c2hkICRuYW1lID4vZGV2L251
bGwKICAgIHB3ZAogICAgZ2l0Tm9GYWlsIGluaXQKICAgIGVjaG8gbGluZTE+cmVhZG1lLnR4
dAogICAgZ2l0Tm9GYWlsIGFkZCByZWFkbWUudHh0CiAgICBnaXROb0ZhaWwgY29tbWl0IC1t
IGZpcnN0CiAgICBwb3BkID4vZGV2L251bGwKICAgIGVjaG8gImNyZWF0ZWQgZ2l0IHJlcG8g
JyRuYW1lJyIKfQoKcHJpbnRIZWFkZXIoKQp7CiAgICBlY2hvICI9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIKICAgIGlm
IFtbIC1uICIkMSIgXV07IHRoZW4KICAgICAgICBlY2hvICIkMSIKICAgICAgICBlY2hvICI9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PSIKICAgIGZpCn0KCnNldHVwRW52KCkKewogICAgaWYgW1sgLW4gIiRHSVRfUEFU
SCIgXV07IHRoZW4KICAgICAgICBbWyAtZSAiJEdJVF9QQVRIL2dpdCIgXV0gfHwgZGllCiAg
ICAgICAgZWNobyAidXNlciBwcm92aWRlZCBjdXN0b20gZ2l0IGluICR7R0lUX1BBVEh9Igog
ICAgICAgIGV4cG9ydCBQQVRIPSIke0dJVF9QQVRIfToke1BBVEh9IgogICAgICAgIGdpdE5v
RmFpbCAtLXZlcnNpb24KICAgIGZpCn0KCm1haW4oKQp7CiAgICBzZXR1cEVudgogICAgbG9j
YWwgcm9vdD0kKHB3ZCkKICAgIHJtIC1yZiBjaGlsZHsxLDJ9IHVzZXIxIHNlcnZlcjEKICAg
IGxvY2FsIGdpdEFyZ3M9Ii1jIHByb3RvY29sLmZpbGUuYWxsb3c9YWx3YXlzIgogICAgI2Ny
ZWF0ZSBzdWJtb2R1bGUgcmVwb3MKICAgIHByaW50SGVhZGVyICJjcmVhdGUgc3VibW9kdWxl
IHJlcG8gMSIKICAgIGNyZWF0ZVJlcG8gY2hpbGQxCiAgICBwcmludEhlYWRlciAiY3JlYXRl
IHN1Ym1vZHVsZSByZXBvIDIiCiAgICBjcmVhdGVSZXBvIGNoaWxkMgogICAgI3dvcmthcm91
bmQgZm9yIGlkZW50aWNhbCBpbml0aWFsIFNIQSAoaXMgdGhpcyBhIGJ1Zz8pCiAgICBwdXNo
ZCBjaGlsZDIgPi9kZXYvbnVsbAogICAgdG91Y2ggZm9vYmFyCiAgICBnaXROb0ZhaWwgYWRk
IGZvb2JhcgogICAgZ2l0Tm9GYWlsIGNvbW1pdCAtbSBzZWNvbmQKICAgIHBvcGQgPi9kZXYv
bnVsbAoKICAgICNjcmVhdGUgYSByZXBvIGludGVuZGVkIGFzIHRoZSBzZXJ2ZXIgcmVwbyB0
aGF0IGFsbCB1c2VycyBjbG9uZSBmcm9tCiAgICBwcmludEhlYWRlciAic2V0dXAgc2VydmVy
IHJlcG8iCiAgICBjcmVhdGVSZXBvIHNlcnZlcjEKICAgICNhZGQgc3VibW9kdWxlCiAgICBw
dXNoZCBzZXJ2ZXIxID4vZGV2L251bGwKICAgIGdpdE5vRmFpbCAke2dpdEFyZ3N9IHN1Ym1v
ZHVsZSBhZGQgLWIgbWFzdGVyICIke3Jvb3R9L2NoaWxkMSIgc3ViMQogICAgZ2l0Tm9GYWls
IGNvbW1pdCAtbSBhZGRlZF9zdWJtb2R1bGUKICAgIHBvcGQgPi9kZXYvbnVsbAogICAgCiAg
ICAjYSB1c2VyIGNsb25lcyBmcm9tIHNlcnZlcgogICAgcHJpbnRIZWFkZXIgInNldHVwIHVz
ZXIgcmVwbyIKICAgIGdpdE5vRmFpbCAke2dpdEFyZ3N9IGNsb25lIC0tcmVjdXJzZS1zdWJt
b2R1bGVzIHNlcnZlcjEgdXNlcjEKCiAgICAjY2hhbmdlIGEgc3VibW9kdWxlIHVybCBpbiBh
biBhcmJpdHJhcnkgYnJhbmNoLiBUaGlzIGJyYW5jaCB3b3VsZCBoYXZlIGJlZW4gcHVzaGVk
IHRvIHRoZSBzZXJ2ZXIgYnkgYW5vdGhlciB1c2VyLgogICAgcHJpbnRIZWFkZXIgInN3aXRj
aCBzdWJtb2R1bGUgdXJsIgogICAgcHVzaGQgc2VydmVyMSA+L2Rldi9udWxsCiAgICBwd2QK
ICAgIGdpdE5vRmFpbCBjaGVja291dCAtYiBleHBlcgogICAgZ2l0Tm9GYWlsIGNvbmZpZyAt
LWZpbGU9LmdpdG1vZHVsZXMgc3VibW9kdWxlLnN1YjEudXJsICIke3Jvb3R9L2NoaWxkMiIK
ICAgIGdpdE5vRmFpbCAke2dpdEFyZ3N9IHN1Ym1vZHVsZSBzeW5jIC0tIHN1YjEKICAgIGdp
dE5vRmFpbCAke2dpdEFyZ3N9IHN1Ym1vZHVsZSB1cGRhdGUgLS1yZW1vdGUgLS0gc3ViMQog
ICAgZ2l0Tm9GYWlsIGFkZCAtLWFsbAogICAgZ2l0Tm9GYWlsIGNvbW1pdCAtbSBzd2l0Y2hf
c3VibW9kdWxlX3VybAogICAgcG9wZCA+L2Rldi9udWxsCgogICAgI25vdyB1c2VyIHdpbGwg
dXBkYXRlCiAgICBwdXNoZCB1c2VyMSA+L2Rldi9udWxsCiAgICBwcmludEhlYWRlciAidXNl
ciB1cGRhdGVzIgogICAgcHdkCiAgICAjdGhpcyB3aWxsIGdpdmUgYW4gZXJyb3IsIGJ1dCBz
aG91bGRuJ3QKICAgIGdpdFRyeSBmZXRjaAoKICAgICN0ZXN0IGFnYWluCiAgICBwcmludEhl
YWRlciAidHJ5IGFnYWluIgogICAgZ2l0Tm9GYWlsIGJyYW5jaCAtciAtRCBvcmlnaW4vZXhw
ZXIKICAgIGdpdFRyeSBmZXRjaAoKICAgICN0ZXN0IHdvcmthcm91bmQKICAgIHByaW50SGVh
ZGVyICJ3b3JrYXJvdW5kIgogICAgZ2l0Tm9GYWlsIGJyYW5jaCAtciAtRCBvcmlnaW4vZXhw
ZXIKICAgIGdpdE5vRmFpbCBjb25maWcgc3VibW9kdWxlLnJlY3Vyc2UgZmFsc2UKICAgIGdp
dE5vRmFpbCBmZXRjaAoKICAgIHBvcGQgPi9kZXYvbnVsbAp9CgptYWluICRACgo=

--------------wCKnUKM8c93ji28pDR53hIO7--
