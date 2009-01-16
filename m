From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 14:50:45 +0100
Message-ID: <adf1fd3d0901160550m200e9478t5755ebdc176f09a2@mail.gmail.com>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
	 <200901151500.01876.trast@student.ethz.ch>
	 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
	 <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
	 <adf1fd3d0901160512i2de8f473gd471cc1dcb72afa4@mail.gmail.com>
	 <alpine.DEB.1.00.0901161415230.3586@pacific.mpi-cbg.de>
	 <adf1fd3d0901160546o50db0594h7377774fed9fef99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNp7O-0003AF-0S
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764884AbZAPNut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 08:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763207AbZAPNus
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:50:48 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:55640 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762764AbZAPNur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 08:50:47 -0500
Received: by bwz14 with SMTP id 14so5024152bwz.13
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:50:45 -0800 (PST)
Received: by 10.103.226.10 with SMTP id d10mr904051mur.105.1232113845265; Fri, 
	16 Jan 2009 05:50:45 -0800 (PST)
In-Reply-To: <adf1fd3d0901160546o50db0594h7377774fed9fef99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105960>

2009/1/16 Santi B=E9jar <santi@agolina.net>:
> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> On Fri, 16 Jan 2009, Santi B=E9jar wrote:
>>
>>> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> >
>>> > Note that this affects creating bundles with --all; I contend tha=
t it
>>> > is a good change to add the HEAD, so that cloning from such a bun=
dle
>>> > will give you a current branch.  However, I had to fix t5701 as i=
t
>>> > assumed that --all does not imply HEAD.
>>>
>>> From the description I understand that it only affects when the HEA=
D is
>>> detached, but in t5701 the HEAD is not detached so nothing should b=
e
>>> fixed.
>>
>> The error in t5701 was that it _wanted_ to test a bundle without a H=
EAD,
>> but it actually created it with --all.  That was implying that --all=
 does
>> not mean HEAD
>
> Yes, that is the current behaviour.
>
>> , and I disagree with that.
>
> I know you disagree, but in the commit log you said:
>
> ---
> [PATCH] revision walker: include a detached HEAD in --all
>
> When HEAD is detached, --all should list it, too, logically, as a
> detached HEAD is by definition a temporary, unnamed branch.
> ---
>
> so nothing talks about changing the behaviour when the HEAD is not de=
tached.
>
> But the problem with t5701 is another thing. If you run this:

>
> git init
> : >file
> git add .
> git commit -m1
> git bundle create b1.bundle --all HEAD
> git ls-remote b1.bundle
> git rev-parse --all HEAD
>
> you will see that the same rev-parse parameters in "git bundle"
> produce tree lines while with "git rev-parse" only two are produced.
>

Sorry, there are two problems with t5701, the one of the changing
behaviour of the --all flag and this one.

Santi
