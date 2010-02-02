From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor  with no changes written
Date: Tue, 2 Feb 2010 23:06:29 +0100
Message-ID: <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com> <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com> <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:27:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRDl-0001Lp-Um
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab0BBW1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 17:27:34 -0500
Received: from outmail137067.authsmtp.co.uk ([62.13.137.67]:59319 "EHLO
	outmail137067.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756871Ab0BBW1d convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 17:27:33 -0500
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 17:27:33 EST
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o12M6dnH073389;
	Tue, 2 Feb 2010 22:06:39 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o12M6YvO068603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Feb 2010 22:06:35 GMT
Received: from [192.168.1.2] (124.Red-88-3-77.dynamicIP.rima-tde.net [88.3.77.124])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o12M6USw012865
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 2 Feb 2010 17:06:32 -0500
In-Reply-To: <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 3ae7b3a8-1047-11df-97bb-002264978518
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH ahwdAFdZdwdEHAkR AWQBW1JeU1s/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwRqfBpo QGEeVBF0dwYIeXhw ZEYsXSEOWxZ5JE5g Q05QEnAHZDM2dWkY AhJFdwNWcgVOdxhN b1F3GhFYa3VsFB8X Kkd2d3o+PCkXIyNQ RwARZRdXSEMGGDJ2 DxsFGDAuAVZBDzoz IhpuJ04dAEcXPQ0u MVZpVF4ZLxgIQkVB Hl1NSCleb1IBTiwk ABgSQlQfDCFQR08A 
X-Authentic-SMTP: 61633436303433.1014:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138771>

El 02/02/2010, a las 22:56, Eugene Sajine escribi=F3:

>>
>> As has already been pointed out, an extremely common workflow for =20
>> "git
>> commit --amend" is to include additional changes that were =20
>> accidentally
>> overlooked  in the initial commit, and no changes are made to the =20
>> commit
>> message.
>>
>> Changing the behavior would break that perfectly reasonable,
>> widely-practised workflow, and _that_ would be 100% not ok.
>
> I'm not against that workflow - I'm not forcing anybody to change the
> commit message. The thing I'm talking about is roughly that it should
> NOT treat the result of command ":q" the same way as the command
> ":wq".

Why should Git care about how you exited from your EDITOR? All it =20
should care about is the contents of the commit message, and the exit =20
code of the editor.

> For example IF there is a variable somewhere where message is stored:
> For new commit message it is NULL and when commit is ready it is set
> up to "message". We check If it is not empty and not NULL (:wq
> executed),  then we can commit.
> For "prepopulated" messages this variable can be is set to "message"
> from the beginning, so it doesn't matter if you're writing changes or
> not the check will always be true, so we can commit.

I don't understand what change you're asking for, as things already =20
work as you've just described (the "variable" is the file, .git/=20
COMMIT_EDITMSG).

> If the implementation would be like this, then I would propose to
> clean up this variable after the prepopulated message is populated, s=
o
> it won't use it blindly, but only after you're overwriting the messag=
e
> (even if the message is not changed).

Here is where you've lost me. Not sure what you mean here, nor how =20
you're going to maintain the existing behavior for all of the people =20
who have grown used to it over a long, long period of time.

Wincent
