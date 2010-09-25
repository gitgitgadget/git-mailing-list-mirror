From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: .gitignore Bug Report on the behavior of *
Date: Sat, 25 Sep 2010 22:03:48 +0200
Message-ID: <201009252203.48820.j6t@kdbg.org>
References: <201009251923.o8PJNJYE031841@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 22:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzayU-000292-Hb
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 22:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab0IYUDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 16:03:53 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62370 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab0IYUDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 16:03:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 14E5DCDF89;
	Sat, 25 Sep 2010 22:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1367419F614;
	Sat, 25 Sep 2010 22:03:49 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <201009251923.o8PJNJYE031841@no.baka.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157196>

On Samstag, 25. September 2010, Seth Robertson wrote:
> # Properly shows X and B/XX as untracked, as I expected
> echo X > X; echo XX > B/XX; git status
>
> # I expected B/XX to show up as untracked
> rm -f .gitignore B/.gitignore
> echo '*' > .gitignore; echo '!*' > B/.gitignore; git status

You should update your expectations to match what you got. ;-)

To show why your expectations are wrong, consider a *huge* and *deep* 
directory with thousands and thousands of subdirectories, call it "usr", that 
should be ignored. The .gitignore at the top-level would just say:

  /usr

Do you really expect git to walk down this ignored directory, just to make 
double-sure that really, really down there does nowhere exist a .gitignore 
that says "oh, wait, don't ignore *this* file"?

-- Hannes
