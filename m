From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 21:53:52 +0100
Message-ID: <4F6B9160.1040300@in.waw.pl>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net> <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl> <20120322141245.GB8803@sigill.intra.peff.net> <7vbonozi8c.fsf@alter.siamese.dyndns.org> <20120322173701.GA11928@sigill.intra.peff.net> <7viphwxyp1.fsf@alter.siamese.dyndns.org> <4F6B84DF.8040806@in.waw.pl> <7vk42cwew5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAp1O-0005Vu-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759880Ab2CVUyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 16:54:06 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56101 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758051Ab2CVUyE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:54:04 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAp1C-0003aA-8e; Thu, 22 Mar 2012 21:53:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vk42cwew5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193716>

On 03/22/2012 09:37 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> Even this updated text does not say _what_ happens when
>> core.ignorecase is set on a case-insensitive filesystem.
>
> That was very much on purpose. We tell users not to do that, because =
it is
> calling for an undefined behaviour. And leaving it undefined gives us=
 a
> wiggle room to later do something better if we choose to.
>
>> Maybe:
>> --- 8<  ---
>> When set, case-insensitive comparisons will be used when internally
>> comparing file names.
>
> When we try to create a new file with open("./Makefile", O_CREAT) sys=
tem
> call, we do not opendir(".")  and readdir() to see if "makefile" exis=
ts
> ourselves at all, but the above makes it sound as if we would do such
> things to make sure we compare filenames ignoring there case.

Hence "internally" -- in the sense that filesystem calls are executed
by the OS, so they can be said to be external to git. Maybe this could
be worded differently.

> That is *not* what happens, and that is not what we want to say in th=
e
> documentation.
Yeah, but we should say *something*, to let the reader understand
the behaviour.

=46or example, the reader should understand, that "work arounds"=20
implemented by git do not include the normalization of filenames,
and if files are added with bad capitalization, they will stay that way=
=20
on case sensitive filesystems.

-
Zbyszek
