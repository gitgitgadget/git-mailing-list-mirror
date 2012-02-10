From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 21:10:20 +0100
Message-ID: <CABPQNSaj=-Rr8G0KDvvNJrGOZO2-fREjf=wgc9EiDc-JBRpmTQ@mail.gmail.com>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org> <20120210205242.Horde.Ip6kLu3yGeFPNXWKXsdW3wA@webmail.aegee.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dilyan Palauzov <Dilyan.Palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwoE-0001G3-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760080Ab2BJULB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 15:11:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33365 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760044Ab2BJULA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 15:11:00 -0500
Received: by daed14 with SMTP id d14so2606572dae.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 12:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=R6mcSGG9CYcVubFeYUFoRI97EHVR2rd4qg8p5Y0qNyI=;
        b=vAbUaKlASOd3Tch/1m7Dv+Xacb5eLNQYjqe2TTu2gKtXIMcLNT1KQQ2PGMAggW4Ftr
         +/clxzUBa0N0s1LkaT4pFKHIrZSxxhFv/Hv7Gmh+X1XlnrMn1PWAngWFGcEK8FlAjELd
         g2lcMscVyipekJ3aiVSb2jGul40wvu3ImLe0w=
Received: by 10.68.132.66 with SMTP id os2mr19395789pbb.50.1328904660166; Fri,
 10 Feb 2012 12:11:00 -0800 (PST)
Received: by 10.68.222.165 with HTTP; Fri, 10 Feb 2012 12:10:20 -0800 (PST)
In-Reply-To: <20120210205242.Horde.Ip6kLu3yGeFPNXWKXsdW3wA@webmail.aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190446>

2012/2/10 Dilyan Palauzov <Dilyan.Palauzov@aegee.org>:
> Hello,
>
> on my system locale_charset is included in libiconv as local symbol a=
nd thus
> linking with -liconv is not sufficient.
>
> =A0nm /usr/lib64/libiconv.so.2.5.1 | grep locale
> =A00000000000012694 t locale_charset
>
> whereas in libcharset the symbol is global:
>
> =A0nm /usr/lib64/libcharset.so.1 |grep locale
> =A00000000000000c50 T locale_charset
>

This is from the import library for libiconv we use for Git for Windows=
:

$ nm /mingw/lib/libiconv.dll.a | grep locale_charset
00000000 I __imp__locale_charset
00000000 T _locale_charset

Looks pretty defined to me.
