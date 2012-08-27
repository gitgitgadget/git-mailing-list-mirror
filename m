From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout -t -B
Date: Mon, 27 Aug 2012 16:22:49 -0700
Message-ID: <7vsjb7q5rq.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
 <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
 <10B409063A944B298250064D2DB0BAB7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68e4-0004VW-0r
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab2H0XWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab2H0XWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:22:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB389403;
	Mon, 27 Aug 2012 19:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fu0jjUIteNagwlUNb8lDrYlc1QY=; b=MbhIn1
	l9RqfijKLa2zrE/1qGXy2GhfNswEW5LBgqkf9s5SHKbjclNe+HPb3nw2xTu8bc4R
	BfJe6bOCRIZoInqScwUzW/vegkH5F0/NHubzB7JN2gTAjpWt1JvyaWYx46BvuspO
	sEpqeAANikYsyPXb2narq1HwOXBhA1+AfygsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pllknyfFntdLzannQgznk/H91w053YPQ
	77LLWVscIdLB7Z1ZRqkHYjFpuIhk33xH9vgJg2TyxdWfw4ETQI54Jft47IKoBlPl
	W9iX5IAHb1oQ65RfW0rGkb9w654F9MI87pzvsNQF/Ao044Onxnn3KpnOiIowvS7i
	qlqrSUlDUuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ABA69402;
	Mon, 27 Aug 2012 19:22:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAEBF93FF; Mon, 27 Aug 2012
 19:22:50 -0400 (EDT)
In-Reply-To: <10B409063A944B298250064D2DB0BAB7@PhilipOakley> (Philip Oakley's
 message of "Tue, 28 Aug 2012 00:09:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EB35692-F09E-11E1-9B57-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204392>

"Philip Oakley" <philipoakley@iee.org> writes:

> I searched for all occurrences of '[[' which would indicate a double 
> optional argument within the synopsis and only found git-read-tree.

Double-optional?  That is not an issue.

If an option always takes a parameter, we would have

	git cmd [--option parameter]

instead of one of

	git cmd [--option]
	git cmd [--option] parameter
	git cmd [--option] parameter...

and if we had

	--option::
        	This option distims the parameter ...

that needs to be updated to

	--option parameter::
        	This option distims the parameter ...
