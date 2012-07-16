From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 10:47:52 -0700
Message-ID: <7vtxx738dz.fsf@alter.siamese.dyndns.org>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 <vpqhat7wujb.fsf@bauges.imag.fr> <500445CC.2020404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:48:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqpOr-00045F-W7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab2GPRr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:47:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab2GPRrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:47:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B76D82C1;
	Mon, 16 Jul 2012 13:47:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a5Of3lmyBk5HjG8wt0eSe93j2Ng=; b=VMXkDG
	IgP0Qtrv0vtU7pqBMgH0fOEkUb3i7T5VyCTpl1CYmGscrWNujnFsKNG6mbUKxF1k
	TR0v4m7+/UHLz25SrWS3RGUzfi4FKnTtPxfflT7mp8NbjSsRlzk990w9w64BbzLb
	8/p8ajSVMeCqasp2/sLCrYeZ+aPuMGvU7hLR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g3dPNHI9Q0eN1lgB36nxGdG3G2Jb4SZC
	qjDq1NGTBTlG36sLPb+GAMFyuNV+3Pd2Fp48HrrF1N/DPNC35o8FvijtsUBxFNXb
	AkMGUa6lTqxw0mlMzcRUBkfuWmcjl+IIZI0FNDBWPWBH5rA/mi4dQ6/yqiPrAydm
	xHJXx+3quwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5849C82C0;
	Mon, 16 Jul 2012 13:47:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD5AC82BF; Mon, 16 Jul 2012
 13:47:53 -0400 (EDT)
In-Reply-To: <500445CC.2020404@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 16 Jul 2012 18:48:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E9CA21E-CF6E-11E1-A11A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201536>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It's already supported:
>
>     git config hooks.announcelist \
>         "nosy@example.com, overwhelmed@example.com, phb@example.com"
>     git config hooks.refchangelist \
>         "nosy@example.com, overwhelmed@example.com"
>     git config hooks.commitlist "nosy@example.com"

Sad.  Is the "post-recieve email" squatting on the _whole_ hooks.*
namespace, not postreceiveemailhook.* or something more reasonably
limited?
