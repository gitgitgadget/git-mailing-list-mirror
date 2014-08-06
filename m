From: Peyton Randolph <prandolph@apple.com>
Subject: Bug v1.9.3: Spurious whitespace warnings when using git apply with the
 --exclude option
Date: Wed, 06 Aug 2014 10:13:34 -0700
Message-ID: <332C033B-7809-45A9-9F91-CC3A92090B86@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 19:28:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF518-0003MI-7X
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775AbaHFR2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 13:28:39 -0400
Received: from mail-out6.apple.com ([17.151.62.28]:52340 "EHLO
	mail-in6.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757733AbaHFR2g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 13:28:36 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Aug 2014 13:28:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
	q=dns/txt; i=@apple.com; t=1407345215; x=2271258815;
	h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
	Content-transfer-encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dK+12Kv66GDGGuBQY0SHrVsv2o8P7DlcAtZ9GyEFN0k=;
	b=zE27sTe2nycCjMeEY7DViJW8/sHEZPWOeIBh0jxdLrhu3Hnj2RCnz0hKETMAoeS3
	i/LEXtgtJCSqgy3m8UVnYQHF9Jc9q7GIznjz6k6PiOf54b7s0k85e0IjwKpFBAc1
	F8Rep87VlALm9KwrHnnA9XN2vTW4Xj1XfFxxwGxgYQQrfA0gk0WN7WioTC429mMp
	tfm2iNhFrcd3l7SuLV76Yt9RqavhoB7n0iHUgHtFPchrCslrv90l5U17PBb9AAvf
	12p594C1zocuwPDd5LPS3o7E1b/dk1uh+s8UAgN+Qlk+hE8BoRqNFgHiFYfyOPQp
	V+QRg9kGNzITivuBE3Mn0g==;
Received: from mail-out.apple.com (bramley.apple.com [17.151.62.49])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail-in6.apple.com (Apple Secure Mail Relay) with SMTP id A4.4C.32596.F3262E35; Wed,  6 Aug 2014 10:13:35 -0700 (PDT)
Received: from relay4.apple.com ([17.128.113.87]) by local.mail-out.apple.com
 (Oracle Communications Messaging Server 7.0.5.30.0 64bit (built Oct 22 2013))
 with ESMTP id <0N9W00AXMADX6L03@local.mail-out.apple.com> for
 git@vger.kernel.org; Wed, 06 Aug 2014 10:13:35 -0700 (PDT)
X-AuditID: 11973e15-f79d66d000007f54-b1-53e2623f13a9
Received: from sesame.apple.com (sesame.apple.com [17.128.115.128])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)	by relay4.apple.com (Apple SCV relay)
 with SMTP id FD.D8.03493.34262E35; Wed,  6 Aug 2014 10:13:39 -0700 (PDT)
Received: from [17.202.50.58] by sesame.apple.com
 (Oracle Communications Messaging Server 7.0.5.30.0 64bit (built Oct 22 2013))
 with ESMTPSA id <0N9W00KG3AIMHH40@sesame.apple.com> for git@vger.kernel.org;
 Wed, 06 Aug 2014 10:13:35 -0700 (PDT)
X-Mailer: Apple Mail (2.1972.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsUiON3OUNc+6VGwwakuaYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGU03VjLXDCLteLdt4OMDYyTWboYOTgkBEwklm3V7GLkBDLFJC7c
	W8/WxcjFISQwk0li84SZbCAJXgFBiR+T74HVMwuoS0yZkgtRM4tJ4urkQ6wQzSYSqxZsZ4JI
	9AEl1qxkhXB+MEocn/+MEaSKTUBb4uWCg2AdzED2k3cXWEGmCgskSWzYZAmxzEbi6sFLzCA2
	i4CqRO/OvewgtoiAuMTb4zPZIZbJS5w68A/sUgmB86wS7a0T2SYwCs5CcuwshGNnIdm2gJF5
	FaNQbmJmjm5mnpleYkFBTqpecn7uJkZISIruYDyzyuoQowAHoxIPb4bpw2Ah1sSy4srcQ4zS
	HCxK4rxHzB8FCwmkJ5akZqemFqQWxReV5qQWH2Jk4uCUamCMuRX060qMo1LE5LfcNVdj/9eJ
	/28Qy9VWEW3UXmt5sOqCS95UBqfj/WcvTa3JjLwpOnv6DO7QF/K24Y0TDN48nVEzyyP1Y4Pm
	vQmHq6+vnPm9T1/8QqLykZOfkuak+vMLbOQ68nGG0r+Ce3qXT5+6sWWlxPka/Y32z1M19zFZ
	mOzyfnJtygJZJZbijERDLeai4kQAFZp+CSoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsUi2FDcoOuc9CjY4MJaDYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGU03VjLXDCLteLdt4OMDYyTWboYOTkkBEwkVi3YzgRhi0lcuLee
	rYuRi0NIoI9J4u7bL1DOD0aJ4/OfMYJUsQloS7xccJC1i5GDg1lAXWLKlFyQMDNQ+Mm7C2Bh
	YYEkiQ2bLEHCvAI2ElcPXmIGsVkEVCV6d+5lB7FFBMQl3h6fyQ5RYyBx9e9iZogb5CVOHfjH
	NoGRdxbCgllIFsxC0rGAkXkVo0BRak5ipYleYkFBTqpecn7uJkZwqBSG72D8t8zqEKMAB6MS
	D+8B84fBQqyJZcWVuYcYJTiYlUR4xW0eBQvxpiRWVqUW5ccXleakFh9ilOZgURLnvZh7O1hI
	ID2xJDU7NbUgtQgmy8TBKdXAWJL9x+jNnL5vH2Ym7fmTuO0eV5Tepr/7prRMPfavOejmskwN
	gcVNAtzO+/OWuJ9+WLAmeE3vzrZ1uXKZy1Qc3viv4r857bX1T1ZVFuUOXze2r3fZXhZUbvg9
	V3qX6v7ZRsIzFNr+TUgsuf/dWI6dcTlX2THGnLnP09SYH/6a9Phs/elTl5S2eiixFGckGmox
	FxUnAgDPvO2uEQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254880>

Bug v1.9.3: Spurious whitespace warnings when using git apply with the =
--exclude option

REPRO STEPS:
1. Create a patch PATCH that modifies two files, A and B. Make sure the=
 modifications to file A add whitespace errors and the modifications to=
 file B do not.
2. Apply that patch to a repo using git apply PATCH --exclude A

ACTUAL RESULT:
git apply outputs a "warning: n lines add whitespace errors.=E2=80=9D w=
here n is the number of lines with whitespace errors in A.=20

EXPECTED RESULT:
No warning about adding whitespace errors because no whitespace errors =
are added to the tree since A is excluded and B has no whitespace error=
s.