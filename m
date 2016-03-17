From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 17:45:05 +0800
Message-ID: <CAKqreux4Z4a6qXGewEWLxDZFE+PCXFx3d4d_jrrLvQqX9HKy-Q@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
	<xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Your friend <pickfire@riseup.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 10:45:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agUUS-00071Y-GQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 10:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935175AbcCQJpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 05:45:09 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35846 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396AbcCQJpG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 05:45:06 -0400
Received: by mail-ob0-f180.google.com with SMTP id m7so77746623obh.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=KrHp+ZNZZsJzCVnxNgCz7NdcWAY9sDeLezSz7a1Ctcw=;
        b=Ad8KKKPBp3RmfURqaUEc7lzz2SKu9qnZ8hiEhZkbRKi5dfGqw0QsFp0sDYLQ3Kf8Vt
         QrnGGNQcyMF5aMRnYNJRgWajeihBh3T/SMCmIGZOUPvUoV4GQk2Vu5C48hW8xMKGGCt5
         YueS9QbnUKssrpXXZHoqJMCqRmxH7/quQzAKBAJ1fJ/mjubwfH4XzQPYxQFeN9EQmVfg
         3KOje7s315YkmFzGTG/mqUT9tAN0iiIZxUPkJ/3zH7LzmNsqwY/2dSnEVQEXcZuLotf+
         shMJ7K8UxOptR0F4zV3co4gi8eagGfS5hr5yq0Eqd+g0uH8vA1XmQfsoQBLiHi5Ips9r
         5m8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=KrHp+ZNZZsJzCVnxNgCz7NdcWAY9sDeLezSz7a1Ctcw=;
        b=UAZSXBMoCrQEQUvMHEue8rjpFMK2qKTTGNgwwLJYcZMXRdGV2cwSXyOfsjzlnG/ZeI
         IPpawQkE+elvF0RhKICNgngf7zl9OeP6gALpwhyTKIj2QpUPk4CzhZBLP7Qry50NuCJv
         B/kLNC0n3yt7iolOeK2b3P6oaJyrDiBunuQRR28Hx+SRGqFuO7T8RGeUbUgM4C42Fze5
         t+zjei9N4qyq56arRLPdz6/ZWYso+XXrb/14my49lIX/cIfn24ooU5H6zCFUi2Us3Kzz
         L6C9S5gYptchevatFZ37yxJwwThMsQCgxzNqlH06UhoMTGeBQlegKwdVJ1olc8nU5KSa
         S8Iw==
X-Gm-Message-State: AD7BkJKPGW8n+F+/W7bU15YgrbkuOC9yQOddsz5saoe8BlUDsSk/DJZNkg9eWoOGXo0EQrATRJPr3HJJBF5ikg==
X-Received: by 10.60.141.227 with SMTP id rr3mr5249105oeb.57.1458207905788;
 Thu, 17 Mar 2016 02:45:05 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 02:45:05 -0700 (PDT)
In-Reply-To: <xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289092>

2016-03-17 1:24 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>
>>> Is it because the wish is to always use /tmp/git-$uid/ as a fallbac=
k
>>> for $XDG_RUNTIME_DIR (as opposed to ~/.git-credential-cache/, which
>>> is specific to the credential-cache and would look strange if we
>>> used it for other "runtime" things)?
>>
>> Yes, I mean to use it as a general fallback for git.
>
> If that is the case the code probably needs to be a bit more careful
> before deciding to use /tmp/git-$uid/ directory (is it really $uid's?
> can anybody else write to it to race with the real user? etc.)
>
>> On the other hand, I think, falling back to $HOME/.git-credential-ca=
che/socket
>> doesn't make any sense for back-compability cannot be ensured.
>
> What do you mean by that?
>
> Using ~/.git-credential-cache/credential-cache.sock would not help
> at all for existing users, but ~/.git-credential-cache/socket would
> interoperate well with users with existing versions of Git, no?
>

I meant that FALLBACK instead of DEFAULT is useless for back-compatibil=
ity.

Most users with existing versions of Git will be broken even if there i=
s a
fallback.
