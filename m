Received: from sonic301-34.consmr.mail.ne1.yahoo.com (sonic301-34.consmr.mail.ne1.yahoo.com [66.163.184.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFC34A781
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147568; cv=none; b=J1b6cJcx4sqkD/uBozCiWaztAe+owDyAitRtXKS1BIT8fPnbQNnmrtuSTtfU9Tibd+Q/mtIzpPAkPdS9S9lh6NdONrew1Z3N71XjKpyjtTArsLytKph8TDtIXJ+y0+4Kep6X2PJua5bQrUsVzQ21CYpkj6L0bkWMVPMdJHBso8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147568; c=relaxed/simple;
	bh=GeW+MmmMyKXLvkzwWJMksJirKThDdZlLcB8qopEDGvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OnDLfutZ2zpPsvUlP9ypa15xPZyl+QNjaxzu6Wd+30X5s2/LJ26fIKW4akIV1Afi12cxGisZrG17fCZS6Ib9hkl1L2O1DhKwLxJ9afIbqHibIjVLFrhqrBc8cs6KmXWo1YVWVHwGq+iqgV/Gl7Qug3tAtp0NWCimDuTENJim/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bellsouth.net; spf=pass smtp.mailfrom=bellsouth.net; dkim=pass (2048-bit key) header.d=bellsouth.net header.i=@bellsouth.net header.b=iwvqZY9B; arc=none smtp.client-ip=66.163.184.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bellsouth.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bellsouth.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bellsouth.net header.i=@bellsouth.net header.b="iwvqZY9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s2048; t=1761147557; bh=GeW+MmmMyKXLvkzwWJMksJirKThDdZlLcB8qopEDGvo=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=iwvqZY9BjbzRTsDmYNdypY9HNMOtZJLSQfteyA2QFWvsfsiu1nvQkKfmceY7RZWawdCSfGP+CjWGUfPlHc6uBkAp7OVKgox54gZhJN2IVxwhv5EMS7o09CJ2tXY8XuS/cMPG6wYCjoLQMj1wBQxqzx5KCCAT50P8bY7CaZVDbTilM5gI1SExjkNFCl9sJXp+ExeZ8G4NT87hIuyMOT1x7tSwHKac1V7svINpNzWNj+XidBv50kbPZ506E2cm1gWRose9fFAgKZphF3o1gUIWtDZEP9prrv2d9oMDjFbMLEksJKhXMUDezflhO4RWE7ZBODElWdQFqK0r8C5Gb3QEmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761147557; bh=Lp9jsgHwo3T/0WCaaIB5Tl5mCfyNYVsj1RQq0p1rf6m=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=AO+RX9Jd+aoeswE4reOlGpQNmA5snsT/VAor5TxYdRPwK65W+GTnm1RUugdlKgMQmvg7899J91+/rx7dVuVapEGMCQgSAmda0VvnIr89+QPJZfLTBq0g0QECZf67kb901Zh+Q+O8nawX+sXlirKqa3iaPV8tb70WBFr+Bt8/Q99g/8jTvbJaHFY/BybHzsmpEyiUAK5ZtG8Fxr9GZwWU0B0KQD7wz+5CzkQiAL+m3NqRBBZLYbqitnD+PGymjphlC/kZLWwbokQ2dRI4+xkalDblpI2U6LY3nVYdZ8UzHRF3jSVLr9iEmEsRRuw/ojGentxgm89iCzLCjRjlnrbzng==
X-YMail-OSG: 7xrUZGoVM1mFsetJ1sv1yDfP3ERIDGnCxPcFps4QJagpogVwisr7eUGWEbRima9
 AhO26D2rs64yAepG7chAsMB1Z9G3debcuNdO3_AfRy4QDTg8HsI0P_pWH6AYeUTsNlfy6Ryl5dfq
 pDXua189gsq3hhwnrSC.VEMl_2rIrA6Y_9xeH7U10XtEB6x0UoIks0x2u4UxMz9CgvUUpUHFzuyn
 57q2xTANqPCMz8PdZ84cTk2MKbkkD25b1CgMxc0daDZVIY0CIv0SNHur2c_XZgkQiOwK.2bWE_5v
 DeHM9YZFUO4wjVsedHARaHcU0KzyO8b4b4ffCDyXxAIZadmNZp03ANs_X3sjqgGf7fLw2OTm..Bi
 ixkjYyVsti8ogX.pIDmpLXpcUnPfAv415QuDBuS0rR5JLblGPTaiHlJvv4.ggsXLMI7MVjn0.OMZ
 f_jJIWm7s9FXLpocfiAC.gDMCUtRGGxm1CP0RgqrDD7ZByj2bRXZMSJTGGtZhjH3Yvu_lVTCfHEw
 baJQ7gi.gEuUCdHl9ZvgkqWhSGsTSMzrUufL5hGSdfG0Fo0Eqp2It9sZJQApB7kXpKhz0bs0Jmln
 JtTSfpZSJQRFfOBpBhbx8MlP3LWekmws1k6HhlNPmFlJ6wvhfIQn2LiJzVV7_f672YowYtMLQ2Iy
 fyJyz0hcHCpZNN6mFrYOsim6OkUQ_DfMMCqOSy57xNL0KI2RFw1Y6bxAJK.rT3LWQlaKQKvA8E0P
 YjzByWYAsUgTr325P3q6Vun1zBizkoxw2rQT7VTvXXb8hbLaaMkV0.huiXg75G0P1X.kdb.c2.lv
 KR5R_wjBf3ZFW6OiADNOvUsnyE2Z8EmyijYRMTlewCED.taBzJEF7tkmK1_yejw6VEnZhcTI8KB9
 S6arQvaELCgS4RT5Jovjekc.x40yAHIOPXk9AgEnQZ.sunWDkDQAIe.Xg.WaFXZb5c4HLjtXWIP0
 qxR.xLCUAvs3iJAtswZqZNO.F0j4T.LPGDA7Krlb638Jduz_q8pg5CkwamurjnpMF3DVm80ED_1P
 pqXZi6BPi.8_.GCggfqA.EV6ZeoJ4.hO_7A.TonjlcrPmacvCL7Tfk4OWndSdDXNtf2O.MclUhMG
 Ob.LLsbnCE5fMiFVj5CTFN1S8qAyNCT1QVppd8mA_AKATj4NSCRvtvAO_YQOyWwiEVI4xW0IEybP
 ftSuEuCKJcGvhjLqdJsJK3nj0AYD_Tno36r67wisTzbiQs_oBQ5Z_kAbI5cMcHZCWqCyauiCzHlq
 Kk16KeZLM8NY2t3bTjA4CS5BJUf5mKrp_7dsun5wHSpajbeCQDqCM1G4hHG3I8ol_LRb70sMJ2ot
 ofZtClyQcO7S44QB8Jw8baVxKnERA3lcvVgykVxTY8VXer1opwM6g4UW.WpGPZhBD0prZ33vOZmz
 K4B3A04wumO2lHr6mXppJTkqhFxCCejFdfFGf6lhgEEeYt2uzDVMZp.YjxgcgrtrTjncXfr1UZzK
 uyPMc5Bc54v3yGXxOcCf7pHVIOl.Em7pGQZgabARA05do_xyvUTzJrgVxyY73kqQMG1MtqdLiCeh
 2wZMbXJn0PFc5SGsIJX_645B9fd8r3Jr54Ei7761jjCGZ.WUFAdkoXMXzqg2J.L9UiGa5Cu4vVoB
 2Wng.gRncER6LFgFCAULnhTasaI9Xgkpv9Gyhcgt30JY9HMKRAIhgJu5cosSIVNC6eZBdk503hcH
 m8wSWY4cwqmt79zIlrXWycjcSDeFhGAtCUXKZD51_KXnIa1cQLUGEbzph9KMCEJ1JzliQSCxDlr.
 Y1d0zKljiJzYLwpeN7G50Udq4dGty9_xWOnz5sN4pgvy1394TpeiH8nyq14rnf2xp1E6i4diwgRu
 ifI7NjFGuNp78_7BIaO5vFSh7FJUUGrEjIQ1rOyxOVeDOIjLTN4jBqJgz6RRuOhU.s_qBuA4oNrR
 Q6B6zKspaxAq_ZEn1EtoaewG3jkf0YczCf9TYfyvmq1bYNXJcGZ3MpDU3rLKs8a2az_hH1QKa7Wn
 _YUKJvZuLO..uLsE3sBCgPg7x0IwzckPaEm8gVyz5uVS8S8vQKA5my.KAQlRfWrMInXCWo6SD8Q0
 B.DSBYYuuOqh4_ZYrrx0vYtRoq7R6FZgtRzfiSU1hC3iemDpfmlTb6Za5eHp48oNUt7h3lfXUdwn
 za.6BMXbUfyG1OdQ_OxmeV004DD3g5GlxiYFC64ycWMuNRZcC3IP3u_1qir140ywL6ujG_7oaCsk
 pt.WKGWLg5kY3ydnFRhgeTH4.Nys6OjZ7Uf080befnl4oiLo.cx6GgsBt2tK.1esgPvIu7W4-
X-Sonic-MF: <dap1@bellsouth.net>
X-Sonic-ID: 08541fd3-2009-43a0-abe6-3844367f2159
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Oct 2025 15:39:17 +0000
Received: by hermes--production-bf1-554b85575-cnk59 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 65fd4309595f4cb9b9fe3999fd29b02c;
          Wed, 22 Oct 2025 15:29:09 +0000 (UTC)
Message-ID: <16b5dc64-201e-4796-942e-1e6e2f386ce8@bellsouth.net>
Date: Wed, 22 Oct 2025 11:29:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Migrating Repository without Network
To: git@vger.kernel.org
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
 <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
 <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
From: Dennis Putnam <dap1@bellsouth.net>
Content-Language: en-US
Autocrypt: addr=dap1@bellsouth.net; keydata=
 xsDiBD7uAhwRBADrOwguPXQyhbUDGKL2Uey6/aOXHeT4cuhfh1hXWyhAHxJzb2p4xDJLqxdX
 i/iAbMb+6Y1GGoLU3cXmDBo50+OAqVRPSxi1M1+uP287/uz2to0xhPCOGot1F0bjbwmxVtWm
 THsnnQTSjEoZETZB7/mnbOwD7sioReNEVHvTmwwRhwCg/7UxK/vZYr0xOKjXsUxdbnTTT58D
 /A9b7wfkEqKNpWvMy7Oh9T9s7naq7HixxidivyOoAMPKz6lYaHP+FZyPW/+i0lB4lN5mvndZ
 qoLMHG8gqqRVCXBCjnVvukg/DA5BMsGgmkoN2+VnR04HsNJoaoiu2IqjBtw2OxyRM6MI2uQN
 xUsdogbxvy+L2y8udkSJdfO7QdCHBADBkRFHdRyRq/uq2VW+82PlzADmy3L+bypbmJvVVdMT
 i1LHu9pZ2fPY9h1Wo4+aUdpp/xuFAQTrmAlsl7PB+Uxweb4/yBkeBCz/HbOp5pZFbYV040Gr
 lMMbAuWGiwQ8t0fzD+g1P/u3BzQfC9XbGd2jy7pd81GZRm18cozfeOlNZs0iRGVubmlzIFB1
 dG5hbSA8ZGFwMUBiZWxsc291dGgubmV0PsJOBBARAgAOBAsDAgEFAlpOQqkCGQEACgkQ/fiW
 YqZ2tVShGwCfbROiENYcACS4WZGMxPQ2ZdJV0cYAnioFIPK5mMvje1c4a5NwBfq52RWKzsFN
 BD7uAhwQCAD2Qle3CH8IF3KiutapQvMF6PlTETlPtvFuuUs4INoBp1ajFOmPQFXz0AfGy0Op
 lK33TGSGSfgMg71l6RfUodNQ+PVZX9x2Uk89PY3bzpnhV5JZzf24rnRPxfx2vIPFRzBhznzJ
 Zv8V+bv9kV7HAarTW56NoKVyOtQa8L9GAFgr5fSI/VhOSdvNILSd5JEHNmszbDgNRR0PfIiz
 HHxbLY7288kjwEPwpVsYjY67VYy4XTjTNP18F1dDox0YbN4zISy1Kv884bEpQBgRjXyEpwpy
 1obEAxnIByl6ypUM2Zafq9AKUJsCRtMIPWakXUGfnHy9iUsiGSa6q6Jew1XpMgs7AAICB/95
 AiJ9EDojDAaCCLfKc/nO58mpQiqpJ4Mecs5viPfhjzuqzE8TVegLA4jWjrsun2eE/M357NJA
 mZvvGeRsunHfxeq9JZ8R/yYTC4/trW19trU77LE61If51O0MRIh+wODfjZPxrZN5cQ/3l/as
 hZrZMD3jHo2rvzA2Oq1LQyqZWRIaD42vor6SOJj//81bEIb3N3uCh5EEpXT+EzXTgGF7Wrng
 oNVmehu92wtV5h8IoHfzcODwcXEk6C7d9nVqW6TNSfJM7/GBSvbxTSQTK/7fn/5QphDIf7V+
 +Et0Xe6gA/sUA9Fd8m1MQUs1KJnuOWjw5qQ3sCwyL6eG7qVtFNoOwkYEGBECAAYFAj7uAhwA
 CgkQ/fiWYqZ2tVTabgCfUed1hVCTMDNx0+WS0NDgrYZpQ00AoOjRozaRTJcR8Fmp8ehnmx1O XGif
In-Reply-To: <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CASxu2IVknD0ejgeTjz088aH"
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CASxu2IVknD0ejgeTjz088aH
Content-Type: multipart/mixed; boundary="------------XSd3qmO0VeG5YOa108i3N0jb";
 protected-headers="v1"
From: Dennis Putnam <dap1@bellsouth.net>
To: git@vger.kernel.org
Message-ID: <16b5dc64-201e-4796-942e-1e6e2f386ce8@bellsouth.net>
Subject: Re: Migrating Repository without Network
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
 <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
 <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>
In-Reply-To: <6tygbwc6ifpuo3xylsmsveufqyroazy35u4lyblnvuls3l7n3u@d4ail3s6vtoa>

--------------XSd3qmO0VeG5YOa108i3N0jb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB0aGUgcmVwbHkuIEknbSBub3QgYSBnaXQgZXhwZXJ0IChvYnZpb3VzbHkp
IHNvIEkgYW0gbm90IHN1cmUgDQpvZiBzb21lIG9mIHRoZSB0ZXJtaW5vbG9neS4gVGhpcyBp
cyBhIHJlbW90ZSByZXBvc2l0b3J5IHRoYXQgaXMgYWNjZXNzZWQgDQp2aWEgU1NIIGZyb20g
dmFyaW91cyBjbGllbnRzLiBEb2VzIHRoYXQgY2xhcmlmeSB0aGluZ3M/DQoNCk9uIDEwLzIy
LzIwMjUgNTowNCBBTSwgS29uc3RhbnRpbiBLaG9tb3V0b3Ygd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDIxLCAyMDI1IGF0IDEwOjIxOjUyQU0gLTA0MDAsIERlbm5pcyBQdXRuYW0gd3JvdGU6
DQo+DQo+PiBJIGhhdmUgYSBzZXJ2ZXIgd2l0aCBhIGdpdCByZXBvc2l0b3J5IHdob3NlIE5J
QyBpcyBubyBsb25nZXIgd29ya2luZy4gSSBuZWVkDQo+PiB0byBtaWdyYXRlIHRoYXQgcmVw
b3NpdG9yeSB0byBhIG5ldyBzZXJ2ZXIgdXNpbmcgYSBmbGFzaCBkcml2ZS4gSSBjYW4gb25s
eQ0KPj4gZmluZCBpbnN0cnVjdGlvbnMgZm9yIG1pZ3JhdGluZyB3aGVuIGJvdGggc2VydmVy
cyBoYXZlIG5ldHdvcmsgYWNjZXNzLiBDYW4NCj4+IHNvbWVvbmUgdGVsbCBtZSBob3cgdG8g
ZG8gYSBtaWdyYXRpb24gd2l0aG91dCB1c2luZyBhIG5ldHdvcms/IFRJQS4NCj4gTm90ZSB0
aGF0IEdpdCByZXBvc2l0b3JpZXMgLSBib3RoICJiYXJlIiB3aGljaCBhcmUgdHlwaWNhbCBm
b3Igc2VydmVycyBbMV0gLQ0KPiBhbmQgIm5vcm1hbCIgLSB3aGljaCB1c3VhbGx5IGdldCBj
cmVhdGVkIHdoZW4gdGhlIGZvbGtzIGNsb25lIHJlcG9zaXRvcmllcw0KPiBmcm9tIGNlbnRy
YWxpemVkIGxvY2F0aW9ucywgYXJlIHNlbGYtY29udGFpbmluZywgc28gd2hhdCB5b3Ugc2hv
dWxkIGRvIGlzIHRvDQo+IGp1c3QgcGh5c2NhbGx5IGNvcHkgdGhlIGRpcmVjdG9yeSB3aXRo
IHRoZSByZXBvc2l0b3J5IHRvIHRoZSBmbGFzaCBkcml2ZSwNCj4gcmVjdXJzaXZlbHkuIFRo
ZW4gbWFrZSBzdXJlIHlvdSBoYXZlIGFub3RoZXIgY29weSBvZiBpdCwganVzdCBpbiBjYXNl
IHlvdSdsbA0KPiBzY3JldyBzb21ldGhpbmcgbGF0ZXIuDQo+DQo+IFRoZW4sIG9uY2UgeW91
IGhhdmUgdGhlIHJlcG9zaXRvcnkgb24gdGhlIGZsYXNoIGRyaXZlLCB3aGF0IHRvIGRvIGhl
YXZpbHkNCj4gZGVwZW5kcyBvbiBob3cgdGhlIGFjY2VzcyB0byB0aGF0IHJlcG9zaXRvcnkg
d2FzIHByb3ZpZGVkIC0gc2ltcGx5IGJlY2F1c2UNCj4gdGhlcmUgYXJlIG1hbnkgd2F5cyB0
byBkbyB0aGF0IC0gc2F5LCB2aWEgU1NIIHdpdGggc2V2ZXJhbCByZWFsIHN5c3RlbQ0KPiBh
Y2NvdW50cywgdmlhIFNTSCB3aXRoIGEgc2luZ2xlICJ2aXJ0dWFsIiB1c2VyLCB2aWEgSFRU
UFtTXSB3aXRoIHRoZQ0KPiBhdXRoZW50aWNhdGlvbiBwcm92aWRlZCBieSB0aGUgbWVkaWF0
aW5nIHdlYiBzZXJ2ZXIsIGFuZCBzbyBvbjsgaXQgaXMgYWxzbw0KPiBwb3NzaWJsZSB0byBj
b21iaW5lIHRoZXNlIHdheXMgb2YgYWNjZXNzLiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRoYXQg
dGhlIHJlcG8NCj4gaXMgdW5kZXIgdGhlIGNvbnRyb2wgb2Ygc29tZSB0dXJuLWtleSBzb2x1
dGlvbiBzdWNoIGFzIEdpdExhYiwgR2l0ZWEgZXRjLg0KPiBTbywgaW4gdGhlIGVuZCwgd2hh
dCB0byBkbyBuZXh0IGRlcGVuZHMgb24gd2hhdCBzZXR1cCAqYXJvdW5kKiB0aGF0IEdpdCBy
ZXBvDQo+IHlvdSBoYXZlIHJpZ2h0IG5vdy4NCj4NCj4gSW4gZWl0aGVyIGNhc2UsIGl0IHdp
bGwgYmUgcG9zc2libGUgdG8gZmV0Y2ggYWxsIHRoZSBkYXRhIGZyb20gdGhlIHJlcG8gc2F2
ZWQNCj4gb24gdGhlIGZsYXNoIGRyaXZlOiBpdCBtaWdodCBiZSBub3QgZXhhY3RseSBvYnZp
b3VzIGJ1dCBhbGwgR2l0IGNvbW1hbmRzIHdoaWNoDQo+IGZldGNoIGRhdGEgLSBzdWNoIGFz
ICJjbG9uZSIsICJmZXRjaCIgZXRjIC0gZG8gdW5kZXJzdGFuZCAicGxhaW4iIHBhdGhuYW1l
cw0KPiBzdWNoIGFzIC90aGUvcGF0aC90by90aGUvcmVwbyBhbmQgVVJMcyB3aXRoIHRoZSBz
cGVjaWFsIHNjaGVtZSAiZmlsZTovLyIgLQ0KPiBzdWNoIGFzIGZpbGU6Ly8vdGhlL3BhdGgv
dG8vdGhlL3JlcG8sIGFsbG93aW5nIHRoZW0gdG8gd29yayB3aXRoIG9uLWRpc2sgcmVwb3MN
Cj4gYXZhaWxhYmxlIGxvY2FsbHkgc3VjaCBhcyBvbiBhIG1vdW50ZWQgZmxhc2ggZHJpdmUu
DQo+DQo+ICAgMS4gaHR0cHM6Ly9naXQtc2NtLmNvbS9ib29rL2VuL3YyL0dpdC1vbi10aGUt
U2VydmVyLUdldHRpbmctR2l0LW9uLWEtU2VydmVyDQo+DQoNCg==

--------------XSd3qmO0VeG5YOa108i3N0jb--

--------------CASxu2IVknD0ejgeTjz088aH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQTebsbo9TQsIuOkbg/9+JZipna1VAUCaPj4RQUDAAAAAAAKCRD9+JZipna1VM1B
AJ9RR1ZOKSBNerG+jHK+OAQBvSPBVgCeJYBNnFTbDih932Q6hSUZFsgitNI=
=MfoG
-----END PGP SIGNATURE-----

--------------CASxu2IVknD0ejgeTjz088aH--
