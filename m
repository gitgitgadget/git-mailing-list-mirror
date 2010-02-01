From: Steve Diver <squelch2@googlemail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 1 Feb 2010 22:34:42 +0000
Message-ID: <31a97741002011434t565824abiba52f3329258ec14@mail.gmail.com>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
	 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
	 <alpine.LFD.2.00.1002011309020.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc4rR-0002hJ-VL
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 23:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0BAWep convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 17:34:45 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:44385 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab0BAWeo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2010 17:34:44 -0500
Received: by pxi12 with SMTP id 12so4958439pxi.33
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GH39zjTA6XC0bTD9T/gXIQ48DqUp1zotrxbcgKf3vTE=;
        b=cxmuLElhmcvNNUxmjRiSEBFYlb0XPrQgmRl742TsIW8/cEYpqZi2I/fYuh880H/4lm
         SfkLOqdTsZqBq31C0xbAKyraM+YnESzYzDF+0UK5OLweuJqiuOJZouy1oaQS7zJ2pGGp
         gYeXqypcTiktX2i8gEXPFeMYn7TbxXC+De104=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SmaaSxoroFlKJn1XvJ85a7716/cYuOFqKh0FGao4owzkG6Bn3j/lL/wjdevQ/Q54z8
         aK8pLHCEtUFNsTNI2xiziAFwyhtxbXkQIHTxGGggihiKLdXXB42PMhifeM4ZpTPxCPMs
         YeZuj7TfN1Pt9xoVVMmjP+h3C7yAhBN/4917U=
Received: by 10.141.4.10 with SMTP id g10mr3562027rvi.281.1265063682324; Mon, 
	01 Feb 2010 14:34:42 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002011309020.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138652>

On 1 February 2010 18:12, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 1 Feb 2010, Junio C Hamano wrote:
>
>> I do not think we need yet another term "scratchpad" for this, but w=
hat is
>> important is that both introductory and full documentation explain t=
he
>> detached HEAD well.
>>
>> Currently we say:
>>
>> =A0 =A0 Detached HEAD
>> =A0 =A0 -------------
>>
>> =A0 =A0 It is sometimes useful to be able to 'checkout' a commit tha=
t is
>> =A0 =A0 not at the tip of one of your branches. =A0The most obvious
>> =A0 =A0 example is to check out the commit at a tagged official rele=
ase
>> =A0 =A0 point, like this:
>>
>> =A0 =A0 ------------
>> =A0 =A0 $ git checkout v2.6.18
>> =A0 =A0 ------------
>>
>> =A0 =A0 Earlier versions of git did not allow this and asked you to
>> =A0 =A0 create a temporary branch using the `-b` option, but startin=
g from
>> =A0 =A0 version 1.5.0, the above command 'detaches' your HEAD from t=
he
>> =A0 =A0 current branch and directly points at the commit named by th=
e tag
>> =A0 =A0 (`v2.6.18` in the example above).
>>
>> If read carefully (some may argue that it does not need a very caref=
ul
>> reading to get it, though), this hints that "detached HEAD" state is=
 a
>> substitute for using a temporary branch, but it may not be strong en=
ough.
>>
>> I thought that a documentation update in this area was already plann=
ed?

A "temporary branch" is probably the simplest description, and would
make it easier to grasp the concept in plain language for those that
are new to Git without glazing over.

Is how it worked pre version 1.5.0 now moot in terms of reference?
Probably the first encounter a user might have is when they arrive at
a detached HEAD situation and receive the message that prompted Ron
Garret to start this thread. The concept of an automatic temporary
branch might be easier to understand from the outset without needing
reference to the "old ways" ;)

As an aside, I believe a common misconception is for a user to think
they are checking out a single file revision which could be the most
likely mechanism to lead them into an inadvertent detached HEAD state.
Any improvement in both the first line message and the full
documentation would be most helpful.

>
> Jay Soffian (added to CC) agreed to augment the documentation with th=
e
> comprehensive explanation he posted to the list lately.
>
That is good news indeed.

Steve
