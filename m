From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Mon, 11 Nov 2013 21:41:25 +0100
Message-ID: <528140F5.6090700@web.de>
References: <loom.20131110T222043-57@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ari Pollak <ari@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 21:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyIi-0000pT-UU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab3KKUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:41:33 -0500
Received: from mout.web.de ([212.227.15.3]:55020 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783Ab3KKUlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:41:31 -0500
Received: from [192.168.178.41] ([91.3.132.224]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0M3T1Y-1VORNh0VDU-00qxGP for <git@vger.kernel.org>;
 Mon, 11 Nov 2013 21:41:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <loom.20131110T222043-57@post.gmane.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:uvveGetv9pEie9+FKiANJvADI6IPCR3xRwRbAMJNQskDnf47oU5
 GBwHez1/imi7cfil0jo9O2CFmiBXguWWBY9WP6xqIQyvrhr019zKdzYTKRjvmti2J/BsJyt
 0HkQlWkaJOJwsZ87ZcLPp1KVw48ZUVhUJni4O/XLCzSY03/S5i3OW0n30Pw99YOp/MKpwVy
 oZGYCYn1ykKAewPwltioQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237645>

Hi Ari,

Am 10.11.2013 22:49, schrieb Ari Pollak:
> I'm using git 1.8.4.2, and I've set the "diff.submodule = log" option 
> globally. If I change the revision that a submodule is set to, then run
> "git commit -av", The submodule shortlog is appended to the log message without 
> any #s before it, so the log messages get included in my own log message. 
> This seems like a bug and not a feature, as diffs aren't normally included in 
> the commit message with -v.

Thanks for your report, I can reproduce that here. But first I think
this is unrelated to the "diff.submodule = log" setting, as without it
you'll just see the submodule commit hash diff instead of the shortlog
(which is perfectly consistent with what I'd expect from this setting).
And secondly what you describe looks like documented behavior, the man
page of "git commit" states:

 -v, --verbose
     Show unified diff between the HEAD commit and what would be
     committed at the bottom of the commit message template. Note that
     this diff output doesn't have its lines prefixed with #.

And after adding a modified file the log message also shows the diff of
that file (and without leading "# "s too), so I doubt that diffs aren't
normally included in the commit message with -v. What am I missing?


Thanks
Jens
