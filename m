From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line
 termination mode
Date: Mon, 30 Apr 2012 17:43:59 -0700
Message-ID: <7v62cgenn4.fsf@alter.siamese.dyndns.org>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <1335817705-24718-1-git-send-email-jk@jk.gs>
 <7vd36oesjr.fsf@alter.siamese.dyndns.org> <m2ehr4sq1q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 01 02:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP1Cx-000465-1v
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 02:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab2EAAoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 20:44:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757281Ab2EAAoE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 20:44:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09331760D;
	Mon, 30 Apr 2012 20:44:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HWXrjKi8hFy0hGuO/au8GD3t5D8=; b=fq8+UI
	ttmzuz3Eq1577SPn+1cEvIEz1MR/UrFsec6AngcaRqy8VCWy8pqJL2w/1jjJbXIi
	qWYc6b7vCnheh0h7zGpt0m9Z2h6nfSNSemeL56yHZepGezV7SfIJgrvBqKWbqy/M
	wYH0+kE3SHSfPhQ4XxUOl0D78dMLmMgZMkZCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JT+o3bIR7GDKrlKIDkTJwzeYPxIHdxQK
	+PU9wAdI4+V3cGkaZxRzZS/OXGmrev/2pBVLg+0/L/1ELUnfWaCVj/Xd0qE6J/n0
	svMfUGeYoyNAwU0L4AvySKcz+anvKZ5Ge2B6Xs32m8cbzTEZQNF9PsIoyTA3b8or
	ORWsMeyvWvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B52760C;
	Mon, 30 Apr 2012 20:44:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411F3760B; Mon, 30 Apr 2012
 20:44:02 -0400 (EDT)
In-Reply-To: <m2ehr4sq1q.fsf@igel.home> (Andreas Schwab's message of "Tue, 01
 May 2012 02:28:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF25B0BE-9326-11E1-9BEF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196639>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Having said that, are we sure that
>>
>> 	printf "add bar\0initial"
>>
>> works per specification, or merely works by accident in some
>> implementation?
>
> Since the backslash is not followed by $ ` " \ <newline> it is not
> special to the shell.

Yeah, but I wasn't worried about what shell does in the first place. I was
worried about what printf(1) does.
