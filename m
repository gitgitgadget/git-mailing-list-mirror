From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Wed, 08 Dec 2010 21:22:12 -0800
Message-ID: <7v62v3ikqj.fsf@alter.siamese.dyndns.org>
References: <201011041721.53371.jnareb@gmail.com>
 <4D00316F.9000305@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 06:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQYyp-0005I0-25
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 06:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab0LIFW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 00:22:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0LIFWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 00:22:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D769920D5;
	Thu,  9 Dec 2010 00:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqDYNs70d32a2U/lIacMunX6yvM=; b=oIj9w0
	ajePtACC7kkUjzRysufn8q4+6QqwHUu0/SIj7wzMxkH9WbRaaDDpjcqRNz2J91F4
	Kr4Pyd+x3ga9TrsGP9rTEyu6c/ZxCaBmfKYTESji5iWtUK4+1P5P5hkqdS2aYTH9
	+dnLJ122mCOgC1xhcYszpvZP5QT7uT7SMEA3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DVi+ZhZDqPnWIkN82VN7H02h8YbcW/xW
	M3Xr6vUyIJe3m+EEgOuEJpNuF/jqPQn8WuTLe/PvSDrB37r8geGR0kb7WAw3c5ya
	4UbrvgsY9Nio6nw1C7Gbcaun8Vio+/EGHxbbmPPzZKOpuIXpJun7amhSthjyDYi3
	WjsG/GzjrA4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 780E220D0;
	Thu,  9 Dec 2010 00:23:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58C0520CA; Thu,  9 Dec 2010
 00:22:37 -0500 (EST)
In-Reply-To: <4D00316F.9000305@eaglescrag.net> (J. H.'s message of "Wed\, 08
 Dec 2010 17\:31\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A2C1066-0354-11E0-9C39-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163263>

"J.H." <warthog9@eaglescrag.net> writes:

> P.S. Most of this e-mail was written a couple of weeks ago, I found it
> in my drafts folder and wanted to get it out along with a note that I've
> got v8 percolating. -JH

Thanks.  Is "Tomorrow morning" relative to "a couple of weeks ago"? ;-)
