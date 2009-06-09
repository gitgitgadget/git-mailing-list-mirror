From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] builtin-remote: Make "remote -v" display push urls
Date: Tue, 09 Jun 2009 11:30:27 -0700
Message-ID: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
	<1244563298-15479-6-git-send-email-git@drmicha.warpmail.net>
	<7vvdn5nzmb.fsf@alter.siamese.dyndns.org>
	<4A2EA04D.9080405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME65j-00067S-NS
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbZFISa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZFISaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:30:25 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36045 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZFISaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:30:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609183027.GRQQ17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jun 2009 14:30:27 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1uWT1c0054aMwMQ04uWTgV; Tue, 09 Jun 2009 14:30:27 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=sIeVhkn_z2MA:10 a=JRC6Y12iPbEA:10
 a=cCri8_SAAAAA:8 a=VwQbUJbxAAAA:8 a=jfONHrilub25-ceZ-wIA:9
 a=GIDhJDh6j1OdTu4D9ttddSRHTHcA:4
X-CM-Score: 0.00
In-Reply-To: <4A2EA04D.9080405@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\, 09 Jun 2009 19\:47\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121199>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 09.06.2009 18:25:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> Example with "mjg" having 1 url and 1 pushurl, "origin" having 3 urls,
>>> sb having 1 url:
>>>
>>> mjg     git://repo.or.cz/git/mjg.git (fetch)
>>> mjg     repoor:/srv/git/git/mjg.git (push)
>>> origin  git://repo.or.cz/git.git (fetch)
>>> origin  git://repo.or.cz/git.git (push)
>>> origin  git://git2.kernel.org/pub/scm/git/git.git (push)
>>> origin  git://repo.or.cz/alt-git.git (push)
>>> sb      git://repo.or.cz/git/sbeyer.git (fetch)
>>> sb      git://repo.or.cz/git/sbeyer.git (push)
>> 
>> The readers will get distracted, saying "eh, git:// can be used for push?"
>> (and the answer is "yes, sometimes, but not for repo.or.cz") even though
>> that is not the point of these illustrations.  For these examles, I think
>> it is better to use "repo.or.cz:foo.git" style, instead of "git://".
>
> Uhm, isn't host:foo.git equivalent to ssh://host/foo.git?

The primary point is git:// is usually considered read-only and not for
push.  I personally am more used to host:repo and that is why I wrote it
that way; besides, the second line in your example already uses that
notation, not the ssh:// one.
