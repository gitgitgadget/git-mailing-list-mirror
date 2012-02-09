From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git merge <tag>: Spawning an editor can't be disabled
Date: Thu, 09 Feb 2012 19:50:53 +0100
Message-ID: <4F34158D.3030903@kdbg.org>
References: <20120209153431.GA24033@godiug.sigxcpu.org> <20120209160803.GA5742@burratino> <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Guido_G=FCnthe?= =?ISO-8859-1?Q?r?= 
	<agx@sigxcpu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 19:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZ5B-0003SY-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab2BISu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:50:57 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59680 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758190Ab2BISu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:50:56 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 03BAFA7EB0;
	Thu,  9 Feb 2012 19:51:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B9C0719F641;
	Thu,  9 Feb 2012 19:50:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vzkcrx4f2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190303>

Am 09.02.2012 19:11, schrieb Junio C Hamano:
> If the editor is not spawned, there is no way for the user to review the
> result of signature verification before deciding to accept the merge.
> "git merge --no-edit v1.7.2" could error out saying "you cannot create
> this merge without reviewing".  Or it could behave as if it was asked to
> "git merge --no-edit v1.7.2^0", dropping the signature verification and
> recording part altogether.

It should behave as if the editor was spawned and the user did not
change the content of the commit message.

Use case: First, you merge ordinarily, that is, you review the signature
and the contents, and you are satisfied. Shortly later, you discover
that a fix should be applied before the merge. So you rewind the branch
before the merge, and commit the fix. Now you can repeat the merge with
--no-edit because you have already seen the contents.

Contrived? Dunno.

-- Hannes
