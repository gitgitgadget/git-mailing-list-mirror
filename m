From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Thu, 8 Jul 2010 20:09:17 +0000
Message-ID: <AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 22:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWxPT-0002ZT-IQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 22:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0GHUJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 16:09:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42876 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0GHUJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 16:09:20 -0400
Received: by iwn7 with SMTP id 7so1243730iwn.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+0luAlwBmlYgZ+mzv9X46LSmF4OAR9auJSRj1W0DqOc=;
        b=pjY4LQ9wNaTcLKABQVrjvByJGsGA+fBjVHFxqHgwxElou8xbzSHynnf4bRKQ0E9Ffc
         1rNCC8ZheTiGQzSgMI8PhV2Km13xQDKG7rpDO6PXDRH4xRL8+gLFzLthgisSEfuKH8py
         cGq64c3/Sq7sLCKgg8x86LU6R9ZJP88AThYKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MPK7W6hSorPZs+enH+GbaZBHm1WuOoRPA/QW/R6TNLzpCuQYWwas+RtHGmifuiVqc0
         7RcfI9po3klu4bvVcak+lDufkIuaP741R5eAP4xGEAAnXAj9im5Lk0wJF4Ad2odEg1W2
         IprM3dQ+x0G45ce2zwlmqFi71Di5k3EcFE7Q4=
Received: by 10.231.161.73 with SMTP id q9mr8874078ibx.70.1278619757972; Thu, 
	08 Jul 2010 13:09:17 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 8 Jul 2010 13:09:17 -0700 (PDT)
In-Reply-To: <7viq4ppxt9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150609>

On Thu, Jul 8, 2010 at 19:40, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> +if git grep ile a
>> +then
>> + =C2=A0 =C2=A0 test_expect_success 'git grep ile a' 'git grep ile a=
'
>> +else
>> + =C2=A0 =C2=A0 test_expect_failure 'git grep ile a' 'git grep ile a=
'
>> +fi
>
> So if command "X" is known to succeed, we run it inside expect_succes=
s
> and if not we run it inside expect_failure?
>
> What kind of idiocy is that, I have to wonder...

Well, the point is to normalize the test suite so that we never have
passing TODO tests if everything's OK.
