From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from
	breaking when CWD is .git
Date: Wed, 11 Feb 2009 10:01:00 -0800
Message-ID: <20090211180100.GJ30949@spearce.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com> <1234366634-17900-2-git-send-email-ted@tedpavlic.com> <1234366634-17900-3-git-send-email-ted@tedpavlic.com> <1234366634-17900-4-git-send-email-ted@tedpavlic.com> <7vprhogbfa.fsf@gitster.siamese.dyndns.org> <499308DA.9090208@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJQ7-0006bg-Dv
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbZBKSBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbZBKSBE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:01:04 -0500
Received: from george.spearce.org ([209.20.77.23]:39270 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbZBKSBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:01:01 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B6E7138210; Wed, 11 Feb 2009 18:01:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <499308DA.9090208@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109459>

Ted Pavlic <ted@tedpavlic.com> wrote:
>
>> You have at least three possible states:
>>   * You are not in git repository at all;
>>   * You are somewhere in $GIT_DIR, perhaps in a bare repository, perhaps a
>>     repository with a work tree.
>>   * You are inside a work tree.
>
> It seems like (psuedocode)...
>
> 	if git rev-parse --is-inside-git-dir; then
> 		use '!' flag to indicate caution
>
> 	elif git rev-parse --is-inside-work-tree; then
> 		proceed as before (with '*' and '+' flags)
>
> 	else
> 		do nothing
>
> I think that handles those cases. No?

Yes, that looks right to me.

-- 
Shawn.
