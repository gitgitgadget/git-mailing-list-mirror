Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.31.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86464225A37
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059136; cv=none; b=kl86pC5fRNUld79iHBh2JDgqUCYxhRFvOC6MmQREh51S7f3KychBnCXnAP7DqGSbgb+91ijTVlBaA92Eqgw6HWGaeuktfcmDfEDaZHpwjOF3nfaHWLPdUroWzCGGG4mIxSHNHbQpiEynflHNe527JKm8BvIUT28H/BqNmrVOkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059136; c=relaxed/simple;
	bh=P6SD15ldayc4A9ff8BHs2du46e8WcHcG+SnDW4Bu/IE=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:To:Subject; b=ef0W9tmKNKXq+x4UOCz35HRfas3864ke4sry5EJP9ya4GZ0syKlIENJsrsCToA8y1jHJwITLxF7pbBt+XYAvDFWDm1AiVC0m2xTvxXktnMT0fJ4tRI0hCemI1zEtZEceCf7TBI2auDMlsxXt9e7mtj/85vkhanBMUrsVKcEDzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akr.yagii.de; spf=pass smtp.mailfrom=akr.yagii.de; arc=none smtp.client-ip=80.67.31.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akr.yagii.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akr.yagii.de
Received: from [193.5.235.15] (helo=[192.168.0.30])
	by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98)
	(envelope-from <obs@akr.yagii.de>)
	id 1uZSYD-000000002uf-2l4L
	for git@vger.kernel.org;
	Wed, 09 Jul 2025 13:01:21 +0200
Content-Type: multipart/mixed; boundary="------------v0XDR5ly74SxzGVbVdWF0zmT"
Message-ID: <6907e423-324f-459f-a62e-fe6be14f4f73@akr.yagii.de>
Date: Wed, 9 Jul 2025 13:01:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexander Krupp <obs@akr.yagii.de>
Content-Language: de-DE, en-US
To: git@vger.kernel.org
Subject: git-subtree documentation fix request: split example causes fatal
 error
X-Df-Sender: b2JzQGFrci55YWdpaS5kZQ==

This is a multi-part message in MIME format.
--------------v0XDR5ly74SxzGVbVdWF0zmT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Read the documentation on git-subtree and try it:

 > git clone git://git.kernel.org/pub/scm/git/git.git test-git
Cloning into 'test-git'...
remote: Enumerating objects: 392367, done.
remote: Counting objects: 100% (7710/7710), done.
remote: Compressing objects: 100% (1126/1126), done.
remote: Total 392367 (delta 7015), reused 7002 (delta 6575), pack-reused 
384657
Receiving objects: 100% (392367/392367), 131.92 MiB | 49.57 MiB/s, done.
Resolving deltas: 100% (296075/296075), done.
 > cd test-git/
 > git subtree split --prefix=gitweb --annotate='(split) ' \
 >                      0a8f4f0^.. --onto=1130ef3 --rejoin \
 >                      --branch gitweb-latest
fatal: '0a8f4f0^..' does not refer to a commit
 >

What did you expect to happen? (Expected behavior)

Example should work as documented.

What happened instead? (Actual behavior)

see above.

What's different between what you expected and what actually happened?

Anything else you want to add:

Recommend a fix of the documentation. Due to lack of experience with 
subtree I cannot provide.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.4.0-150600.23.50-default #1 SMP PREEMPT_DYNAMIC Fri May  
9 22:09:52 UTC 2025 (dee422c) x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

--------------v0XDR5ly74SxzGVbVdWF0zmT
Content-Type: text/plain; charset=UTF-8;
 name="git-bugreport-2025-07-09-1251.txt"
Content-Disposition: attachment; filename="git-bugreport-2025-07-09-1251.txt"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5z
d2VyIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3Vy
IGlzc3VlLgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3Rl
cHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpCgpSZWFkIHRoZSBkb2N1bWVudGF0aW9uIG9u
IGdpdC1zdWJ0cmVlIGFuZCB0cnkgaXQ6Cgo+IGdpdCBjbG9uZSBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2dpdC9naXQuZ2l0IHRlc3QtZ2l0CkNsb25pbmcgaW50byAndGVzdC1n
aXQnLi4uCnJlbW90ZTogRW51bWVyYXRpbmcgb2JqZWN0czogMzkyMzY3LCBkb25lLgpyZW1v
dGU6IENvdW50aW5nIG9iamVjdHM6IDEwMCUgKDc3MTAvNzcxMCksIGRvbmUuCnJlbW90ZTog
Q29tcHJlc3Npbmcgb2JqZWN0czogMTAwJSAoMTEyNi8xMTI2KSwgZG9uZS4KcmVtb3RlOiBU
b3RhbCAzOTIzNjcgKGRlbHRhIDcwMTUpLCByZXVzZWQgNzAwMiAoZGVsdGEgNjU3NSksIHBh
Y2stcmV1c2VkIDM4NDY1NwpSZWNlaXZpbmcgb2JqZWN0czogMTAwJSAoMzkyMzY3LzM5MjM2
NyksIDEzMS45MiBNaUIgfCA0OS41NyBNaUIvcywgZG9uZS4KUmVzb2x2aW5nIGRlbHRhczog
MTAwJSAoMjk2MDc1LzI5NjA3NSksIGRvbmUuCj4gY2QgdGVzdC1naXQvCj4gZ2l0IHN1YnRy
ZWUgc3BsaXQgLS1wcmVmaXg9Z2l0d2ViIC0tYW5ub3RhdGU9JyhzcGxpdCkgJyBcCj4gICAg
ICAgICAgICAgICAgICAgICAgMGE4ZjRmMF4uLiAtLW9udG89MTEzMGVmMyAtLXJlam9pbiBc
Cj4gICAgICAgICAgICAgICAgICAgICAgLS1icmFuY2ggZ2l0d2ViLWxhdGVzdApmYXRhbDog
JzBhOGY0ZjBeLi4nIGRvZXMgbm90IHJlZmVyIHRvIGEgY29tbWl0Cj4KCldoYXQgZGlkIHlv
dSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgpFeGFtcGxlIHNob3Vs
ZCB3b3JrIGFzIGRvY3VtZW50ZWQuCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwg
YmVoYXZpb3IpCgpzZWUgYWJvdmUuCgpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5
b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/CgpBbnl0aGluZyBlbHNl
IHlvdSB3YW50IHRvIGFkZDoKClJlY29tbWVuZCBhIGZpeCBvZiB0aGUgZG9jdW1lbnRhdGlv
bi4gRHVlIHRvIGxhY2sgb2YgZXhwZXJpZW5jZSB3aXRoIHN1YnRyZWUgSSBjYW5ub3QgcHJv
dmlkZS4KClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cu
CllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCgpb
U3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjQzLjAKY3B1OiB4ODZf
NjQKbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxkCnNpemVvZi1sb25nOiA4
CnNpemVvZi1zaXplX3Q6IDgKc2hlbGwtcGF0aDogL2Jpbi9zaAp1bmFtZTogTGludXggNi40
LjAtMTUwNjAwLjIzLjUwLWRlZmF1bHQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBGcmkgTWF5
ICA5IDIyOjA5OjUyIFVUQyAyMDI1IChkZWU0MjJjKSB4ODZfNjQKY29tcGlsZXIgaW5mbzog
Z251YzogNy41CmxpYmMgaW5mbzogZ2xpYmM6IDIuMzgKJFNIRUxMICh0eXBpY2FsbHksIGlu
dGVyYWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNoCgoKW0VuYWJsZWQgSG9va3NdCg==

--------------v0XDR5ly74SxzGVbVdWF0zmT--
