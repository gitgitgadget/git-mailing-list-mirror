From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: t5560-http-backend-noserver.sh fails on FreeBSD 8.1-STABLE
Date: Sat, 21 Aug 2010 12:07:25 -0600
Message-ID: <AANLkTi=JgwjfbBus23M3Kw8-cksparsFKvfOs3fMx6MR@mail.gmail.com>
References: <AANLkTin8KvXBn4R3-_2_wG3B3QU9F1X0Ax69Rrb1cw1y@mail.gmail.com>
 <AANLkTimPpiO2RBbNNo0Z8mFm1VH_Ujk7HVskYvh=X2Fc@mail.gmail.com> <AANLkTimm9uXRxcwL=o1JE_voOOYVNo-1V-+Sx78votJO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 20:07:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmsTx-0002FM-52
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 20:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab0HUSHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 14:07:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46894 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0HUSHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Aug 2010 14:07:47 -0400
Received: by ewy23 with SMTP id 23so2746808ewy.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=VlnB0XatLALSJf+suUZaZRhekJBdfLY41zlgPGKx+mU=;
        b=SStpdGqzQRKs8NJ8m4UZ275Y7s7iH/41GmyCtpIcwbTPtiKJJ5HD9A80C7psYEoDkH
         ZlaEgKUr31Y/tQI2QD8r8QOoQ5LvGt2D+SMw0Du8Y4qQiIeIUYkQ2zt/kFcMncFipY1r
         VsL5o7Vfhiw2bmlV98DnPCQVv3Ea/2T+S3f5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=P4v5KY91+61QWDrhfnrC40RxA3DcjilISYyX6mgBsvP9PcUXu544TwR+B+Xcw7EQ0Y
         eD1Q2n/xrdTxwWWNDXuxK8X68LCpiOA7pEZSjSXAoFnMludr2DSyicgnxsbEHOPvDMJ1
         WfU1N9xotQ9bcSxCekd3TJR/LaZMkTng3QJa8=
Received: by 10.213.7.76 with SMTP id c12mr1673428ebc.39.1282414065130; Sat,
 21 Aug 2010 11:07:45 -0700 (PDT)
Received: by 10.14.45.13 with HTTP; Sat, 21 Aug 2010 11:07:25 -0700 (PDT)
In-Reply-To: <AANLkTimm9uXRxcwL=o1JE_voOOYVNo-1V-+Sx78votJO@mail.gmail.com>
X-Google-Sender-Auth: k69OYp6SHR-ciUimKN8j-NLee3U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154149>

On Sat, Aug 21, 2010 at 2:06 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Aug 21, 2010 at 07:57, Tarmigan <tarmigan+git@gmail.com> wrot=
e:
>> On Thu, Aug 19, 2010 at 9:56 AM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> I haven't investigate this, but here's the failure output:
>>>
>>> ok 7 - static file if http.getanyfile false fails
>>>
>>> expecting success:
>>> =A0 =A0 =A0 =A0log_div "uploadpack default"
>>> =A0 =A0 =A0 =A0GET info/refs?service=3Dgit-upload-pack "200 OK" =A0=
&&
>>> =A0 =A0 =A0 =A0POST git-upload-pack 0000 "200 OK"
>>>
>>> --- exp 2010-08-19 15:56:14.000000000 +0000
>>> +++ act 2010-08-19 15:56:14.000000000 +0000
>>> @@ -1 +1 @@
>>> -Status: 200 OK
>>> +Status: 404 Not Found
>>> not ok - 8 http.uploadpack default enabled
>>> #
>>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 log_div "uploadpack default"
>>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 GET info/refs?service=3Dgit-upload-pa=
ck "200 OK" =A0&&
>>> # =A0 =A0 =A0 =A0 =A0 =A0 =A0 POST git-upload-pack 0000 "200 OK"
>>> #
>>>
>>
>> Thanks for the report. =A0Is this a new breakage and what version is=
 it
>> failing on?
>>
>> Do you ever test with GIT_TEST_HTTPD set? =A0If not, can you please =
try this
>> =A0 =A0 export GIT_TEST_HTTPD=3D1 && ./t5561-http-backend.sh -d -i -=
v
>> and report back? =A0Hopefully the test suite will automatically find
>> apache on FreeBSD, otherwise you may need to give it some hints (see
>> lib-httpd.sh).
>
> Here are the outputs of:
>
> $ GIT_TEST_HTTPD=3D ./t5560-http-backend-noserver.sh -d -i -v >
> /tmp/no-httpd.txt 2>&1
> $ GIT_TEST_HTTPD=3D1 ./t5560-http-backend-noserver.sh -d -i -v >
> /tmp/with-httpd.txt 2>&1

Oops, sorry for not being more clear.  Test t5560 runs the same tests
as t5561, but t5561 runs through the httpd server while t5560 tries to
run without the httpd server.  t5561 is probably a better test, but
depends on GIT_TEST_HTTPD.  t5560 will run by default if you just run
all the tests.  So please try to run t5561 if you have the chance.

Thanks,
Tarmigan
