From: Daniel Steinborn <daniel.steinborn@lrz.de>
Subject: Re: Poor git write performance to NFS
Date: Thu, 22 Oct 2015 15:04:16 +0200
Message-ID: <5628DED0.3050002@lrz.de>
References: <56278FD3.3010103@lrz.de>
 <xmqqlhaw5bj2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 15:04:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFXd-0002X8-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 15:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757166AbbJVNEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2015 09:04:21 -0400
Received: from postout1.mail.lrz.de ([129.187.255.137]:44397 "EHLO
	postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbbJVNET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 09:04:19 -0400
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 3nhTRQ0sVqzyV6;
	Thu, 22 Oct 2015 15:04:17 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=lrz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lrz.de; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:mime-version:user-agent:date:date:message-id:from:from
	:references:subject:subject:received:received; s=postout; t=
	1445519057; bh=JShiqflV0OIuB2cfflV3M+3gbQF4QRorfRpNTGBsUDA=; b=n
	G9V6eueRQ7zrJPnedGH2pH21lfPtCx1drPCEv0RKxlpaBbWJcjcAql5QDvu9ndXB
	/aJ39SbldjynjSoWI2izmUrPOX4i/7njOjXNvjD64ExDEytUxo485JkU/QEmI/3h
	AQFpMAlrjtriHYrgDun3yUM4P/kevxUm8RyFmO83sznC8LqxgofKiDzcpSeDcyWE
	eJ8KgWBAxUjpvJr86U3dZZeYIoT/RwanRXp/wce6b1hWeucIFAA5Oyi46OtPVwKg
	2pDZHHhnV3uXRMmo+1NuuauSXXJhx6+9sGUbogdnporn0hV+wkkqVDM+3dtvCb1O
	YYnsEp3S5mqo5LT7L3IQg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.892
X-Spam-Level: 
X-Spam-Status: No, score=-2.892 tagged_above=-999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, LRZ_FROM_PHRASE=0.001,
	LRZ_FROM_PRE_SUR=0.001, LRZ_FROM_PRE_SUR_PHRASE=0.001,
	LRZ_MSGID_AN_AN=0.001, LRZ_MSGID_HU8_HU7=0.001, LRZ_MSGID_MOZ=0.001,
	LRZ_MSGID_SPAM_68=0.001, LRZ_UA_MOZ=0.001] autolearn=no
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id RvBgGoZECEiN; Thu, 22 Oct 2015 15:04:17 +0200 (CEST)
Received: from badwlrz-cldst01.ws.lrz.de (unknown [IPv6:2001:4ca0:0:f000:fab1:56ff:febb:c1bd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 3nhTRN4sbYzyTn;
	Thu, 22 Oct 2015 15:04:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqlhaw5bj2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280052>

Hi,

thank you for your answer.
I removed the git Debian package and compiled v2.6.2 manually. The=20
performance is much better now (on the same level als v1.7.12.4).
We opened a Debian bug report, to request a git version >=3D 2.6 to be=20
backported to jessie:=20
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D802661

The issue is now solved for us, thanks again for your quick response.

Best regards,
Daniel Steinborn

Am 21.10.2015 um 20:20 schrieb Junio C Hamano:
> Daniel Steinborn <daniel.steinborn@lrz.de> writes:
>
>> currently we are experiencing poor write performance when a reposito=
ry
>> is pushed to a nfs volume. Interestingly, this seems to be a problem
>> in newer git versions:
>>
>> v1.7.12.4: Very good performance
>>
>> v2.1.4: Bad performance, up to 6 times slower
>>
>> Are there any changed default settings or new features that can be t=
he
>> reason for that problem?
>>
>> Please ask for specific details if they are neccessary.
> Between 1.7.12.x series and v2.1.4, there are more than two years'
> worth of changes, so it is unreasonable for anybody to expect that
> such a question can be answered in a meaningful way.
>
> Have you tried more recent versions yet?  2.1.x series is over a
> year old, and I am reasonably sure there have been tons of "earlier
> we did X for correctness, which unfortunately made things slower,
> and this ensures the same correctness in a different way that is
> much more performant" fixes since then.

--=20
Daniel Steinborn
Leibniz-Rechenzentrum
Boltzmannstra=DFe 1
85748 Garching bei M=FCnchen
