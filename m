From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 20:37:00 +0200
Message-ID: <AANLkTik1yeju8Z9+EMBBTG_Dt8Z=7dMBLdX8s51zd1Wk@mail.gmail.com>
References: <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net> <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net> <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr> <20101007175358.GD12130@sigill.intra.peff.net>
 <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com>
 <20101007181349.GD18518@sigill.intra.peff.net> <AANLkTikkZaCQKFTnQ=k2Ajp_6mVRd6mrP1P7bEASEGgd@mail.gmail.com>
 <20101007183342.GA20289@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vLb-0004sG-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab0JGShY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:37:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64236 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0JGShW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 14:37:22 -0400
Received: by ewy23 with SMTP id 23so113120ewy.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=M4tAI6Z7hcTCvR1ks6vCVIUPeKibW7XMZ9kdv4HC9/I=;
        b=LsHKKqrN+JJKCIXRDtht1ric2lLJeqseKMoGVdLaWbdYdPwbzgkQrZUSrTGPthpTur
         aZPOn5vTZp+3rACEr5MloP9+1gRC93yquop7s+91yBT3MqCpsoPk2vW20Rw5kpQTdsM7
         DxfoZBDKpUK727eqK6QNHQC8qDIZkZrrPIraw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=t+NVWFt0sV3a6FsCHykSd/0HIFFbcOLOwseSYFQZsOWC1chKHgTWEVfH7kHbROkVo5
         Mff8LH8v/xi4V5fFGvDDh6lT953TPo/YoDp+3pK7D9bFrv5cktt8+5eH/AJAcq93fS/T
         ORMLaGHEaahCy1yjmk9oOSosdhIe8bguxDS8s=
Received: by 10.213.7.131 with SMTP id d3mr1872376ebd.55.1286476641317; Thu,
 07 Oct 2010 11:37:21 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Thu, 7 Oct 2010 11:37:00 -0700 (PDT)
In-Reply-To: <20101007183342.GA20289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158429>

On Thu, Oct 7, 2010 at 8:33 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 07, 2010 at 08:19:01PM +0200, Erik Faye-Lund wrote:
>
>> Yeah. When I read K&R a bit closer, I find this:
>>
>> "A number specifying a minimum field width. The converted argument
>> will be printed in a field _at least this wide_, and wider if
>> necessary. If the converted argument has fewer characters than the
>> field width _it will be padded_ on the left (or right, if left
>> adjustment has been requested) to make up the field width."
>
> You are confusing field width (%*s) with precision (%.*s) here.
>
> C89 is pretty clear that the behavior I am seeing is mandated:
>
> =A07.19.6.1, paragraph 4:
>
> =A0 =A0 An optional precision that gives ... the maximum number of by=
tes to
> =A0 =A0 be written for s conversions.
>
> =A07.19.6.1, paragraph 8, item "s":
>
> =A0 =A0... Characters from the array are written up to (but not inclu=
ding)
> =A0 =A0the terminating null character. If the precision is specified,=
 no
> =A0 =A0more than that many bytes are written. If the precision is not
> =A0 =A0specified or is greater than the size of the array, the array =
shall
> =A0 =A0contain a null character.
>
> so it is always about giving a maximum to print an unterminated strin=
g,
> or to print a partial string. But printf always stops at a NUL.
>
> -Peff
>

Indeed, thanks for clearing that up.
