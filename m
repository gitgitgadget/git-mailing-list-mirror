From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Thu, 03 Mar 2011 09:20:02 +0100
Message-ID: <4D6F4F32.60108@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com> <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net> <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com> <AANLkTimPGxzP+XfX8Ng5U_4UnPWZCFLQ-3rP4oPTE3o+@mail.gmail.com> <4D6E4246.5080407@drmicha.warpmail.net> <7vhbblcvl7.fsf@alter.siamese.dyndns.org> <4D6F0E89.4020200@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 09:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv3p0-0002Qt-VK
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 09:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab1CCIXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 03:23:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44461 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754461Ab1CCIXa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 03:23:30 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3214F208F7;
	Thu,  3 Mar 2011 03:23:30 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Mar 2011 03:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nvQGA3h6FGFR8pVSADzSsJgLwso=; b=VMRmH73yS4rU4CvVIES+1XJm93Jaxa6+kre9FRUXxqHXOrqXSJLErPxsy7FF4ZcayTeRBMstVaRJBcbgL4hiZj5a0BqB5EAZXd+MU5YigZgc6Ju8SPJ93XbBQKqPGAJ35W7SZGaoSe//SL3iOkPVHieNX98jg5ccIBolEo2QSmQ=
X-Sasl-enc: gErOrywVhtxs0f7TttX48Mvu/IFvnJdhxjN8OY4YEKTE 1299140609
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 57954406FFF;
	Thu,  3 Mar 2011 03:23:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <4D6F0E89.4020200@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168380>

Phil Hord venit, vidit, dixit 03.03.2011 04:44:
> On 03/02/2011 11:53 AM, Junio C Hamano wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> [*] I keep forgetting that some people may have files whose names begin
>>> with ":". They are ambiguous now already with "treeish pathspec"
>>> commands, but not with "pathspec" commands. The latter would change.
>> Just to make sure I understand that they have easy workarounds:
>>
>>  - If you have a path foo/:bar, you can say
>>
>>    git log master -- foo/:bar
>>
>>    because ':' signals the magic and gets stripped only when it is at the
>>    beginning (i.e. not affecting foo/:bar); and
>>
>>  - For :boz at the root level, you can say
>>
>>    git log master -- '\:boz'
>>
>>    because the backslash in '\:boz' makes the colon not at the beginning and
>>    the glob match sees '\:boz' and then matches '\:' with literal ':' at the
>>    beginning of the pathname ":boz".
> 
> Easy workaround, maybe, but still a potential problem for unsuspecting
> scripts.
> 
>   - I think this fails in a directory with :foo.c
> 
>     git log master -- *.c
> 
> 
>   - Would this work, though?
> 
>     git log master -- "*.c"

I hope you are aware that these two are completely different before my
patch already, are you?

The second one will match ":foo.c" and any other .c-file at cwd in any
commit in master (which changes it), of course. No ambiguity here. This
is almost always what you want.

The first one would match ":foo.c" and any other .c file which you
currently have at cwd in your working tree (!), before my patch (unless
you don't have any in your wt), and is almost never what you want.

After my patch, it would interpret the ":foo.c" which the shell glob
expands to differently. That is exactly the ambiguity that I mentioned.

Michael
