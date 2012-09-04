From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 01:53:34 -0700
Message-ID: <7v8vcqdv8x.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:54:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8otY-0007ji-8d
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab2IDIxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:53:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab2IDIxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 04:53:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0999B7FA4;
	Tue,  4 Sep 2012 04:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=drcz4lq5a9FroxT3/WFW6B0LsSM=; b=xDF89R
	Us0CaQ7dNOB7CmLSLsXn47wuc1l3cXO+fzGI3OTyozj3/8ovrfjERjSfAxATCA6u
	fSd3gIHS9Ok2mCLcx+tExTWfAAQCZ2ML6J+FeuYWCVu+HN5+pmoOJYPPFvWWYPdm
	tw+YBXMZCZmlJF8MW3E/BiFXLg5kaSoDIvnv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m6zBl+iLP19VTVAu9t02wJsd14IE9tvH
	HtPWOqR96yOqkgHvC70rCdrFgD9Y0hT7EfSkuSbpbZ+//wE2mR/KwaAZVi4RVz4A
	bJrfih7+iC5dwc9p5N0EnEaoDMu53t3V0BOJNt9hBvkQ0XfBq/k617poWOU6D/DV
	3cGx9Xv6ALc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E70B37FA3;
	Tue,  4 Sep 2012 04:53:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61B297FA2; Tue,  4 Sep 2012
 04:53:36 -0400 (EDT)
In-Reply-To: <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com> (Angelo
 Borsotti's message of "Tue, 4 Sep 2012 09:15:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 038AA1EC-F66E-11E1-BAAD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204729>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

>    "It updates the named paths in the working tree from the index file or
>    from a named <tree-ish> ..."

It checks out the contents of the named paths out of either the
index or out of the tree-ish and stores that to a file in the
working tree.  The working tree is not consulted by Git to tell what
paths the user wants to affect at all, but if you pass fileglob,
your shell may consult the working tree to expand it to concrete
pathnames it gives to Git.
