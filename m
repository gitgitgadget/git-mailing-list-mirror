From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH 6/6] Automatically switch to crc32 checksum for index when
 it's too large
Date: Mon, 06 Feb 2012 00:50:27 -0800
Message-ID: <E799595D-61B3-4978-BCE1-BA6A33034B55@apple.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 10:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLDX-0000jD-4e
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 10:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab2BFJu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 04:50:29 -0500
Received: from crispin.apple.com ([17.151.62.50]:59908 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab2BFJu2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 04:50:28 -0500
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0LYY006VDR7OVLI0@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 06 Feb 2012 00:50:28 -0800 (PST)
X-AuditID: 11807136-b7cd6ae000007787-ce-4f2f9454e1e2
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id A1.10.30599.4549F2F4; Mon, 06 Feb 2012 00:50:28 -0800 (PST)
Received: from [10.0.1.254]
 (adsl-70-231-241-90.dsl.snfc21.sbcglobal.net [70.231.241.90])
 by koseret.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0LYY00LTAR834G00@koseret.apple.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 00:50:28 -0800 (PST)
In-reply-to: <1328507319-24687-6-git-send-email-pclouds@gmail.com>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsUiON1OXTdkir6/QUODuEXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDLWHvzMVNDHUrF+yxP2BsZlzF2MnBwSAiYS63b+Y4ewxSQu3FvP
	1sXIxSEk0Mkk0TPlFSuEc5RJ4vWOQ0xdjBwczALqElOm5II08AroSZzbNxesWVggXmL+r+1s
	IDabgIbEp1N3wRZwCjhJNF24wwJiswioSpw73M8IMSZFYvFOKZAws4C2xJN3F1ghRtpIrGv/
	CVYuJFAp0bDtOjtIuYiAr8TuMwUQZ8pKHJqxknECo8AshHtmIblnFpKhCxiZVzEKFqXmJFYa
	muolFhTkpOol5+duYgSFXEOh2Q7GHX/lDjEKcDAq8fBK6ur7C7EmlhVX5h5ilOBgVhLhVZsE
	FOJNSaysSi3Kjy8qzUktPsQozcGiJM671VrZX0ggPbEkNTs1tSC1CCbLxMEp1cAYMD+UL1l1
	QnTV0z/8J59efBqsZrQlmcWp/xnPg5DzuxNiwjq0rswpE8v3b8rkYhe+7dH7M5PnY/by/T8Y
	GTtrT/f29fh0T5rUdHDS7LnfZhhe2f0/qnh/962aWqXYkKfXDgnMW2h4RmarjzFLLfcDpc7w
	B3JbYmRFNSNZj2y/+dM2mOmV5RElluKMREMt5qLiRAAS/QxLNQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190055>

Which crc32 polynomial is being used? crc32c (a.k.a. Castagnoli)? It wo=
uld be great if this were the same polynomial that Intel implements in =
hardware via SSE4.2.


On Feb 5, 2012, at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:

> An experiment with -O3 is done on Intel D510@1.66GHz. At around 250k
> entries, index reading time exceeds 0.5s. Switching to crc32 brings i=
t
> back lower than 0.2s.
>=20
> On 4M files index, reading time with SHA-1 takes ~8.4, crc32 2.8s.
