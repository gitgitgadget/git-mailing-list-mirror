From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 09:39:21 -0700
Message-ID: <50253939.7080908@zytor.com>
References: <5024523F.3050208@zytor.com> <20120810103612.GA21562@sigill.intra.peff.net> <7vsjbuls9h.fsf@alter.siamese.dyndns.org> <b661ef79-510e-4be6-bed2-451e9967db6f@email.android.com> <7v628qlo53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 18:40:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzsFu-0003TM-5f
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 18:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab2HJQju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 12:39:50 -0400
Received: from terminus.zytor.com ([198.137.202.10]:52147 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab2HJQjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 12:39:37 -0400
Received: from anacreon.sc.intel.com ([134.134.139.76])
	(authenticated bits=0)
	by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q7AGdQSo017770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2012 09:39:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120605 Thunderbird/13.0
In-Reply-To: <7v628qlo53.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203233>

On 08/10/2012 09:15 AM, Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> The users I am referring to generally have a --- line, rather than
>> a scissor, between the cover text and commit.  Also, there is
>> (almost) always a From: line and subject at the top of the patch
>> proper.
> 
> Oh, so it is more like this?
> 
>     From: author name <author@address.xz>
>     Date: author date
>     Subject: patch title
> 
>     Heya,
> 
>     I was walking my dog when I found a solution to this
>     problem the other day.  Here it is.
> 
>     ---
>     >From 755e8b3f35e3991a735a6be740eda4567d45a741 Mon Sep 17 00:00:00 2001
>     From: author name <author@address.xz>
>     Date: random date we do not care
>     Subject: patch title
> 
>     commit message body
> 
>     ---
> 

That is exactly what I see, except usually with the mbox header.

However, it makes sense to me to treat From: as a scissor (we can then
ignore the preceding --- completely).

	-hpa
