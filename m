From: Christoph Buchner <bilderbuchi@phononoia.at>
Subject: Bug: git ls-files and ignored directories
Date: Sat, 02 Jun 2012 13:00:29 +0200
Message-ID: <4FC9F24D.7000306@phononoia.at>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com> <20120531101451.C35C5B4C00D@dd24126.kasserver.com> <20120601093757.GE32340@sigill.intra.peff.net> <7vr4tz3tpw.fsf@alter.siamese.dyndns.org> <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
Reply-To: bilderbuchi@phononoia.at
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 13:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sam4T-0001Hw-IE
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 13:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966044Ab2FBLAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 07:00:33 -0400
Received: from dd24126.kasserver.com ([85.13.143.154]:50953 "EHLO
	dd24126.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966034Ab2FBLAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 07:00:32 -0400
Received: from [192.168.1.2] (chello080108007198.36.11.tuwien.teleweb.at [80.108.7.198])
	by dd24126.kasserver.com (Postfix) with ESMTPSA id B9F6AFC003D;
	Sat,  2 Jun 2012 13:00:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CACsJy8CqMudg=uKuDmRHoYAXhUoYhOp3V2ZLuKM8W5wWWE460w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199039>

@Jeff: Thank you for the clarification. I didn't want to appear pushy, I 
just wanted to make sure that I did everything right and that my mail 
won't get ignored/filtered because of some breach of protocol.

@Junio, Duy: Thanks for starting/proposing work on this!

thanks,
Christoph

On 06/02/2012 12:33 PM, Nguyen Thai Ngoc Duy wrote:
> On Fri, Jun 1, 2012 at 11:03 PM, Junio C Hamano<gitster@pobox.com>  wrote:
>> Jeff King<peff@peff.net>  writes:
>>
>>> No, I don't think anybody is working on it at the moment (at least I
>>> do not see anything near the time of that old discussion, nor do I
>>> recall it being discussed since).
>>>
>>> +cc Clemens, in case he had any work-in-progress as a result that did
>>> not end up getting published.
>> I think the way the codepath for -i feeds path to excluded() is wrong.
>>
>> The excluded() interface relies on the fact that the caller has
>> already checked foo/ before calling it for foo/bar; when asked to
>> see if "foo/bar" is excluded, it does not consider if "foo/" is
>> excluded---the caller should have already checked it.
> Sparse checkout deals with the exact same problem and it reconstructs
> a tree structure from cache list, before feeding to excluded(). I
> thought of generalizing it (e.g. for this case), but with v5 in
> progress, we'll probably have tree-based index soon. "ls-files -i"
> could be fixed by then.
