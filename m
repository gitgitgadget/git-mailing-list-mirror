From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t7003: Use test_commit instead of custom function
Date: Mon, 13 Sep 2010 15:46:13 +0000
Message-ID: <AANLkTikqGLvMHzsa4We7OUcYz5o2v62huO1OhiYLPHeS@mail.gmail.com>
References: <1284156396-81023-1-git-send-email-brian@gernhardtsoftware.com>
	<214E9A5B-E9CE-4B98-88EC-744DBE1F3C32@gernhardtsoftware.com>
	<AANLkTi=1p7tTNfhX7_4vMPFGtRC=F14im3qo009RPJV9@mail.gmail.com>
	<2CFDEC64-9F88-4510-A4FE-DB708CA62224@gernhardtsoftware.com>
	<AANLkTi=v+EXucegQ20oskr_cr5WJoTO+zCXPEB-J+Ucs@mail.gmail.com>
	<alpine.DEB.1.00.1009131741270.2439@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 13 17:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvBEb-0001zm-1N
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab0IMPqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 11:46:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38185 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0IMPqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 11:46:14 -0400
Received: by iwn5 with SMTP id 5so5261593iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X+SABea4+eSEx6QDe5xckU9WhetzhQdOoftbHB0WNug=;
        b=hbY+iThmM67kjNlXdJyWZ5UFTqobsa1aUanl1ili5he4vqY1nf25L0/61pL5zRVyVu
         lAPppi6bQN7cKXoBM0YHEwf43qY7uwd//wdaAKKg+4RY58W+raGR84bvBsyr2M5ljKHH
         ZQtKEe/FlBsrxB6SX6odzPoZDpbveIZwsh/2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zkzoo1JRs2cdlUfirUYn24zFvjK/kzVnlEFDbi2oPmZIqvCKDD2889HJFCTOn7jpUN
         kDDDKjLamtc81LvUGdwLKXDWet1LaU27QtojbPI4KFk0dZfdaZxQSYEQv59/3visLsSf
         ObCTXVJ0Lt2n/JzJ6m3+elW9QZlAxqvFqsK2A=
Received: by 10.231.172.83 with SMTP id k19mr6270360ibz.114.1284392773554;
 Mon, 13 Sep 2010 08:46:13 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 13 Sep 2010 08:46:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1009131741270.2439@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156100>

On Mon, Sep 13, 2010 at 15:44, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 13 Sep 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Sep 13, 2010 at 15:24, Brian Gernhardt
>> <brian@gernhardtsoftware.com> wrote:
>> > On Sep 13, 2010, at 8:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>
>> > In addition, why do we need a custom make_commit when we have
>> > test_commit in test-lib.sh?
>>
>> It was added in v1.5.3-rc0~69^2~10 by Johannes Schindelin (CC'd). It=
's
>> probably just now-needless duplication, but I haven't familirized my=
self
>> with the code.
>
> Yep, I did not make a cleanup patch after adding test_commit. Neither=
 did
> I consolidate other cases in t/ where the steps are done explicitly.

Thanks. I didn't check when test_commit was added, it makes sense now.

There's a lot of old spiderwebs like that in t/* that could now use
cleanup.
