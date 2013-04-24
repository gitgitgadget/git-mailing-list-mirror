From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 09:30:16 +0200
Message-ID: <87y5c875dj.fsf@samsung.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
 <CAPig+cT18z7Hs70XMF99ACOs5cy2S=FTapjQO=Mb+EMYc=6hJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUu9p-0006p4-GY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624Ab3DXHaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 03:30:21 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65209 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab3DXHaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 03:30:21 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MLR0074P0O6HK70@mailout4.w1.samsung.com> for
 git@vger.kernel.org; Wed, 24 Apr 2013 08:30:18 +0100 (BST)
X-AuditID: cbfec7f4-b7fb86d000007679-e2-51778a0af56f
Received: from eusync3.samsung.com ( [203.254.199.213])
	by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id EE.B2.30329.A0A87715; Wed,
 24 Apr 2013 08:30:18 +0100 (BST)
Received: from localhost ([106.116.147.110])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0MLR008C10UIHS30@eusync3.samsung.com>; Wed,
 24 Apr 2013 08:30:18 +0100 (BST)
In-reply-to: <CAPig+cT18z7Hs70XMF99ACOs5cy2S=FTapjQO=Mb+EMYc=6hJw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsVy+t/xq7pcXeWBBl9OKFh0XelmsjjzppHR
	gclj8QMvj8+b5AKYorhsUlJzMstSi/TtErgyjl3Yx1ownb3i4Zq5bA2Me1i7GDk5JARMJC6e
	a4GyxSQu3FvP1sXIxSEksJRR4uv97+wQThOTxMT27WwgVSIC2hIfNmxiBLGZBZQkfj+Yyw5i
	CwvoSpxZuYMZoqGXUWLZg4tgY9kE7CXm/nvO0sXIwcEioCox6yMziMkpECwxZVc6SAWvgIbE
	5E2zmEBsUQFLicY3V1gg4oISPybfA+tkFlCXmDIlF2KrtsSTdxdYJzAKzEJSNQuhahaSqgWM
	zKsYRVNLkwuKk9JzDfWKE3OLS/PS9ZLzczcxQsLxyw7GxcesDjEKcDAq8fA6zi0LFGJNLCuu
	zD3EKMHBrCTCG8NQHijEm5JYWZValB9fVJqTWnyIkYmDU6qBsXH1FOlDX1y7i69xCuoyeHVJ
	zzn22Ofy0hPLeXN9s8Q1U9adzt2jPTmYweXl3xsurf9yqm5s1znu56M2e+k9Gzcu71cfjwj4
	8ArM3zbhVG7dnj8fDL533GCS7d5Yum9dbIfRhUsuotfm/vU8Y2vBWeFdzHHBVivnovX6ieGB
	HyK9/RSZd/HPVmIpzkg01GIuKk4EACsIkGElAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222230>

It was <2013-04-24 =C5=9Bro 09:19>, when Eric Sunshine wrote:
> On Tue, Apr 23, 2013 at 7:13 AM, =C5=81ukasz Stelmach <l.stelmach@sam=
sung.com> wrote:
>> Enable sending patches to NNTP servers (Usenet, Gmane).
>> ---
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index bd13cc8..0356635 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1174,6 +1249,18 @@ X-Mailer: git-send-email $gitversion
>>
>>         if ($dry_run) {
>>                 # We don't want to send the email.
>> +       } elsif ($email_protocol eq 'nntp') {
>> +               if (!defined $nntp_server) {
>> +                       die "The requires NNTP server is not properl=
y defined."
>
> s/requires/required/

Done. Waiting for more comments.

--=20
=C5=81ukasz Stelmach
Software wizzard
Samsung Poland R&D Center

Al. Armii Ludowej 26, 00-609 Warszawa
http://www.rd.samsung.pl
