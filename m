From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Wed, 17 Apr 2013 21:50:04 +0200
Message-ID: <516EFCEC.1090803@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <7v1uabsin7.fsf@alter.siamese.dyndns.org> <7vwqs3r3m4.fsf@alter.siamese.dyndns.org> <516C5DBF.1010102@gmail.com> <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 21:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USYMs-0002An-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 21:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758836Ab3DQTuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 15:50:06 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:40724 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146Ab3DQTuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 15:50:04 -0400
Received: by mail-ee0-f49.google.com with SMTP id l10so920154eei.8
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eL4O3GQ5wYeurMGBCtm6r9lZpj2lE9whaaKAHnItXY4=;
        b=WEX8+li7h7yndkHThaonnwaswV80MrwHac+M6njpiKGym4le5ALH0CESE/k7G6vLjh
         GSl++nbYm0+jMfZGMeJofpRDxFHSUBnsymqeBlg2nXpXp055+CybZxEAiouVPejcR8CB
         +nOF5vJvqLJKPSNUyxPir7iVugtbsFefqPpgAuwYwQ+Bg4N3TO7n1qeWxHVxCPq35wfw
         NRhZooe8hNZoGf62oHS+h5H6WWA5fj6VRPf0xGd5CT2I7O6BCBFVLfDXzBJokkrpj8Ct
         Q5p/RwFBk3/kYYhOjRYGliz/5rZ5AUtgGb/dL3Pr0Yc/k9aEeexP7DlESXW1hFw2fTEJ
         K0IQ==
X-Received: by 10.15.35.200 with SMTP id g48mr7576674eev.33.1366228203684;
        Wed, 17 Apr 2013 12:50:03 -0700 (PDT)
Received: from [10.1.100.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id b5sm11075383eew.16.2013.04.17.12.50.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 12:50:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221566>

Am 15.04.2013 22:25, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 15.04.2013 21:33, schrieb Junio C Hamano:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Karsten Blees <karsten.blees@gmail.com> writes:
>>>>
>>>>> This patch series addresses several bugs and performance issues in
>>>>> .gitignore processing.
>>>>
>>>> A 8-patch series ending at 5d765dc7888b (dir.c: git-status: avoid
>>>> is_excluded checks for tracked files, 2013-03-18) has been cooking
>>>> in 'next'; in general we won't revert and requeue a new round for a
>>>> topic that has already merged to 'next'.
>>>>
>>
>> I'm sorry to have caused such trouble. I thought you were expecting a reroll from this:
> 
> Heh, that was an ancient history.

My git time is scarce, so progress is slow...guess I need some performance improvements, too :-)

> 
> It is not such a big deal to revert stuff from 'next'.  I've tried
> to queue this reroll, but tentatively ejected the result from 'pu'
> for today's integration run, as as/check-ignore topic has an
> unpleasant conflict with this.
> 

I'll send fixups for #11 and #14, or you can pick the entire series rebased to pu from:
https://github.com/kblees/git/tree/kb/improve-git-status-ignored-v2-pu
git pull git://github.com/kblees/git.git kb/improve-git-status-ignored-v2-pu

HTH, Karsten
