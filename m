From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Feature Request] git export
Date: Tue, 11 Aug 2009 09:50:20 +0200
Message-ID: <4A8122BC.7030009@drmicha.warpmail.net>
References: <200908101822.59940.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Tue Aug 11 14:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqkQ-0004ns-QT
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbZHKMqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754201AbZHKMqW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:46:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58600 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754195AbZHKMqT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:46:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9A92013470;
	Tue, 11 Aug 2009 03:50:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 11 Aug 2009 03:50:36 -0400
X-Sasl-enc: DRM7/mj7hDAeh0xes/SYq2t9vXENqVWjTDzZXO9BzSZJ 1249977036
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 273FD27BE;
	Tue, 11 Aug 2009 03:50:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <200908101822.59940.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125542>

Thomas Koch venit, vidit, dixit 10.08.2009 18:22:
> could you please provide a simple solution to save a tree object into an 
> arbitrary location?
> I found some hints, that it would be possible by missusing either git 
> checkout-index or git-archive, but I think that it shouldn't require that much 
> GIT FU to do such a simple thing.
> 
> Thanks,
> 
> Thomas Koch, http://www.koch.ro

To serve you with an explicit command line, it's really only

git archive HEAD | tar -C wheretoexport/ -xf-

which you need to issue from within your git repo. Instead of HEAD, you
can use any "treeish", for example the name of a branch, which need not
be checked out. You can add path arguments after the treeish if you want
to export only parts of your repo.

Note that in true unix philosophy, git archive does the (git specific)
exporting only and leaves the importing into the file system (saving) to
the proper tool. I mean, would you rather use cp -r or pipes with tar
-x/tar -c or cpio -i/-o in order to copy a tree? ;)

Cheers,
Michael
