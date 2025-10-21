Received: from sonic306-24.consmr.mail.ne1.yahoo.com (sonic306-24.consmr.mail.ne1.yahoo.com [66.163.189.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8C13A3F7
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058342; cv=none; b=NIEXkAUhXt+Z36ahbNcj7/MDVfrsWRP6ZP5I7uuoXCLBW6+Z/dtwav3AI/UdcYsBm6LO2LNQlP/qnzc+yii+miQoP6LQHC2TlTbUCvASnE6E2ecW2A4UOEOjZ29BgHDr9UW6pUkw/wbA4I3MADaNM3K3CGfsGvYm4iGiviJkG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058342; c=relaxed/simple;
	bh=hokvM2oKIn9Vr0aNiomWglEUF1Z6/IJ5h2xM2VlSHvE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=f/3XjTYPiWbCTlpzlt9gp4ZHA7F20Eiga7aqmTWxuIgnJFloDNL9TRwi02RxKevr2nlhzkJEpIZI+JKkPGCmmxdp7oc59ThicCVMGpZPfRIDvHcjkiAcVn+EEOiwWAp4XRtOmV/QizkC7/YJ9p3JrkJE5AcNZPR0xBWNXeG8v3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bellsouth.net; spf=pass smtp.mailfrom=bellsouth.net; dkim=pass (2048-bit key) header.d=bellsouth.net header.i=@bellsouth.net header.b=r6cn4Vdi; arc=none smtp.client-ip=66.163.189.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bellsouth.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bellsouth.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bellsouth.net header.i=@bellsouth.net header.b="r6cn4Vdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s2048; t=1761058339; bh=hokvM2oKIn9Vr0aNiomWglEUF1Z6/IJ5h2xM2VlSHvE=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=r6cn4VdibhJzzKYThcxz3vFTRWBN8Q+Z3wLnTzU2Ack1rt97KlSycIKVVfviE2QOG2Vb4H4dn+RXEHicZthuH4UZZ84oW4HrBBZDwllUb0Ac7jx6flbc5rTf9qNN/sPnsCOkRXK3Srae1DmxPwQzjnjMsffN4+1EtIOmf7obzVxlyLnZArh46egMBvzCn67bZh0blOLcWm6Z02QKfZBKqOBU93LxlII2OWcZvYHIiIl0MdsOseSmsETPiJTdmizmF0JVHvTbwkD7SggzluBKb1Eecvx6Ak6eWGzydfp2bN0QD8yqUQqexkRFEsz2ecP5GgynYZhDtPHqpSwwSDpXVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761058339; bh=66WaqadKhRz7B/7s9Eiu5ftESL3bspg6vz5MXxov6BF=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=hGVO4itkXWN2/8rheEuiw4Wx6p/9S4KK7vVxDSYV2zS4aZt+Oy3USY3SuTqPxxAJIdGkN1YuDLxg78Bt3ezIjKX7u38xkF6U3qomgOEHLlbgr+Ati8DvCOrMmAlLDSxsWqxfNgROEKSSoE6aVjr/vYmiPBcSqohFnAKuLqi83j4/Pcltxs5Eo/a19gRlpnsTNlvYC3QietdH4WSXUs0FDE3PiDbMC3slJjBSVim4aRMD4JfHKkhx7Blk5cwBPL3BpC9Lf7yseNrVpi6S4Hab9FZjZ0DzDUedMmgL61OMDO4dMj/xT+gipL+cjREN9bA8R933iTSz8S20y0Di44nf1A==
X-YMail-OSG: NuzY0HoVM1kHbtJXESTs8FeLfqYF8OQb6zB8Hz.J3nMmmm0Bpxf_mTCuTWuDj2S
 1MIB3tiC2lQYgwYMWIJ5hp6iv6.eYAGgHNztJ0xbo1UNgcLt3Me2lJ3ohtzv65IWo_Z1cESesqIq
 X4ADdBjR9JfMzFOUzgJ0gxQaFAQNmMomCfKeJDu_a19FBpZ5kK5OvPnh0iQ9.l1U1wXGPmoF96Kv
 e2y0G2U41LcyDe_ZBnHhSKGNsan4fOLY.piU6R2G53qlWxmzl2nOwbpjx3Zz3TyJkol1.xb75Oyf
 BaqeLffuYgYUv19S6k7Lu3e0R2L8C5JJPbU63fRGbS_8LNhe9fUd1NHntHT3cp962VP93j6WpJSR
 i7Mi8pUCjbPVoXR64mKMit1IafoQs9LqMcpW5MWNjDTRsjv5dwL1Nk2FJTxxavCzf23Csa4nsylq
 .aXASbtDQ845u2q.DiIDx6C3eeV2RHwMrWKoH56P92Mo0qHbu1p1ZQ2znwlQqrp8Tg3GwocyQx_J
 EVvKT.gKLz8vTj4ycGpSv5WrQZ5n32TsIzEVZT4IDWC1wmhXz1Avzs0USyzoFyIVPRzmiAOIVTY7
 I4HTko8cNMZzohjBXOpfXVcijjeRGcT59bMQbG1O77cplTouXo3LjlY_P.gPjS9umlArcJefLAo3
 WoUgJK4PWnaFMsevSJSoHxRQy75KfaeuERmBZeQRRfjFpWdjPvjVOGqs660r9xhGy8ZRxMy5LaQA
 bqBAeAstditZKlDQL0JsbrXBCfLobdgLvk9M.ZSosn5XWMugc1ymKS.aNTw6wKXoWp457pzmP7E8
 HQEViO_l7PsClXIApfgoszDXSxv6rrSnCRUda63e25O5eCy9dFT4vG2PsjboI9OeyccPehtnvo8S
 MJxsoDTUzzPosRaZd6_GunjNJoh2NZgFa0_Rzc50i8U0G_kox7S2cDARXa2xCm6LEcISTnR7wbwi
 sv2hNulgw657bos6WSQSdxJfx4VRPZ4Uz9c2iHGDhIWCvvdZdTvdB10BUa9NZYE6gUiAkz3xP7mY
 pAmPBTCHfnH0ziGb1geWiGnPQND3rsxhwThZSPTrMSYB_2yIH0sI_Gnwn11Qy.OkUW9QKRKDqu1r
 fJYS9fyteLgl3up.ytf7eIuE9qrQU4jhRt0LLEf6oroaSv8680DLoPUF782NRPc8OiiYFCgaq3Ti
 p5DnSzpJ0CKhStzXnbjmBZadrL.LbekR3rjDg_i4FBQWTCDrjMcmvUUEjMaBUnsp_X4lh3Z0Yo.9
 Cc4k1qttmHOqAOs4oQSm6Oe1BAdNz3ptFWEen6ITRO1ZGa_WTkxPnVbXODLYGJXZq7lZlq9MJCAI
 tUnLvVnvmu905G4LX0dT60mav5YFhm.pj_iHW6xK9NueSLonEnS0HzG1ScI.H63El.ZBWprRmBLn
 I.Uy2qGkdFK7E523CjaKC3x9sa67n.nvdKs1sTAw7tmfhNj43mgyYFhcMG6_VCRddDrfXUFiWvSC
 GUYjnbgpMlbYJ9.lBkvl.RLyMydHr3uk_tRwmIthSo.EJc1o3Iih8I4CQk6kC1OWaDyc6CER2Zcy
 mONAkg81G5nMWYHlnmQHErHlGgTUc7Crl15IKbYpc0G0XxDuWz.52tZ7.JhbwTLB1K36YW_rufDd
 PJt2jPv3iBgcQnrtn93XuRuON7iZJTsPKLphRudbgQCn0._UwaoWENgCVVsWb7vfMSczYs.bKNKS
 IPhUdluEh9WGGsL85f9D2KiCfUZSg3PYq4vysSHPKKo.XEcW2EmCM5ZoYq777U0pMiRGqLvmEqE_
 A5jSr51mRGnkA8TV1Pvws8ti9fCMLOPJQRR_De_V5ylnispqV7XHd4dSDi8nd_iwH1CzmuHtqFGk
 jNx4EkrlvLXXsHPqABNruoE2t4dCglxozwa2H1Eb6iujfiVEHPjWltKesm73YBFxUnNLSReFrVqY
 5gqC6jXNTPeCXlk7j6Wn3efz7x5yHKGIZo_3UKKY7IsATes.jo7chb0vv8hMnfpMt33Jnb_hUDI5
 1OS6PYyZfGFEA1nYzEbPijX4adCpxz6odJ39RHvlcVmgr2xhhdjHSRnB871dHwAYoS3cH.KwkTuq
 pFnzdmoFElIL_ogJ4AqD4XdZWiv2RvOpRo8r5pq5YMSUkF93Qp2_VPIcM_HdGC88._ctW0fiLtXd
 x3JYcakV3h4rwlBH8itRiRbuTANNpvbP6g3l_d1wZMTLL12IgvEkHYguTX4WcFXcjHw.MDzQtNHF
 5D3a3oy87UITHE0mBkrFPoYSIOf_SbEG55F4dc40plG0AObmbZi2xT5pxG3xhYyoXMcsRTcaq
X-Sonic-MF: <dap1@bellsouth.net>
X-Sonic-ID: 37fd6e35-98eb-4354-8d34-feb75eb4a303
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Oct 2025 14:52:19 +0000
Received: by hermes--production-bf1-554b85575-8k8xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a228b9db080ad5009a34388a201d263f;
          Tue, 21 Oct 2025 14:21:53 +0000 (UTC)
Message-ID: <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
Date: Tue, 21 Oct 2025 10:21:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: Dennis Putnam <dap1@bellsouth.net>
Content-Language: en-US
Subject: Migrating Repository without Network
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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4dH0x0lSmQdbVUtF231Pdv3O"
References: <94497aac-c61a-4b17-9e4c-8ca9b966829c.ref@bellsouth.net>
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4dH0x0lSmQdbVUtF231Pdv3O
Content-Type: multipart/mixed; boundary="------------F6WePfsXd7YzHTE07Zl0rOIQ";
 protected-headers="v1"
From: Dennis Putnam <dap1@bellsouth.net>
To: git@vger.kernel.org
Message-ID: <94497aac-c61a-4b17-9e4c-8ca9b966829c@bellsouth.net>
Subject: Migrating Repository without Network

--------------F6WePfsXd7YzHTE07Zl0rOIQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SSBoYXZlIGEgc2VydmVyIHdpdGggYSBnaXQgcmVwb3NpdG9yeSB3aG9zZSBOSUMgaXMgbm8g
bG9uZ2VyIHdvcmtpbmcuIEkgDQpuZWVkIHRvIG1pZ3JhdGUgdGhhdCByZXBvc2l0b3J5IHRv
IGEgbmV3IHNlcnZlciB1c2luZyBhIGZsYXNoIGRyaXZlLiBJIA0KY2FuIG9ubHkgZmluZCBp
bnN0cnVjdGlvbnMgZm9yIG1pZ3JhdGluZyB3aGVuIGJvdGggc2VydmVycyBoYXZlIG5ldHdv
cmsgDQphY2Nlc3MuIENhbiBzb21lb25lIHRlbGwgbWUgaG93IHRvIGRvIGEgbWlncmF0aW9u
IHdpdGhvdXQgdXNpbmcgYSANCm5ldHdvcms/IFRJQS4NCg==

--------------F6WePfsXd7YzHTE07Zl0rOIQ--

--------------4dH0x0lSmQdbVUtF231Pdv3O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQTebsbo9TQsIuOkbg/9+JZipna1VAUCaPeXAQUDAAAAAAAKCRD9+JZipna1VDdy
AJ4jYoTQyrJcpwnA3FbqaFsfWuqGeQCdGZyhlzjPN3M0C0c4WycgPU1y4Jc=
=S1me
-----END PGP SIGNATURE-----

--------------4dH0x0lSmQdbVUtF231Pdv3O--
