From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Thu, 16 Sep 2010 13:36:14 +0200
Message-ID: <AANLkTimKV6iT-inphJbCiRa2Pb3OeP-usPpCHoaRuL8O@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTimFjofJo4ByFwr2Cz6-YqkHcZsHGk6r4siEFmDa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwClf-0005mK-3K
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab0IPLgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:36:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41773 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0IPLgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:36:35 -0400
Received: by gxk23 with SMTP id 23so358989gxk.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1PDJ5GNufp9ltwzbgSONybngjLKhmjo0HC2d19as5X4=;
        b=x1NtV4RGlx9wBv+Imt9A0AUph9D6VinGkEDE5huYYD3JxutKarF3Wl7J3DfWnegXaK
         f7ybLou9HEnKxslbCkIy9XFntG6jGMvYKcbG8LUQAXoLVzTpuScaFAtBESRhitWhsvMI
         XrCSeNgUfcc9hEQLlJyfKQn6UqYmmE7AiaoCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=czaddmdgm/5CDNNiXPF9xyMslBYORhxRTgCRXymFhezMVg6DDn5iqAx29t9PK71CmF
         cmPRI8+JxMsJejBtzq21TIp03n5euzS60gure9v05Z5MWNoeZcV16ZgndhPYGZL/5uNB
         YQF+0yCPKAMTG1Qtrb1q+HJPGxPolcZN9fNqk=
Received: by 10.101.69.3 with SMTP id w3mr3487694ank.178.1284636994137; Thu,
 16 Sep 2010 04:36:34 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Thu, 16 Sep 2010 04:36:14 -0700 (PDT)
In-Reply-To: <AANLkTimFjofJo4ByFwr2Cz6-YqkHcZsHGk6r4siEFmDa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156322>

On Thu, Sep 16, 2010 at 12:29 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>
>> +sub git_get_remotes {
>> + =A0 =A0 =A0 my ($limit) =3D @_;
>> + =A0 =A0 =A0 open my $fd, '-|' , git_cmd(), 'remote';
>> + =A0 =A0 =A0 return () unless $fd;
>> + =A0 =A0 =A0 my @remotes =3D map { chomp ; $_ } <$fd>;
>> + =A0 =A0 =A0 close $fd or return ();
>
> =A0 =A0return unless $fd;
> =A0 =A0chomp(my @remotes =3D <$fd>);
> =A0 =A0close $fd or return;

Thanks a lot. I guess this shows pretty much how Perl is not exactly
my primary language 8-)


--=20
Giuseppe "Oblomov" Bilotta
