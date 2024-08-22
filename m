Received: from srv1.howhill.co.uk (mx2.howhill.co.uk [85.95.36.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC376025
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.95.36.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353725; cv=none; b=l+5D9673r+qPvQdV1vTdHYiWJkmX+ZP9NDtIfPq62cQtMwgC8GFyujIoJ/cEAPP3ZLaEqGibGtdAPzStyy4Bhnh7xQ6JwgCOnkcNAHYq1BSVvNRTSLHdM/NefNSWmh5VhekaQdsrRXNsD3NlmmFoTD5UaD//q5yy3UJWSEeAcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353725; c=relaxed/simple;
	bh=pxGeqEvcV5IKnKpxPU0bX/Oclku2lcyUJ3zM8CwfXX8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To; b=DDmIsadSUx9xaiK6NKpEd+1O+Rkeuq0JSxR4lWrxwyYcMUIDdtegFRMjeq21zOnyWEJVM7Qh1DRZucZXhVNl62EVsHs69MJP/InMKsyFLj/ZsszITuNDM0sl2LKZjxma8hLHCIgubvQJX60dfpqKSjncNyoLiQIDBV0LsnhHRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howhill.com; spf=pass smtp.mailfrom=howhill.com; dkim=pass (2048-bit key) header.d=howhill.com header.i=@howhill.com header.b=TdvEUy9P; arc=none smtp.client-ip=85.95.36.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howhill.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howhill.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howhill.com header.i=@howhill.com header.b="TdvEUy9P"
Received: from [192.168.1.223] (Ellychnia-corrusca.howhill.co.uk [192.168.1.223])
	(Authenticated sender: willow)
	by srv1.howhill.co.uk (Postfix) with ESMTPSA id EF08F9C969
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 20:00:57 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 srv1.howhill.co.uk EF08F9C969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=howhill.com;
	s=default; t=1724353258;
	bh=Ybrg9ABT4UtobGqvrsL8f6Jh/BCmtgTrOlIeffSn1xA=;
	h=Date:From:Subject:To:From;
	b=TdvEUy9P+GzGlYgs8u555f9rPYK3oDhIlK0o+7MogV0Nyt59Nm8SLTt1blEztvfYf
	 wKKIz8QPuVaqxKTdVoOZnaEQNWoixjPweT7DoSCHZJdzfDmzxYAw69DNYoB4GV/RQr
	 uef/Iof2u3HgbXW0cPIBBek8tgeqNNtiwQMXlqWHyZZ3fZvxGxRRG/JGtctsBAwy95
	 WtLC6GcuL/yywiHU/3G/QBaGVR0bNTEvfs4v8/ssoeyzhiqyoat9bbZSPnaSeR0fkT
	 zKRgvKyrGHeCbAXuufMyyQjElfoAWw5rcuuVmEYDWIHsFbphbQsR/8MxkuaJiiFU2s
	 3UE+0EqTFtzgQ==
Content-Type: multipart/mixed; boundary="------------5qhEUwkdl3UP5p3a5CI7BJFw"
Message-ID: <f6ebc032-3a5a-4ec5-ab6a-160f26e9bb4e@howhill.com>
Date: Thu, 22 Aug 2024 20:00:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Willow Liquorice <willow@howhill.com>
Subject: git diff --word-diff misbehaving over paragraph breaks?
To: git@vger.kernel.org
Content-Language: en-GB
X-Spamd-Result: default: False [-1.64 / 20.00];
	BAYES_HAM(-2.97)[99.89%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	GENERIC_REPUTATION(-0.67)[-0.67108001906725];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-rst];
	MIME_BASE64_TEXT(0.10)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[]
X-Rspamd-Queue-Id: EF08F9C969
X-Rspamd-Server: srv1.howhill.co.uk

This is a multi-part message in MIME format.
--------------5qhEUwkdl3UP5p3a5CI7BJFw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'm having some trouble diffing revisions of the Jargon File at the word 
level, because the formatting seems to be confusing git diff 
--word-‍diff. The diffs produced are far from minimal, or word diffs for 
that matter.

I've attached a pair of files that produces non-minimal output. The 
entire first paragraph of the diff is rewritten in the diff despite the 
fact that it is nearly identical across revisions. The word diff can be 
made sensible by removing the second blank line so that the term and 
definition are no longer in separate "paragraphs".

The behaviour persists whether I set the word regex to 
"[[:punct:]]+|[[:alnum:]]+" or use the default word regex.

IMO this behaviour is aberrant: whitespace is whitespace regardless of 
whether it constitutes a paragraph break or not. Is there a command line 
option, or specific way of phrasing the regex, that I'm missing, or is 
this a bug?

	- Willow Liquorice
--------------5qhEUwkdl3UP5p3a5CI7BJFw
Content-Type: text/x-rst; charset=UTF-8; name="Acme1.rst"
Content-Disposition: attachment; filename="Acme1.rst"
Content-Transfer-Encoding: base64

DQogICA6QWNtZTogbi4gIFRoZSBjYW5vbmljYWwgc3VwcGxpZXIgb2YgYml6YXJyZSwgZWxh
Ym9yYXRlLCAgICBhbmQNCm5vbi1mdW5jdGlvbmFsIGdhZGdldHJ5IC0gd2hlcmUgUnViZSBH
b2xkYmVyZyBhbmQgSGVhdGggICAgUm9iaW5zb24NCih0d28gY2FydG9vbmlzdHMgd2hvIHNw
ZWNpYWxpemVkIGluIGVsYWJvcmF0ZSAgICBjb250cmFwdGlvbnMpIHNob3AuDQpUaGUgbmFt
ZSBoYXMgYmVlbiBodW1vcm91c2x5IGV4cGFuZGVkIGFzIEEgKG9yICAgIEFtZXJpY2FuKSBD
b21wYW55DQpNYWtpbmcgRXZlcnl0aGluZy4gIChJbiBmYWN0LCBBY21lIHdhcyBhIHJlYWwg
ICAgYnJhbmQgc29sZCBmcm9tIFNlYXJzDQpSb2VidWNrIGNhdGFsb2dzIGluIHRoZSBlYXJs
eSAxOTAwcy4pICAgICBEZXNjcmliaW5nIHNvbWUgWCBhcyBhbiAiQWNtZQ0KWCIgZWl0aGVy
IG1lYW5zICJUaGlzIGlzICAgIHtpbnNhbmVseSBncmVhdH0iLCBvciwgbW9yZSBsaWtlbHks
ICJUaGlzDQpsb29rcyB7aW5zYW5lbHkgICAgZ3JlYXR9IG9uIHBhcGVyLCBidXQgaW4gcHJh
Y3RpY2UgaXQncyByZWFsbHkgZWFzeSB0bw0Kc2hvb3QgeW91cnNlbGYgICAgaW4gdGhlIGZv
b3Qgd2l0aCBpdC4iICBDb21wYXJlIHtwaXN0b2x9Lg0KDQogICBUaGlzIHRlcm0sIHNwZWNp
YWxseSBjaGVyaXNoZWQgYnkgQW1lcmljYW4gaGFja2VycyBhbmQgZXhwbGFpbmVkDQpoZXJl
IGZvciB0aGUgYmVuZWZpdCBvZiBvdXIgb3ZlcnNlYXMgYnJldGhyZW4sIGNvbWVzIGZyb20g
dGhlICAgIFdhcm5lcg0KQnJvdGhlcnMnIHNlcmllcyBvZiAiUm9hZHJ1bm5lciIgY2FydG9v
bnMuICBJbiB0aGVzZSAgICBjYXJ0b29ucywgdGhlDQpmYW1pc2hlZCBXaWxlIEUuIENveW90
ZSB3YXMgZm9yZXZlciBhdHRlbXB0aW5nIHRvICAgIGNhdGNoIHVwIHdpdGgsDQp0cmFwLCBh
bmQgZWF0IHRoZSBSb2FkcnVubmVyLiAgSGlzIGF0dGVtcHRzIHVzdWFsbHkgICAgaW52b2x2
ZWQgb25lIG9yDQptb3JlIGhpZ2gtdGVjaG5vbG9neSBSdWJlIEdvbGRiZXJnIGRldmljZXMg
LSAgICByb2NrZXQgamV0cGFja3MsDQpjYXRhcHVsdHMsIG1hZ25ldGljIHRyYXBzLCBoaWdo
LXBvd2VyZWQgICAgc2xpbmdzaG90cywgZXRjLiAgVGhlc2Ugd2VyZQ0KdXN1YWxseSBkZWxp
dmVyZWQgaW4gbGFyZ2UgY2FyZGJvYXJkICAgIGJveGVzLCBsYWJlbGVkIHByb21pbmVudGx5
IHdpdGgNCnRoZSBBY21lIG5hbWUuICBUaGVzZSBkZXZpY2VzICAgIGludmFyaWFibHkgbWFs
ZnVuY3Rpb25lZCBpbiBpbXByb2JhYmxlDQphbmQgdmlvbGVudCB3YXlzLg0KDQo=
--------------5qhEUwkdl3UP5p3a5CI7BJFw
Content-Type: text/x-rst; charset=UTF-8; name="Acme2.rst"
Content-Disposition: attachment; filename="Acme2.rst"
Content-Transfer-Encoding: base64

DQo6QWNtZTogbi4NCg0KICAgW2Zyb20gIEdyZWVrICBha21lICBoaWdoZXN0ICBwb2ludCAg
b2YgcGVyZmVjdGlvbiBvciBhY2hpZXZlbWVudF0gVGhlDQogICBjYW5vbmljYWwgc3VwcGxp
ZXIgb2YgYml6YXJyZSwgZWxhYm9yYXRlLCBhbmQgbm9uLWZ1bmN0aW9uYWwgZ2FkZ2V0cnkN
CiAgIC0tICB3aGVyZSAgUnViZSAgR29sZGJlcmcgIGFuZCAgSGVhdGggIFJvYmluc29uICAo
dHdvIGNhcnRvb25pc3RzIHdobw0KICAgc3BlY2lhbGl6ZWQgIGluICBlbGFib3JhdGUgIGNv
bnRyYXB0aW9ucykgIHNob3AuICBUaGUgIG5hbWUgIGhhcyBiZWVuDQogICBodW1vcm91c2x5
IGV4cGFuZGVkIGFzIEEgKG9yIEFtZXJpY2FuKSBDb21wYW55IE1ha2luZyBFdmVyeXRoaW5n
LiAoSW4NCiAgIGZhY3QsICBBY21lICB3YXMgYSByZWFsIGJyYW5kIHNvbGQgZnJvbSBTZWFy
cyBSb2VidWNrIGNhdGFsb2dzIGluIHRoZQ0KICAgZWFybHkgIDE5MDBzLikgRGVzY3JpYmlu
ZyBzb21lIFggYXMgYW4gIkFjbWUgWCIgZWl0aGVyIG1lYW5zICJUaGlzIGlzDQogICB7aW5z
YW5lbHkgIGdyZWF0fSIsICBvciwgbW9yZSBsaWtlbHksICJUaGlzIGxvb2tzIHtpbnNhbmVs
eSBncmVhdH0gb24NCiAgIHBhcGVyLCBidXQgaW4gcHJhY3RpY2UgaXQncyByZWFsbHkgZWFz
eSB0byBzaG9vdCB5b3Vyc2VsZiBpbiB0aGUgZm9vdA0KICAgd2l0aCBpdC4iIENvbXBhcmUg
e3Bpc3RvbH0uDQoNCiAgIFRoaXMgdGVybSwgc3BlY2lhbGx5IGNoZXJpc2hlZCBieSBBbWVy
aWNhbiBoYWNrZXJzIGFuZCBleHBsYWluZWQgaGVyZQ0KICAgZm9yICB0aGUgIGJlbmVmaXQg
IG9mICBvdXIgIG92ZXJzZWFzICBicmV0aHJlbiwgY29tZXMgZnJvbSB0aGUgV2FybmVyDQog
ICBCcm90aGVycycgIHNlcmllcyAgb2YgICJSb2FkLXJ1bm5lciIgY2FydG9vbnMuIEluIHRo
ZXNlIGNhcnRvb25zLCB0aGUNCiAgIGZhbWlzaGVkICBXaWxlICBFLiAgQ295b3RlICB3YXMg
IGZvcmV2ZXIgYXR0ZW1wdGluZyB0byBjYXRjaCB1cCB3aXRoLA0KICAgdHJhcCwgIGFuZCAg
ZWF0IHRoZSBSb2FkLXJ1bm5lci4gSGlzIGF0dGVtcHRzIHVzdWFsbHkgaW52b2x2ZWQgb25l
IG9yDQogICBtb3JlICBoaWdoLXRlY2hub2xvZ3kgIFJ1YmUgIEdvbGRiZXJnICBkZXZpY2Vz
ICAtLSAgcm9ja2V0ICBqZXRwYWNrcywNCiAgIGNhdGFwdWx0cywgIG1hZ25ldGljICB0cmFw
cywgaGlnaC1wb3dlcmVkIHNsaW5nc2hvdHMsIGV0Yy4gVGhlc2Ugd2VyZQ0KICAgdXN1YWxs
eSBkZWxpdmVyZWQgaW4gbGFyZ2Ugd29vZGVuIGNyYXRlcyBsYWJlbGVkIHByb21pbmVudGx5
IHdpdGggdGhlDQogICBBY21lICBuYW1lICAtLSB3aGljaCwgcHJvYmFibHkgbm90IGJ5IGNv
aW5jaWRlbmNlLCB3YXMgdGhlIHRyYWRlIG5hbWUNCiAgIG9mICBhICBwZWcgIGJhciAgc3lz
dGVtICBmb3IgIHN1cGVyaW1wb3NpbmcgIGFuaW1hdGlvbiAgY2VscyAgdXNlZCBieQ0KICAg
Y2FydG9vbmlzdHMgIHNpbmNlICBmb3JldmVyLiBBY21lIGRldmljZXMgaW52YXJpYWJseSBt
YWxmdW5jdGlvbmVkIGluDQogICBpbXByb2JhYmxlIGFuZCB2aW9sZW50IHdheXMuDQoNCg==


--------------5qhEUwkdl3UP5p3a5CI7BJFw--
