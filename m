From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Recommended steps for a "subsystem maintainer" ?
Date: Thu, 20 Nov 2008 10:58:42 +0100
Message-ID: <492534D2.7000709@drmicha.warpmail.net>
References: <643392.36561.qm@web37903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Thu Nov 20 11:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L36KQ-0002Mn-QC
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYKTJ6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 04:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYKTJ6r
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 04:58:47 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41116 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788AbYKTJ6q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 04:58:46 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7D2701C4E9F;
	Thu, 20 Nov 2008 04:58:45 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 20 Nov 2008 04:58:45 -0500
X-Sasl-enc: QClEh3yIznmo0XY5Yfc6+SuckKQF6iOdX5p9IeIWkV9r 1227175125
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB3101790F;
	Thu, 20 Nov 2008 04:58:44 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <643392.36561.qm@web37903.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101397>

Gary Yang venit, vidit, dixit 19.11.2008 21:47:
> Hi,
> 
> The
> doc,http://www.kernel.org/pub/software/scm/git/docs/gitcore-tutorial.html
> at "Working with Others" recommended steps for a "subsystem
> maintainer". See below. But, I do not understand the step 3. Copy
> over the packed files from "project lead" public repository to your
> public repository. The step 1 used git-clone. That means, I got the
> code including histories as well. Why do I need step 3 to get the
> packed files?

Step 1 sets up your private development repo. Step 3 talks about your
public repo.

It's recommended you get the original packs because differently abled
protocols like http cannot repack on the fly. That is, if people pull
via http from upstream and your public repo they might have to download
two different packs for (almost) the same objects.

> If I really need the packed files, how do I get it? As
> an example, I need to get the packed files for
> http://git.denx.de/?p=u-boot.git;a=summary . How can I get the files
> something like, pack-d5ef1966072c86ef5108ac57525b802581de5d21.idx and
> pack-d5ef1966072c86ef5108ac57525b802581de5d21.pack ? The snapshot
> dose not have the packed files. They are all text files.

Snapshots are about files, i.e. contents. They've got nothing to do with
packs. May I suggest reading of both parts of the git tutotorial, as
well as the user manual, in order to clarify some concepts? This would
be an ideal first step before thinking about becoming a subsystem
maintainer.

You can get the original upstream packs by copying them (if you have
shell access) or simply by cloning via http. Store them in
.git/objects/pack of your public repo before you push anything into it,
and don't run "repack -adf" there (repack is OK).

Michael
