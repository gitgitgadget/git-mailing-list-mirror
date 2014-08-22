From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 15:32:50 -0700
Message-ID: <xmqqa96wnoj1.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<53F7A119.7070704@gmail.com>
	<xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
	<53F7A68D.2000109@gmail.com>
	<xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>
	<53F7AA48.3000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKxOO-0002Z5-7j
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 00:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaHVWdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 18:33:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57622 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbaHVWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 18:33:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5EFE32DFC;
	Fri, 22 Aug 2014 18:33:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vOAYs7egGqIs9zQsm9647NGJo4U=; b=uR0hrB
	8RJ8/rpuAF9s3uF2WOxGMg3bzT/UJ0mtxkVjgQX+uJuUC74ONlAw35FSxiKwdaCn
	ZsngYxgGGTByyLFoDzurpXnz0c6AdTy3M+QmRDeCrssI8DNpTSDyw+xuLFQC4jRO
	aDMjsz4mSCqdn6KCAhztomzsn7f9ZWNLZjI48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TkqN5VAW9gJ6VTv1austy045Z/QBms45
	RevyNrWPYtWKgzfMD51RSMlEPlG6LOar607ayeD7yR42ckwBa9vjoYvGfmfzJcjK
	zfgooAizYrH7kbWwIV8PAnFCEdIAVGuZC2BPah/AQWjazvF7NFD5oaWmBW4QYDez
	YRLFwGgmupM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D64932DFB;
	Fri, 22 Aug 2014 18:33:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6835732DF5;
	Fri, 22 Aug 2014 18:32:52 -0400 (EDT)
In-Reply-To: <53F7AA48.3000601@gmail.com> (Stefan Beller's message of "Fri, 22
	Aug 2014 22:38:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41019A44-2A4C-11E4-A4EF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255723>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 22.08.2014 22:33, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@gmail.com> writes:
>> 
>>> On 22.08.2014 22:03, Junio C Hamano wrote:
>>>> Stefan Beller <stefanbeller@gmail.com> writes:
>>>>
>>>>> So there would be tags like:
>>>>> 	master_2014_08_21
>>>>> 	master_2014_08_22
>>>>> 	...
>>>>> 	maint_2014_08_13
>>>>> 	maint_2014_08_21
>>>>> and so on. Whenever there is no tag at the tip of the branch, we'd
>>>>> know there is something wrong.
>>>>
>>>> Who creates that tag?
>>>>
>>>
>>>> My guess would be usability as tagging so many branches is cumbersome
>>> for a maintainer?
>> 
>> Did you answer my question?  Who creates these tags?
>> 
>
> It would be up to the one who pushes, the user, or in our case you!
> ...
> As I wrote in the first email, I made up this workaround and wanted to
> see, what's so bad about that workaround and how to overcome the
> problems. And all I could find was a burden on the maintainer/user.

"burden" is not an issue, as I'll be signing the push certificate
anyway when I push.  A signed tag or a signed commit and signed push
certificate solves two completely separate and orthogonal issues.

What happens if you break into GitHub or k.org and did

    $ git tag maint_2014_08_22 master_2014_08_22

to create an extra tag out of the tag signed by me?  If you want,
you could also remove the original while at it.  The goal is to let
us validate without having to trust the hosting site, its management
and its software, which is what creates the tag there, controls
where the tag sits in refs/ hierarchy and how it is shown to the
outside world.
