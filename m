From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 16:04:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604221601270.6812@virtualbox>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:04:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atbh3-00055H-6R
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbcDVOEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:04:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:65097 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbcDVOEU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:04:20 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MXEs5-1bH1hG0tZV-00WHSV; Fri, 22 Apr 2016 16:04:03
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:JfWdtWAr7o9E36OynI7k12tiRU8xKhThNk+Kuow8MTWAdzemLMF
 VAGtqbPUKCnhZ/vNVWLWjuFaQFFViB85XYMWB/9pcXl7Jgl66sNqLmryLKxZHrjc6eJbR0t
 CJI+1MKSCKB95QQB3Km+CFaZSk8iNytFDJh7RNe40DEJ29PYsOVyCfFrC0tBddDW9EvQfv+
 Zfdw88BnYxRGlz5+OL8KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ohVd6DeITds=:nhtjSXOgiGTq1z4DUtVVwm
 FTx5gMc5SVdpWJxmu8Lk6wo4W5A+dF3mBp1mTKaB8VFMMrDhKtUMgrHLd5MEeho9rNVaZlL6x
 iaIpJPNL3YzPXC/v1lSUNVp5CTcqxDMhLkwr+yLzr6Rk02QAsfYFEAf+BtekDcFxORYcD0X9d
 Yk/hadOUPOCEdpoidponpLjTYJy5C+X71cMaQE4aqRfpQOzcXp0jyK00AlWW8eEa7Lwy1G324
 ag+hP/utUjx3yrDAyvDvNJjddOdYG0I362PmaNwgwTVQQGa72cDp2/Ml1W5GW30VEOpd1Gp9T
 vV271a9CGv24FxsOynN/7WHKm68TMSGQVs4Zskocuc88R54OLUPC9o5OGdqAJDz7y4yl8nPQC
 k8zITF9AgCvg1Cdr/u0vhlD1kbS8+Jhjo7vJy5agTBQ+oJ1Xmts9/PQzHIxCP2zVH27wqT6nq
 IJtNQWP73UHHX0F8hUTgxuPOwQNFxHGmwJTgTTm1tWror7ao8AYtzSkA/3tgof7n/DMlNN7Pp
 ve9NUV7BtLIRj0GneUXhcfymoSpt+w4D5I6zB4yR4KRKWdX4zujrW2cvMPY6sDIwtwG9j3GUR
 rLeHIp/NxEH+J5e9C5/bOqFN0G14yNZ+/nGLtVyqWOUKZVSpkrVeo1XgXi1hMtlrLM7+XrGMr
 gJ9BXyG/WQOo9iLZXfAvx+Qldechl5J/DbXue7boguanah5+xwd+kOTC8+pOo8Kqjk7YOkQkL
 uRnMkrEBcvyiCHHCZaNgGnfuPbaTAThcTW6N1fpmatZ0gnkXdJRItPSKNrLySQGLT52pe++w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292205>

Hi Junio,

On Thu, 21 Apr 2016, Junio C Hamano wrote:

> * js/am-3-merge-recursive-direct (2015-10-12) 2 commits
>  - am: make a direct call to merge_recursive
>  - merge_recursive_options: introduce the "gently" flag
> 
>  The merge_recursive_generic() function has been made a bit safer to
>  call from inside a process.  "git am -3" was taught to make a direct
>  call to the function when falling back to three-way merge.
> 
>  Being able to make a direct call would be good in general, but as a
>  performance thing, the change needs to be backed up by numbers.
> 
>  Needs review.
> 
>  I haven't gone through the "gently" change with fine toothed comb;
>  I can see that the change avoids calling die(), but I haven't made
>  sure that the program states (e.g. what's in the in-core index) are
>  adjusted sensibly when it returns to the caller instead of dying,
>  or the codepaths that used to die() are free of resource leaks.
>  The original code certainly did not care the program states at the
>  point of dying exactly because it knew it is going to exit, but now
>  they have to care, and they need to be audited.

I actually found a bug in my implementation, when I needed it in my
rebase--helper branch: at some point, we should return 128 instead of -1,
to indicate that we won't even start merging (because we would overwrite
untracked files).

I hope to find the time next week to go through the entire call graph and
verify that we are only die()ing in case if really critical errors (such
as out-of-memory, in which case we traditionally just die).

Ciao,
Dscho
