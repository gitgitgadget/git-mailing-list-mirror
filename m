From: "Yann Dirson" <ydirson@linagora.com>
Subject: Re: "git svn reset" only resets current branch ?
Date: Wed, 8 Jul 2009 17:41:01 +0200 (CEST)
Message-ID: <50232.10.0.0.1.1247067661.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Ben Jackson" <ben@ben.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 17:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOZGP-0003ML-MB
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 17:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbZGHPkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 11:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbZGHPkq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 11:40:46 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:46139 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbZGHPkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 11:40:45 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id B03EE429F01;
	Wed,  8 Jul 2009 17:40:43 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 82.127.2.119)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Wed, 8 Jul 2009 17:41:01 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122901>

> On Tue, Jul 07, 2009 at 10:01:08AM +0200, Yann Dirson wrote:
>>
>> As an alternative, we could also allow "git svn reset" to take us back
>> into the future to undo any such mistake without refetching.
>
> You can't do that directly, since data is destroyed (specifically, the
> rev_map is truncated back to the selected revision).  However, you can
> "git reset" the branch back to where it was using the reflog, and then
> the next git-svn command you run will rebuild the rev_map from the
> comment metadata (obviously you're out of luck if you set "no_metadata").
>
> It's possible that "git-svn reset" should be saving something like
> ORIG_HEAD (comments welcome) but that does conflict with the idea of
> adding "--all" or defaulting to "--all" behavior.

Well, adding --all would probably be better after all.
