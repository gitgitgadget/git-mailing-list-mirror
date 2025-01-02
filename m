Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10831B414E
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830967; cv=none; b=lUMyYR5cdjCKTB0ZK2Nd2Xlv8OA0vvo9V5Y4Kv8ZjcgHhPszwaX7S3CM1zevF7M5o1Tj7WrZXu/exB34ME9XYoo/Jw7tKgP14eLuGbiztgUDQnsPTYipsUX/tmQS8rQxZpzRMHPUgpqjXMz9lyltvUkZLKtjp/zBmGCMgpE+O0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830967; c=relaxed/simple;
	bh=u/UImrs09NzoP1HsHcXiGnDm8/3dyjLTAg4VRMxq/xg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rZlTodjrqMuDyM5VEnhIR4E/30NuVVWcN9RNPPEJAnUELe83EE9Ewu7kaRjS/kf7nkivFf/NHqG1YRN5M0joy7cUsOARptA+vXkFWP0HiuiQDjWt6szhs27Wf+rGfuP0+sAJ88R+A9JWKqhoLbC3Dumi2bKGYnbC187kG8anpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Lhv2vck3; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Lhv2vck3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1735830955; x=1736090155;
	bh=hzwX0qyt6jHc8KDPRr2915MkTSjuEeGovVbA1AcsWA4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Lhv2vck3XJNNsgpgAvhee1W7xrag/F5N1Fhq7TpYa5aTEqcuc7kUlnlGSztWxc49N
	 x1V8U7IFbnsS/YtcxH7fU2KpjeJwWaA1bCrt4KaOzVxag0R4tdmAhK4GKFaLGLM+HB
	 E7qoln8KGcBtjlzFsR2jVIdgUR2W0bcV17y3Wv98tvkRsdiEEfhVFjXPMCrLQib04r
	 /tr+RLeDqipj/fiQ/beN65+OVDfYdW86SRwCAA2n2dxPSoau0Bx2hX7CglwoYiFzeZ
	 Xu1c3a0czjkGuTH0kiou0SEQbMApdDUXzzZhHip+EYQN89Cw2FzMH/hjl8jzI2Mzsj
	 MPoyCBuOaCxAA==
Date: Thu, 02 Jan 2025 15:15:50 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sarah Gastner <gastner2001@protonmail.com>
Subject: git log date filter bug
Message-ID: <gEmXX5Orp18U4lUPlWeCKoepi91ih8VkreogEnepOIzTOihbf_iNuXqvdhFcgnIpRabnUscWIKf_GH04iI5NeVpdWjbHnPIPa6ZAtkfITk0=@protonmail.com>
Feedback-ID: 61900280:user:proton
X-Pm-Message-ID: f979efacba19a3b15c238722145f821402d21645
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_px4sP2oToWTVmnzSrzsgpDWGtzf9uS3IqDRvn0KJ7hg"

--b1=_px4sP2oToWTVmnzSrzsgpDWGtzf9uS3IqDRvn0KJ7hg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good day,

I encountered some weird behaviour that I think is a bug. I'll paste the bu=
g report below and also attach it to this email.

Best regards

Sarah Gastner

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I used the command "git log --after=3D2023-03-10 before=3D2024-01-24" in th=
e kubernetes repository (https://github.com/kubernetes/kubernetes), checked=
 out branch master (commit cb93d6ee69b8d4ca8701336e4f7cb278751f34e4).

What did you expect to happen? (Expected behavior)
The following commit (amongst others) to appear in the output:
commit 501976cc34ed3bfea6e1c994d41cb9bc464d6c3b
Author: Jiahui Feng <jhf@google.com>
Date:   Mon Mar 13 14:40:47 2023 -0700

    fix broken tests after dependency injection.

What happened instead? (Actual behavior)
The commit did not appear.

What's different between what you expected and what actually happened?
Both the author date and the commit date are 2023-03-13.=20
The interval 2023-03-10 to 2024-01-24 should include this date and therefor=
e this commit.

Anything else you want to add:
I was able to figure out the minimal date interval needed for this commit t=
o appear: 2023-03-07 to 2023-03-14.
The following command will only display the commit specified above: git log=
 --after=3D2023-03-07 --before=3D2023-03-14 --grep=3D"fix broken tests afte=
r dependency injection."
If you change the --after date to one day later (2023-03-08), there will be=
 no output.

This issue appears in other repositories too.

I observed this behaviour on Windows and WSL (Ubuntu).

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.1.windows.1
cpu: x86_64
built from commit: 2cd22437f64229935dc564db969cbcbfed5e9045
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.11.0
OpenSSL: OpenSSL 3.2.3 3 Sep 2024
zlib: 1.3.1
uname: Windows 10.0 19045=20
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]

--b1=_px4sP2oToWTVmnzSrzsgpDWGtzf9uS3IqDRvn0KJ7hg
Content-Type: text/plain; name=git-bugreport-2025-01-02-1249.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-bugreport-2025-01-02-1249.txt

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkkgdXNlZCB0aGUgY29tbWFuZCAiZ2l0IGxvZyAtLWFmdGVyPTIw
MjMtMDMtMTAgYmVmb3JlPTIwMjQtMDEtMjQiIGluIHRoZSBrdWJlcm5ldGVzIHJlcG9zaXRvcnkg
KGh0dHBzOi8vZ2l0aHViLmNvbS9rdWJlcm5ldGVzL2t1YmVybmV0ZXMpLCBjaGVja2VkIG91dCBi
cmFuY2ggbWFzdGVyIChjb21taXQgY2I5M2Q2ZWU2OWI4ZDRjYTg3MDEzMzZlNGY3Y2IyNzg3NTFm
MzRlNCkuCgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9y
KQpUaGUgZm9sbG93aW5nIGNvbW1pdCAoYW1vbmdzdCBvdGhlcnMpIHRvIGFwcGVhciBpbiB0aGUg
b3V0cHV0Ogpjb21taXQgNTAxOTc2Y2MzNGVkM2JmZWE2ZTFjOTk0ZDQxY2I5YmM0NjRkNmMzYgpB
dXRob3I6IEppYWh1aSBGZW5nIDxqaGZAZ29vZ2xlLmNvbT4KRGF0ZTogICBNb24gTWFyIDEzIDE0
OjQwOjQ3IDIwMjMgLTA3MDAKCiAgICBmaXggYnJva2VuIHRlc3RzIGFmdGVyIGRlcGVuZGVuY3kg
aW5qZWN0aW9uLgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQpUaGUg
Y29tbWl0IGRpZCBub3QgYXBwZWFyLgoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91
IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwpCb3RoIHRoZSBhdXRob3IgZGF0
ZSBhbmQgdGhlIGNvbW1pdCBkYXRlIGFyZSAyMDIzLTAzLTEzLiAKVGhlIGludGVydmFsIDIwMjMt
MDMtMTAgdG8gMjAyNC0wMS0yNCBzaG91bGQgaW5jbHVkZSB0aGlzIGRhdGUgYW5kIHRoZXJlZm9y
ZSB0aGlzIGNvbW1pdC4KCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgpJIHdhcyBhYmxl
IHRvIGZpZ3VyZSBvdXQgdGhlIG1pbmltYWwgZGF0ZSBpbnRlcnZhbCBuZWVkZWQgZm9yIHRoaXMg
Y29tbWl0IHRvIGFwcGVhcjogMjAyMy0wMy0wNyB0byAyMDIzLTAzLTE0LgpUaGUgZm9sbG93aW5n
IGNvbW1hbmQgd2lsbCBvbmx5IGRpc3BsYXkgdGhlIGNvbW1pdCBzcGVjaWZpZWQgYWJvdmU6IGdp
dCBsb2cgLS1hZnRlcj0yMDIzLTAzLTA3IC0tYmVmb3JlPTIwMjMtMDMtMTQgLS1ncmVwPSJmaXgg
YnJva2VuIHRlc3RzIGFmdGVyIGRlcGVuZGVuY3kgaW5qZWN0aW9uLiIKSWYgeW91IGNoYW5nZSB0
aGUgLS1hZnRlciBkYXRlIHRvIG9uZSBkYXkgbGF0ZXIgKDIwMjMtMDMtMDgpLCB0aGVyZSB3aWxs
IGJlIG5vIG91dHB1dC4KClRoaXMgaXNzdWUgYXBwZWFycyBpbiBvdGhlciByZXBvc2l0b3JpZXMg
dG9vLgoKSSBvYnNlcnZlZCB0aGlzIGJlaGF2aW91ciBvbiBXaW5kb3dzIGFuZCBXU0wgKFVidW50
dSkuCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3Ug
Y2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJ
bmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40NS4xLndpbmRvd3MuMQpjcHU6IHg4Nl82
NApidWlsdCBmcm9tIGNvbW1pdDogOTY1YjE2Nzk4ZGFiNjk2MmFkYTViMGQ4Y2YwZGNhNjhmMzg1
YzQ0OApzaXplb2YtbG9uZzogNApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gK
ZmVhdHVyZTogZnNtb25pdG9yLS1kYWVtb24KdW5hbWU6IFdpbmRvd3MgMTAuMCAxOTA0NSAKY29t
cGlsZXIgaW5mbzogZ251YzogMTMuMgpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZh
aWxhYmxlCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IEM6XFByb2dyYW0g
RmlsZXNcR2l0XHVzclxiaW5cYmFzaC5leGUKCgpbRW5hYmxlZCBIb29rc10K

--b1=_px4sP2oToWTVmnzSrzsgpDWGtzf9uS3IqDRvn0KJ7hg
Content-Type: text/plain; name=git-bugreport-2025-01-02-1249.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-bugreport-2025-01-02-1249.txt

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkkgdXNlZCB0aGUgY29tbWFuZCAiZ2l0IGxvZyAtLWFmdGVyPTIw
MjMtMDMtMTAgYmVmb3JlPTIwMjQtMDEtMjQiIGluIHRoZSBrdWJlcm5ldGVzIHJlcG9zaXRvcnkg
KGh0dHBzOi8vZ2l0aHViLmNvbS9rdWJlcm5ldGVzL2t1YmVybmV0ZXMpLCBjaGVja2VkIG91dCBi
cmFuY2ggbWFzdGVyIChjb21taXQgY2I5M2Q2ZWU2OWI4ZDRjYTg3MDEzMzZlNGY3Y2IyNzg3NTFm
MzRlNCkuCgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9y
KQpUaGUgZm9sbG93aW5nIGNvbW1pdCAoYW1vbmdzdCBvdGhlcnMpIHRvIGFwcGVhciBpbiB0aGUg
b3V0cHV0Ogpjb21taXQgNTAxOTc2Y2MzNGVkM2JmZWE2ZTFjOTk0ZDQxY2I5YmM0NjRkNmMzYgpB
dXRob3I6IEppYWh1aSBGZW5nIDxqaGZAZ29vZ2xlLmNvbT4KRGF0ZTogICBNb24gTWFyIDEzIDE0
OjQwOjQ3IDIwMjMgLTA3MDAKCiAgICBmaXggYnJva2VuIHRlc3RzIGFmdGVyIGRlcGVuZGVuY3kg
aW5qZWN0aW9uLgoKV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQpUaGUg
Y29tbWl0IGRpZCBub3QgYXBwZWFyLgoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91
IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwpCb3RoIHRoZSBhdXRob3IgZGF0
ZSBhbmQgdGhlIGNvbW1pdCBkYXRlIGFyZSAyMDIzLTAzLTEzLiAKVGhlIGludGVydmFsIDIwMjMt
MDMtMTAgdG8gMjAyNC0wMS0yNCBzaG91bGQgaW5jbHVkZSB0aGlzIGRhdGUgYW5kIHRoZXJlZm9y
ZSB0aGlzIGNvbW1pdC4KCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgpJIHdhcyBhYmxl
IHRvIGZpZ3VyZSBvdXQgdGhlIG1pbmltYWwgZGF0ZSBpbnRlcnZhbCBuZWVkZWQgZm9yIHRoaXMg
Y29tbWl0IHRvIGFwcGVhcjogMjAyMy0wMy0wNyB0byAyMDIzLTAzLTE0LgpUaGUgZm9sbG93aW5n
IGNvbW1hbmQgd2lsbCBvbmx5IGRpc3BsYXkgdGhlIGNvbW1pdCBzcGVjaWZpZWQgYWJvdmU6IGdp
dCBsb2cgLS1hZnRlcj0yMDIzLTAzLTA3IC0tYmVmb3JlPTIwMjMtMDMtMTQgLS1ncmVwPSJmaXgg
YnJva2VuIHRlc3RzIGFmdGVyIGRlcGVuZGVuY3kgaW5qZWN0aW9uLiIKSWYgeW91IGNoYW5nZSB0
aGUgLS1hZnRlciBkYXRlIHRvIG9uZSBkYXkgbGF0ZXIgKDIwMjMtMDMtMDgpLCB0aGVyZSB3aWxs
IGJlIG5vIG91dHB1dC4KClRoaXMgaXNzdWUgYXBwZWFycyBpbiBvdGhlciByZXBvc2l0b3JpZXMg
dG9vLgoKSSBvYnNlcnZlZCB0aGlzIGJlaGF2aW91ciBvbiBXaW5kb3dzIGFuZCBXU0wgKFVidW50
dSkuCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3Ug
Y2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJ
bmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24gMi40Ny4xLndpbmRvd3MuMQpjcHU6IHg4Nl82
NApidWlsdCBmcm9tIGNvbW1pdDogMmNkMjI0MzdmNjQyMjk5MzVkYzU2NGRiOTY5Y2JjYmZlZDVl
OTA0NQpzaXplb2YtbG9uZzogNApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IEQ6L2dpdC1z
ZGstNjQtYnVpbGQtaW5zdGFsbGVycy91c3IvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFl
bW9uCmxpYmN1cmw6IDguMTEuMApPcGVuU1NMOiBPcGVuU1NMIDMuMi4zIDMgU2VwIDIwMjQKemxp
YjogMS4zLjEKdW5hbWU6IFdpbmRvd3MgMTAuMCAxOTA0NSAKY29tcGlsZXIgaW5mbzogZ251Yzog
MTQuMgpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlCiRTSEVMTCAodHlw
aWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IEM6XFByb2dyYW0gRmlsZXNcR2l0XHVzclxiaW5c
YmFzaC5leGUKCgpbRW5hYmxlZCBIb29rc10K

--b1=_px4sP2oToWTVmnzSrzsgpDWGtzf9uS3IqDRvn0KJ7hg--

