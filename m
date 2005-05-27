From: Junio C Hamano <junkio@cox.net>
Subject: Re: resolving merge conflicts?
Date: Thu, 26 May 2005 20:55:17 -0700
Message-ID: <7vekbt2uhm.fsf@assigned-by-dhcp.cox.net>
References: <429698A0.1020008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 05:54:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbVui-0006n7-Sr
	for gcvg-git@gmane.org; Fri, 27 May 2005 05:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVE0DzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 23:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0DzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 23:55:25 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35063 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261429AbVE0DzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 23:55:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527035517.EMLQ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 23:55:17 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <429698A0.1020008@pobox.com> (Jeff Garzik's message of "Thu, 26
 May 2005 23:48:48 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> So is there a doc or something that describes how to resolve merge
JG> conflicts?

JG> Presumably I look at .merge_file_*, and make sure that all necessary
JG> changes make it into the copy of the file in the working
JG> directory... then what?  How to continue the merge?

Then you would copy that .merge_* into the target file, and say

    git-update-cache $that_path

If your merge decision says to remove that file, then making
sure you do not have that file, you say

    git-update-cache --remove $that_path


