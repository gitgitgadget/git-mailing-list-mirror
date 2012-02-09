From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Silly Question About Timing
Date: Thu, 09 Feb 2012 16:16:49 -0500
Message-ID: <201202092116.q19LGnTY024797@no.baka.org>
References: <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbMT-0002DS-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133Ab2BIVQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:16:57 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:45109 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab2BIVQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:16:56 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q19LGpff029943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Feb 2012 16:16:51 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q19LGnTY024797;
	Thu, 9 Feb 2012 16:16:50 -0500
In-reply-to: <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com>
Comments: In reply to a message from "Hilco Wijbenga <hilco.wijbenga@gmail.com>" dated "Thu, 09 Feb 2012 13:10:58 -0800."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190324>


In message <CAE1pOi1+FQNoPZ_P-fmFx-YhnUYzMQT=6zh3s-OyT71vcDm=wQ@mail.gmail.com>, Hilco Wijbenga writes:

    I've noticed that entering a Git controlled project directory takes
    quite some time so I wanted to measure exactly how much (it's the
    prompt I'm using that's taking the time, I suspect). I first tried (a
    bit naive, I admit :-) )

    time cd my-project

Your confusion is because you are measuring the wrong thing.  I'm
assuming, here, that you have a shell prompt which is giving you all
sorts of status about the git repository.  The "cd" operation is
instantaneous, it is the shell attempting to compute the new prompt
which is slow.

Exactly how your shell does this is shell dependent, but you might
want to look at your setting of $PROMPT_COMMAND.  Then you can test it
by running something like:

time sh -c "cd git-directory; $PROMPT_COMMAND"

					-Seth Robertson
