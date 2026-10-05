Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C6394798
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232394; cv=pass; b=MTnZc3byLwZuTaFDuSHwB8L2JEKEI49/b0/vrVy/mBLQ3cGF1kDGf4/bk572GesLrf2k+25qkzbtF3qoAW0KhiuSl8bVTb88feblGD+pyidBi9kYU0Hgm/j12nX/llBYA3yMUXESzClgEtZsQWMSgcqrk8NM808V8ZSVa1PKRIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232394; c=relaxed/simple;
	bh=+1OJOUc43RwKvril424DQwpE8DqaJTsjqlj0HKvKFYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GohRhxUSzaVk6tikgECkniRcc0ziCaPYhc63ada6Ag3ZMQsYjK+nzsgMF2NDociPcFS9EeEB3EenJxGWi0/Rrvj3tW36hdOH2VMtl0O9XIeFKPiRnaDV6R1lCGRhUo4kVVTQLinpBkMMv3nJrB2XHcnYx6gkWIXZdTdzQAty0uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com; spf=none smtp.mailfrom=sph3r3.com; dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b=r98XiUta; arc=pass smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b="r98XiUta"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91782a91a3aso32036366d6.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 13:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791232390; cv=none;
        d=google.com; s=arc-20260327;
        b=mtlNshkWCN+BCG9CM7GJ2qd9uCWnzKThO/dTkUZo5ebSPNPPgb5GzitMPGAptjDwPG
         sfxrS+DuOgDku01Aja3/qEyTUEJ519+bSAOWWCXFPYFtH2k/JvQBMW5IBTg5WJDarFuc
         iPbaf4r4aQwWoZ5I0Nv5pO+knGPwGIY45f4T+TGnDvclE4i136vYBCCxCy+2kVesxb2T
         KzHP0RAta+0zNUSpvxkKrYpaiQDDAAkv+bC2HK4wLJPI7oAfO1uor5b3podDzQ4l2H1N
         8afGkrhbJdnkkdMrmURKK2et0f3lXnGkyxvc/Sv6H/Yf55yxiX/Yw+k1YHfvt7uXG7R+
         TvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UK+mN1MlmKPOb6ipLS7fQfE7U2b9Yc/6TYiqRQjFlz8=;
        fh=71a8gNWjjH3jDnCK3/PRHZEeOlOeFkLaM81Nc2bGo4I=;
        b=PuVfZaY1CkSRvFxqyODC0EzB++alPQ7zoRtxWICmYd4yysXriLkpUDmci91GMQpS/X
         AkodcBO+zSJ4eZD4ARRitLC50aUy3eVoTracO4oZFtJbxoXwmfLHSb8ay/p5BqezNA5X
         nu5PdoRTOdj5zJv4hQ0JUSy7vwHQke2/B0SG0dkVonW2pwifU6dW4IwMx9HG2Zg+9Ycd
         ZXva8+UV+/MeopfaucCoGP9rOeDkDsVjogKUf0K9ljni1uGI5xh8uwzolQQk0GVpkC8J
         pldtQdXv89TKVipBRtRuYns7SoVDTz2NtYYpo/LSsYYV5YDvwVNoHoimy8tY+m5H2ktS
         3PpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sph3r3-com.20251104.gappssmtp.com; s=20251104; t=1791232390; x=1791837190; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UK+mN1MlmKPOb6ipLS7fQfE7U2b9Yc/6TYiqRQjFlz8=;
        b=r98XiUtaqmdaqefzEJlMO1vv4asrshqo/JNvf8osGFGPXetBYODkhFx07behm9gPAH
         0+7ecFcRCKSGwvKNeow5lru3ZF/qiyNpNWfjFBDKl3s/h8nIeNDmxUcGNiUzebPUmarU
         jm+y/8OEWi8+mD0V7IUaoj+6nl8sY/CsGRtRHvpowjjdcy8+a5LaglO6m1JEvQwYJZMW
         Vk6qTTefK4ebb2ESDs6U0ukWMlIZRpFjjEPrumwtHAnLc8yme1sDVOcwI/cQSnOxXsPs
         s8jKu6E0+O2r72PqwV1o9V6r+fQUcRD0UfwjfPGvvUx2Htul/1HbZaF0esFDraCOGnTR
         fHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791232390; x=1791837190;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UK+mN1MlmKPOb6ipLS7fQfE7U2b9Yc/6TYiqRQjFlz8=;
        b=n3iru3CtqlOhXT2wb0bRY+BTM0tWUHcEFAZjQi6GjjPPoGbcae9qNpehvnvnoh7KLV
         /pV9E6RKsrXjsvOGO46cmZFyqvNlzqfUbuZgyrzQk7tZFqLuSF0ovCJ2lyZyrlH1JLjb
         hNsoPqUjjfEpehJmGTsXBixlrSF9G7/rSIwQ1NeH4SNAlfbv8sfc9KvCVTa/DmR7k+/X
         mqDUAIB1869TCjjYcDTvcjp+FI2eHr8fUF1Cr5FvIzyxiSv6St3RaxD+CX6RUxtzTVCl
         Y7V6qSjfC0+QRBkntaCFC1YUu0sQczGIg0R+NTytSzH0uTHt88QCi8VzwxLcI7rI4Aur
         /oew==
X-Gm-Message-State: AFq9FYIx2Wkg77mLQxdcR8wTmjMF5+KRy75eXaEi7iZ0ppm6BycV2UmP
	XVheKz60P2Pov5WRZs6YBme373ET1rV4NVusUWk9cTVkIWzFg/bSLwSfTbJ/4TRfMrJGmDhdMP/
	LYV8q2jIZWL3TFcxdIEkzRawYLC9tA+sWr+RxATofPA==
X-Gm-Gg: AYBFou2n5h3shItVXI0iSAjb4EFxBxnqUcgtGByWnKKdgWvCP0ZKkjvTDLaIuyE/pD1
	tJGmhu/KNXeQTE+397VtbPaqhrNyg0a/POLizY/B9gUmri31r8+zcgkUBogVZJdco7P8MP1+s8J
	2FYcJISDn7Rx789xMLRnFafR97FNCq3h6z/00ZxMTJigmmfhwyJHX32EVWtQ1Hd7vuhYSoDr9Sn
	Ivvw+lsifmRlSLAj/lrqE8eSuHvLYhJTvOwYYcHo5OV7jEvvEVvexbgDUR4z+GmfJD2KQ2QYZyU
	eFEasRBdXtaH8jnDz+uLdWRmwuoBnsJY6oLMHBK6Xvj1Ha4/zsLMqJrSdGtBNz0r4Gw6Rnyn8A1
	yHgCdIAkutFlKUTPujmB0LijQ4m2xb3gLp0HxcLXw0Ez2X4VpvzzL865aoys/eqZNWZfEoYJxbl
	vqJCroLBGs1Xoo0A3tolZ15yqcDIhD2QvxurIuLfVW1XwfGL+HSIpnnFpIlvHFvFSMewRWxhpGr
	K4xOr21dTg=
X-Received: by 2002:a05:6214:3305:b0:919:65f6:e47c with SMTP id
 6a1803df08f44-91965f6e4bamr113893146d6.36.1791232389422; Mon, 05 Oct 2026
 13:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
In-Reply-To: <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
From: "Matthew E. Luallen" <m@sph3r3.com>
Date: Mon, 5 Oct 2026 15:32:32 -0500
X-Gm-Features: AclHuK_pkLjj3-vu5_CIE3DnGOO_Gyn82irsqFV31q-HH77sp_IsRzN8_F6n1mA
Message-ID: <CA+h9NxQEJaKrbTXUeryEhNMfOfuU0EykiJRi3PaJE9dRFo5tWw@mail.gmail.com>
Subject: Re: [BUG] ZIP timestamp conversion and strict fast-import date validation
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000489f1e065d1dca6e"

--000000000000489f1e065d1dca6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

Thank you for the thoughtful response. I appreciate your help.

- Reader example: Python 3.14.7's ZipInfo.date_time reports 2100 for
  the 1972 ZIP despite its correct Unix timestamp. Our tested UnZip
  and bsdtar restored 1972 correctly; this is a metadata-reading example.

- Separate consequence: the 2106-to-1970 wrap caused UnZip update mode
  to retain different existing 2025 content. The 2038 control updated
  correctly. No deployed security bypass has been demonstrated.

- Fix direction: would you prefer clamping or rejecting ZIP timestamps
  beyond the Unix field's range? Our candidate rejects them. Would
  rejecting negative dates in strict raw import be a useful first step?

Attached is brief guidance on misinterpretation risks, clearer date
labels, and safer downstream decisions. These suggestions complement
the ordinary bug fixes without asserting a security classification.

Best,
Matt

--000000000000489f1e065d1dca6e
Content-Type: text/plain; charset="US-ASCII"; name="git-timestamp-guidance.txt"
Content-Disposition: attachment; filename="git-timestamp-guidance.txt"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

R0lUIFRJTUVTVEFNUCBHVUlEQU5DRTogSU5URVJQUkVUQVRJT04sIElOVEVHUklUWSBBTkQgUkVN
RURJQVRJT04KNSBPY3RvYmVyIDIwMjYgfCBDb21wYW5pb24gdG8gdGhlIHB1YmxpYyBHaXQgZGF0
ZS1oYW5kbGluZyBkaXNjdXNzaW9uCgpXSFkgSVQgTUFUVEVSUwoKLSBJbnRlcnByZXRhdGlvbjog
ZGF0ZXMgY2FuIGJlIG1pc3Rha2VuIGZvciBjcmVhdGlvbiwgcHVibGljYXRpb24gb3IKICBhcHBy
b3ZhbCB0aW1lcy4gQ29udmVyc2lvbiBlcnJvcnMgY2FuIG1pc2xlYWQgd2l0aG91dCBtYWxpY2lv
dXMgaW50ZW50LgotIFNjYWxlOiByZXBlYXRlZCByZWxpYW5jZSBvbiBkYXRlcyBhY3Jvc3MgdXBk
YXRlLCByZXZpZXcgYW5kIGF1ZGl0CiAgcGlwZWxpbmVzIGNvdWxkIG11bHRpcGx5IGVycm9ycy4g
UHJldmFsZW5jZSBoYXMgbm90IGJlZW4gbWVhc3VyZWQuCi0gU2VjdXJpdHkgaW1wYWN0IHJlcXVp
cmVzIGF0dGFja2VyLWluZmx1ZW5jZWQgbWV0YWRhdGEgdG8gYWZmZWN0IGEKICBzZWN1cml0eSBk
ZWNpc2lvbiB3aXRob3V0IGluZGVwZW5kZW50IGNoZWNrcy4gQSBsb2NhbCB1cGRhdGUgZGVjaXNp
b24KICBjaGFuZ2VkOyBhIHByb2R1Y3Rpb24gc2VjdXJpdHkgYnlwYXNzIGhhcyBub3QgYmVlbiBk
ZW1vbnN0cmF0ZWQuCgpPQlNFUlZFRCwgV0lUSCBDT05UUk9MUwoKLSBQeXRob24gMy4xNC43IHJl
YWRzIHRoZSAxOTcyIFpJUCdzIERPUyBkYXRlIGFzIDIxMDAgZGVzcGl0ZSB0aGUgY29ycmVjdAog
IFVuaXggZXh0cmEgZmllbGQuIFVuWmlwIDYuMDAgYW5kIGJzZHRhciAzLjUuMyByZXN0b3JlZCAx
OTcyOyBQeXRob24ncwogIG9yZGluYXJ5IGV4dHJhY3Rpb24gdXNlZCBhIGN1cnJlbnQgbG9jYWwg
bW9kaWZpY2F0aW9uIHRpbWUuCi0gQSAyMTA2IGNvbW1pdCdzIFpJUCBVbml4IHRpbWVzdGFtcCB3
cmFwcGVkIHRvIDE5NzA7IFVuWmlwIHVwZGF0ZSBtb2RlCiAga2VwdCBkaWZmZXJlbnQgZXhpc3Rp
bmcgMjAyNSBieXRlcy4gQSAyMDM4IGNvbnRyb2wgcmVwbGFjZWQgdGhlbTsKICBUQVIgcHJlc2Vy
dmVkIDIxMDYuIFN0cmljdCByYXcgaW1wb3J0IGFsc28gYWNjZXB0ZWQgYSBuZWdhdGl2ZSBkYXRl
CiAgc3Vic2VxdWVudGx5IHJlamVjdGVkIGJ5IHN0cmljdCBmc2NrLiBSZWFkZXIgYmVoYXZpb3Ig
dmFyaWVzIGJ5IHBsYXRmb3JtLgoKUFJBQ1RJQ0FMIE9QVElPTlMKCi0gRXhwb3J0ZXJzOiB2YWxp
ZGF0ZSByYW5nZXMgYmVmb3JlIGVuY29kaW5nLiBDbGFtcCBwcmUtMTk4MCBET1MgZGF0ZXMKICB3
aGlsZSBwcmVzZXJ2aW5nIHJlcHJlc2VudGFibGUgVW5peCBkYXRlcy4gRm9yIFVuaXgtZmllbGQg
b3ZlcmZsb3csCiAgY2hvb3NlIHJlamVjdGlvbiBvciBkb2N1bWVudGVkIGNsYW1waW5nOyBjbGFt
cGluZyBsb3NlcyB0aGUgb3JpZ2luYWwKICB2YWx1ZS4gT3VyIGNhbmRpZGF0ZSByZWplY3RzIG92
ZXJmbG93LiBUaGVzZSBhcmUgcHJvcG9zZWQgcG9saWNpZXMuCi0gSW1wb3J0ZXJzOiBhbGlnbiBz
dHJpY3QgcGFyc2luZyB3aXRoIHZhbGlkYXRpb247IGNoZWNrIG5lZ2F0aXZlIHZhbHVlcywKICBj
b21wbGV0ZSBudW1lcmljIGlucHV0IGFuZCBvdmVyZmxvdy4gS2VlcCBwZXJtaXNzaXZlIG1vZGVz
IGV4cGxpY2l0LgogIFRlc3QgYm91bmRhcmllcyBhY3Jvc3MgdGltZXpvbmVzIGFuZCBhcmNoaXZl
IHJlYWRlcnMuCi0gQ29uc3VtZXJzOiBkZWNpZGUgdXBkYXRlcyB1c2luZyBleHBlY3RlZCBjb250
ZW50L3ZlcnNpb24gaW5mb3JtYXRpb24KICBmcm9tIGEgdHJ1c3RlZCBzb3VyY2UsIG5vdCBtb2Rp
ZmljYXRpb24gdGltZSBhbG9uZS4gRm9yIGNoYW5nZSByZXZpZXcsCiAgcmV0YWluIGEgdHJ1c3Rl
ZCBiYXNlbGluZSBjb21taXQgYW5kIGNvbXBhcmUgcmVhY2hhYmxlIGNoYW5nZXM7IGhhbmRsZQog
IG1pc3Npbmcgb3IgcmV3cml0dGVuIGhpc3RvcnkgZXhwbGljaXRseS4gRGF0ZSB3aW5kb3dzIGRv
IG5vdCBlc3RhYmxpc2gKICBjb21wbGV0ZSBjb3ZlcmFnZSBvZiBuZXdseSByZWNlaXZlZCBjb250
ZW50LgotIERpc3BsYXlzOiBkaXN0aW5ndWlzaCAnY29tbWl0dGVyLXN1cHBsaWVkIGRhdGUnLCAn
YXJjaGl2ZSBtb2RpZmljYXRpb24KICB0aW1lJyBhbmQgJ3NlcnZlciBvYnNlcnZlZCBhdCcuIEV4
cGxhaW4gY2xhbXBpbmcgYW5kIG1pc3NpbmcgZXZpZGVuY2UuCiAgU2VydmVyIHJlY2VpcHQgaXMg
bm90IG9yaWdpbmFsIGNyZWF0aW9uIG9yIGZpcnN0IHB1YmxpY2F0aW9uIGVsc2V3aGVyZS4KLSBF
dmlkZW5jZTogcHJlc2VydmUgb3JpZ2luYWwgYnl0ZXMgYW5kIGluZGVwZW5kZW50IHJlY2VpcHQg
cmVjb3Jkcy4KICBDb21taXQgc2lnbmF0dXJlcyBiaW5kIHNpZ25lZCBjb250ZW50IHRvIGEga2V5
IHVuZGVyIGEgdHJ1c3QgcG9saWN5OwogIHRoZXkgZG8gbm90IGluZGVwZW5kZW50bHkgcHJvdmUg
aXRzIGNsYWltZWQgY3JlYXRpb24gdGltZS4gQSB2YWxpZGF0ZWQKICB0cnVzdGVkIHRpbWVzdGFt
cCBjYW4gc3VwcG9ydCBleGlzdGVuY2UgYnkgYSB0aW1lLCBub3QgZXhhY3QgY3JlYXRpb24uCgpS
SVNLIFRBWE9OT01ZLCBOT1QgQSBWVUxORVJBQklMSVRZIEFTU0lHTk1FTlQKCi0gTnVtZXJpYyBy
ZXByZXNlbnRhdGlvbi90cnVuY2F0aW9uOiBDV0UtMTk3OyB3cmFwYXJvdW5kOiBDV0UtMTkwLgot
IFZhbGlkYXRpb246IENXRS0yMCAoYnJvYWQgY2F0ZWdvcnkpLiBEb3duc3RyZWFtIHRydXN0OiBD
V0UtODA3IG9ubHkKICB3aGVyZSBhIHNlY3VyaXR5IGRlY2lzaW9uIHJlbGllcyBvbiB1bnRydXN0
ZWQgaW5wdXQuIERpc3BsYXkgY29uZnVzaW9uCiAgYWxvbmUgZG9lcyBub3QgZXN0YWJsaXNoIGl0
LiBUaGVzZSBsYWJlbHMgZG8gbm90IGVzdGFibGlzaCBzZXZlcml0eS4KClJFRkVSRU5DRVMgQU5E
IEVWSURFTkNFCgpHaXQgZGF0ZSBjb250cm9sczogaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dp
dC1jb21taXQjX2NvbW1pdF9pbmZvcm1hdGlvbgpBcmNoaXZlIGJlaGF2aW9yOiBodHRwczovL2dp
dC1zY20uY29tL2RvY3MvZ2l0LWFyY2hpdmUjX2Rlc2NyaXB0aW9uCkNXRSB0YXhvbm9teTogaHR0
cHM6Ly9jd2UubWl0cmUub3JnL2RhdGEvZGVmaW5pdGlvbnMvMTk3Lmh0bWwKaHR0cHM6Ly9jd2Uu
bWl0cmUub3JnL2RhdGEvZGVmaW5pdGlvbnMvMTkwLmh0bWwKaHR0cHM6Ly9jd2UubWl0cmUub3Jn
L2RhdGEvZGVmaW5pdGlvbnMvMjAuaHRtbApodHRwczovL2N3ZS5taXRyZS5vcmcvZGF0YS9kZWZp
bml0aW9ucy84MDcuaHRtbApUcnVzdGVkIHRpbWVzdGFtcCBzZW1hbnRpY3M6IGh0dHBzOi8vd3d3
LnJmYy1lZGl0b3Iub3JnL3JmYy9yZmMzMTYxCkV2aWRlbmNlOiByZWNvcmRlZCAyMDI2LTEwLTAx
IGNvbnN1bWVyLWRhdGUtaW1wYWN0IHJlc3VsdHMgYW5kIEdpdCBtYXRyaXg7Cm5vIG5ldyBleHBl
cmltZW50IGlzIGNsYWltZWQgYnkgdGhpcyBndWlkYW5jZS4KCk1hdHRoZXcgRS4gTHVhbGxlbiAo
QG1lbHVhbGxlbiksIHdpdGggcmVzZWFyY2gsIHJlcHJvZHVjdGlvbiBhbmQgZHJhZnRpbmcKYXNz
aXN0YW5jZSBmcm9tIE9wZW5BSSBDb2RleC4K
--000000000000489f1e065d1dca6e--
