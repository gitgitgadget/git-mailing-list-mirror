From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: Excluding files from git-diff
Date: Fri, 17 Oct 2008 18:30:31 +0200
Message-ID: <48F8BDA7.50901@pflanze.mine.nu>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erik Hahn <erik_hahn@gmx.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 18:32:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqsEu-0004Dp-TI
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 18:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbYJQQaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 12:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbYJQQaf
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 12:30:35 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:44997 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754461AbYJQQae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 12:30:34 -0400
Received: (qmail 15758 invoked from network); 17 Oct 2008 16:30:31 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 17 Oct 2008 16:30:31 -0000
Received: (qmail 21243 invoked from network); 17 Oct 2008 16:30:31 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 17 Oct 2008 16:30:31 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <48F8ACC2.1010903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98487>

Michael J Gruber wrote:
> your .gitignore probably doesn't change that often,
> so that it shouldn't show up in the diff after that anyways. Or put it
> in .git/info/excludes.

For me, adding entries to that file does not make "git diff" or "gitk" 
or even "git ls-files" ignore files matching the entries. Only "git 
ls-files --others --exclude-from=.git/info/exclude" will exclude them. 
And "git diff " and gitk don't seem to know the --exclude-from option.

Is there a way to really invert the patterns given to "git diff" or 
alike? I.e. instead of saying "git diff -- * .somedotfile 
.someothernongitignoredotfile" one could just say something like "git 
diff --invert-matches -- .gitignore"? And even better, could one 
configure some such so that it has effect on all tools by default?

(That would help working around the clutter problem from the "Separating 
generated files?" thread; i.e. in some cases this could be good enough 
to not require splitting a project into multiple repositories. (Although 
I'm all the same currently working on a 
"intergit-find-matching-commit-in" script, since there may be more good 
reasons than only the clutter to split projects.))

Christian.
