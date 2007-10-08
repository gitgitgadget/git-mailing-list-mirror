From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 08:15:11 +0200
Message-ID: <20071008061511.GA2859@steel.home>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234039.GH2765@steel.home> <51419b2c0710071709s2f797df0u986447f5455f306d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 08:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ielto-0003uH-TF
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 08:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbXJHGPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 02:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXJHGPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 02:15:16 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:38791 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbXJHGPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 02:15:14 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo46) (RZmta 13.4)
	with ESMTP id D02e03j985RKhn ; Mon, 8 Oct 2007 08:15:12 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0DD9F277AE;
	Mon,  8 Oct 2007 08:15:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 05370C502; Mon,  8 Oct 2007 08:15:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51419b2c0710071709s2f797df0u986447f5455f306d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60293>

Elijah Newren, Mon, Oct 08, 2007 02:09:50 +0200:
> On 10/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > you missed something. Your example compresses to about 124k.
> 
> What version of git are you running?  I reran all the steps to which

git version 1.5.3.4.225.g31b973 (irrelevant custom modifications)

> you responded (repeated below for clarity) with git-1.5.3.3 and still
> get 11MB.  Also, you must have different filesystem extents than me
> since an empty git repo takes 196k here[1], so I don't think any repo
> is going to get down to 124k.

it is ext3. I do not install the hooks (~8k apparent, ~32k fs blocks)
and never activate logs by default.

> # Use vi to remove the line referring to refs/original...
> git reflog expire --all

another part of the suggestion re reflogs was to look into the logs,
to check if expire actually removed anything. It seems to have been
the culprit.
