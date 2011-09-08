From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git push output goes into stderr
Date: Thu, 8 Sep 2011 13:54:00 +0530
Message-ID: <CAMK1S_g5FjqBV=a19LPdwLCHbcvoG+5cQe9ZcLSz-hxEi3KkCg@mail.gmail.com>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
	<7v8vq3ztym.fsf@alter.siamese.dyndns.org>
	<20110906074916.GC28490@ecki>
	<20110907215716.GJ13364@sigill.intra.peff.net>
	<CAMK1S_gro=THLkc_wrHSLwUVaJp9k-zRDuFDQpOGaiyBTHiDnQ@mail.gmail.com>
	<20110908070706.GA1454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 10:24:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ZuF-0002FW-D8
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 10:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab1IHIYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 04:24:07 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:53833 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363Ab1IHIYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 04:24:03 -0400
Received: by vws10 with SMTP id 10so821349vws.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vm9Yl6Np7GKp5InaElT/zyKDRF0uIDn+kyjjfMZc5nQ=;
        b=A15IaX+IpHA8dqKxuh2qzkJT0pBrq2wybU1nZUhEaz+LwOT+04pX1CcJjvBYEt4hLN
         MKUuopXngA16ETv+EebRfcumyBj2xfWshlCPSv1qAbR2ng+4bb+vHd+jELuABW1vvD8g
         BUjO8PA8aChJtAFdyJc3LGbolesVU77UkUtIo=
Received: by 10.52.172.174 with SMTP id bd14mr398047vdc.246.1315470240812;
 Thu, 08 Sep 2011 01:24:00 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Thu, 8 Sep 2011 01:24:00 -0700 (PDT)
In-Reply-To: <20110908070706.GA1454@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180949>

On Thu, Sep 8, 2011 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 08, 2011 at 11:12:48AM +0530, Sitaram Chamarty wrote:
>
>> > But with a program whose main function is to perform an action, li=
ke
>> > "git push", I think there are really two ways to look at it:
>> >
>> > =C2=A01. There is no main output; any progress or status update is=
 just
>> > =C2=A0 =C2=A0 diagnostic chat, and should go to stderr.
>> >
>> > =C2=A02. The main output is the status report; it goes to stdout, =
and
>> > =C2=A0 =C2=A0 progress updates go to stderr.
>>
>> I always thought if you write stuff to stdout the remote client gets
>> confused because it is executing to a defined protocol and suddenly
>> sees unexpected input in the middle.
>>
>> Bit if *you* are saying this (output random stuff to STDOUT) can
>> happen if we want it to, clearly I was wrong...
>
> For the remote side, yes, we have to be sure not to pollute stdout,
> because that's where the protocol is going.. But the status table is
> generated on the client side, so stdout is just connected to the user=
's
> terminal there.

 aah ok, that makes sense; thanks.
