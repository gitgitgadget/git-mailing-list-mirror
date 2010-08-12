From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 10:20:59 +0000
Message-ID: <AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 12:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjUuI-0006ES-Oi
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 12:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359Ab0HLKVC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 06:21:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56396 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343Ab0HLKVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 06:21:01 -0400
Received: by fxm13 with SMTP id 13so612046fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IWeGa0drt5T+h6alqVYTHXAdy0Mf5dL91eiuC6+myfg=;
        b=rYgArMIOfDX549ISMVSL9t2UBIwY+226GjWEXieP+IYI8907aw0LoWgYcyfDDFwZwp
         e7p8ARn9DZtWZkFW08/VZQC4v7SjD2PZ83Oco5h1FdylPZOoZUo/VKlcWvovGaYMOo+H
         Mi2MNTz7/dhu0xA5+4Y7f18PH2jpRNpu4z9Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lJ3MrFoc1r9Zh0i2ZU0u+xAhWJPCz4eLvLYRhs4aghoT7y71fy0fgKI4iW/jo22tAL
         JAwdKKwTPrmgIK6qtq543//IBRe0EFK0ksJsQwHW3xroA7DCB6WsY+wGfOcqglhJcdLx
         xbX5AvvLi+WoGH0gcpdlgLvVeZbjd9VyLIHvI=
Received: by 10.223.124.145 with SMTP id u17mr21355365far.92.1281608459966; 
	Thu, 12 Aug 2010 03:20:59 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 12 Aug 2010 03:20:59 -0700 (PDT)
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153362>

On Thu, Aug 12, 2010 at 09:23, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> [Sorry for the Cc spam; I lack the time to conduct individual message=
s.]
>
> I compiled many topics in pu and ran the test suite on Windows,

A Windows smoker would be useful :)

> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>> * en/rebase-against-rebase-fix (2010-08-06) 2 commits
>> =C2=A0- pull --rebase: Avoid spurious conflicts and reapplying unnec=
essary patches
>> =C2=A0- t5520-pull: Add testcases showing spurious conflicts from gi=
t pull --rebase
>
> This should not use "sed -i" in the test suite.

Another case for the modify() helper function I guess.

>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>> =C2=A0- apply: Handle traditional patches with space in filename
>> =C2=A0- t4135 (apply): use expand instead of pr for portability
>> =C2=A0- tests: Test how well "git apply" copes with weird filenames
>> =C2=A0- apply: Split quoted filename handling into new function
>>
>> Looked Ok. =C2=A0Will merge to 'next'.
>
> The test cases that work with files with tabs must have a prerequisit=
e;
> see t3600-rm.sh.

Hrm, another test with tabs in filenames. There are already three
setting the TABS_IN_FILENAMES prereq, but I missed this one.

I should probably move those checks into some prereq library, maybe to
test-lib.sh itself.
