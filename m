From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 11:44:42 -0700
Message-ID: <7viphwxyp1.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejew?= =?utf-8?Q?ski-Szmek?= 
	<zbyszek@in.waw.pl>, Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:44:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn0H-0001LC-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758848Ab2CVSos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:44:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab2CVSoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:44:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FAA61BC;
	Thu, 22 Mar 2012 14:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OhpczlxA7bg1ctS/yslhnVQ5rnk=; b=psdrZE
	gpP5mP7PFWcoEs/ZJb3ZeR49e+oeIP995fJ6M1RimTcdACuBk2vDZzXCeke6laC/
	h1q7ZAUEyxCPpC79C5t+AGesyGgPFU54nyn6n1JCz70s1WDYSFrAtesFvtfrfGph
	dUsFx75w0ppdaheHexTkydti+O7y3CYlxIm2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDDJYkfRVe8+c53OB4hxoPMkfqQWABlX
	H22J063oN32Pys7934BGZw6T51tAnKrsbMnu0SFC5t6hfsu0ncwl5vy4gwWgSSPq
	9T+HXNBROKY2z47t80ubrVzlNhnFq6ZCp/OP7W+QkgIMDRedAxQlNvzRNVO9Qs08
	9o/BPpCA49k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C05DC61BB;
	Thu, 22 Mar 2012 14:44:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26E6661B9; Thu, 22 Mar 2012
 14:44:44 -0400 (EDT)
In-Reply-To: <20120322173701.GA11928@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 13:37:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17675CD8-744F-11E1-9D1A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193679>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 22, 2012 at 09:57:23AM -0700, Junio C Hamano wrote:
>
>> Hrm, replacing unclear part with clarified text may make sense, but it
>> would not help adding new text if the existing description is not clear
>> enough.
>> 
>> How about doing it like this?
>> 
>>    Case-insensitive filesystems like FAT and HFS+ have various strange
>>    behaviours, like reporting that a file "Makefile" already exists when
>>    the file that actually exists on them is "makefile". By setting this
>>    variable to `true`, Git employs logic to work around them.
>> 
>>    The default is false, except that git-clone[1] and git-init[1] will
>>    probe the filesystem and set it to `true` as necessary when a new
>>    repository is created.
>
> IMHO, it suffers from the same problem as the original, which is that it
> does tells when to use core.ignorecase, but does not specify what

I wanted it to tell *what* happens when core.ignorecase is set.  In other
words, I wanted the description to say that the logic employed is to work
around what case-insensitive filesystems do.  Case sensitive filesystems
obviously do not do what case-insensitive ones do (like reporting a
"Makefile" exists when only "makefile" exists), so I hoped that it was
clear enough that the additional logic would not be suitable there.

> happens when one sets core.ignorecase to true on a case-sensitive
> filesystem. Maybe we should be more explicit about what _does_ happen in
> that case (to be honest, I am not completely sure). Or just say that it
> is not a supported use case.

I guess we really need to make the description foolproof then.

                   ... exists on them is "makefile". By setting this
	variable to `true`, Git employs logic to work around them.
        Setting this to `true` on a case insensitive filesystem does
	not make any sense, because it would not magically make your
	system to treat your filesystem case insensitively.
