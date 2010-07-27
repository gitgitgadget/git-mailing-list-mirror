From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git 
	log --grep=foo".
Date: Tue, 27 Jul 2010 12:21:47 +0000
Message-ID: <AANLkTikcKd4nEZuot5fyZyiLqwAWl4gQyqtNg2512SKM@mail.gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
	<vpqsk355ea6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 14:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdjAU-0005ce-C0
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 14:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab0G0MVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 08:21:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62609 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab0G0MVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 08:21:50 -0400
Received: by gwb20 with SMTP id 20so455784gwb.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3W4DORkX7y1QCi0qPT9mnipVIvhkEKblKLe2B/a77Pw=;
        b=RkdjwlvZwDt7SF3a1MVSO71JtcpgWy5ow5quXcloGHPHqr/H/7DERv2auFE1sDNDeE
         ATKUDqXKi3NwniF6dojpQAEc5738+wXLMDlw9ZH22jndxuxI8XojFnz+2lBV5Vt/mk9y
         vsKqal19cNKdA6UMnLxRVXH1tGyPWxMh6P5KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=adCcSz3Q/RQqp5vnDkcZRSIGGs0g1/Xj+e3OLKzGjZWZI1w3BHTkaQmvM0JT2t4blz
         veO9O9eUMd4K9dLwfqQy5BNjbMMwcEado+CXuefZReBxj/udycg/fyujSzbJ3YXhHq2s
         JYQiCyilFTEsNl5KfNCR4KT7wSsj0mazVmh9s=
Received: by 10.150.69.30 with SMTP id r30mr7412025yba.43.1280233307581; Tue, 
	27 Jul 2010 05:21:47 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 05:21:47 -0700 (PDT)
In-Reply-To: <vpqsk355ea6.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151935>

On Tue, Jul 27, 2010 at 11:56, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Jul 26, 2010 at 18:14, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
>>
>>> + =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(arg, "--grep")) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_message_grep=
(revs, optarg);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;
>>
>> This looks good. I've been bitten by git-log's non-standard option
>> parsing. But there's still a lot of options that need the =3D, no?:
>
> Sure, that's why the patch is just an RFC. I wanted to start the
> discussion before diving into the repetitive task or migration to
> parse-option for others, and I picked --grep and -S because they're
> the ones which annoys me the most.

Ah, there was nothing to indicate that, so I thought I'd mention the
rest. I look forward to seeing what you'll come up with to consolidate
the option parsing later on.

Jakub's suggestion seems particularly interesting, maybe we can use
the optparse lib here with some modifications to allow it to parse a
subset of the total number of options.
