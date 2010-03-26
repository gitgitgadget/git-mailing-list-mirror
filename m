From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 21:50:22 +0100
Message-ID: <m239zmdcz5.fsf@gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
	<20100326124650.GA12215@coredump.intra.peff.net>
	<7vwrwykhee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 21:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvGUK-0004d6-8D
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 21:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab0CZUuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 16:50:35 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41358 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab0CZUue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 16:50:34 -0400
Received: by bwz1 with SMTP id 1so2142624bwz.21
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=OJ6D6b9SLAathINfbmITaB+1c22jCI3Ydc3PQe60QhU=;
        b=G9Q2vi/kpo0n3UVOXTOuqI+nvLFOtr4KdIkRmLvnImd/fWI4FARJmcKHwGck1SWqRz
         yo1NYaJt4RzwatPbBRJF2+sl4kYdTqSzNDpcUBEOMZWVJIe1oF4sHTwTSz5nmmClDBs2
         ToQyzOqiL4Mt5gedAN1hRLa68WcyW3ZJuGRNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=giY6WGhe0eO4SsT5sZ+jHERPd5qrkO98BiZU+FhkutuhJTbFu+NaEOl1WY7rY7Gjpp
         o5a7Tyu0VrbZi/vBifIxJV4HU4shCXZyuyXPfMQV/kygoCtk/zCZ6OC706975a8n9LQU
         QPqpnAMro4JRT+jmhIWgM/O7SfmZ6OgoPB5lo=
Received: by 10.204.127.70 with SMTP id f6mr2334761bks.76.1269636632789;
        Fri, 26 Mar 2010 13:50:32 -0700 (PDT)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id x16sm10601453bku.17.2010.03.26.13.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 13:50:31 -0700 (PDT)
In-Reply-To: <7vwrwykhee.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Mar 2010 12:32:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143284>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Mar 26, 2010 at 11:48:41AM +0100, Johannes Schindelin wrote:
>>
>>> This supports opening the results of a 'git grep' directly in a pager 
>>> (where the pager can be 'vi', too).
>>
>> This is not an argument against your patch, but you may be interested in
>> an alternate method:
>>
>>   git grep -n $pattern >grep.out
>>   vim -q grep.out
>>
>> The advantage is that the editor understands the output as a "quickfix"
>> list and lets you cycle through the hits (just like you might with
>> compiler errors). The disadvantage is that quickfix is a vim extension,
>> so "less" and stock "vi" can't do this (I imagine emacs has a similar
>> feature). It's also obviously a little more typing, but you can hide it
>> inside an alias quite easily.
>
> "M-x grep-find" mode is designed for this,

Do you mean "M-x grep" ? I don't see the point to use "M-x grep-find".

> and I often run "git grep -n" in that mode..

I always need to pass the '--no-pager' switch: "git --no-pager grep -n"
since git doesn't detect that its output is sent to a 'dumb' terminal.

-- 
Francis
