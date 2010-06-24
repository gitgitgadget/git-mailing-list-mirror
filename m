From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/9] Add stream helper library
Date: Thu, 24 Jun 2010 16:29:04 -0500
Message-ID: <20100624212904.GB2458@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624110112.GF12376@burratino>
 <AANLkTinQT6YvwkYrehAl5kGW9Ebkq1AantCap5nD8ByR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 23:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtz6-0006TT-7X
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 23:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0FXV3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 17:29:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44353 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab0FXV3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 17:29:14 -0400
Received: by iwn41 with SMTP id 41so1246967iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WsynjJ/pNyS6T2+Hr/XchzK+54CRDUwrERiy6fxRmck=;
        b=MXVGfFOkrvl3uPP8ZC7SaXP0qHAN2IddQzoAPPyRgnraa9OR616aTUDCqCCYtpbuVp
         hBRfFY55ZMK6m16j7a9SUlGn60A/L5nzHUJbbvH9tAY3AKUWP2KRUyREAM81oD1Y1feO
         OCrneIjGQwhy//BsYw1zDekXg2LE7ZhEX94RI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ke1FfeY9Dl19cBydY9eLq5YMrrHuxO/YRVCRA3KtTgtY4d++dTU/6QmWvy8sbyjvwX
         TrXmDib2NtonuA+rb26Ifkx7qUYrFR+MyZXUZydZVvnkBRanzikgmhxL/uGTyHLJIYrn
         Df/gMmwlcn300r0X4HPhaGWhMlJnwxDo2CjDA=
Received: by 10.231.123.194 with SMTP id q2mr11388351ibr.166.1277414954407;
        Thu, 24 Jun 2010 14:29:14 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm19455338ibg.21.2010.06.24.14.29.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 14:29:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinQT6YvwkYrehAl5kGW9Ebkq1AantCap5nD8ByR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149653>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> This library provides thread-unsafe fgets()- and fread()-like
>> functions where the caller does not have to supply a buffer. =A0It
>> maintains a couple of static buffers and provides an API to use
>> them.
>
> Few (no?) changes since last time.

I simplified it a bit by getting rid of pushback.

 static uint32_t line_buffer_len =3D 0;
 static uint32_t line_len =3D 0;

Sorry, I should have mentioned so.

Jonathan
