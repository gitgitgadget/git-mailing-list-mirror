From: layer <layer@known.net>
Subject: Re: post-checkout hook not run on clone
Date: Mon, 02 Mar 2009 21:02:29 -0800
Message-ID: <23978.1236056549@relay.known.net>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMpH-0006Wa-Hp
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbZCCFCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbZCCFCb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:02:31 -0500
Received: from relay.known.net ([67.121.255.169]:35153 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750747AbZCCFCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:02:31 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000027480; Mon, 2 Mar 2009 21:02:29 -0800
In-reply-to: <20090303042848.GC18136@coredump.intra.peff.net>
Comments: In-reply-to Jeff King <peff@peff.net>
   message dated "Mon, 02 Mar 2009 23:28:49 -0500."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111996>

Jeff King <peff@peff.net> wrote:

>> On Mon, Mar 02, 2009 at 02:43:37PM -0800, layer wrote:
>> 
>> > I realize this might be a feature, but when I switch to the master
>> > branch with "git checkout master" it is, and I would think that a
>> > clone that gets the master branch would also does a sort of "checkout
>> > master" and would run the hook.
>> 
>> Right. Hooks are not cloned with the repo.

The hook in question was in /usr/share/git-core/templates/hooks/, so
it would get setup on clone.  That works fine.  If I immediately
switch branches, the hook gets called.  It's just the `post-clone'
(when I assume something like `checkout' is done), the hook doesn't
get called.

>> The general wisdom on the list is that it's a bad idea to run remote
>> code arbitrarily for security reasons...

I agree, but not in this specific situation.  All the users of the
code are trusted, as is the author of the hooks.
