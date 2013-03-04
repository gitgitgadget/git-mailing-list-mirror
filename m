From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: "git commit" fails due to spurious file in index
Date: Mon, 4 Mar 2013 21:58:58 +0100
Message-ID: <87y5e2op9p.fsf@pctrast.inf.ethz.ch>
References: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robert Irelan <rirelan@epic.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 21:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCcTv-0000ZV-2S
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 21:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478Ab3CDU7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 15:59:05 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:8866 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab3CDU7D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 15:59:03 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 4 Mar
 2013 21:58:56 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 4 Mar
 2013 21:58:58 +0100
In-Reply-To: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
	(Robert Irelan's message of "Mon, 4 Mar 2013 18:15:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217409>

Robert Irelan <rirelan@epic.com> writes:

> Now, when I run 'git add admin_script/setup' to add the new directory to
> the repo and then try to commit, I receive the following message:
>
>     $ git commit
>     mv: cannot stat `admin_scripts/setup/2012/setup': No such file or directory
>
> The error message is correct in that `admin_scripts/setup/2012/setup`
> does not exist, either as a file or as a directory. However, I'm not
> attempting to add this path at all. Using grep, I've confirmed that the
> only place this path appears in any of my files is in `.git/index`.

To me that sounds like the message comes from a commit hook.  Can you
check if you have anything in .git/hooks/, especially pre-commit?

There really isn't any other good reason why 'git commit' would call
'mv' (plain mv, not git!).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
