From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/33] peel_object(): give more specific information in
 return value
Date: Mon, 15 Apr 2013 10:38:20 -0700
Message-ID: <7vhaj7wv77.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnMJ-0003Ij-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab3DORiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:38:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756286Ab3DORiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:38:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DEEC15BEA;
	Mon, 15 Apr 2013 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=yMG54XrhbIPZku1l/9//Te5RDEE=; b=fxeN+L6rxqi/2MNF55j0
	yobAmZKb0clgQU//DCRqGvv3wlm8OeltjDZzPPs+L2rIDiNhK2dAVkutVX/JhUbW
	IAOiIr5DfH7rrnMSCxB0bUdENQaCKnLsRLNdgWONzIYs4PFHnNonJZBgAhnZNMsL
	6gDxoGRWDOfR+DoORLVKDeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rzXGqlpe/Q4OjH96tHcXK0CLaYF0rW+kDwMtzO7LNJ1Ab+
	WkumuBpeZna1iGHIn1klkEdOTpWMV9by6qEPNoG4MV9lMGZvdFM4rR9VsCg9L/c1
	58/ChEENcvH3E4nQPZjS3xXWVOOTMuKRx3sE5SCSDe3SojMrTOWTnADbBQD58=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2390E15BE9;
	Mon, 15 Apr 2013 17:38:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 977DF15BE6; Mon, 15 Apr
 2013 17:38:21 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4450CBB8-A5F3-11E2-8D5E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221260>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Instead of just returning a success/failure bit, return an enumeration
> value that explains the reason for any failure.  This will come in
> handy shortly.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

This is a valid rewrite because all existing callers check if the
return value is 0 and does not check the error code against -1.

Looking good so far.
