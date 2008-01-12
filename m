From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 16:22:23 -0800
Message-ID: <7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:23:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDU9K-0002CF-Rf
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760914AbYALAWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760225AbYALAWb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:22:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbYALAWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:22:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1026C357B;
	Fri, 11 Jan 2008 19:22:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF74357A;
	Fri, 11 Jan 2008 19:22:25 -0500 (EST)
In-Reply-To: <9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	(Stephen Sinclair's message of "Fri, 11 Jan 2008 19:09:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70232>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

>> I'd almost agree with this patch if if added AUTHOR but not
>> COMMITTER, and only when AUTHOR is different from me.  That
>> would help reassure anybody while amending other's changes.
>> COMMITTER is always me and I should not reminded with extra
>> lines that waste precious screen real estate.
>
> The purpose of my patch was to remind _myself_ what my name is, in
> case I hadn't configured it correctly.

In that case, I would imagine a rule like this would be more
appropriate than unconditionally showing AUTHOR/COMMITTER in all
cases:

 * If AUTHOR_NAME+EMAIL is different from AUTHOR_NAME+EMAIL that
   I would normally get for myself, or

 * If AUTHOR_NAME+EMAIL contains garbage identifier commonly
   found when misconfigured (e.g. ".(none)" at the end of
   e-mail),

then show AUTHOR.  In addition, if it is the latter case, give
hints to configure before casting the mistake in stone.
