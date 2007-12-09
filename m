From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
Date: Sun, 09 Dec 2007 00:29:21 -0800
Message-ID: <7vlk84s23i.fsf@gitster.siamese.dyndns.org>
References: <20071208123058.7364.25491.stgit@rover>
	<m38x45tb9y.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1HXw-0005pf-VV
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXLII3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbXLII3g
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:29:36 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:47706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbXLII3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:29:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EB88B57A3;
	Sun,  9 Dec 2007 03:29:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A42357A2;
	Sun,  9 Dec 2007 03:29:23 -0500 (EST)
In-Reply-To: <m38x45tb9y.fsf@roke.D-201> (Jakub Narebski's message of "Sat, 08
	Dec 2007 08:13:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67606>

Jakub Narebski <jnareb@gmail.com> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> This is important for the list of clone urls, where if there are
>> no per-repository clone URL configured, the default base URLs
>> are never used for URL construction with this patch.
>
> Thanks.
>  
>> @@ -1512,7 +1512,7 @@ sub config_to_int {
>>  sub config_to_multi {
>>  	my $val = shift;
>>  
>> -	return ref($val) ? $val : [ $val ];
>> +	return ref($val) ? $val : $val ? [ $val ] : [];
>>  }
>
> Shouldn't it be
>
>   +	return ref($val) ? $val : defined($val) ? [ $val ] : [];

I think so.  Pasky?
