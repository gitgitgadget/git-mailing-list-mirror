From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib/test-hg*.sh: Do not use PYTHON_PATH
Date: Wed, 17 Apr 2013 14:17:57 -0500
Message-ID: <CAMP44s1i5Pw5-Cbn3v_fGPLScjcs3HbUNkSpCgCngsTNnb1DJg@mail.gmail.com>
References: <201304171610.49384.tboegi@web.de>
	<CAMP44s2RTKLO3nhBJcm_KAwq9iHt8ZSXeFuYksYv_JebK-eqrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 17 21:18:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXrp-0005Wh-Pf
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 21:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966273Ab3DQTSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 15:18:00 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:59470 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966374Ab3DQTR7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 15:17:59 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so1847492lab.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=UCYu0Kg/5Bgko2ORxjLWdm1Xn0I2St3YDSynTWxOLI8=;
        b=qFeN/pkaSP9mbHon1LPOfFV2vM/CBv/IoGycMOT8yJMzcnoFVFIFuLNdBMMMPxMUjg
         1Kp5XGp8+UexDIna+FyKwvBcTpR0PMr7Hv6DDVWeju+Ryb2AMOp+Bn1mx9PEM7RgMOxO
         /IcyE65U+VrOqQGMLpqQy50DRpTMw484Gk7icwvrE/heByml6GuvBX81UyPlpa7spmdZ
         Kn6TceOOgLTBqUu4d4f4rjJRf7Bo4zQLM1fYJIen+DApLY7LWwsD7JAIjkzXa5t2GdzF
         6vt7CFKv0xjEBmwFYJCe37219o4M1yev2mmAFUPlshzQXt7bHHuACSwFmZ/kUc+zhXBF
         Ugmg==
X-Received: by 10.152.18.164 with SMTP id x4mr4202251lad.38.1366226278025;
 Wed, 17 Apr 2013 12:17:58 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 12:17:57 -0700 (PDT)
In-Reply-To: <CAMP44s2RTKLO3nhBJcm_KAwq9iHt8ZSXeFuYksYv_JebK-eqrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221565>

On Wed, Apr 17, 2013 at 1:36 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Apr 17, 2013 at 9:10 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> The test cases in contrib/remote-helpers use mercurial and python.
>> Before the tests are run, we check if python can import
>> "mercurial" and "hggit".
>> To run this check, python pointed out by PYTHON_PATH is used.
>> This may not work when different python binaries exist,
>> and PYTHON_PATH is not set:
>>  Makefile sets it to the default /usr/bin/python
>>  The PATH may point out e.g. /sw/bin/python.
>> When /sw/bin/python has the mercurial module installed,
>> but /usr/bin/python has not, the test will not be run.
>>
>> Git respects PYTHON_PATH, hg does not.
>> Use python instead of $PYTHON_PATH to check for installed modules.
>
> And this would fail if the distribution doesn't have a 'python'
> binary, and instead has python2, python3, etc.

Also, it would fail if mercurial is installed for python2, and python
is really python3.

--=20
=46elipe Contreras
