From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Wed, 10 Jun 2009 15:43:47 -0700
Message-ID: <4A303723.4060805@zytor.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>	<c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>	<4A2E7EEC.2050807@zytor.com>	<c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>	<7viqj5kutl.fsf@alter.siamese.dyndns.org>	<c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com> <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEWcz-0004eD-UE
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 00:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbZFJWu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756766AbZFJWu2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 18:50:28 -0400
Received: from terminus.zytor.com ([198.137.202.10]:33493 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756437AbZFJWu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 18:50:26 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n5AMhl7a004850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2009 15:43:48 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.94.2/9451/Wed Jun 10 11:05:54 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121315>

Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> On Tue, Jun 9, 2009 at 10:37 PM, Junio C Hamano<gitster@pobox.com> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> My opinion is that we should not penalize all the people working on
>>>> "quite clean" projects and also people working on "not clean" projects
>>>> who are able to recover, on the pretence that there are other people
>>>> on these "not clean" projects who are not.
>> ...
>> When I wrote "clean", I just mean with not too many untestable commits.
> 
> Ok, then the "opinion" in the above paragraph was simply stating the
> obvious: we should have a good "bisect skip".  I obviously agree with that
> ;-).
> 
> In other words, you were not arguing against my observation that your
> algorithm would not be much better than randomly picking the next commit
> when the best one is untestable, unless the history is linear.  I guess
> that was what I was confused with.  I thought you were saying that we
> should give preferential treatment to people with linear history. 
> 
>> Ok. I started working on optionaly using a PRNG but I am not sure that
>> you will want to add another one.
> 
> It may still make sense to replace, not add to, that "fixed alternating
> distance in goodness space" with a randomized one, for the reasons HPA
> stated, especially for avoiding to give a false impression that the magic
> constants are picked for some reason.
> 

That being said, Christian's observation that a biased selection would
be better than a linear random pick is a good one.

	-hpa
