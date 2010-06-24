From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rev-parse.txt: Document ":path" specifier
Date: Thu, 24 Jun 2010 13:47:46 -0700
Message-ID: <7vvd98b1jh.fsf@alter.siamese.dyndns.org>
References: <4C2355EF.7030604@drmicha.warpmail.net>
 <2f6ddf1fa551acf6074140865fbc2940ab45ed83.1277384506.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtL7-0002sP-QI
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab0FXUr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:47:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0FXUr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14096BEFFF;
	Thu, 24 Jun 2010 16:47:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcmf0JM5GFse2JeqSTO8NkqAz4g=; b=OnmkVg
	jXsz2qu2yBK7KkN2rtzp3t5CnwnNX0Q9GDDtlvMKHHnaPqiV6v7clpWsmeLiDPXd
	OMDExvyuciUY6O+u1cgVI+mzErFmFl1smazJxvdNUOySN+XAMc+zNHa0XEK2koma
	yUSmLov9urwpPI+sV6SvJ0m0OMetAJrNRY+O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JCdFrwiz3u9c2/NtdcKbpQXWwvUVOAcm
	2srIWa3vXxv0cwQUASCAvw9Gq6FYeWIyjmWrx7y4uvK2jw8M769itBsulCh4AD3l
	CQi4UKXAhRnc/nd/RoKJLJ1wnzqrPJtiM6+fODlTQnQH2PAzqgQR+F3iljhCz5px
	yG4G5yp9pPY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D57DABEFFE;
	Thu, 24 Jun 2010 16:47:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FEC8BEFFD; Thu, 24 Jun
 2010 16:47:47 -0400 (EDT)
In-Reply-To: <2f6ddf1fa551acf6074140865fbc2940ab45ed83.1277384506.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 24 Jun 2010 15\:02\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1AA70DC-7FD1-11DF-B257-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149646>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The empty treeish in ":path" means "index", not "HEAD" like in probably
> every other place.

I would suggest dropping the ', not "HEAD"... place.' part from the above.
It is more confusing than useful to the readers.  

E.g. "git diff <treeish>" compares with the named tree-ish, but "git diff"
compares with the index, even though the latter obviously lacks <treeish>
and does not default to HEAD.

The rule is more like "the index is used by default for missing value, but
with an operation that does not make sense with the index, it defaults to
the HEAD", I think.
