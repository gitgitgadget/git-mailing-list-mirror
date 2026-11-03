Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712297;
	b=BI6BB+WmQ0GS1qypTWbjPitBjrVKE9JchwmVXWBVqSB/aHwlW1IIDbZ+s3Mb0uFMmhQw
	 O59mrvRN/0/dgG9M4VXrz9N5T1fpW7HLhatUfJxHGY+rBxS5b36t8R5Rkh713M/J8O045
	 rzEEYFgR1F1hdxfKd0hLn3AHtSgl9ME0S+FwMIiDgyFrIKmt748005bMkCqMJ1Prw7ZsD
	 L4/GynplZdtMxwr/iHl7QCpmuckN8OC07bFRAGODtF3hhXcCJ/6RJwfBYQVdbvwgiychL
	 W84lp4r/Xc+r+71Gl5Kj3nnB4pVqurOL34jirvZLJGcmeZ/TMtCzfHbTLdICkeYfWxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712297;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Organization:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NmpOcmZ/MFTmXhj4zIUzMfxWaaWW8gjx3NwE1LPz+uc=;
	b=t3j9os78Oy6JWcg9D/E4ZOO9vw3zq+BJ3jQJCE9AlF7e3bZwika4AomngAWuP1giit1m
	 tEOesddq15JTqWBK+3rxghJLNT174tO6Iu1SVzmEHoa5EARL9z/lrPYs6GCk+/5mdgkvD
	 ezY8UYF3UkEA6zZAa1Iwk50bzGTo/rxeXw8jQvmIL/uqG9fQuhwFncTuaDdGJgm/lw0mn
	 PrPHt0lUOiOCwqYASvnpVq9JbC1kxnsc3fO61YmvHQ6FGLyI31uypUJwKQ51T65rMJBMl
	 dKelfJxZhEL+xq3Zb16IFo7pAPeQ/cDXoRPlLAo8SP7TPVWIwm5ddqRzD/xtOA/Ls4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aWxWhM1T;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02614606A327
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02614606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aWxWhM1T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793712296; x=1825248296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NmpOcmZ/MFTmXhj4zIUzMfxWaaWW8gjx3NwE1LPz+uc=;
  b=aWxWhM1TgGEFvMz9U8WH+yLKABzpkQrdVe9IhIN5b2BH3MgPWBVLHhAt
   9OFspEZ49emqYH7R2pvmJcIQFpvehMKD0d2gkQOMn48qUWBNFrzCu10az
   +DYC/+Hj4DpKPEFYMossYGgM8J9xJ5Pf9gBAsATo1DUI7CnOdorBBhteL
   15lArbFs9lktzddeOnMjQVguyxXpTWpVW6FPYhm5YI+vupOW9ZWwK+Cnr
   kORr+dihIjCM/I/qKvJiKWbfGJmOGB/AcL61FR/jSl2uGrHzigZswnLG3
   dSOfNHtxig2mz5AqLXPAQsVjnxfV7vTpeSz33pbXv6nxmvdOkcRmo1maI
   w==;
X-CSE-ConnectionGUID: evYr5be8QdCxEcsQGlhbzQ==
X-CSE-MsgGUID: NrxWlYvJRhm/FYYtD5bctg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2444911"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2444911"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 05:24:55 -0800
X-CSE-ConnectionGUID: PAfreyRAS/i7bDcpfGJrWg==
X-CSE-MsgGUID: Dg0cnVVPRMWBtT1IcwVXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8273629"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 05:24:54 -0800
From: "Patrick Ohly" <patrick.ohly@intel.com>
To: git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Subject: [BUG] Lazy fetch in partial clone fails with "not our ref" since
 5946a564 (odb/source: make read_object_info() pluggable)
Organization: Intel Deutschland GmbH, Dornacher Strasse 1, D-85622
 Feldkirchen/Munich
Date: Tue, 03 Nov 2026 14:24:51 +0100
Message-ID: <yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCiJnaXQgbWVyZ2UiIGluIGEgYmxvYmxlc3MgcGFydGlhbCBjbG9uZSBmYWlscyB3
aXRoICJub3Qgb3VyIHJlZiIgd2hpbGUNCmxhemlseSBmZXRjaGluZyBhIG1pc3Npbmcgb2JqZWN0
LiBUaGlzIHN0YXJ0ZWQgdG8gb2NjdXIgdG9kYXkgaW4gdGhlDQpLdWJlcm5ldGVzIENJLCBjb21w
bGV0ZWx5IGJyZWFraW5nIHRoZSBtZXJnaW5nIG9mIFBScy4gV2Ugc2hvdWxkIGhhdmUNCmJlZW4g
dXNpbmcgZ2l0IDIuNTQuMCwgdGhlIGFmZmVjdGVkIHZlcnNpb24sIGZvciBhIGZldyBkYXlzIGF0
IGxlYXN0DQp3aXRob3V0IGlzc3Vlcywgc28gaXQgY2FuJ3QgYmUgcnVsZWQgb3V0IHRoYXQgdGhp
cyBpcyBhdCBsZWFzdCBwYXJ0bHkNCmNhdXNlZCBieSBhIGNoYW5nZSBvbiB0aGUgR2l0SHViIHNp
ZGUuIFdlIGFyZSBhYm91dCB0byByZXZlcnQgdG8gZ2l0DQoyLjUyLjAgdG8gdW5ibG9jayB0aGUg
S3ViZXJuZXRlcyBwcm9qZWN0Lg0KDQpXaGF0IGZvbGxvd3MgaXMgYW4gYWdlbnQgYW5hbHlzaXMg
b2YgdGhlIHByb2JsZW0uIEknbSBub3QgcmV3cml0aW5nIGl0DQpiZWNhdXNlIGl0IHNlZW1zIHN1
Y2NpbmN0IGFuZCB1c2VmdWwgYXMtaXM6DQoNCldoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1
ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSkNCg0KZ2l0IGluaXQgayAmJiBjZCBrDQpS
PWh0dHBzOi8vZ2l0aHViLmNvbS9rdWJlcm5ldGVzL2t1YmVybmV0ZXMuZ2l0DQpnaXQgZmV0Y2gg
LS1maWx0ZXI9YmxvYjpub25lICRSIDY1NzU3MjRiNjNlNTBjZDVkZDQ1NGU3NzRiYzI5M2M2ZGUx
ZTRlMTINCmdpdCBjaGVja291dCA2NTc1NzI0YjYzZTUwY2Q1ZGQ0NTRlNzc0YmMyOTNjNmRlMWU0
ZTEyDQpnaXQgZmV0Y2ggLS1maWx0ZXI9YmxvYjpub25lICRSIDc4N2RkMjdhZjQ0YzE0YzIyZDNi
YWU0NmJmNjJiNGEwMjcxZWZjMDYNCmdpdCAtYyB1c2VyLm5hbWU9YSAtYyB1c2VyLmVtYWlsPWFA
YiBtZXJnZSAtLW5vLWZmIDc4N2RkMjdhZjQ0YzE0YzIyZDNiYWU0NmJmNjJiNGEwMjcxZWZjMDYN
Cg0KV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/DQoNClRoZSBtZXJnZSBzdWNjZWVkcywg
d2l0aCBtaXNzaW5nIGJsb2JzIGZldGNoZWQgbGF6aWx5IGZyb20gdGhlIHByb21pc29yIHJlbW90
ZS4NCg0KV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPw0KDQpmYXRhbDogcmVtb3RlIGVycm9yOiB1cGxv
YWQtcGFjazogbm90IG91ciByZWYgMjdiNjRjYzg2MzE4N2U2MmQ4YjQ3MTk2YTc4YzA0NTQxMmQz
MmFjOQ0KZmF0YWw6IGNvdWxkIG5vdCBmZXRjaCAzYzgwNGI4OGJjZjE3N2ExNDM1YmE3NzBmYTkw
NTRjMjVlMTMxNWMzIGZyb20gcHJvbWlzb3IgcmVtb3RlDQoNCkJpc2VjdCByZXN1bHQNCg0KSSBi
aXNlY3RlZCB2Mi41Mi4wIChnb29kKSB0byB2Mi41NC4wIChiYWQpLiBUaGUgZmlyc3QgYmFkIGNv
bW1pdCBpczoNCg0KNTk0NmE1NjRjZGRjMGJmNDcxZjI3YWU0YzNmZTIwNTQ0MWUzZWY2NQ0Kb2Ri
L3NvdXJjZTogbWFrZSBgcmVhZF9vYmplY3RfaW5mbygpYCBmdW5jdGlvbiBwbHVnZ2FibGUNCg0K
VGhlIHBhcmVudCwgM2JjMzE3N2FkNyAowqAyLjUzLjAuMTg1LmczYmMzMTc3YWQ3wqApLCBpcyBn
b29kLg0KDQpWZXJzaW9ucyB0ZXN0ZWQNCg0K4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQri
lIIgVmVyc2lvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
4pSCIFJlc3VsdCDilIINCuKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0K4pSCIDIuMzkuNSwg
Mi40My40LCAyLjQ1LjIsIDIuNDcuMiwgMi40OS4xLCAyLjUyLjAgICAgICAgIOKUgiBPSyAgICAg
4pSCDQrilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilKQNCuKUgiAyLjU0LjAsIDIuNTYuMCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIgZmFpbCAgIOKUgg0K4pSc4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSkDQrilIIgbWFzdGVyICh2Mi41Ni4wLTM0MS1nZWJkYzA4N2Rj
LCBidWlsdCB3aXRoIE5PX1JVU1Q9MSkg4pSCIGZhaWwgICDilIINCuKUlOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUmA0KDQpOb3Rlcw0KDQrigKIgVGhlIHJlbW90ZSBpcyBnaXRodWIuY29tIG92ZXIg
SFRUUFMuIEkgaGF2ZW4ndCB0cmllZCBvdGhlciBob3N0cy4NCuKAoiBJIGhhdmVuJ3QgYW5hbHlz
ZWQgdGhlIGNhdXNlLiBNeSBndWVzcyBpcyB0aGF0IHRoZSBuZXcgwqBPQkpFQ1RfSU5GT19TRUNP
TkRfUkVBRMKgIGFuZCByZXByZXBhcmUgcGF0aCBjaGFuZ2VzIGhvdyB0aGUgcHJvbWlzb3IgbGF6
eSBmZXRjaCBpcyB0cmlnZ2VyZWQuIFRoZSBjbGllbnQgdGhlbiByZXF1ZXN0cyBhbiBvYmplY3Qg
YnkgT0lEIHRoYXQgdGhlIHNlcnZlciByZWZ1c2VzIHdpdGggIm5vdCBvdXIgcmVmIi4NCuKAoiBU
aGUgZmFpbHVyZSBpcyBkZXRlcm1pbmlzdGljLiBUaGUgZmlyc3QgUFIgaGVhZCBtZXJnZXMgZmlu
ZSBvbiAyLjUyLjAgYW5kIG9sZGVyLg0KDQpbU3lzdGVtIEluZm9dDQoNCmdpdCB2ZXJzaW9uIDIu
NTYuR0lUIChhbHNvIDIuNTQuMCBhbmQgMi41Ni4wKSwgTGludXggeDg2XzY0IChEZWJpYW4gc3Rh
YmxlIGNvbnRhaW5lcikNCg0KLS0gDQpCZXN0IFJlZ2FyZHMNCg0KUGF0cmljayBPaGx5DQpDbG91
ZCBTb2Z0d2FyZSBBcmNoaXRlY3QNCg==
