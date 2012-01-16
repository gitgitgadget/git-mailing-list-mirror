From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: The shared Git repo used by git-new-workdir
Date: Mon, 16 Jan 2012 20:15:22 +0100
Message-ID: <4F14774A.40100@ira.uka.de>
References: <CAE1pOi3fBUBeNuhJqtJhxuMfz2G3iYOJy7U2HX6Nv4kqjcbnhw@mail.gmail.com>	<4F1467C1.504@ira.uka.de> <CAE1pOi3JocCoDGAmpCYdGdJN4E1nz8O4_i0MtLhwhP_axmH-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:15:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rms1b-0005vt-BL
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 20:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab2APTPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 14:15:20 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40035 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab2APTPT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 14:15:19 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Rms1Q-0003Zj-RM; Mon, 16 Jan 2012 20:15:17 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1Rms1P-0003sC-Bs; Mon, 16 Jan 2012 20:15:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAE1pOi3JocCoDGAmpCYdGdJN4E1nz8O4_i0MtLhwhP_axmH-uw@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1326741318.060820000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188646>

On 16.01.2012 19:57, Hilco Wijbenga wrote:
> In my working directory:
> hilco@centaur /mnt/lacie/workspaces/my-project-master
> my-project-master (master $ u=)$ git status
> # On branch master
> nothing to commit (working directory clean)
>
> In the shared repo:
> hilco@centaur ~/git-clones/my-project my-project (master +$ u=)$ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD<file>..." to unstage)
> #
> #       deleted:    .gitattributes
> #       modified:   .gitignore
> #       new file:   ...
> ... hundreds more ...

This is related to your using two repos with the same branch 
(irrespective of root repo or not).

There is nothing wrong with that per se, but if you add/commit/merge etc 
in one of those two, the working directory and index of the other repo 
doesn't get updated automatically. You would have to do "git reset 
--hard" in that repo to get it up-to-date

If you want to avoid this just don't check out the same branch in any 
two repos, root or not.
