From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "Temporary merge branch 2" Conflicts
Date: Fri, 17 Aug 2012 14:10:47 -0700
Message-ID: <7vfw7lteaw.fsf@alter.siamese.dyndns.org>
References: <1972858401.161319.1345211324976.JavaMail.root@genarts.com>
 <732986549.167685.1345236990359.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, newren@gmail.com
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 23:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2Toz-00045C-AG
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 23:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab2HQVKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 17:10:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453Ab2HQVKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 17:10:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB85C8B25;
	Fri, 17 Aug 2012 17:10:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6+APNCEqblBCAWm0pZiH/e8G39Y=; b=DkIFz2
	KefibPsvtLcw7IoFaORUlP1JZZQsO5RgyCXA1CQKUedK833oqEgObfVhPbOCWHVH
	HBVBkkVeCubqHIj+odbxHQCDkHcqXuT4ReVyjJpvjObyg0/9wJ8xOF/efcSyI9qb
	goLEw/khlzhK7qhyJq/jlRYzRxBy+LOXGBmTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvZ+UF60Zp9wotsm+HP+SWzXhymMP2uo
	pRbj+IYngijoLsw02fZdC/czq6hXDBGpQ+VWqfRwyQFSjYwBw9rbmeX+ksaRrMg0
	OS9kL+7gmM9BcIBg92yHgBJb80VpmQQBH+ET/2B0Av7jBXboAA1e7QfX2OsqoFsu
	SvxJIWhEM9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93908B24;
	Fri, 17 Aug 2012 17:10:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 522A58B23; Fri, 17 Aug 2012
 17:10:49 -0400 (EDT)
In-Reply-To: <732986549.167685.1345236990359.JavaMail.root@genarts.com>
 (Stephen Bash's message of "Fri, 17 Aug 2012 16:56:30 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04FDA13A-E8B0-11E1-AA1E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203666>

Stephen Bash <bash@genarts.com> writes:

> What is the recommended method for resolving this sort of merge?
> kdiff3 obviously doesn't understand the situation.  Do the working
> tree files contain all the conflicts?  If so, I can just go
> through by hand and resolve the conflicts the old fashion way.

Yes.  External tools like kdiff3 may not understand the conflict in
the working tree, but the files in the working tree should have
resolved the naturally resolvable bits and only left the conflicted
bits conflicted.  Just resolve manually if you can, and then look at
what both branches wanted to do to the file ("git log -p --merge
$that_path" before you "git add" as the final sanity check would
work nicely) to make sure your resolution makes sense.
