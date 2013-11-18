From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc2
Date: Mon, 18 Nov 2013 10:49:40 -0800
Message-ID: <xmqqiovpbl4r.fsf@gitster.dls.corp.google.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
	<5284FE88.8040208@xiplink.com>
	<xmqqvbzpbq4d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 19:49:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViTtP-0007Fs-KF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 19:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256Ab3KRSts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 13:49:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab3KRStn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 13:49:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2340D519C3;
	Mon, 18 Nov 2013 13:49:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qRabvd4nLGYiIXkSkdeCs5+QJLg=; b=xFzDkq
	nrv05c1Oai9RJb1BhMWo/S0SR/UHMHF0nZ9068d3G3cqiHX8mXkgX1UhJHk5mPg2
	MvPdR3sl8SHZIMMOhhapY383SxaLAAj3Tpml70ZWAdKRd6ok14CMWT1UKHqZA0M3
	0rL/zNQk4PNrvZIecSdVGZ7RWpHwGnP30QgFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKSOmLoIpZt863kXKSn3VOa4vMdS8rX7
	4HkiopeSoefAiv2F8sF7eDIyLjCoe2KYSPsWRuxOacF50CL1bCWqkkQa49FSAI9k
	dEcgVVszak6TdH8XroeLvxpWLaTGxt/pOOPSr7bkja82/XaQ7mnrPnnnEdYboxRT
	YuLGuKR7i4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14CC7519C1;
	Mon, 18 Nov 2013 13:49:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6604A519BF;
	Mon, 18 Nov 2013 13:49:42 -0500 (EST)
In-Reply-To: <xmqqvbzpbq4d.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Nov 2013 09:01:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F820488-5082-11E3-8A97-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238007>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>>> Foreign interfaces, subsystems and ports.
>>> 
>>>  * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>>>    dumped core due to a bug in the serf library that SVN uses.  Work
>>>    it around on our side, even though the SVN side is being fixed.
>>>  ...
>>>  * Subversion 1.8.0 that was recently released breaks older subversion
>>>    clients coming over http/https in various ways.
>>
>> Isn't this the same as the serf fixes ([1],[2])?  If not, what git change is
>> it referring to?
>
> The latter, I think, is 8ac251b6 (git-svn: allow git-svn fetching to
> work using serf, 2013-07-06).  Without it we won't even work with
> newer SVN library.
>
> The former I think refers to 73ffac3b (git-svn: fix termination
> issues for remote svn connections, 2013-09-03).  Even with the serf
> support, without a work-around, we won't work with serf.
>
> The description can and should be rolled into one, but I am not sure
> what the best wording would be.
>
> Thanks.

I'd keep them as separate entries, like so:

 * "git-svn" has been taught to use the serf library, which is the
   only option SVN 1.8.0 offers us when talking the HTTP protocol.

 * "git-svn" talking over https:// connection using the serf library
   dumped core due to a bug in the serf library that SVN uses.  Work
   around it on our side, even though the SVN side is being fixed.
