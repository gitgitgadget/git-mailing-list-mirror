From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch and -t
Date: Mon, 11 Feb 2013 18:24:33 -0800
Message-ID: <7v621yjmla.fsf@alter.siamese.dyndns.org>
References: <4B2793BF110AAB47AB0EE7B9089703854FEE40B6@fmsmsx110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen\, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 03:25:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U55YM-0000pj-VN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 03:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab3BLCYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 21:24:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab3BLCYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 21:24:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13693C139;
	Mon, 11 Feb 2013 21:24:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IwIrTCquRcd82JMFgxpGvtBqBT8=; b=M0I4QW
	gl97FGlkCpC8+aVi/46O1zbYoLIl5v2AUyAO5eYzlyAYWhGdQD8akU4aDfvO9hIJ
	5B3D1IJcMGmzYPhNm1JeCu5y88RzvDZDNyJZklc8ELAe0VDzBYcS1gefP0p5EJhH
	+T0BqclKq4NRuIaHz2cicMJLDyP+XYsd1Mjlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJRHQGURcdbRXww/DhnchUGhCieAdk/p
	/goPK2l+m4trCZWR5oF9Xj+a1QAUC1umTS0jDMMs1O+oOexeYfcqzkVeoUfsi1A2
	V0SxMpN9uhbVpye3ThFQY8OnBxlCf/rYQTYMErZIHeKU6g1KZbRoMM0/VJsGgXHw
	APruV3CA1fg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08788C138;
	Mon, 11 Feb 2013 21:24:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C92DC136; Mon, 11 Feb 2013
 21:24:35 -0500 (EST)
In-Reply-To: <4B2793BF110AAB47AB0EE7B9089703854FEE40B6@fmsmsx110.amr.corp.intel.com> (Alan
 R. Olsen's message of "Tue, 12 Feb 2013 00:41:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57CB2710-74BB-11E2-9209-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216111>

"Olsen, Alan R" <alan.r.olsen@intel.com> writes:

> I have found that if I add a remote and do a "git fetch -t -f
> remote_name" that it *only* pulls tags.
>
> Reading the man page it seems like it should pull all the remotes
> and all the tags and the commits only reachable by tags.

This is what appears in the documentation we ship these days.

    -t::
    --tags::
            This is a short-hand for giving "refs/tags/*:refs/tags/*"
            refspec from the command line, to ask all tags to be fetched
            and stored locally.  Because this acts as an explicit
            refspec, the default refspecs (configured with the
            remote.$name.fetch variable) are overridden and not used.

http://git-htmldocs.googlecode.com/git/git-fetch.html

Previous discussion:

    http://thread.gmane.org/gmane.comp.version-control.git/180636

A more recent one:

    http://thread.gmane.org/gmane.comp.version-control.git/211439/focus=211464
