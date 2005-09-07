From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Wed, 07 Sep 2005 12:18:03 -0700
Message-ID: <7vhdcw661g.fsf@assigned-by-dhcp.cox.net>
References: <u5tzmqp8fzx.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 21:20:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED5Qw-0000xs-AJ
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 21:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVIGTSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVIGTSG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 15:18:06 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53502 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751274AbVIGTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 15:18:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907191804.YIGQ7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 15:18:04 -0400
To: David =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFs?= <davidk@lysator.liu.se>
In-Reply-To: <u5tzmqp8fzx.fsf@lysator.liu.se> (David
 =?iso-2022-jp-2?B?SxsuQRtOZWdlZGFsJ3M=?= message of
	"Wed, 07 Sep 2005 10:00:02 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8174>

David K.ANegedal <davidk@lysator.liu.se> writes:

> The authorship info in commits created by git-cvsimport-script
> only contains the username of the CVS committer.  This patch
> adds a flag -e <domain> to git-cvsimport-script that makes it
> possible to specify an email domain that is added to all email
> addresses in the commit "author" and "committer" fields.
>
> ---
> I have stopped using cvsimport, because cvsps seems to produce bad
> output on the repository I'm using it with, but I had already prepared
> this patch.

Hmph.  One reason the original implementation did not do this is
because Linus and other people wanted to have a repeatability,
so making this an optional thing is good, but if we go this
route, I think if it would be nicer to have a --author-map
option that lets you feed a list of:

    <author> ==> "A U Thor <author@author.dom>"

mappings, instead of a single -e, which essentially does not add
much information to the result.

I take that your oob comment indicates that you do not have much
incentive/inclination to further hack on this, so I am not
asking you to do the above even if you find my suggestion
worthwhile.
