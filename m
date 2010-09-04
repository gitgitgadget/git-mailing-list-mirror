From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: smtp server on windows
Date: Sat, 4 Sep 2010 14:24:46 +0000
Message-ID: <AANLkTi=5f3+g9HrssNKj99PHr_2ymxGWmM=NjHwc94j2@mail.gmail.com>
References: <4C8251A0.1020809@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Sep 04 16:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ortfo-0000Kp-4y
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 16:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab0IDOYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 10:24:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48857 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab0IDOYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 10:24:46 -0400
Received: by iwn5 with SMTP id 5so2506925iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/eKiDW8vcOdJ1BDgZfw5SLfi4o9DNHD4WTBQ5QIUm84=;
        b=PR/L5ZfkSUUsnnpFlBBnyBiaYO9J585+kc5l7j/HA87qMj7QkDiK1RvWjzaqpmv9mN
         wbzAPYKFXm/DDLAlwEib7eLESFYvlKArHVr6lDocF/TLvsOR4hvlD2zlLVaVlctUJFqB
         UPrN1fNk3E5q5QedlszflHBcCXngUwspZk6iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PZ19IX6rLtCoocp3bTqIEjEthXTGAmd5J6ZXMIfuRmjQC0ZmxvzmJ4gIqt1b5MQell
         /O4VPWOfJKErYHpa9NcNc+wlALsy5WgctKHSfoHmsiyAcPNz1S0c7/kPBAH6mtTjnJzM
         bFY+ghDD3cITew3JevO4DrTvqcnmPkN1pCfyg=
Received: by 10.231.191.147 with SMTP id dm19mr2900955ibb.6.1283610286145;
 Sat, 04 Sep 2010 07:24:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 07:24:46 -0700 (PDT)
In-Reply-To: <4C8251A0.1020809@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155329>

On Sat, Sep 4, 2010 at 14:03, Pascal Obry <pascal.obry@gmail.com> wrote=
:

> This is using the default account as specified in my .msmtprc. I want=
 to
> use a specific account (say gmail) for this repository, I tried:
>
> [sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0smtpserver =3D /usr/sbin/msmtp --account=3D=
gmail
>
> but this fails as smtpserver is expecting a simple executable. Is the=
re
> a way to pass some parameters to an smtpserver specified on a Git
> configuration?

No, but you could modify this bit in git-send-email.perl:

    } elsif ($smtp_server =3D~ m#^/#) {
        my $pid =3D open my $sm, '|-';
        defined $pid or die $!;

Or, to make it work right now: just make a wrapper script.
