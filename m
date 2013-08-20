From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Mon, 19 Aug 2013 17:26:39 -0700
Message-ID: <D9B32897-9ABC-4F98-BE8B-CCC105FCAD9E@eyesopen.com>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de>	<20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
 <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
 <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
 <20130816205246.GA6487@sigill.intra.peff.net>
 <B692A7F2-C5C2-4B5A-8FFC-6CF5C9DB72D8@eyesopen.com>
 <7vzjsdldbi.fsf@alter.siamese.dyndns.org>
 <30EC6002-1044-41E0-8700-1F210A6CA882@eyesopen.com>
 <xmqq1u5p8kqc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 02:26:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBZma-0002cV-1I
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 02:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab3HTA0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 20:26:42 -0400
Received: from exhub018-3.exch018.msoutlookonline.net ([64.78.17.18]:20067
	"EHLO EXHUB018-3.exch018.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812Ab3HTA0l convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 20:26:41 -0400
Received: from EXVMBX018-11.exch018.msoutlookonline.net ([64.78.17.52]) by
 EXHUB018-3.exch018.msoutlookonline.net ([64.78.17.18]) with mapi; Mon, 19 Aug
 2013 17:26:40 -0700
Thread-Topic: [PATCH] Git segmentation faults if submodule path is empty.
Thread-Index: Ac6dO/BFzhnvBU0SS8aQjjYGzeAruQ==
In-Reply-To: <xmqq1u5p8kqc.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232579>

It looks great to me.

Thanks,

--
Jharrod LaFon
OpenEye Scientific Software

On Aug 19, 2013, at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Jharrod LaFon <jlafon@eyesopen.com> writes:
> 
>> I will keep trying this until it's perfect, and I thank you for
>> the help.  When I resubmit this, would you like me to include your
>> sign-off line as well?
> 
> If the one I attached at the end of the message you are responding
> to looks fine to you, I'd just apply it without having you to
> reroll.
> 
>> Also, the end of the test script was not included in your message.  
> 
> Sorry, but I am not sure what you meant by this.
> 
> I reworked your example to make it the second test in an existing
> test script.  There are many existing tests after that so it is
> natural that we wouldn't see the end of the file in the patch
> context.
> 
>>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>>> index 5ee97b0..a39d074 100755
>>> --- a/t/t7400-submodule-basic.sh
>>> +++ b/t/t7400-submodule-basic.sh
>>> @@ -18,6 +18,16 @@ test_expect_success 'setup - initial commit' '
>>> 	git branch initial
>>> '
>>> 
>>> +test_expect_success 'configuration parsing' '
>>> +	test_when_finished "rm -f .gitmodules" &&
>>> +	cat >.gitmodules <<-\EOF &&
>>> +	[submodule "s"]
>>> +		path
>>> +		ignore
>>> +	EOF
>>> +	test_must_fail git status
>>> +'
>>> +
>>> test_expect_success 'setup - repository in init subdirectory' '
>>> 	mkdir init &&
>>> 	(
