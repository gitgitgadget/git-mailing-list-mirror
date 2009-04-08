From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be
 used
Date: Tue, 07 Apr 2009 23:30:14 -0700
Message-ID: <7v4owzr72g.fsf@gitster.siamese.dyndns.org>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
 <20090404180601.GA14888@coredump.intra.peff.net>
 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
 <20090404232505.GA26906@coredump.intra.peff.net>
 <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
 <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
 <alpine.LFD.2.00.0904052220060.6741@xanadu.home>
 <449c10960904051934l54d2d504w1af867dc53ef7dd7@mail.gmail.com>
 <alpine.LFD.2.00.0904052311020.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRKQ-00040P-Q8
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761686AbZDHGaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761411AbZDHGaY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:30:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760602AbZDHGaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:30:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 09DD4A829B;
	Wed,  8 Apr 2009 02:30:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CAFD7A829A; Wed,
  8 Apr 2009 02:30:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD306822-2406-11DE-BEE5-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116046>

Nicolas Pitre <nico@cam.org> writes:

>> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
>> index 9fc3b35..99181fd 100644
>> --- a/builtin-pack-objects.c
>> +++ b/builtin-pack-objects.c
>> @@ -1612,7 +1612,7 @@ static void ll_find_deltas(struct object_entry
>> **list, unsigned list_size,
>>                 return;
>>         }
>>         if (progress > pack_to_stdout)
>> -               fprintf(stderr, "Delta compression using %d threads.\n",
>> +               fprintf(stderr, "Delta compression using up to %d threads.\n",
>>                                 delta_search_threads);
>> 
>>         /* Partition the work amongst work threads. */
>
> This I have absolutely no issue with.
>
> Acked-by: Nicolas Pitre <nico@cam.org>

I do not have problem with the wording either, but then the commit log
message needs to change, I think.  Care to re-submit?
