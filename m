From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC 0/2] test_terminal: check that TTY prerequisite is declared
Date: Fri, 15 Oct 2010 19:27:34 +0800
Message-ID: <AANLkTi=Cvgu-761fQdhwbHhHJ6AgWYUSAbsOt=Cstji-@mail.gmail.com>
References: <20101014030220.GB20685@sigill.intra.peff.net>
	<20101014030505.GC5626@sigill.intra.peff.net>
	<20101014031642.GB14664@burratino>
	<20101014033448.GB28197@sigill.intra.peff.net>
	<20101014203721.GA28958@burratino>
	<20101015044252.GA22438@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 15 13:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6iVJ-0004lM-Nu
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 13:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab0JOL1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 07:27:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57596 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0JOL1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 07:27:37 -0400
Received: by ewy20 with SMTP id 20so665459ewy.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GTVdHLDKsyDlfB0AEKSo2u/uU41l7jppjFuw+WcilX4=;
        b=gtfw7Nb/a99a957ztsvuqiCntQTt1Uq1zhjpxyJCmDu8WxNMFQ7VoeYkcqSZ5oqQaW
         owrIrm9Xvu/9dsvMS15XD6efwlcX5xNNzk9sLCEkfUXb4esI52I2NsaScNqVY+/t5O1c
         uUAsYJ6a53IYFsL1a0Zg14fREGv0JJ+21z5bA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KhxaIvuG7MROfNaapAghSlm9trWF2Ut9sH5N+HRsDKWNfbikv6LCeGEthJ5UoSUWQU
         nxBmcfGi0+dXe9AUO8fBgIA4H9uT/qOGinUXj8mhZrTnEoAy+jDoqcrbK8odRI10279P
         h3qNUwVstikFxMZkF8DEvES4gwOS1BZX3/ZsY=
Received: by 10.213.16.144 with SMTP id o16mr1217190eba.64.1287142054500; Fri,
 15 Oct 2010 04:27:34 -0700 (PDT)
Received: by 10.213.7.77 with HTTP; Fri, 15 Oct 2010 04:27:34 -0700 (PDT)
In-Reply-To: <20101015044252.GA22438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159112>

On Fri, Oct 15, 2010 at 12:42 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 14, 2010 at 03:37:21PM -0500, Jonathan Nieder wrote:
>
>> > Oops, good catch. I think we should already catch it, as test_term=
inal
>> > will not be defined at all in the no-tty case. We could print a ni=
cer
>> > message, but
>>
>> I rather meant something like this.
>>
>> Patch 1 exposes the internal $prereq variable from
>> test_expect_(success|failure). =A0Maybe it should be called
>> GIT_TEST_something to avoid trampling other programs' namespaces? =A0=
Not
>> sure.
>>
>> Patch 2 introduces some magic autodetection so people that never run
>> tests without -v can still notice the missing TTY prereqs.
>
> Yeah, that is better, as it will catch the lack of prerequisite even =
on
> systems where the prerequisite is met.
>
> It seems like a lot of code to catch something small, but on the othe=
r
> hand, it does seem to be a repeated mistake.

I'll probably be re-rolling the push --progress fix series with this an=
d Jeff's.

--=20
Cheers,
Ray Chuan
