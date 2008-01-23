From: Sam Vilain <sam@vilain.net>
Subject: Re: Be more careful about updating refs
Date: Thu, 24 Jan 2008 11:53:05 +1300
Message-ID: <4797C551.8020909@vilain.net>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 23:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHoTp-00005v-9H
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 23:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYAWWxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 17:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYAWWxV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 17:53:21 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60131 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYAWWxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 17:53:20 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 44C2B21D113; Thu, 24 Jan 2008 11:53:11 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id BC85821D108;
	Thu, 24 Jan 2008 11:53:05 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71574>

Linus Torvalds wrote:
> Perhaps more importantly, it also refuses to update a branch head with a 
> non-commit object. I don't quite know *how* the stable series maintainers 
> were able to corrupt their repository to have a HEAD that pointed to a tag 
> rather than a commit object, but they did. Which results in a totally 
> broken repository that cannot be cloned or committed on.

I actually used this for a prototype system to allow push over git://
with secure authentication via PGP; basically it used an update hook
that disallowed any ref change that wasn't a signed tag, and then in the
post-update hook, moved the tag to an audit log refspace and put the
referant commit in the refs/heads/* location.

The hooks (probably racy etc) can be seen under
http://git.utsl.gen.nz/Tangram/hooks

Sam.
