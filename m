From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/2] notes-merge: Don't remove .git/NOTES_MERGE_WORKTREE;
 it may be the user's cwd
Date: Thu, 15 Mar 2012 09:12:42 +0100
Message-ID: <4F61A47A.2050205@viscovery.net>
References: <7vlin3qdpt.fsf@alter.siamese.dyndns.org> <1331769333-13890-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	david@tethera.net, pclouds@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85nv-000289-Gf
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab2COIMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:12:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36689 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759439Ab2COIMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:12:49 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S85nf-0005Ep-9Y; Thu, 15 Mar 2012 09:12:43 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CE3B11660F;
	Thu, 15 Mar 2012 09:12:42 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331769333-13890-1-git-send-email-johan@herland.net>
X-Enigmail-Version: 1.3.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193198>

Am 3/15/2012 0:55, schrieb Johan Herland:
> When a manual notes merge is committed or aborted, we need to remove the
> temporary worktree at .git/NOTES_MERGE_WORKTREE. However, removing the
> entire directory is not good if the user ran the 'git notes merge
> --commit/--abort' from within that directory. On Windows, the directory
> removal would simply fail, while on POSIX systems, users would suddenly
> find themselves in an invalid current directory.
> 
> Therefore, instead of deleting the entire directory, we delete everything
> _within_ the directory, and leave the (empty) directory in place.

Just a data point: With this patch, the test passes on Windows.

-- Hannes
