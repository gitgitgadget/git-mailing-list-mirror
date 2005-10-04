From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 11:53:26 -0700
Message-ID: <7vfyrhcdw9.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<200510031455.30187.Josef.Weidendorfer@gmx.de>
	<7v1x31hlj4.fsf@assigned-by-dhcp.cox.net>
	<200510041108.36202.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 20:56:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMrwH-0001TO-E3
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 20:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVJDSx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVJDSx3
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 14:53:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12231 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964912AbVJDSx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 14:53:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004185319.RTRY29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Oct 2005 14:53:19 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200510041108.36202.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 4 Oct 2005 11:08:35 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9686>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Tuesday 04 October 2005 07:57, Junio C Hamano wrote:
>> I do not understand this comment.
>
> I talk about configuration per remote repository vs. configuration per
> local head, and a consistent user interface regarding these.
>
> Cogito is using configuration per head: If there is a remote fetch mapping,
> this is stored in branches/<headname>. There is no new shortcut to
> remember, because every file in branches corresponds to a local head.

Thanks.  This is "lightbulb" moment for me.  I did not realize
branches/ files are "per head configuration" -- I just thought
they are arbitrary tokens, and by convention it can only slurp
into the branch with the same name as the file.  I even thought
about mentioning the possibility to enhance the current

    url://to/repo#rembranch

to
    url://to/repo#rembranch1:localbranch1,rembranch2:localbranch2,...

but I am glad I didn't -- localbranch cannot be anything other
than the filename because by definition the file is to describe
the local branch of the same name, and describing more than one
localbranch does not make sense.  OTOH,

    url://to/repo#rembranch1,rembranch2,...

may make sense now --- you are telling this local branch pulls
(and makes Octopus) from multiple remote branches.

Anyway, I think I understand what you meant to say now.

> I still think it is wrong to use one head name of a repository as the
> default for the repository's name.

I think this is about branches/ file: "One head name of the
local repository is used as a shorthand to name the remote
repository described by the file, inside the local repository".  
