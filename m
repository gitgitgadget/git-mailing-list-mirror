From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 21:12:58 -0200
Message-ID: <55bacdd30910301612xabe2071i1319d920191f080f@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<7vljisk1m7.fsf@alter.siamese.dyndns.org> <7viqdwilx2.fsf@alter.siamese.dyndns.org> 
	<55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com> 
	<7v4opgh5qr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N40er-0006Zs-Ps
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbZJ3XNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 19:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbZJ3XNO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 19:13:14 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:37651 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbZJ3XNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 19:13:13 -0400
Received: by ywh40 with SMTP id 40so3149103ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SzTs+w3L1TdjVVEi9WIzSjulVA/accqvl8HwIT83r7I=;
        b=lemjQQEcAdeOz/mWh4Uexhzqd9wRgbyBSOnzPH6CYf16kfAEQhbvPVB+X36eIS8+8P
         r76h7afZi7tEk0ARVRUO05RSHlv6K4gnGN89GSs5TpsZ/Y6CBOjfRfPWKHMTSxy6yLsM
         aNBw+yi/m52T0/rv810JkIC3pXHPpndmB/T2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eE/1zbB13jIFJQQ37nynQ4ND/J2I1uFgCtz7cmrbYWvgUahzYWLGlkeBs7OYvjkuTC
         3y/pY0I93+Q7CWTlxVuoQRd3V5iF+Ic/4JsuIeXOu07FFmpa7D6C/CDgfX4lRtbne4YD
         9wzWmE0fnczhVab9rbYFolUMpTquGyREhBiCY=
Received: by 10.150.46.15 with SMTP id t15mr4052051ybt.253.1256944398048; Fri, 
	30 Oct 2009 16:13:18 -0700 (PDT)
In-Reply-To: <7v4opgh5qr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131775>

2009/10/30 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> 2009/10/30 Junio C Hamano <gitster@pobox.com>:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> ...
>>>> I agree that the issue the patch addresses is worth improving, and=
 I think
>>>> it is sensible to default to reuse the timestamp for -C and not to=
 reuse
>>>> for --amend. =C2=A0I am not sure about -c myself, but it probably =
shouldn't
>>>> reuse the timestamp by default.
>>>
>>> So after realizing that this was about "author" timestamp, I am res=
cinding
>>> this comment about the change of the default for -c and --amend.
>>
>> Actually I am only changing the default for -c and I see it useful.
>> At least with me I normally use -c only to use messages of commits a=
s
>> template.
>
> I do that from time to time as well. =C2=A0As I said in a different m=
essage, it
> may make the default more intutitive if we give new timestamp when th=
e
> author is the same as the committer when doing "-c". =C2=A0You are cr=
eating
> your own commit in that case.
>

I don't see a use for comparing the author and committer because I can
use as template my own commits or others'.

Let's clarify the subject:

In my point-of-view -c option is mainly used for templating commit mess=
ages.
In that case -c has a different default from -C and --amend options
thus creating a need for two new options: --reuse-timestamp and
--no-reuse-timestamp.

As I see by your messages you do prefer to have all those options set
up for reusing timestamp as default.
In that case we just need one new option: --no-reuse-timestamp (or
--recreate-timestamp or whatever).

So now It is a matter of decision only and you are the guy.

What should be for all?
