From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 6 May 2010 03:01:44 -0500
Message-ID: <20100506080144.GA25876@progeny.tock>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
 <20100506064428.GA29360@progeny.tock>
 <4BE26A83.4010708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 06 10:01:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9w1H-0000zE-DL
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 10:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557Ab0EFIBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 04:01:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61932 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0EFIBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 04:01:13 -0400
Received: by gwj19 with SMTP id 19so2637740gwj.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2tfOXGgsGEVw5vPRVfkYySRfaInNqTzuFkhqnhjR9OM=;
        b=iEjtW5WhFFWec1Jd1auByPCgOj0pmKZePjnFLyQNAO2jZZ3CAK7QeGbSLN7YChYkqe
         px/nINDcGMVzFAZUu6hQiLmK0iUDh7ojuYaO76hHfZ0OfKw+xnJcn/vI3wbpUDpsCUAk
         4X9JG3bf4MQj5EVqM4s25ZcAQ2ycwQHo79tuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u4HYFc1xuLlJPAFOBNW1FDocwbICTrbFxc3sqPFeZC2rgv0OTWswnGErZ1UAbAQHun
         nYwSQF65o0pvDEXccCuPjKZkHxw9ansSbj0MZfH/WiTF98W4scdUznj7Ay9LJrQh0sDJ
         n1jyeVfg95k+Fu9dix26ssoXBJ2/bapGtwz2s=
Received: by 10.150.188.11 with SMTP id l11mr1241126ybf.197.1273132871426;
        Thu, 06 May 2010 01:01:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm591575iwn.15.2010.05.06.01.01.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 01:01:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE26A83.4010708@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146456>

Johannes Sixt wrote:
> Am 5/6/2010 8:44, schrieb Jonathan Nieder:
>>  test_when_finished () {
>> 	test_cleanup=3D"$* && $test_cleanup"
>>  }
>
> I'm wondering why you want this test_cleanup at all?
>=20
> Is it so that subsequent tests can succeed even if an earlier test fa=
iled
> before its regular cleanup?

Yes.  In some cases (permissions-related), if a test fails, even a
=E2=80=98make clean=E2=80=99 afterwards fails.

> I don't see what this buys you. If a test case uncovers a regression,=
 you
> got to fix it - who cares how many later tests fail or not? Once you =
are
> finished with your change, all tests will pass anyway (including thei=
r
> regular cleanups).

Why do we support the non --immediate mode at all, then?  Just like it =
can
be easier to understand the result when a compile uncovers more than on=
e
error, it can help in debugging to see which later tests were broken.

If there is a consensus that this is not worth it, I am fine with
that, though.  The current status is that each test where this matters
does things its own way.

Jonathan
