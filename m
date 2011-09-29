From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 29 Sep 2011 22:20:29 +0200
Message-ID: <CABPQNSZaEdBMRq9wMbGV1E=EzZgpcKhT=_JW-3hSzF4GqviHHQ@mail.gmail.com>
References: <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx>
 <4E3EEF3B.80908@kdbg.org> <4E401869.8060702@lsrfire.ath.cx>
 <20110809050211.GA3588@sigill.intra.peff.net> <4E410B26.1080407@lsrfire.ath.cx>
 <20110809200504.GA31944@sigill.intra.peff.net> <CABPQNSba+nQ+AOmVEVNWhJi2e65EiuhRxfOWZsW03Pkc6zXdHg@mail.gmail.com>
 <4E84D29F.6020305@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, msysGit <msysgit@googlegroups.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 29 22:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9N6a-0001ns-2F
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab1I2UVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 16:21:11 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:43660 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab1I2UVJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 16:21:09 -0400
Received: by pzk1 with SMTP id 1so2560713pzk.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1Ikz7OHN+q49du4D1mYAk+AIXqvgYR3r4RShz7fNPGQ=;
        b=MMyqwO8bTYEM8pUHEuT8XP06TkNxdlnoRasDTw7g9Ll5+SH+dciPsIgMhI+78WHep5
         MY7B9IkHv3CEVefFUiGpUpF3Cb3ysU4qwQnXGUNJgUum1yT1HjR4fp5DU+fEiWaShLfS
         2i8ffUrcTTxb9mvsmTCTAaJweCS/mOYd2mAtA=
Received: by 10.68.36.99 with SMTP id p3mr52892051pbj.61.1317327669062; Thu,
 29 Sep 2011 13:21:09 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 29 Sep 2011 13:20:29 -0700 (PDT)
In-Reply-To: <4E84D29F.6020305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182431>

On Thu, Sep 29, 2011 at 10:18 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 29.09.2011 21:54, schrieb Erik Faye-Lund:
>> So the way forward is probably to just change to a self-compiled gzi=
p
>> in msysGit (and Git for Windows by proxy).
>>
>> I'll post the patch to build a native-gzip to the msysGit mailing li=
st
>> (I only got 1.2.4 to compile on Windows, but it's the same version a=
s
>> we have in msysGit so it's probably fine), and post the latest versi=
on
>> of this series soon...
>
> Good to hear that.
>
> By the way, are you aware of http://unxutils.sourceforge.net/ (includ=
es
> a native gzip 1.2.4 binary)?

Yes, but we prefer to build our binaries ourselves in the msysGit proje=
ct.

> Or http://zlib.net/pigz/ (parallel gzip, no binaries)?

I'm aware of pigz, but changing the gzip implementation isn't really
the scope of this change IMO.
