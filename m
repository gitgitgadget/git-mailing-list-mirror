From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: allow disabling expensive broken symlink checks
Date: Thu, 05 Feb 2009 00:02:40 -0800
Message-ID: <7vljslgvkv.fsf@gitster.siamese.dyndns.org>
References: <200901311414.58205.markus.heidelberg@web.de>
 <20090201021844.GB18855@dcvr.yhbt.net>
 <7vbptlo7zg.fsf@gitster.siamese.dyndns.org>
 <20090203044549.GA2483@dcvr.yhbt.net>
 <7v4ozcdnbt.fsf@gitster.siamese.dyndns.org>
 <20090203191021.GB2077@dcvr.yhbt.net> <20090205074215.GA24887@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzDb-0000jI-Am
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbZBEICs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbZBEICs
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:02:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbZBEICs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:02:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B0B892A780;
	Thu,  5 Feb 2009 03:02:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D6EDB2A77E; Thu, 
 5 Feb 2009 03:02:41 -0500 (EST)
In-Reply-To: <20090205074215.GA24887@dcvr.yhbt.net> (Eric Wong's message of
 "Wed, 4 Feb 2009 23:42:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5FE01EFA-F35B-11DD-B2AE-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108521>

Eric Wong <normalperson@yhbt.net> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>
>> > > Previously, git-svn would just stop importing and refuse to continue.
>> > > So allowing the user to enable it would be a problem; too.  I don't
>> > > recall the error being easy to distinguish from other errors.
>
> Actually I was wrong on git-svn refusing to continue.  git-svn will
> create a regular 100644 file with "link path/to/dest" as its contents.
> git-svn only croaks on checksum differences with the blob itself; it
> does not have an easy way to verify the mode change => 120000 if it
> happened previously.

Thanks for being thorough.
