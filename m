From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-svn pulling down duplicate revisions
Date: Sun, 1 Jun 2008 22:06:49 -0700
Message-ID: <5FB2F28F-4C9A-422E-BF7D-B271471154F9@sb.org>
References: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org> <20080602050050.GC9904@hand.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 07:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K32Go-0000gb-Pe
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 07:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYFBFGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYFBFGv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 01:06:51 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:48406 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750939AbYFBFGv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2008 01:06:51 -0400
Received: from [192.168.1.112] (c-76-103-51-229.hsd1.ca.comcast.net [76.103.51.229])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id 9AFC7185D64;
	Sun,  1 Jun 2008 22:06:50 -0700 (PDT)
In-Reply-To: <20080602050050.GC9904@hand.yhbt.net>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83489>

On Jun 1, 2008, at 10:00 PM, Eric Wong wrote:

> Kevin Ballard <kevin@sb.org> wrote:
>> I started a git-svn clone on a large svn repository, and I noticed
>> that for various branches, it kept pulling down the exact same
>> revisions (starting at r1). In other words, if I had 4 branches that
>> shared common history, their common history all got pulled down 4
>> times. I double-checked, and the created commit objects were  
>> identical.
>>
>> Why was git-svn pulling down the same revisions over and over, when  
>> it
>> already knows it has a commit object for those revisions?
>
> Can you give me an example if a repository and command-line you used
> that does this?   Did you use 'git svn clone -s' or did you manually
> specify the branch locations in the repo?
>
> It could even be a lack of read permissions to the repository root
> that would cause things like this.

The repository is, unfortunately, a private repo so I can't share it.  
I used `git svn clone -s` to clone it. I have the SVN perl bindings  
v1.4.4 (according to git svn --version).

I definitely have read permissions to the repo root. If I specify to  
only fetch -r 12000:HEAD (there's 14000-odd revisions), it doesn't  
pull down any duplicates, but when I let it start from the root, it  
pulls down hundreds of duplicates for multiple branches.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
