Received: from sonic321-23.consmr.mail.ne1.yahoo.com (sonic321-23.consmr.mail.ne1.yahoo.com [66.163.185.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13328399
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457170; cv=none; b=OEy9HjAn3DjS1/rvqtv1NVoPSzD6UjZUF7+6/yJ1tnDogUvJA/AtDMczdIPPnVygl6n+MG7kZmx6Fsk+uo9pKP5F9QU+UvoDRFQm0wtJul1JNVZ31Zd8X5AStfbtgjHj7+aYerO64wozKRNko5DsLZJ6EXXH07MHQKfIAv5S2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457170; c=relaxed/simple;
	bh=YZ8s746LHNGnkrvi3dQmbJMPFbbOQ12uL5Un8J8KEng=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=Ya47NwU8CYAFtuii+dxHDjau6Dd5IGHA6YKW2pHnTVv18b0TjImZwT3wJRilrFcJvdFXqc5yYMvCre8bJXk7+fM1x1bdJxDsVJMkQlLDSf0gWXM5Pt1sIoJSJuhyPTF5JPcy7nAgnWEMnzUAWNVjTqPaNJG7ECRZ+M7DodV+eYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=R5f+WE2Z; arc=none smtp.client-ip=66.163.185.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R5f+WE2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755457167; bh=IWw0gDQT5NmZArMzP5kSx2VsrA9Zh0HPnHr0n9ymDhs=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=R5f+WE2Zr4fRzacQQUz5PkK0zzUiVLwD/h5VVj76h9BkWjMLIqdmygKLRK8JDancqOoRbvE3Q0dvOTDIubp5cd2PamQ/8DxMW7YmgCo6JnPW3IBr+ISj0zKTt0ufRANjz5Z5Z5Jj1eqJiv2z8SwZiHEFTZT1mX7RwqK4eW6GVTufeHfkz7cLAMD8iEyXO50ypEf69UAT+TZSCXdr1fm2LZzAernqD/Zaz1cVUrs0hUyGVE5kaccJXX+nh6JRh4GRN4Fh5CPUtmZEK2TIDf1LQPaVg1jQYhfh5ZzqOzCMT79LduwV/F2SmGo/5eGnQpcIrlTwdFi/WTnHudyrSMjX3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755457167; bh=pX+QJnv/YU70x6w0ybOaZDMLo1/1cx9NFRFt6I2uoPg=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=tIZ9Vkubj2HQfXY59df7YRy6s41BP1ncKV1inGFrIJTznqV6rGTk3o4FnVLjjORSwEfmQsAtWSnkxvQSJOjrYyv9Wl7oosqOJ9s/u/5icP6+a/AEn/vUIVxWf4USllEWLWZBbRKh0hVquYf7c2xr02c7zWU8qTcS/L92mIdqrW3VRlH7xqLCW6Cl7w5aOJONqe5n5LQG8ursWZEVKPAq5qoXV0kRyYcQb4x7foeUKdazWz4MRpYzFyNKbMV8PFHrb4345bPnpZ6eFTUgihtG7d+Oij3yypao0eWoPIQCn/lvJivN3StoZ4iGg7qt/rSZ+IdyDNzMTEAL84mL+Cn8Tg==
X-YMail-OSG: 6UD9IjcVM1kIfW40FBoLMo.pWQMFvSnmwX8glcReK5IlFL1qDH8q7FwxMMEfF51
 SrgUFG6W5U2co7saM84Tf1HaKkyohbWuqC6LGGb1pRRuvlpmBF5XGnKzzA1Gfmgu9jEeNAuggb4R
 L1v9B0N4iCs8ezIj46IqsTAuNJzi_hOuip5QdQJnf3eEsNTN4Qh2UTaZVSGVoiyzeZDdXFCPMuoE
 _OQpBdP99R5PU5yR9nlukXk82JUkW0QCnwZx_W3RQeZFog9MoPF8ppQi5mVmHfBpsFCrP_.Gr1VM
 1CkqapjH0Zth3cxVfjHki9uTIxJulf.9JM52ID1P6VvyT8dWeJwupsKN89sqDuDVVsnnjXhq5ZZS
 AWkT9n_wlH2TnZGdLTSqXUhKg6DFlmySw0TcOGc3jLc0lRtz.sNE5fChov7KhSAmilrc_1QKkVpo
 n_0xYF2kHtv9aaTLdGgZsjeBU1bt7VfeiIrRpWCWNw22t.TCPfNFOpIAUUJLo86VqfHQNR1LsL3i
 Plh6OOw515JkBaEgUbOyaXH7f.v3XiUZao0ShYlqBHNn6dmyMboUvg7GvAmwmQ5yO0bNj7fG9Ve6
 pRoPCDz5pmTbHi6iSxEtqzAb0k.GrczssQK_y27Yw8betPwH8YoHEbJPhEmZPRKoXAHbtoB5Wc6G
 9SNxjXSiiKZb00M7ddBjjOzwk4hepLyoRPEP8Wmhb6Zu_lSZ1yg7AIZ6vb5FfR_nZ8vjilYgsYVM
 UyBV4VLpK4BnP0CrcjabzogpolG8vAYnqdxT_9mZlmzqlhPHZ9WZ.5pmzsLu167c81JqHEMekoD6
 CEvJYwCfaNccD_duyerWFsWbZw2GfZNUHq4eiDZb0A2psfpoQB069o79jJoZf83GDJOPd.KutmF8
 cgsTnS1jKPfH.dLkGqOCkkEQtq4TvRe1vmh81Bg9HMhtiIJgVTgwNhD97a7vIUpRipHBnqt2i9vC
 gZLz.QQNBwuqeFNL5h2B9.uawm11Pbr3SDFu5aR8UypPu3k.3vu7hWOApYGXLiSrYa0y1hfKGkmv
 PreYLYuSmkM2uwBmCYIk2lLdQi_lgU5jZstioAP40wY8NI72DZkYEI0XIAPZJHuSO2JTBwPamwEW
 fCT5sYc8U84OU6BCYitKXxpKbd38OdPq2Yl3UyIvoQkMK1PRRM.p9uF9YEYa8q2FXRFjdlOa.pJh
 seff7nzd4ulJgs2UjSXAiRvDtN_d5f7WRAu5XYMhkVBzAeg87pJEL5OFdiNlL2tMyhpXJItcLJQD
 m3et.JiYNnCwbGL3m8jWefUnI3YqhTOfRI2V0FID8YjXTQeBEISn22_d_z8FQz6dx6KulNskqy1B
 mNoPF4PRrzJCS.x8Mk8GFk1H1EUCQsTEFTVdzIMQFVdfW.02hLcnJ4FTC4m8O.LwCJOkNrTyQrXt
 WFapcVlurD1oECE7_HvsytGv1XaMh5WbHeuwRL0P.rUVtdDArl8a7prpDo0_h2MC5Y9egkKYlU9X
 XKotU5ZKBT8iqFqLIZAnJY85O5sH0JhoXquoU5ui1og4YGOSv0pkV976Q19.DXFisFR4AVPpKIA0
 SanwwrlqQolv8d.zWlgj3qXLHdYa9PiQU5mNT_KBJH.ih8lsIfzptu0vEGhOdXHnGofOPE0Ni2sj
 62vVPTvlvmhFcuo9aeL8kZY1r1hV_6tK6GCpU0Waj_mnZw3MffysFPJR7NG6Hx26Gu7AevLtLo_D
 PkXAargQi9SAfjSsvuykVTaxNg34Atyq6sGqEzJXIegbzzb740zfR6vwCiDPoyBdb961ZiDAjx.X
 9eEFZ1P2vYYplMmUAHN2iQYXL.HfG7drTciBA844RAv3zIn0xPTXSrk6E0r6orwq31A3Wzs02J.x
 J_ndE7j4aDmPOEeQS8paENBt0WNm3ucwGvevxIyUIOGxT7c75ylqyrgsx9MKcn_np2Qz2bKuNBvJ
 DQl1sXw2KPiT_BGwpjbL_mYJ5ohL.yqJ2wXq0rjcVlx6gSv5jHz_JAfTTOH2N6_8tnLVUg6gpewu
 iQ65rYN4h2eoklur6ApxwUU7rNsbK77tCDusKd5.7f.pg_f9MHwLWXMQIoa1ZRkfG6khiiBzEl6O
 Y4yDjJEKA6cGuqdYDbf8bb_bIbuhd4agKB64K.9oAOafKaSuaWR5.o_SXC8X2l6avNOy09G6Xchw
 dFHiTGF3hvd.irnWeIlSyEu9c0S0Ov10uYEieJkEBD9ik6Am5qCGLU2Vm16mRPFgT0DTEpDJUAC5
 6.Lc4Z_veVXUvWnHL3x9pskOSN.ugyPCDNCoQ
X-Sonic-MF: <keith_smile@yahoo.com>
X-Sonic-ID: f9aa702f-6d70-4276-8a57-59b52b441755
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.ne1.yahoo.com with HTTP; Sun, 17 Aug 2025 18:59:27 +0000
Date: Sun, 17 Aug 2025 18:59:27 +0000 (UTC)
From: Keith <keith_smile@yahoo.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1679622008.808432.1755457167024@mail.yahoo.com>
Subject: Gitweb advanced
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1679622008.808432.1755457167024.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.24338 YMailNovation

I have tried everything on git-scm dot com/docs/gitweb#_advanced_web_server_setup to get files from:
localip/~user/
to work and nothing I have tried has worked.
I know, the local IP is the actual 192.168.... and the <user> is my username
If i put a public_git folder under my user it never shows the repo there, only the ones under 
/pub/git/

it will not show the repo's on users. always shows 404 no projects
does show projects under /pub/git and /pub/scm
Thanks
Keith
