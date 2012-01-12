From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are
 intent-to-add entries
Date: Wed, 11 Jan 2012 19:05:48 -0800
Message-ID: <7vaa5t4o37.fsf@alter.siamese.dyndns.org>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <7vr4z67jbb.fsf@alter.siamese.dyndns.org> <20120111110222.GA32173@burratino>
 <7vr4z654m3.fsf@alter.siamese.dyndns.org>
 <CACsJy8CHOuZMP4hWp6Lb_TbdfwSgofSg_0tDZ4oDcD0veie2Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAzD-0000BU-HW
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab2ALDFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:05:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2ALDFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:05:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 886436D03;
	Wed, 11 Jan 2012 22:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9tYBBuvDF71yKweFDRie8gYbsb4=; b=WqLbs/
	ELAlXSCbhfTZo26aTUoaoDYxv8ZNJji4plMXSF+Uvb1GHdeuzbv5eJRhsSX0nS25
	9LC8kvq+ZRBZh/jLxLuFUUmqrjA9h2bu0F3SSSSgprvy/Itsy143+oJFl5FMk80h
	/uf1frHZ8x0M8d+tN5TVB2hMGafBA2RKdZ4so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UHdn+4VXmShQOXoK9QtPyFHmfmBEObFY
	p/U0kFl/ugQCQPHmwSMc2JmNBBNaWFAS4O1UOAGsSHKXxGNYy7AxsQxLl7zy9DCT
	2eE9AQz7TmGjcrO2wnSB5Oc5L5YfCJI+gz3ZgaxlF/Hsgy2rGcfL/9XDAtSt/D4T
	OGHkWlkaZL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E9FA6D00;
	Wed, 11 Jan 2012 22:05:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 125726CFF; Wed, 11 Jan 2012
 22:05:49 -0500 (EST)
In-Reply-To: <CACsJy8CHOuZMP4hWp6Lb_TbdfwSgofSg_0tDZ4oDcD0veie2Dw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 12 Jan 2012 09:53:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54C1A974-3CCA-11E1-B729-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188424>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> I really wish it were the case, but I doubt it.
>>
>> People from other VCS background seem to still think that "commit" without
>> paths should commit everything; after getting told that "what you add to
>> the index is what you will commit", I can easily see this commint: but but
>> but I told Git that I _want_ to add with -N! Why aren't you committing it?
>
> I see "-N" just as an indication, not really an "add" operation.

But the thing is, what _you_, who knows a bit more than these new people
about Git, see does not matter, because they would not listen to you.
