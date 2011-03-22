From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 10:18:30 +0100
Message-ID: <AANLkTimg74nh5C74tTXNQeK1nZnQVhGfH=gh8t1Nwr4j@mail.gmail.com>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
 <20110322085027.GF14520@neumann> <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xjs-0000Ef-VR
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab1CVJSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 05:18:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35671 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab1CVJSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 05:18:51 -0400
Received: by fxm17 with SMTP id 17so6226369fxm.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZgTk4ppjP13578/7HLYziOdaqUfztrTzjBdC0JEG1Fw=;
        b=Q484ifF6+2kSFt0fFkJfwXXMbTfBvbvkVIRTt+KXx/Ct1AqlANMT8891BJlYA5kxS4
         5IymVKHU9u2uT/p1Jwc9njpsLbIfIDpUnXhWnHa3KuSyQinMEuvZ1jXxuQRzjMHg22VB
         HFrMIkM4XWBJAFEuPqK/Nqyq3lz2xq06w3Uo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=snlnsBoHSggQ1fEhcx8JeICm/Kwvpi+FOnGqxnUBmLdFl4BMhfZ3AUaWM1NMq0SS2G
         yfagCUS9SlsdwM53HyUc8UaNjPjJM/tPEJwLdl6qqFqEnnjhPRXu19eSiipHvCzizXWU
         3ERiqka5az8QCvdCqvEsIe3J4j8rYB/QPiESs=
Received: by 10.223.78.138 with SMTP id l10mr3308882fak.106.1300785530092;
 Tue, 22 Mar 2011 02:18:50 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Tue, 22 Mar 2011 02:18:30 -0700 (PDT)
In-Reply-To: <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169714>

2011/3/22 Erik Faye-Lund <kusmabite@gmail.com>:
> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>> On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
>>> This is a constructive tangent but if we are going to run $(__git_a=
liases)
>>> every time we run _git_help, perhaps it would want a hack similar t=
o the
>>> way the value for $__git_all_commands is generated just once?
>>
>> I think this is not necessary. =A0We already run __git_aliases() eve=
ry
>> time after 'git <TAB>', and it was not an issue so far. =A0And indee=
d, I
>> just created 50 aliases, and the time required for __git_aliases()
>> seems to be negligible:
>>
>> =A0$ time __git_aliases
>> =A0<bunch of aliases>
>>
>> =A0real =A0 =A00m0.028s
>> =A0user =A0 =A00m0.016s
>> =A0sys =A0 =A0 0m0.004s
>>
>
> Unfortunately, the situation is not quite so good on Windows:
> $ time __git_aliases
> <bunch of aliases>
>
> real =A0 =A00m0.112s
> user =A0 =A00m0.030s
> sys =A0 =A0 0m0.015s
>
> This is with 50 aliases, with 0 aliases I get this:
> $ time __git_aliases
> test
>
> real =A0 =A00m0.063s
> user =A0 =A00m0.015s
> sys =A0 =A0 0m0.015s
>

OK, apparently I have a dummy alias around from some time earlier, so
this was for 51 and 1 alias. But the point remains, it's actually a
bit of a problem on Windows.
