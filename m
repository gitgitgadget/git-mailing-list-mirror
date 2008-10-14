From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git and tagging hook
Date: Tue, 14 Oct 2008 19:22:27 +0200
Message-ID: <20081014172227.GB6931@efreet.light.src>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se> <1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org> <1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristis Makris <kristis.makris@asu.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:23:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpnch-0005gh-8Y
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 19:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYJNRWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYJNRWn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 13:22:43 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41797 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYJNRWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 13:22:42 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 50179576D7;
	Tue, 14 Oct 2008 19:22:41 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id dojaQMwRXJwP; Tue, 14 Oct 2008 19:22:35 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 627F2576CE;
	Tue, 14 Oct 2008 19:22:34 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KpnbH-00025z-9a; Tue, 14 Oct 2008 19:22:27 +0200
Content-Disposition: inline
In-Reply-To: <48ECF072.3000506@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98203>

On Wed, Oct 08, 2008 at 19:40:02 +0200, Andreas Ericsson wrote:
> Kristis Makris wrote:
>> On Tue, 2008-10-07 at 19:28 +0200, Jakub Narebski wrote:
>>> Kristis Makris wrote:
>>>> I want the integration when I apply the tag to a local repository, NOT
>>>> only when I push/pull.

Care to explain why that would ever be useful? It's local, which means that:
 - the user can take it back without a trace it ever happened (git tag -d or
   even git update-ref -d) and
 - noone except the user will see it anyway, so it's not like they should
   care either.

Besides, you don't need git tag to create a tag in git, so the hook wouldn't
really be guaranteed anyway (I mean, just like the commit hook is not -- you
can still commit by calling write-tree, commit-tree and update-ref and avoid
the hook).

>>> If you are talking about taging locally, you can simply make an alias
>>> or do something after tagging. Search archives for description when
>>> it is worth to add a hook, and when it is not.
>>
>> I am looking for a guarantee that is better than casually saying
>> "simply". I will be providing the integration work to users that may not
>> be as comfortable with making aliases. 
>>
>> I still don't see why a hook on local tagging is not available. Is it
>> possible to add support in Git for such a hook ? Both pre-tag and
>> post-tag.
>
> Because noone's ever needed one before. If aliases can't do what you
> want, write a patch to support it and hope Junio accepts it. It's really
> quite straight-forward. Make sure you read Documentation/SubmittingPatches
> before you send it.
>
> Note though that use of tags on the developer's side will still be up
> to the developer and not something you can force through other means
> than policy or convention.

Being possible was never a reason to add features to git and the less it was
a reason to add hooks. And there does not seem to be a use-case that would
clearly benefit from having such hooks, or at least none was shown on the
list so far.

For integration with issue tracker, the local tag is neither final, nor
useful to anybody except the user who did it until it hits the central
repository. And working on the central repository directly does not seem like
a good idea either.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
