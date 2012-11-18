From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/7] completion: add tests for invalid variable name among
 completion words
Date: Sun, 18 Nov 2012 09:34:19 +0100
Message-ID: <CAMP44s26MkA8QWm_JQkk8M0mM39XK0Fv1CBZfpt52VKt1urkAw@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-5-git-send-email-szeder@ira.uka.de>
	<20121117234059.GD3815@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0Ko-0003ql-BH
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 09:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2KRIeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 03:34:20 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60978 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2KRIeU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 03:34:20 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so4026777obb.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IKaqCxKLwjgGeYuP1bASvEep4rUGWObmPFrXoS2lsNs=;
        b=P38O6DrWbMSqFSgnaqcZjkRbCVv7sLr3P1Q8bwGZC1LHNcjKuA/OdvAWiWWTQtcIWw
         CllhEvVZr5v1t1oNRWfhDrCRErKYqlEbbInd0pXLyKlTIyBNOEVy9jjSYxbNhGcsHRmw
         /+ZRCNZJoTwBtHdydbTUepsPA9U2zA07nrgFtTAPyqJCAejLrQUpA+8tutFiTa24CS6z
         kFyzr6RRPmP3/5PMmJUDKu2UKCNzA2JOKczOaUVpGMqbzeyTKWjeDw1Sa3dq0+qBJbZz
         c7GSTaQtm2mE+fBEh0xfer77ljQFwPX4MS5n2kLo9eVjN894p6FwvRDqW3JU8ufvYD9D
         wSkw==
Received: by 10.182.116.6 with SMTP id js6mr7769197obb.82.1353227660043; Sun,
 18 Nov 2012 00:34:20 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 00:34:19 -0800 (PST)
In-Reply-To: <20121117234059.GD3815@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209994>

On Sun, Nov 18, 2012 at 12:40 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> SZEDER G=C3=A1bor wrote:
>
>>                                                      The breakage ca=
n
>> be simply bogus possible completion words, but it can also be a
>> failure:
>>
>>   $ git branch '${foo.bar}'
>>   $ git checkout <TAB>
>>   bash: ${foo.bar}: bad substitution
>
> Or arbitrary code execution:
>
>         $ git branch '$(>kilroy-was-here)'
>         $ git checkout <TAB>
>         $ ls -l kilroy-was-here
>         -rw-rw-r-- 1 jrn jrn 0 nov 17 15:40 kilroy-was-here
>
> The final version of this patch should go to maint.  Thanks for
> catching it.

Shouldn't this go to the commit message?

--=20
=46elipe Contreras
