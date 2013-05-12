From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Sun, 12 May 2013 14:47:51 -0700
Message-ID: <CAJDDKr6hzJjd4E0oTubBNi6RZFriqHUGZp27MoW+WYyMPCObiQ@mail.gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
	<1368260548-52612-2-git-send-email-davvid@gmail.com>
	<1368260548-52612-3-git-send-email-davvid@gmail.com>
	<CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
	<CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
	<7vk3n3vqku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 12 23:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ube7Z-0001V4-5t
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 23:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab3ELVrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 May 2013 17:47:53 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49385 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab3ELVrw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 17:47:52 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so550837wib.0
        for <git@vger.kernel.org>; Sun, 12 May 2013 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=24iXunAvHQojgcdSkLyqt/QypORB0YLVWrZC926H0pE=;
        b=p4RIEaxxEIDs4J1byNtQYG1DSwpCIUol1j8/LsuCgRTWxhD90As2SFy8Y4pD/YfJEc
         PKAISuMsLopQcSZuKaKOgf9f8xcgR+L8p74vQgs8IBkurXElzxJpQjYHMmuklLVKImI7
         D6sb0i6aoQbdL2VI9SRlC54bFpv3AbQW2wjYS052qHPUAhcbhIPNuglgGF06Bs5oAabu
         K/2+AmKZWGcx2QinVFkYBya9wCCXMqQ1PFVCXer6co3qrZvQnrRTssAsFS1pzFL351uB
         wNeXVp2wD4OtOBPa0WA0mLUJfLDWzJ21ObJfqnUdjxdJ9FC7hjy7PIcqgIbeRwOvDVWX
         ZcOg==
X-Received: by 10.194.121.200 with SMTP id lm8mr8387938wjb.55.1368395271519;
 Sun, 12 May 2013 14:47:51 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sun, 12 May 2013 14:47:51 -0700 (PDT)
In-Reply-To: <7vk3n3vqku.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224064>

On Sun, May 12, 2013 at 2:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Aguilar <davvid@gmail.com> writes:
>
>> Yup, warnings still remain, but only in imap-send.c.  All the SHA1
>> ones are gone.  Those were particularly bothersome since they affect=
ed
>> several files.
>>
>> I haven't dug to deeply into how to fix these.  In case anyone has a=
ny
>> pointers, the warnings look like this:
>>
>> imap-send.c: In function =E2=80=98ssl_socket_perror=E2=80=99:
>> imap-send.c:185: warning: =E2=80=98ERR_error_string=E2=80=99 is depr=
ecated (declared
>> at /usr/include/openssl/err.h:279)
>
> Hmph.
>
> I thought your separate imap-send patch switched to CommonCrypto.
> Why are you still including from /usr/include/openssl/?
>
> By the way, is CommonCrypo anything "common"?  I am geting an
> impression that it is an Apple-only thing, and if that is the case
> the naming feels somewhat funny.

=46ar from common -- it's an Apple-ism.

The imap-send patch switches the HMAC parts to CommonCrypto and do
eliminate the HMAC warnings.  It still includes the x509 headers from
SSL.  I haven't figured those out.
--
David
