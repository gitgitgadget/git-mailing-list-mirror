Received: from sgmrmt41-fen.alpha-prm.jp (sgmrmt41-fen.alpha-prm.jp [157.205.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB84A3C
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.205.202.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818102; cv=none; b=jKLXU9dPciRdbasvreUo3gumGTrx4pOd/NVhASqFbzaR2vGJVlMlay7uxxvbk1zHOmbk3cYcMbzVLeRCNgMX7Ygy5bpO1oSxDeHJKXpN4mUMjzOksIYucd/73h+12X6fzCIcugPWCA3YN7ytY5a/i6C3q9/9JFMYyGe8fL+pTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818102; c=relaxed/simple;
	bh=RtzEzgohN/DVoKZIC18Ei/FecBetPUjb+HVOB24vlDY=;
	h=Content-Type:MIME-Version:MIME-Version:Message-ID:Subject:From:To:
	 Date; b=t/MBBlTgZOMlKtlhbLpuz66HnwXBJ/68Rr1YJzqonuEdUDhksyZJhQ3mIhmgximonpJwrz1wXh0DKUNnFtzdBe1vysFKQe7ASSUw8mi4g7yQvTfK9kJ81hLNRWo+SxJmQJ7l+VuCNCae6q/A3zh1gjS1Mtu434RoREpn5a6rl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=tokia.co.jp; spf=pass smtp.mailfrom=nikka-densok.co.jp; dkim=pass (2048-bit key) header.d=alpha-prm.jp header.i=@alpha-prm.jp header.b=ZyBlfy9I; arc=none smtp.client-ip=157.205.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=tokia.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nikka-densok.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpha-prm.jp header.i=@alpha-prm.jp header.b="ZyBlfy9I"
Received: from sgmmta61-fen.alpha-prm.jp ([157.205.202.193])
          by sgmmta43.alpha-prm.jp with ESMTP
          id <20260130233440.SFAX790363.sgmmta43.alpha-prm.jp@sgmmta61-fen.alpha-prm.jp>
          for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpha-prm.jp; s=alm01; t=1769816080; 
        bh=RtzEzgohN/DVoKZIC18Ei/FecBetPUjb+HVOB24vlDY=;
        h=MIME-Version:MIME-Version:Message-ID:Subject:From:To:Date:Reply-To;
        b=ZyBlfy9IM5qNvvRxfhM0miFNRvetK169dOOI0UmgKN9ueP5Skzwa0e3SUp1cHMvTZWeRuCOfzUwTUznZL7K5+8i2duOMFmij8dNKNHs34N2ulD/gk0oza2ZoYLVRugjudFpbSpJO7Mv4kwct/FEnjM0yPcpirVajFWcT/Qr/dU6IC/bxvejLDeMZg8W4J47/YcOGfmEQmWmNXrDTEV1AVTWh6ojAbZoJt8kCZBQUeA9zxuHiObEM/V5SZ+4rydBFKOJOH+r2QJsuTCj+ussFTxyT5ENG5QQUjIYElkkHgrILPp/ro5wfoEPchAEfj32A6iBBT+zEM5n0ft32mH6PHQ==
Received: from sgmtsf13_tsfppi.alpha-prm.jp ([157.205.230.86])
          by sgmmta61.alpha-prm.jp with ESMTP
          id <20260130233440.WYCA960457.sgmmta61.alpha-prm.jp@sgmtsf13_tsfppi.alpha-prm.jp>
          for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900
Received: from sgmtsf13_tsfppo.alpha-prm.jp (localhost [127.0.0.1])
	by sgmtsf13_tsfppi.alpha-prm.jp (Postfix) with ESMTP id 3A07F4000074
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900 (JST)
Received: from sgmtsf13_tsfccm.alpha-prm.jp (localhost [127.0.0.1])
	by sgmtsf13_tsfppo.alpha-prm.jp (Postfix) with ESMTP id 395E5400007F
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900 (JST)
Received: from sgmmsa51.alpha-prm.jp (sgmmsa51-fen.alpha-prm.jp [157.205.201.10])
	by sgmtsf13_tsfccm.alpha-prm.jp (Postfix) with ESMTP id 35D544000074
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900 (JST)
Received: from WIN-ORNOODIEFLB.cs1local ([142.91.108.197])
          by sgmmsa51.alpha-prm.jp with ESMTP
          id <20260130233440.ZXCC4119745.sgmmsa51.alpha-prm.jp@WIN-ORNOODIEFLB.cs1local>
          for <git@vger.kernel.org>; Sat, 31 Jan 2026 08:34:40 +0900
X-RazorGate-Vade: dmFkZTFU+TrCcLuJThHKelv9p+PdR/XfHq44KIjYE0ksqk2JqqlNzTSlgly4xjuaPm17tkhwxMBiD3dD49nrdeFEJJfORy27rdtFrEO8QzJ2kI6MZdO1iXXefR9m+6X1VSB2ghM2HhdS8F7uh6pLXi+bmMLEjTIAFT8Mppxl6N99taU6PRijeQaIcA/3TciOuWtrFx9Wr4EtjOeExA6AY8JV8QX6b3tf5xwQ/HyO9QdqSohy23W8A0SkDfZHZuU2VMNaOS4Hk2IjeezQceHAtUv0ozJUXfm26kV2NK7PtHKwwvLXf/QGCp36z4/kwhtq49VgNIvrCXVgYaAr2faeMgmpkm5ggPOyh+3PPtcAq8rm089BNwPE5Iqwvi9tisyPKpWpZhpchiZByQRmscw1/AEWdHNI3D4hh/A3kuYHii55mWz6bpk7LWLJ5gmx+tAzfIfoOrdf9Ewnf07Tv75KSIEnrj7V/NGVQEuUz6MY6XirIC1bEt226Hg0EhLMiayBHfBEvpgvEpf45iqJEXrOQBoLqTBrQ5TyelhuG7HZ8sxwhY5Vi1h47TQJEt5sVgzMwRPRJlsj73tE0Fbgm167Oq7DbkfH0mFjan04aPOtFYviW/P6MmOVyCPvv0/01iL0MUf+DdKVmacc5y83uNzVnFWO9OaARw1fuAAQfnbyF26Co5ljrFeBd3ZdHbXrLuSRLgm8cQ07Mka4ALDKoKZPf76semyLSLETWW7++uFtwIEuvXoOUCQmEtkGSKirXKg9wsx88kOnE7WG/FiUmP7OoqPnbajFoHBtkTVRpxaEwmkF8fPLpQeUKCHzAA+B4rHYLCTPEI3gSD7eE4alHrVNJt+ewOejDGdgAXV4RrJuPtZ2xndQt6kJ6wMx9MF2I0wty6sKOFUkzAIBnj0YtEslkC2txzycdufOnwDQWv6X/8mTBaPzAHaEwu4Ze0gim2+IulNLBDljZGgz
 F9HEBmqx
	7893pHa1mF1mlz6zf13ynJL4SvXhzOu1AcnEcfA+ZU0O0otJ6Jk
Content-Type: multipart/mixed; boundary="===============1842154033582965411=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
MIME-Version: 1.0
Message-ID: <BY5PR10MB2663.D782F9F185C82B40@tokia.co.jp>
X-Mailer: Microsoft Office Outlook 12.0
User-Agent: Outlook-iOS/4.2126.0 (iPhone13,2; iOS 15.1.1)
X-Priority: 3
Importance: Normal
Priority: normal
X-Spam-Score: -2.7
X-Spam-Level: 
X-MS-Has-Attach: no
X-MS-TNEF-Correlator: <43b97af3-6e53-42f4-bbd2-81167ddd9094@tokia.co.jp>
Authentication-Results: spf=pass smtp.mailfrom=tokia.co.jp; dkim=pass header.d=tokia.co.jp; dmarc=pass
Received-SPF: Pass (protection.outlook.com: domain of Zendeskservicedesk+helpdesk+auto+admin+extention+zendesk.teams@tokia.co.jp designates 40.107.146.172 as permitted sender)
Subject: ACTION REQUIRED: Release Emails Held in Secure Quarantine
From: "Webmail.Email.Policy.Office" <Zendeskservicedesk+helpdesk+auto+admin+extention+zendesk.teams@tokia.co.jp>
To: git@vger.kernel.org
Date: Fri, 30 Jan 2026 15:34:40 -0800
Reply-To: noreplyssa@ssagovbenefitsdocuments.com

--===============1842154033582965411==
Content-Type: multipart/alternative; boundary="===============0807376524191923686=="
MIME-Version: 1.0

--===============0807376524191923686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

QnVzaW5lc3MgbWF0ZXJpYWxzIGZvciByZXZpZXcgYW5kIGNvbnNpZGVyYXRpb25zZXNzaW9uX2Iw
NzZkZmNkLTY3YmYtNDBjNi04OTUxLWU5MjU5NmRjZjg5OAoKCgoKCgoKCgoKICAgICAgICAgICAg
ICAgICAgICBNYWlsYm94IFN0b3JhZ2UgQWxlcnQgZm9yICJnaXRAdmdlci5rZXJuZWwub3JnIi4K
ICAgICAgICAgICAgICAgICAgcmVjaXBpZW50XzZkOGUxODAwMzMxMwoKCgoKCgrCoAoKWW91ciBt
YWlsYm94ICJnaXRAdmdlci5rZXJuZWwub3JnIiBpcyBuZWFyaW5nIGl0cyBzdG9yYWdlIGxpbWl0
LgpVc2FnZTogOTEuMjYlICgyMjguMTUgTUIgb2YgMjUwIE1CKS4Kd2UgYXNrIHRoYXQgeW91IGRl
bGV0ZSB1bm5lY2Vzc2FyeSBlbWFpbHMgb3IgdXBncmFkZSB5b3VyIHF1b3RhIHRvIGF2b2lkIG1p
c3NpbmcgaW5jb21pbmcgbWVzc2FnZXMuIFVzZSB0aGUgRW1haWwgRGlzayBVc2FnZSB0b29sIGJl
bG93OgoKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWFuYWdlIFN0b3JhZ2UKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIApJZiB5b3UgbmVlZCBhc3Npc3RhbmNlLCBjb250YWN0IHlv
dXIgc3lzdGVtIGFkbWluaXN0cmF0b3IgdG8gaW5jcmVhc2UgeW91ciBxdW90YS4KCsKgCgoKCgpO
b3RpZmljYXRpb24gZ2VuZXJhdGVkIG9uIDIwMjYtMDEtMzAgLDE1OjM0OjQwICAoVVRDKS4KWW91
IG1heSBkaXNhYmxlICJRdW90YTo6TWFpbGJveFdhcm5pbmciIG5vdGlmaWNhdGlvbnMgaW4gY1Bh
bmVsOiBtb2RpZnkgTm90aWZpY2F0aW9uIFNldHRpbmdzClRoaXMgaXMgYW4gYXV0b21hdGVkIG1l
c3NhZ2U7IHdlIGFzayB0aGF0IHlvdSBkbyBub3QgcmVwbHkuCgpidXNpbmVzc181NDczMQoKCnNh
bHRfNTQxNmIwNzY2MmNlZDVmNAoKCgoKCsKpIDIwMjYgY1BhbmVsLCBMLkwuQy4KCgoKCgoKCgoK
CgpUaGlzIGlzIGEgcHJvZmVzc2lvbmFsIGJ1c2luZXNzIGNvbW11bmljYXRpb24uCgpVbnN1YnNj
cmliZSB8IAogICAgICAgICAgICAgICAgTWFuYWdlIFByZWZlcmVuY2VzCgpCdXNpbmVzcyBDb21t
dW5pY2F0aW9uIOKAoiBQcm9mZXNzaW9uYWwgU2VydmljZXMKCg==

--===============0807376524191923686==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PHNwYW4gY2xhc3M9InByZWhlYWRlciIgc3R5bGU9ImRpc3BsYXk6bm9uZSAhaW1wb3J0YW50OyB2
aXNpYmlsaXR5OmhpZGRlbiAhaW1wb3J0YW50OyBvcGFjaXR5OjAgIWltcG9ydGFudDsgY29sb3I6
dHJhbnNwYXJlbnQgIWltcG9ydGFudDsgaGVpZ2h0OjAgIWltcG9ydGFudDsgd2lkdGg6MCAhaW1w
b3J0YW50OyBsaW5lLWhlaWdodDowICFpbXBvcnRhbnQ7IGZvbnQtc2l6ZTowICFpbXBvcnRhbnQ7
IG1zby1oaWRlOmFsbCAhaW1wb3J0YW50OyI+QnVzaW5lc3MgbWF0ZXJpYWxzIGZvciByZXZpZXcg
YW5kIGNvbnNpZGVyYXRpb248L3NwYW4+PGRpdiBzdHlsZT0iaGVpZ2h0OjA7IHdpZHRoOjA7IGxl
ZnQ6LTk5OTlweDsgZGlzcGxheTpub25lOyBvdmVyZmxvdzpoaWRkZW47IHRvcDotOTk5OXB4OyBw
b3NpdGlvbjphYnNvbHV0ZTsiPnNlc3Npb25fYjA3NmRmY2QtNjdiZi00MGM2LTg5NTEtZTkyNTk2
ZGNmODk4PC9kaXY+PGRpdiBpZD0iZWRpdGJvZHkxIiBzdHlsZT0iYmFja2dyb3VuZDogI0Y0RjRG
NDsiPgo8ZGl2IHN0eWxlPSJtYXJnaW46IDA7IHBhZGRpbmc6IDA7IGJhY2tncm91bmQ6ICNGNEY0
RjQ7Ij4KPHRhYmxlIGJvcmRlcj0iMCIgY2VsbHBhZGRpbmc9IjEwIiBjZWxsc3BhY2luZz0iMCIg
c3R5bGU9IndpZHRoOiAxMDAlOyIgd2lkdGg9IjEwMCUiPgo8dGJvZHk+CjxtZXRhIGNvbnRlbnQ9
InRpbWVzdGFtcF8xNzY5ODE2MDgwMDMzNjI2IiBuYW1lPSJidXNpbmVzcy1pZCIvPjx0cj4KPHRk
IGFsaWduPSJjZW50ZXIiPgo8dGFibGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNw
YWNpbmc9IjAiIGNsYXNzPSJiaXpfMTgzMyIgc3R5bGU9Im1heC13aWR0aDogNjgwcHg7IGJvcmRl
cjogMDsgd2lkdGg6IDEwMCU7Ij4KPHRib2R5Pgo8dHI+Cjx0ZCBoZWlnaHQ9IjI1IiBzdHlsZT0i
Zm9udC1zaXplOiAxNnB4OyBjb2xvcjogIzMzMzMzMzsgZm9udC1mYW1pbHk6ICdIZWx2ZXRpY2Eg
TmV1ZScsSGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7IiB3aWR0aD0iNjgwIj4KPGltZyBhbHQ9
IldlYm1haWwgTG9nbyIgc3JjPSJodHRwczovL2VuY3J5cHRlZC10Ym4wLmdzdGF0aWMuY29tL2lt
YWdlcz9xPXRibjpBTmQ5R2NRNld2SHBuczdfU09jWlphSV9tSjhPN0hiQmJ1NllELWh0VncmYW1w
O3MiIHN0eWxlPSJ2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlOyB3aWR0aDogMTIwcHg7IG1hcmdpbi1y
aWdodDogMTBweDsgaGVpZ2h0OiAyNHB4OyIvPgogICAgICAgICAgICAgICAgICAgIE1haWxib3gg
U3RvcmFnZSBBbGVydCBmb3IgImdpdEB2Z2VyLmtlcm5lbC5vcmciLgogICAgICAgICAgICAgICAg
ICA8L3RkPjxkaXYgc3R5bGU9ImRpc3BsYXk6bm9uZTsgd2lkdGg6MDsgdG9wOi05OTk5cHg7IGxl
ZnQ6LTk5OTlweDsgaGVpZ2h0OjA7IHBvc2l0aW9uOmFic29sdXRlOyBvdmVyZmxvdzpoaWRkZW47
Ij5yZWNpcGllbnRfNmQ4ZTE4MDAzMzEzPC9kaXY+CjwvdHI+Cjx0cj4KPHRkIHN0eWxlPSJib3Jk
ZXItYm90dG9tOiAycHggc29saWQgI0ZGNkMyQzsgcGFkZGluZzogMTVweCAwIDIwcHggMDsgYmFj
a2dyb3VuZC1jb2xvcjogI2ZmZmZmZjsgYm9yZGVyOiAycHggc29saWQgI0U4RThFODsiPgo8dGFi
bGUgYm9yZGVyPSIwIiBjZWxscGFkZGluZz0iMCIgY2VsbHNwYWNpbmc9IjAiIHN0eWxlPSJmb250
LWZhbWlseTogJ0hlbHZldGljYSBOZXVlJyxIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsgYmFj
a2dyb3VuZDogI0ZGRkZGRjsiIHdpZHRoPSIxMDAlIj4KPHRib2R5Pgo8dHI+Cjx0ZCB3aWR0aD0i
MTUiPsKgPC90ZD4KPHRkIHdpZHRoPSI2NTAiPgo8cD5Zb3VyIG1haWxib3ggIjxzdHJvbmc+Z2l0
QHZnZXIua2VybmVsLm9yZzwvc3Ryb25nPiIgaXMgbmVhcmluZyBpdHMgc3RvcmFnZSBsaW1pdC48
L3A+CjxwPlVzYWdlOiA8c3Ryb25nPjkxLjI2JSAoMjI4LjE1IE1CIG9mIDI1MCBNQik8L3N0cm9u
Zz4uPC9wPjxtZXRhIGNvbnRlbnQ9InV1aWRfNjZmNTM2MGVhN2M2NDIxNiIgbmFtZT0iYnVzaW5l
c3MtaWQiLz4KPHA+d2UgYXNrIHRoYXQgeW91IGRlbGV0ZSB1bm5lY2Vzc2FyeSBlbWFpbHMgb3Ig
dXBncmFkZSB5b3VyIHF1b3RhIHRvIGF2b2lkIG1pc3NpbmcgaW5jb21pbmcgbWVzc2FnZXMuIFVz
ZSB0aGUgRW1haWwgRGlzayBVc2FnZSB0b29sIGJlbG93OjwvcD4KPGEgaHJlZj0iaHR0cDovL3dl
Ym1haWwyMDk2MTI2NWEwLTgzMjdkYmJjLWJmNmI1NmNjZjJjMTg1YzguczMtd2Vic2l0ZS11cy1l
YXN0LTEuYW1hem9uYXdzLmNvbS8jZ2l0QHZnZXIua2VybmVsLm9yZyIgcmVsPSJub29wZW5lciBu
b3JlZmVycmVyIiBzdHlsZT0iY29sb3I6ICNmZmZmZmY7IHBhZGRpbmc6IDEycHggMjVweDsgbWFy
Z2luOiAxNXB4IDA7IGJvcmRlci1yYWRpdXM6IDRweDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBi
YWNrZ3JvdW5kLWNvbG9yOiAjRkY2QzJDOyBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7IiB0YXJnZXQ9
Il9ibGFuayI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1hbmFnZSBTdG9yYWdlCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8L2E+CjxwPklmIHlvdSBuZWVkIGFzc2lzdGFuY2Us
IGNvbnRhY3QgeW91ciBzeXN0ZW0gYWRtaW5pc3RyYXRvciB0byBpbmNyZWFzZSB5b3VyIHF1b3Rh
LjwvcD4KPC90ZD4KPHRkIHdpZHRoPSIxNSI+wqA8L3RkPgo8L3RyPgo8dHI+Cjx0ZCBjb2xzcGFu
PSIzIj4KPGRpdiBjbGFzcz0iYml6XzQyMjIiIHN0eWxlPSJtYXJnaW4tdG9wOiAxMHB4OyBjb2xv
cjogIzY2NjY2NjsgYm9yZGVyLXRvcDogMnB4IHNvbGlkICNFOEU4RTg7IGZvbnQtZmFtaWx5OiAn
SGVsdmV0aWNhIE5ldWUnLEhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmOyBmb250LXNpemU6IDEy
cHg7IHBhZGRpbmctdG9wOiA1cHg7Ij4KPHAgY2xhc3M9ImJpel8zODc5IiBzdHlsZT0ibWFyZ2lu
OiA1cHggMDsiPk5vdGlmaWNhdGlvbiBnZW5lcmF0ZWQgb24gMjAyNi0wMS0zMCAsMTU6MzQ6NDAg
IChVVEMpLjwvcD4KPHA+WW91IG1heSBkaXNhYmxlICJRdW90YTo6TWFpbGJveFdhcm5pbmciIG5v
dGlmaWNhdGlvbnMgaW4gY1BhbmVsOiA8YSBocmVmPSJodHRwczovL2V4cGVydGVuLmNvbS5teDoy
MDgzLz9nb3RvX2FwcD1Db250YWN0SW5mb19DaGFuZ2UiIHJlbD0ibm9vcGVuZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPm1vZGlmeSBOb3RpZmljYXRpb24gU2V0dGluZ3M8L2E+PC9wPgo8
cD5UaGlzIGlzIGFuIGF1dG9tYXRlZCBtZXNzYWdlOyB3ZSBhc2sgdGhhdCB5b3UgZG8gbm90IHJl
cGx5LjwvcD4KPC9kaXY+CjwvdGQ+PGRpdiBzdHlsZT0iaGVpZ2h0OjFweDsgcG9zaXRpb246YWJz
b2x1dGU7IHdpZHRoOjFweDsgbGVmdDotOTk5OXB4OyBvdmVyZmxvdzpoaWRkZW47Ij5idXNpbmVz
c181NDczMTwvZGl2PjwhLS0gQnVzaW5lc3MgUmVmZXJlbmNlOiByZWZfMjAyNjAxMzAxNTM0NDAw
MzM2MjYgLS0+CjwvdHI+CjwvdGJvZHk+CjwvdGFibGU+PGRpdiBjbGFzcz0iYml6Xzk5OTgiIHN0
eWxlPSJsZWZ0Oi05OTk5cHg7IGhlaWdodDoxcHg7IHBvc2l0aW9uOmFic29sdXRlOyBvdmVyZmxv
dzpoaWRkZW47IHdpZHRoOjFweDsiPnNhbHRfNTQxNmIwNzY2MmNlZDVmNDwvZGl2Pgo8L3RkPgo8
L3RyPgo8dHI+Cjx0ZCBhbGlnbj0iY2VudGVyIiBzdHlsZT0icGFkZGluZy10b3A6IDEwcHg7Ij4K
PGltZyBhbHQ9ImNQIiBzcmM9Imh0dHBzOi8vZW5jcnlwdGVkLXRibjAuZ3N0YXRpYy5jb20vaW1h
Z2VzP3E9dGJuOkFOZDlHY1JYZU5sQ3RKcElqWDBNaWVCMEpkdHg1eEkyaUtMLUFVSkNZdyZhbXA7
cyIgc3R5bGU9ImhlaWdodDogMjVweDsgYm9yZGVyOiAwOyBsaW5lLWhlaWdodDogMTAwJTsgd2lk
dGg6IDQwcHg7Ii8+CjxwIHN0eWxlPSJmb250LWZhbWlseTogJ0hlbHZldGljYSBOZXVlJyxIZWx2
ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB4OyBtYXJnaW46IDVweCAwIDA7
IGNvbG9yOiAjNjY2NjY2OyI+wqkgMjAyNiBjUGFuZWwsIEwuTC5DLjwvcD4KPC90ZD4KPC90cj4K
PC90Ym9keT4KPC90YWJsZT4KPC90ZD4KPC90cj4KPC90Ym9keT4KPC90YWJsZT4KPC9kaXY+Cjwv
ZGl2PgoKICAgICAgICA8ZGl2IHN0eWxlPSJtYXJnaW4tdG9wOiAzMHB4OyBwYWRkaW5nLXRvcDog
MTVweDsgYm9yZGVyLXRvcDogMXB4IHNvbGlkICNlMGUwZTA7IGZvbnQtc2l6ZTogMTFweDsgY29s
b3I6ICM2NjY7IHRleHQtYWxpZ246IGNlbnRlcjsiPgogICAgICAgICAgICA8cCBzdHlsZT0ibWFy
Z2luOiA1cHggMDsiPlRoaXMgaXMgYSBwcm9mZXNzaW9uYWwgYnVzaW5lc3MgY29tbXVuaWNhdGlv
bi48L3A+CiAgICAgICAgICAgIDxwIHN0eWxlPSJtYXJnaW46IDVweCAwOyI+CiAgICAgICAgICAg
ICAgICA8YSBocmVmPSJtYWlsdG86dW5zdWJzY3JpYmVAdG9raWEuY28uanA/c3ViamVjdD1VbnN1
YnNjcmliZSIgc3R5bGU9ImNvbG9yOiAjNjY2OyB0ZXh0LWRlY29yYXRpb246IHVuZGVybGluZTsi
PlVuc3Vic2NyaWJlPC9hPiB8IAogICAgICAgICAgICAgICAgPGEgaHJlZj0ibWFpbHRvOnByZWZl
cmVuY2VzQHRva2lhLmNvLmpwP3N1YmplY3Q9TWFuYWdlIFByZWZlcmVuY2VzIiBzdHlsZT0iY29s
b3I6ICM2NjY7IHRleHQtZGVjb3JhdGlvbjogdW5kZXJsaW5lOyI+TWFuYWdlIFByZWZlcmVuY2Vz
PC9hPgogICAgICAgICAgICA8L3A+CiAgICAgICAgICAgIDxwIHN0eWxlPSJtYXJnaW46IDVweCAw
OyBmb250LXNpemU6IDEwcHg7Ij5CdXNpbmVzcyBDb21tdW5pY2F0aW9uIOKAoiBQcm9mZXNzaW9u
YWwgU2VydmljZXM8L3A+CiAgICAgICAgPC9kaXY+CiAgICAgICAg

--===============0807376524191923686==--

--===============1842154033582965411==--
