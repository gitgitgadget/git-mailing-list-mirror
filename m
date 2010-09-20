From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: use base64 instead of quoted-printable in format-patch headers (was Re: Make format-patch produce UTF-8 `From:' header)
Date: Mon, 20 Sep 2010 14:20:40 +0200
Message-ID: <87k4mgsj1j.fsf_-_@gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	<87y6axshmt.fsf_-_@gmail.com> <87mxrda6e3.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: Russ Allbery <rra@debian.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 14:21:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxfNI-00069w-Rg
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 14:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0ITMVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 08:21:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab0ITMV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 08:21:29 -0400
Received: by bwz11 with SMTP id 11so4168607bwz.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=q+SHL5hQs8PcHen8euYcm7uzag+TlKQuAqKxwSxhCPE=;
        b=Pjwe6333/MIuv51y870GM541jp8lLwT3gK5QoH9P6Y2q9/XKuMZDg71m4bqxV5wb5v
         ctIhQjQh+S73pKI4i2H2St1w7Y+Vsrzb+RpykEnt8SOS1OVaXQEwP95JKRwdjCesy00w
         E3pdQtE5WpJvl1bybcoxlLCsPx1mVnMV86d1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=AwFSxNPf0QPi6YOUvaKUo32xf0bM7EoYGkMwHNgQvXeq4RVFdngSZPTZcrMohgpJ0B
         twe7uaYKDvsVK+pKwKPR8mKIbSRvngAjW7cVz4j0mmbPT8AMrDHnAtERvTyXlcMm7G/3
         YuAmuXiAb8RuVirsCvCNrpgKmmekuE5H2xiqM=
Received: by 10.204.47.193 with SMTP id o1mr6545909bkf.134.1284985288480;
        Mon, 20 Sep 2010 05:21:28 -0700 (PDT)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id 24sm6429818bkr.7.2010.09.20.05.21.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 05:21:26 -0700 (PDT)
In-Reply-To: <87mxrda6e3.fsf@windlord.stanford.edu> (Russ Allbery's message of
	"Sun, 19 Sep 2010 12:19:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156620>

Russ Allbery <rra@debian.org> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Maybe format-patch could provide another mode to produce patches th=
at
>>> do not include unnecessary headers (in particular, leaving out the
>>> difficult "From " line and using UTF-8 instead of quoted-printable =
for
>>> the "From: " line).
>
>> FWIW, the quoted-printable `From:' encoding has always annoyed me --=
 I
>> replace it manually with my name & address in UTF-8 every time I sen=
d
>> out a patch. What is the reason format-patch does that (and if there=
 is
>> a reason not to change the default, could an option to disable it be
>> provided)?
>
> Well, it's required if you're going to actually send the result direc=
tly
> as a mail message, since the RFC 5322 format requires headers be enco=
ded
> using RFC 2047 encoding.

Right... thanks for pointing that out. So the problem I'm seeing is
actually different -- some software (including Mutt and the mailing
list/archive software used by this list) appears to have problems with
quoted-printable, but not with base64.

To take my name as example: when I send mail from Mutt, it is encoded a=
s
"=3D?utf-8?B?xaB0xJtww6FuIE7Em21lYw=3D=3D?=3D", i.e. base64, and both M=
utt and
the vger archive seem to decode it properly, whereas the
quoted-printable version produced by fromat-patch, i.e.
"=3D?utf-8?q?=3DC5=3DA0t=3DC4=3D9Bp=3DC3=3DA1n=3D20N=3DC4=3D9Bmec?=3D" =
in this case, is left
undecoded by Mutt and mis-decoded in the ML archive as far as I have
seen. I'm not sure about other software (Gnus seems to be able to deal
with both correctly), but perhaps it would make sense to switch to
base64 in format-patch?

=C5=A0t=C4=9Bp=C3=A1n
