From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Thu, 29 Jul 2010 22:26:25 +0000
Message-ID: <AANLkTikg5uD27sYE-AYCYhTXXaC4LReWPxiTsxrVUqo+@mail.gmail.com>
References: <1280438455-16255-1-git-send-email-avarab@gmail.com>
	<201007300011.50330.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebYd-0004o0-TN
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0G2W01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 18:26:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36161 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab0G2W00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 18:26:26 -0400
Received: by iwn7 with SMTP id 7so662677iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n41kPoiSoYQSQFVeCSlKxEx6pAmz2EiiELTiH+zRVYA=;
        b=NdwYiCgt/h4AiC3RilJpWnTjYPjEylffcm+yvJ/+ygCj4ecv383wmCmFxxu1o6zg6G
         ajn3/V0Vwpq6Biqsyl98RCWMPS5/qkAVbpDvW8JZytMa+m1BSoKGA5ObmNxcFPdzGfuL
         FFpfU2XX+Oi58zW65kjxi3ENSAIMDER/rjxj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v9pliZRNluknGuCS03GcpIy+Keu4Bg+b6XpRagmyNzh1Lp8FR97BxyPWY9e3yO6qcR
         oIIolyH9PKf1CExNeiBlt+gBk7s21kLdTOun7Od6upCQ2PoDUCieZH/+87bjg6A9mZbL
         WLYHNgfXHtnJUmUeodYsy0eXvImp5NW/4VHhg=
Received: by 10.231.173.9 with SMTP id n9mr594333ibz.146.1280442385969; Thu, 
	29 Jul 2010 15:26:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 29 Jul 2010 15:26:25 -0700 (PDT)
In-Reply-To: <201007300011.50330.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152207>

On Thu, Jul 29, 2010 at 22:11, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C2=A0 - Is this worthwhile. Are there developers / packagers / othe=
r
>> =C2=A0 =C2=A0 interested parties here who'd be interested in actuall=
y running
>> =C2=A0 =C2=A0 smoke testers? It should be really easy to set one up.
>
> I'm all for it!
>
> I think I could put a cronjob on a RHEL5.4 machine, and regularly run
> it on my own openSuSE 11.3 install.

That's at least three smokers there. And since your RHEL5.4 machine
already turned up a gettext bug..

>> Tarball contents:
>>
>> =C2=A0 =C2=A0 $ tar xzvf git-smoke.tar.gz
>> =C2=A0 =C2=A0 t0004-unwritable.sh
>> =C2=A0 =C2=A0 t0001-init.sh
>> =C2=A0 =C2=A0 t0002-gitfile.sh
>> =C2=A0 =C2=A0 t0005-signals.sh
>> =C2=A0 =C2=A0 t0000-basic.sh
>> =C2=A0 =C2=A0 t0003-attributes.sh
>> =C2=A0 =C2=A0 t0006-date.sh
>> =C2=A0 =C2=A0 meta.yml
>
> That's the only thing I found confusing about this: why are they name=
d
> as if they were shellscripts?

The output file names just match the test names, which in this case
are shellscripts.

> Also, installing TAP::Harness::Archive was a bit hairy but that's
> CPAN's fault...

This is something we can probably make really easy if we write some
supporting scripts with cpanminus + local::lib. I.e. just have a
config file like:

  ~/.gitsmoker:
    repository =3D ~/g/git
    data       =3D ~/g/git-smoker

Where the git-smoker would maintain the state, dependencies etc. It
needs.
