From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: New git commit tool
Date: Mon, 4 Sep 2006 21:57:36 +0200
Message-ID: <20060904195736.GB2752@diku.dk>
References: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 04 21:58:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKKZs-000716-Q9
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 21:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIDT5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 15:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWIDT5t
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 15:57:49 -0400
Received: from [130.225.96.91] ([130.225.96.91]:30438 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751361AbWIDT5s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 15:57:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id D2877770124;
	Mon,  4 Sep 2006 21:57:39 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19491-11; Mon,  4 Sep 2006 21:57:37 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1A691770118;
	Mon,  4 Sep 2006 21:57:37 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7A3066DF88D; Mon,  4 Sep 2006 21:56:05 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EEA7462A06; Mon,  4 Sep 2006 21:57:36 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17660.4995.977221.767112@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26431>

Paul Mackerras <paulus@samba.org> wrote Mon, Sep 04, 2006:
> Comments and suggestions are welcome.

While doing my best to misuse gitool here is what happened ...

 1. To try out gitool I did the following:

	$ mkdir gitool
	$ cd gitool
	$ git init-db
	$ wget http://ozlabs.org/~paulus/gitool
	$ git add gitool

    Oops, forgot to make it executable ...

	$ chmod +x gitool
	$ ./gitool

    I am a Cogito user, so I am no used to running git-update-index and
    this seems to be a problem in this case:

	can't unset "indexpending(gitool)": no such element in array
	can't unset "indexpending(gitool)": no such element in array
	    while executing
	"unset indexpending($f)"
	    (procedure "readfmod" line 92)
	    invoked from within
	"readfmod file11 0"

 2. When closing the window while the "Application Error" is still open
    causes the following error:

	bgerror failed to handle background error.
	    Original error: can't unset "indexpending(gitool)": no such element in array
	    Error in bgerror: can't invoke "grab" command:  application has been destroyed
	bgerror failed to handle background error.
	    Original error: invalid command name ".ptop.comm.t"
	    Error in bgerror: can't invoke "tk" command:  application has been destroyed

    Maybe it should be ignored.

 3. Finally, I find the difference between clicking on a file name
    versus clicking on a file icon a bit strange. I continue on the
    example above, first modifying gitool and then creating a new file,
    so a file is listed both under "Modified files" and "Untracked/new
    files".

	1. Click on the file name of the modified file to see the diff
	   in the content buffer.

	2. Click on the file icon of the untracked file to add it. State
	   shows "Added" and the content buffer is cleared.

    I have to press the file name to see the content of the added file.
    Maybe it should show the content regardless of whether the file name
    or icon was pressed.

-- 
Jonas Fonseca
