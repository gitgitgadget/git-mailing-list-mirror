From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Thu, 16 Sep 2010 22:54:23 +0000
Message-ID: <AANLkTimO7b8dxPKdOsEnoEpY6mAB86pKM3Cbc8GA4_CG@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
	<AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
	<201009170030.05999.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 00:54:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwNLh-0007f9-MM
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 00:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab0IPWyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 18:54:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44114 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576Ab0IPWya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 18:54:30 -0400
Received: by iwn5 with SMTP id 5so1394643iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kv9P5AFvSCPEYofMCuFGVQXKMbHhJThgq/UoxjmDnpU=;
        b=sU4fp9OoeTUI9D0xZ1AoQkaEQgMDl4LDUrgJPNZtkj82qG+YFK6B1lefBMmoaap4mB
         EXWvPPqy7BrM2REafaO2RVOomE+t7/2f6uzqB9+rtBYJ8IEvVryrWB0B/xv9gclbXvvh
         MDbDTwsr6+R9pr68CUoAlUkPRd0TzNprCI3BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kODKk2F3QeaplURAqOMAgv7dR96sAxpCWJ46Kfv9SfYSLg5LcESQoIZbEO6kpWOqSy
         RgFT/2nCm7nHkT2v3mL/KinwxHE8I83buPRC9x2DEcEgYA1JPQIaHyWMhHMZbglMa9xQ
         gbZFVKX2yrzie34UvsO4yAoTLK0JGXEieDh1I=
Received: by 10.231.30.68 with SMTP id t4mr3987623ibc.129.1284677663814; Thu,
 16 Sep 2010 15:54:23 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 15:54:23 -0700 (PDT)
In-Reply-To: <201009170030.05999.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156360>

On Thu, Sep 16, 2010 at 22:30, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 16 Sep 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
>> <giuseppe.bilotta@gmail.com> wrote:
>>
>> > + =C2=A0 =C2=A0 =C2=A0 if (@remotelist) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_print_heade=
r_div('remotes');
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_heads_body(=
\@remotelist, $head, 0, 15,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$#remotelist <=3D 15 ? undef :
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cgi->a({-href =3D> href(action=3D=
>"remotes")}, "..."));
>> > + =C2=A0 =C2=A0 =C2=A0 }
>>
>> Nit: The $# syntax is pseudo-deprecated, and since you use 16 as a
>> constant above this would be clearer anyway:
>>
>> =C2=A0 =C2=A0 @remotelist <=3D 16 ? undef : ...
>
> Actually gitweb uses *15* as a constant above...

I mean above that snippet, i.e. this:

    +       my @remotelist =3D $remote_heads ? git_get_heads_list(16,
'remotes') : ()

I think that's a bit clearer, you're not left wondering why it's 16
there and 15 here, and don't have to recall that `$#remotelist <=3D 15`
equals `@remotelist <=3D 16` (unless $[ !=3D 0). But like I said, it's =
a
nit.
