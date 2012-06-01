From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting the commit that corresponds to a specific annotated tag
Date: Fri, 01 Jun 2012 15:00:04 -0700
Message-ID: <7vd35i1ymz.fsf@alter.siamese.dyndns.org>
References: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaZtH-00076d-DY
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 00:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907Ab2FAWAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 18:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933280Ab2FAWAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 18:00:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADFFA9239;
	Fri,  1 Jun 2012 18:00:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LqA3/l9D0Soj7tWj8xOyWbnIeQo=; b=Sz+6SQ
	ed0h7xZ6QzFzK0S1fQNRfT61ZZ5Pf5KloKJhdIm5sTLZ1K4wYrtrVx9kgJ2qno+P
	ek5WzEJZxjn6C4PE1edg7RWk8qggpjrHM6qvGsKmfdOnO9oiVOilzh6mRzA567to
	VlRXaCWCa36u4BMy5uLH9CzKbwVjvT0LdmRoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tnqVsSmGUGEsFAYC0TF8eVlgLYKC+jW7
	9MvR1fAVhe2sJnE+WqY5nfj1Qb6ooAp57vjnhrCUGeeKwYZu4Fk757CfbdNy71Iy
	lNwRnarAhZroaNHBX+RDndc2d3CpgBbP2LdGbwr0tEWqlHf5fcar9aZ9W1VzK9NT
	35I/bkjrBYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9680A9238;
	Fri,  1 Jun 2012 18:00:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 094B49233; Fri,  1 Jun 2012
 18:00:05 -0400 (EDT)
In-Reply-To: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com> (Adam
 Mercer's message of "Fri, 1 Jun 2012 16:47:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25842EC2-AC35-11E1-AE1B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199026>

Adam Mercer <ramercer@gmail.com> writes:

> For some porcelain I'm writing I need to determine the commit that
> corresponds to a given annotated tag, so far I have the following:
>
> $ git cat-file tag <tag_name> | grep object | awk '{print $2}'
>
> Is there already some pluming that performs this task?

I think you want

	git rev-parse $tag^{commit}

It's kind of scary, though.
