From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fix 'Use of uninitialized value' error in href()
Date: Fri, 31 Jul 2009 07:51:41 -0700
Message-ID: <7vljm4x5vm.fsf@alter.siamese.dyndns.org>
References: <200907310824.42953.jnareb@gmail.com>
 <1249022929-21037-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200907311030.52643.jnareb@gmail.com>
 <cb7bb73a0907310137o6adb57a5tb05b6745b41b0f01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 16:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWtSe-0007Ns-VX
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 16:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbZGaOvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 10:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbZGaOvr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 10:51:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZGaOvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 10:51:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41F241B378;
	Fri, 31 Jul 2009 10:51:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7A8801B373; Fri,
 31 Jul 2009 10:51:42 -0400 (EDT)
In-Reply-To: <cb7bb73a0907310137o6adb57a5tb05b6745b41b0f01@mail.gmail.com>
 (Giuseppe Bilotta's message of "Fri\, 31 Jul 2009 10\:37\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ABE2ED9E-7DE1-11DE-AE64-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124565>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> 2009/7/31 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 31 July 2009, Giuseppe Bilotta wrote:
>>>
>>> The funny thing is that I seem to get the error for something as simple
>>> as a commit view (_any_ commit view, for the matter), but I wasn't able
>>> to reproduce it from the shell, which is why I'm not adding a testcase.
>>
>> Gaaah! A Heisenbug! ;-)
>
> Well, I can reproduce it consistently on the gitweb repository, with
> any shortlog or commit view. I also think I understand why it happens
> (i.e. in some cases the check for file_parent eq file_name is done
> before calling href). The question, of course, is why wouldn't it
> happen in the test repository.

That sounds like something worth figuring out, independent of the issue
this patch addresses.
