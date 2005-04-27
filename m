From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 11:00:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504271058120.5008@cag.csail.mit.edu>
References: <426F2671.1080105@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 16:58:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQnxC-0002Fm-3H
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 16:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVD0PBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVD0PBM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 11:01:12 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:11980 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261694AbVD0PBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 11:01:09 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DQo27-0000ZM-00; Wed, 27 Apr 2005 11:00:59 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426F2671.1080105@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, H. Peter Anvin wrote:

> Additionally, there is the question of the handling of strings that may 
> contain \n or even \0 (which may be necessary for some applications).

While we're at it, I'll just mention that '\0' is a rather bad delimiter 
for zlib-compressed files; it usually ends up enlarging the file by three 
or more bytes compared to using any whitespace character.  The reason is 
obvious: \0 isn't actually used anywhere else in the compressed contents, 
so it tends to pollute zlib's dictionary.

It's probably too late to do anything about this, but hey.
  --scott

Soviet  STANDEL Yakima JMTRAX Hussein Ft. Meade algorithm JMBLUG CIA 
SEQUIN Bejing Morwenstow Boston nuclear Sigint Ft. Bragg ZRBRIEF Peking
                          ( http://cscott.net/ )
