From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: avoid pipes to better catch "git rev-list"
 errors
Date: Fri, 10 Apr 2009 17:52:47 -0700
Message-ID: <7veiw0nh9c.fsf@gitster.siamese.dyndns.org>
References: <20090329115832.28acd74e.chriscool@tuxfamily.org>
 <20090410093436.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 02:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRUM-0007Hm-N7
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 02:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZDKAw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 20:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZDKAw6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 20:52:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZDKAw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 20:52:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 35903D3AC;
	Fri, 10 Apr 2009 20:52:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5A7D6D3A7; Fri,
 10 Apr 2009 20:52:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18642E8A-2633-11DE-9686-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116284>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Christian Couder:
>
>> When doing:
>> 
>> eval "git rev-list --bisect-vars ..." | {
>>         while read line
>>         do
>>                 echo "$line &&"
>>         done
>>         echo ':'
>> }
>> 
>> the result code comes from the last "echo ':'", not from running
>> "git rev-list --bisect-vars ...".
>> 
>> This means that we may miss errors from "git rev-list".
>> 
>> To fix that, this patch gets rid of the pipes by redirecting the
>> output of "git rev-list" into a file, and then reading from this
>> file.
>> 
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Junio, may I ask what happened to this patch?

I've chosen to ignore it, hoping that Christian's other bisect topic to
stabilize soon.  That will make this patch unnecessary, I think.
