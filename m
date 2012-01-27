From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Test t9500 fails if Time::HiRes is missing
Date: Fri, 27 Jan 2012 10:32:29 +0100
Message-ID: <CACBZZX5Y5u=8U4s2aohr6wERuybCMRTamQK7v=JRUOr+ZpJjxQ@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 <7v8vkt1yry.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqiB2-0000YU-8O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab2A0Jcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 04:32:54 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37366 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323Ab2A0Jcv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 04:32:51 -0500
Received: by lagu2 with SMTP id u2so838320lag.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=s3E6O3mHIZ74cgFAHHUaCtMMzvRd4c24kn/c1sgWpLE=;
        b=bNDu5sPI/BtjniCGW+8AzaMKgG8XPmvcjrmUTcqZJ1f6JOfOX08e/wnnSWMs5vZTfo
         H/wS3qFoVNZDqDu27MdJYt9JlnbXIKhEJ8AkZ7i6blC9qgy518eOjJGoTeaDxRJQMQg4
         QOdrHbPmLpSsgngP/SFE4pdzdQex8F8gxHP2U=
Received: by 10.152.148.228 with SMTP id tv4mr3185310lab.9.1327656769169; Fri,
 27 Jan 2012 01:32:49 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Fri, 27 Jan 2012 01:32:29 -0800 (PST)
In-Reply-To: <7v8vkt1yry.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189208>

On Fri, Jan 27, 2012 at 06:48, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This doesn't actually fix the issue, it only sweeps it under the rug
>> by making the tests pass, gitweb will still fail to compile on Red
>> Hat once installed.
>
> In the short term for 1.7.9, let's at least warn users about this iss=
ue.
>
> -- >8 --
> Subject: INSTALL: warn about recent Fedora breakage
>
> Recent releases of Redhat/Fedora are reported to ship Perl binary pac=
kage
> with some core modules stripped away (see http://lwn.net/Articles/477=
234/)
> against the upstream Perl5 people's wishes. The Time::HiRes module us=
ed by
> gitweb one of them.

Since I wrote that E-Mail I learned what RedHat was doing, I think
that's a far better option. They're splitting up the perl core into
multiple packages, and anyone who has issues with this on RedHat can
trivially just install those packages. So we should just note it in
the INSTALL file as a platform-specific issue and leave it at that.

We *could* deal with this in our code, but I don't think dealing with
every vendor's slightly different perl version is a viable strategy in
the long run.
