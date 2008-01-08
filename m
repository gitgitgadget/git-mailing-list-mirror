From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd number of elements in anonymous hash
Date: Tue, 08 Jan 2008 09:21:55 -0800
Message-ID: <7vbq7wteq4.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCI9q-000158-KJ
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbYAHRWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbYAHRWF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:22:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYAHRWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 12:22:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F55A1519;
	Tue,  8 Jan 2008 12:22:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DD65B1515;
	Tue,  8 Jan 2008 12:21:57 -0500 (EST)
In-Reply-To: <200801081738.56624.devurandom@gmx.net> (Dennis Schridde's
	message of "Tue, 8 Jan 2008 17:38:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69894>

Dennis Schridde <devurandom@gmx.net> writes:

> Hello!
>
> I am getting "Odd number of elements in anonymous hash at /usr/bin/git-svn 
> line 1760." (normal output, no warning/error) during git-svn-clone.
> I am using git version 1.5.4.rc2.
>
> Line 1760 is this (with context, marked with '!!'):
>     # see if we have it in our config, first:
>     eval {
>         my $section = "svn-remote.$self->{repo_id}";
> !!        $svnsync = {
>           url => tmp_config('--get', "$section.svnsync-url"),
>           uuid => tmp_config('--get', "$section.svnsync-uuid"),
>         }
>     };
>
> The commandline was "git svn 
> clone --authors-file=/var/git/org.gna.warzone.git/authors --use-svnsync-props --stdlayout 
> file:///var/svn/warzone2100/ org.gna.warzone.git/"
>
> I assume this is some kind of bug?

More than one svn-remote.$your_repo.svnsync-{url,uuid}?

(Eric CC'ed).
