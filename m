From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Wed, 02 Apr 2008 12:10:28 +1300
Message-ID: <47F2C0E4.10506@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>	 <47EECF1F.60908@vilain.net> <32541b130803301600g5005876enf0fbcfe03e660fc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 01:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgpdN-0000n2-DE
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 01:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbYDAXKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 19:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbYDAXKe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 19:10:34 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35359 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbYDAXKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 19:10:34 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id C1E4821C995; Wed,  2 Apr 2008 12:10:32 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 3E25721C98F;
	Wed,  2 Apr 2008 12:10:28 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <32541b130803301600g5005876enf0fbcfe03e660fc8@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78668>

Avery Pennarun wrote:
>>  Well, that would create a lot of unnecessary work when cloning.
>>  Partitioning by project is a natural way to divide the projects up.
> 
> What unnecessary work do you mean?

A full clone takes a few shortcuts, especially over dumb transports like
HTTP.  I think there might be shortcuts in the git-daemon code as well.
 Forcing these to be partial might make these full fetches involve more
time.

>>  However, what you are suggesting should IMHO be allowed to work.  In
>>  particular, if the submodule path is ".", then I think there's a good
>>  case that they should come from within the same project.  If it's a
>>  relative URL, it should initialize based on the remote URL that was used
>>  for the original fetch (or, rather, the remote URL for the current branch).
> I agree, there's no reason to take away the existing functionality of
> allowing split repos.  I was more suggesting a new functionality so
> that splitting isn't *required*.

Yes - I look forward to a patch.

>>  This push failure thing is regrettable; however it's not clear which
>>  branch name the submodules should get.  A given commit might exist on
>>  several branches, which one do you choose to name it?
> One option is to make a simple "git push origin" operation fail if
> you're not on any branch; iirc, if you try that now, it just silently
> *succeeds* without uploading anything at all, which is one reason I so
> frequently screw it up.

Sounds workable.

> Alternatively, is there a reason I can't
> upload an object *without* giving it a branch name?  I guess that
> would cause problems with garbage collection.

You've answered your own question there.

>>  There is also a Google Summer of Code project for this - see
>>  http://git.or.cz/gitwiki/SoC2008Ideas#head-9215572f23513542a23d3555aa72775bc4b91038
> 
> ok.  I was hoping it wouldn't be so hard as to require an entire SoC
> project, since using --alternate when checking out the child repo
> shouldn't be too hard.

If you think it is simpler, then I'm sure that submodules users would
appreciate you sharing your ideas as a patch.  Sorry if I am starting to
sound like a parrot ;-).

Sam.
