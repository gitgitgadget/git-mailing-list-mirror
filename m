From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Wed, 1 Dec 2010 15:33:06 +0100
Message-ID: <AANLkTi=OyK+Qvin9FjrUTyEacxHVLjBG77Qg_PPoC6kK@mail.gmail.com>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com> <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
 <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com> <7vvd3g58ja.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 15:33:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNnkV-0000O5-IW
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 15:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab0LAOda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 09:33:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0LAOd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 09:33:29 -0500
Received: by fxm20 with SMTP id 20so110025fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 06:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=6L6ZIoxexbLlz+LL9E6aDxsiceoseXMqynxB7D1pPlc=;
        b=HNUdk4V9oxP272j/DsyLO7NWPtzjVt/mwVqRmXkxloICu45FVhmz/WVh572Ief2Iy8
         DRMhwPSHC0DGAMGC2y6RQ8htT8hgfr7xtA9P2el2ZhMTGC5wABaR4/BEEG/SXYqhGvuL
         uSMNsLzKAKjLImhs/fqEq8oDM+ho4GpH5zIGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=T0DSJmOaTgH7x9jun/27BnjsJzwgWcm6hXqig0erOD50wUfEzqzG6blhL3jertqpf3
         /XvnTGRQ09tjaeuVmzfrmCC/mZsgdIovVoSzUEU0lEFtQiL6j7/nRWiBE3fxGNwxj6N/
         FKvRb7s/9sOMLqZ7KB6vqGI/H/iGUlxxqs87A=
Received: by 10.223.71.205 with SMTP id i13mr4197347faj.102.1291214008135;
 Wed, 01 Dec 2010 06:33:28 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 1 Dec 2010 06:33:06 -0800 (PST)
In-Reply-To: <7vvd3g58ja.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162520>

On Mon, Nov 29, 2010 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> For this code-path to trigger we would have to be able to prefix-mat=
ch
>> every common command AND every "main command" must be included in
>> common commands. At the same time. The only possible way to
>> prefix-match all commands is if they all start with the same letter.
>> Do you really think this is a situation we could ever end up in? Eve=
ry
>> git command being a common-command, starting with the same letter?
>>
>> This is basically unreachable code. Perhaps it'd be even clearer jus=
t to die:
>>
>> if (main_cmds.cnt <=3D n)
>> =A0 =A0 =A0 die("Prefix-matched everyting, what's going on?");
>
> Well, the same letter can be an empty string:
>
> =A0 =A0 =A0 =A0$ git ''
>

Indeed, my bad.

> Didn't I already suggest BUG() there? =A0Also, saying "too ambiguous"=
 would
> make the codepath give "... See 'git --help'" message, I think.
>

Sure. I was considering just taking your version verbatim. But let's
see what happens, perhaps I get inspired ;)
