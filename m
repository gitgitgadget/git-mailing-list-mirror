From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Thu, 16 Sep 2010 13:35:33 +0200
Message-ID: <AANLkTimXqpx4_qn7tPB77-mmvkypbmd9uLWpnaRwRsJQ@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCl0-0005DL-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0IPLf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:35:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32860 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab0IPLfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:35:54 -0400
Received: by iwn5 with SMTP id 5so1001617iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gQAviVOSAqjvTQAcMDS3CKu2AQife2IXwHbHfx9H42Q=;
        b=ZowZA61X7KDFSRyXpm9ljZpfs3hc+92eIYIU3V/m1iZDJv9MADtsoUlOb1mXJs+7HB
         5c86D/TDwpH0VTe+D3ioA1dd7AuozNrwmtM7+hFWcJPbNafIMf4BTESsrq+XEYuKpngS
         0ngZYEoXCSqo7H3nR0DA6xd998SviK7ICTMLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w7r8kJhhRAuuIHNPVcduVVKmwfwrfN95Hnla/jgtA+oZh8nSantQxWTjkXuVuzf5SM
         4n/eaAqb6odcFWyMcqp42Z3k0c99NSHvxpPZwRARsT9qAG33U4JYzEtBw4/Ci4egTyRb
         QkkoJ0FRv8N7U3/d+nH88dZz9KMD4+oQZZ3dA=
Received: by 10.231.190.75 with SMTP id dh11mr3116346ibb.189.1284636953491;
 Thu, 16 Sep 2010 04:35:53 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Thu, 16 Sep 2010 04:35:33 -0700 (PDT)
In-Reply-To: <AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156321>

On Thu, Sep 16, 2010 at 12:19 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>
>> + =A0 =A0 =A0 if (@remotelist) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_print_header_div('remotes');
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remotelist, $head, 0,=
 15,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$#remot=
elist <=3D 15 ? undef :
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$cgi->a=
({-href =3D> href(action=3D>"remotes")}, "..."));
>> + =A0 =A0 =A0 }
>
> Nit: The $# syntax is pseudo-deprecated, and since you use 16 as a
> constant above this would be clearer anyway:
>
> =A0 =A0@remotelist <=3D 16 ? undef : ...

I think following the gitweb coding style is better. OTOH, I can
probably prepare a (separate) patch to replace $# with @ where
possible.

--=20
Giuseppe "Oblomov" Bilotta
