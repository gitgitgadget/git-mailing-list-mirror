From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 17:10:24 -0800
Message-ID: <7v4ony8ge7.fsf@alter.siamese.dyndns.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <1260488743-25855-2-git-send-email-warthog9@kernel.org>
 <m34onye3h8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>,
	git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 02:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIu25-0005fO-8N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 02:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761912AbZLKBKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 20:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761746AbZLKBKp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 20:10:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759436AbZLKBKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 20:10:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 974B5871D4;
	Thu, 10 Dec 2009 20:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KsyfErCtZqYBmwh70BVsehtIAeM=; b=qwBFaG
	KbsBIlxIdMGOVs5wdPCT0/tGqnb7Qq+G0jYWxbGYvxGW/kbr94OM3/D0kiHDqfZe
	WsitzYKy3Ma0bji0CawtfzxN4R6QsQb9qYpMZDNkokScwqQZDzubHTsSSgW+t3Aq
	80WJ8tuqVzQ7/5oVLXRRv8yj5a0E/AYegfor4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHx8NRh0mXioQAQF7fLH4s+7XGqf9rwX
	xgH5eBlMJibzpp0yuOEBJkjFIBjn+9Wt1KeBkgjTmzN8LKY9D7k5EIE2/vPvOSxL
	xNgm2sjurc205pkkfZfHkvVX5mXGzRUGJ3xmjfta1oOkKEMyUKLJUTbVB3yK23dU
	3/sfwuoAOOI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AE10871C6;
	Thu, 10 Dec 2009 20:10:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84C67871B5; Thu, 10 Dec
 2009 20:10:25 -0500 (EST)
In-Reply-To: <m34onye3h8.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu\, 10 Dec 2009 16\:52\:22 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAC395F8-E5F1-11DE-986C-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135063>

Jakub Narebski <jnareb@gmail.com> writes:

>> +# loadavg throttle
>> +sub get_loadavg() {
>> +    my $load;
>> +    my @loads;
>> +
>> +    open($load, '<', '/proc/loadavg') or return 0;
>
> Why not use one of existing CPAN modules: Sys::Info::Device::CPU,
> BSD::getloadavg, Sys::CpuLoad?

I would prefer to hear something along the lines of...

    I like this.  Here is a follow-up patch you can squash in to
    support other platforms.

I gave the patches a cursory look (I somehow didn't see 5/6, though) and
they all looked decently done, except that some of the lines were
excessively long.
