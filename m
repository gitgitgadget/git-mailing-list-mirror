From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: diff-filter=T only tests for symlink
 changes
Date: Sat, 18 Oct 2008 11:37:57 -0700
Message-ID: <7viqrpbvga.fsf@gitster.siamese.dyndns.org>
References: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
 <20081018224045.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 20:39:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrGhv-00021B-B3
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 20:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbYJRSiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbYJRSiH
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 14:38:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYJRSiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 14:38:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6771371E7F;
	Sat, 18 Oct 2008 14:38:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C939071E7E; Sat, 18 Oct 2008 14:37:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E65B85DC-9D43-11DD-856D-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98565>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Anders Melchiorsen <mail@cup.kalibalik.dk>:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 7788d4f..7604a13 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -137,7 +137,7 @@ endif::git-format-patch[]
>>  --diff-filter=[ACDMRTUXB*]::
>>  	Select only files that are Added (`A`), Copied (`C`),
>>  	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
>> -	type (mode) changed (`T`), are Unmerged (`U`), are
>> +	type (symlink/regular file) changed (`T`), are Unmerged (`U`), are
>>  	Unknown (`X`), or have had their pairing Broken (`B`).
>>  	Any combination of the filter characters may be used.
>>  	When `*` (All-or-none) is added to the combination, all
>> -- 
>> 1.6.0.2.514.g23abd3
>
> Are symlinks and regular files the only kind of object you can see in
> diff? What happens when a file or directory changes to a submodule?

Oops.  I've already applied Anders's patch, but you are right.  A change
from a blob to submodule also shows up as a typechange event.

Perhaps we should just remove the parenthesised comment from there
instead.  I'll rewind and rebuild, as I haven't pushed the results out
yet (lucky me).
