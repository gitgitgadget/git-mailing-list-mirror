From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Wed, 13 Aug 2008 09:40:38 -0700
Message-ID: <20080813164038.GE3782@spearce.org>
References: <20080813162644.GC12200@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJPx-00026P-0D
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYHMQkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYHMQkj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:40:39 -0400
Received: from george.spearce.org ([209.20.77.23]:56703 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYHMQkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:40:39 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8206D38375; Wed, 13 Aug 2008 16:40:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080813162644.GC12200@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92241>

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> What are the opinions on adding a basic challenge-response type
> authentication mechanism to the native git protocol?
> I.e. the authentication would be a simple one, which uses
> SHA1 (surprise ;-) to actually encrypt username/password/salt
> and authenticate the user.
> 
> I'm willing to do the work, if there are no objections.

Last time we talked about this we got off onto some tagent about
using GnuPG public keys to authenticate users, and then how we might
store the public keys in a keyring and log pushes (changes to refs)
so that one could replicate the log on another server and come up
with the same result.  Hence not just the current source code but
also the "how we got here" could be verified externally.

Username/password management is always ugly.  Some admins will want
you to plug into PAM, others just want a flat file that is unique
to the service, others want LDAP.  And then you get into people
wanting Kerberos support because they already have everything else
in their domain supporting it.  Tons of complexity for our project.

Isn't there some authentication frontend that some IMAP servers
use to handle the authentication for them?  I think last time
I setup bincimap it used checkpassword.  We might want to do the
same if we are going down this road...

-- 
Shawn.
