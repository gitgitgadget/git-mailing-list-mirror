From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase -i: Teach "--edit-todo" action
Date: Mon, 17 Sep 2012 23:56:54 -0700
Message-ID: <7va9wnq0nd.fsf@alter.siamese.dyndns.org>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
 <1347739709-15289-3-git-send-email-andrew.kw.w@gmail.com>
 <7v1ui2zccc.fsf@alter.siamese.dyndns.org> <5055F51B.9070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrk4-0000JR-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab2IRG46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:56:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755594Ab2IRG44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:56:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79B47435F;
	Tue, 18 Sep 2012 02:56:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ufXqWzypQ1qS9+7CgoLw5AXWu64=; b=DgLlwm
	nBZaTqM7xdEvuMufYadpGHSPw0TrwN/eSgHoenmhEnRkFiDQPCtzUb874lQH9/aE
	iyXZyQ2t5oXX93TCnIJfkSaKvyvLr5H5/2dlFBuhPQ4lgOJ5XRJSlqivwr51qyKl
	3O2P8yxv50BmdrXBm/z+mlns0poYBIrsZXgNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qq43LR79hGdjzSWbXDU8n92KslEjoIor
	N022F15bZDYZPcuvtZa8vttCUcYh3p6/SsY2pHFRnERhKCRVcL+1pNA4Js7LYsw7
	8qbIk2cpSjeevfi4LNAjr587022R9kgvYGGuTdc7Ll7mafRHwsZ6uA05m0i0XNIZ
	++WmZ/mh8BE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663C6435E;
	Tue, 18 Sep 2012 02:56:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6833435D; Tue, 18 Sep 2012
 02:56:55 -0400 (EDT)
In-Reply-To: <5055F51B.9070601@gmail.com> (Andrew Wong's message of "Sun, 16
 Sep 2012 11:49:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08B04E60-015E-11E2-B4F4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205801>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On 09/16/12 02:54, Junio C Hamano wrote:
>> In any case, what information are you discarding and then replacing
>> with the standard boilerplate?
> It's to strip out the comment that says:
>
>     # However, if you remove everything, the rebase will be aborted.
>
> As there's no way reliable way to know where that line is and remove it,
> the only way I can think of is to remove all the comments, and append
> the help messages again.

I see.  As long as you know that the other things you are removing
with the code is irrelevant and giving the standard boilerplate is
sufficient, your approach is the simplest way to reliably get what
you want.

Thanks.
