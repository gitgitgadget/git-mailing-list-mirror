From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 12:20:31 -0800
Message-ID: <AANLkTi=4svGhw+L0StH=PKdVWZtbSTSKe+a8dqSmkSE0@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home> <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home> <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimuW-7D4YA2jeF+y4DPE=CdqtL713MQK+1Gtp-d@mail.gmail.com>
 <7vk4hmbyuo.fsf@alter.siamese.dyndns.org> <AANLkTi=mbeBsR5tr4J7kQCL6YqiGfttK01VUN016aapC@mail.gmail.com>
 <7vaaiib1n1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 21:20:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjdla-0007XV-It
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 21:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab1A3UUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jan 2011 15:20:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61391 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab1A3UUx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 15:20:53 -0500
Received: by fxm20 with SMTP id 20so4972369fxm.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 12:20:52 -0800 (PST)
Received: by 10.103.241.16 with SMTP id t16mr1762645mur.23.1296418852136; Sun,
 30 Jan 2011 12:20:52 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Sun, 30 Jan 2011 12:20:31 -0800 (PST)
In-Reply-To: <7vaaiib1n1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165699>

On Sun, Jan 30, 2011 at 12:02, Junio C Hamano <gitster@pobox.com> wrote=
:
> Shawn Pearce <spearce@spearce.org> writes:
>
>>> The amount of transfer being that small was something I didn't quit=
e
>>> expect, though. =A0Doesn't it indicate that our pathname based obje=
ct
>>> clustering heuristics is not as effective as we hoped?
>>
>> I'm not sure I follow your question.
>
> I didn't see path information in your cachefile that contains C commi=
ts, T
> trees, etc. that sped up the object enumeration, but you didn't obser=
ve
> much transfer inflation over the stock git.

I didn't store the path itself, I stored the path hash as a 4 byte
int.  Its smaller, but still helps to schedule the object into the
right position in the delta search.

--=20
Shawn.
