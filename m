From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 13:03:59 +0100
Message-ID: <50D05BAF.4000200@viscovery.net>
References: <20121211153903.7522d6b0@chalon.bertin.fr> <7vd2yg8ngk.fsf@alter.siamese.dyndns.org> <20121212094432.6e1e48c8@chalon.bertin.fr> <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch> <20121217114058.449cbc3c@chalon.bertin.fr> <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com> <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org> <20121218120058.0c558ba5@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkvuM-0006zG-4j
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 13:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab2LRMEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 07:04:07 -0500
Received: from so.liwest.at ([212.33.55.24]:12602 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab2LRMEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 07:04:06 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Tkvtw-000167-3s; Tue, 18 Dec 2012 13:04:00 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C7E461660F;
	Tue, 18 Dec 2012 13:03:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121218120058.0c558ba5@chalon.bertin.fr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211744>

Am 12/18/2012 12:00, schrieb Yann Dirson:
> On Mon, 17 Dec 2012 13:14:56 -0800
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> Yeah, at one point I wanted to have a command that created to craft a
>>>> new commit based on an existing one.
>>>
>>> This isn't hard to do, you only have to resort to plumbing:
>>>
>>> $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
>>> bb45cc6356eac6c7fa432965090045306dab7026
>>
>> Good.  I do not think an extra special-purpose command is welcome
>> here.
> 
> Well, I'm not sure this is intuitive enough to be useful to the average user :)

When I played with git-replace in the past, I imagined that it could be

   git replace <object> --commit ...commit options...

that would do the trick.

We could implement it with a git-replace--commit helper script that
generates the replacement commit using the ...commit options... (to be
defined what this should be), and git-replace would just pick its output
(the SHA1 of the generated commit) as a substitute for the <replacement>
argument that would have to be given without the --commit option.

-- Hannes
