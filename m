From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 3 Aug 2013 12:39:15 -0400
Message-ID: <20130803163915.GB945@analysisandsolutions.com>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
 <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam A <hitsthings@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:39:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5erQ-0006on-N7
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab3HCQjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:39:17 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60839 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3HCQjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:39:16 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id F176D18973; Sat,  3 Aug 2013 12:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375547955;
	bh=ck4CZ2G6Mj8I0QqrG2HuEGE3qY9AC2TcNoYT/lOsDIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhFse/E/sB0VpwdHy4MzZBZfq0Nhv7jzSdDLnNYdRdBv+1F/RBf62uIxXfwD42ZpY
	 rxIkOPy2qNlWUWvdFvled5nhGKb3V+OBOjCzYmDciOlchQQ8IkUrP8GJKCYrwOMQ6h
	 Mjr3xF3udfSbZXR8j0GzSb1t4uPxHEh10myFwUFI=
Content-Disposition: inline
In-Reply-To: <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231602>

Hi Adam:

On Sat, Aug 03, 2013 at 10:01:30PM +1000, Adam A wrote:
> - create a remote repository at URL with commit(s) in it
>   - e.g., a new github repo with README and LICENSE files auto-added
> - write some files in a local directory
> - git init
> - git add .
>   - the contents of the directory are now in the index
> - git remote add origin URL
> - git pull origin master
> 
> The local files added to the index are now completely wiped out and
> replaced with the remote content. I lose all my previous work. :/

All is not lost.  Your local files should be stored in the repository's
reflog.  Examine the output of "git reflog".  You can then reset your
working directory to obtain those files by doing something _like_
"git reset --hard HEAD@{1}".

All hail reflog.

Good luck,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
