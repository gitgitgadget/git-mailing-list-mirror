From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 18 Apr 2012 22:16:06 +0200
Message-ID: <16489638.QvpMpkdxMd@flomedio>
References: <11292500.AVmZFUUvNi@flobuntu> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:16:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbIt-0003EM-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab2DRUQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:16:34 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:51551 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab2DRUQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:16:33 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q3IKG8Lt002119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Apr 2012 22:16:09 +0200 (CEST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <20120410171707.GA3869@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195897>

On Tuesday 10 April 2012 12:17:07 Jonathan Nieder wrote:
> In other words, in the above list the strategy is:
> 
>  1. First convert the remote helper to C so it doesn't have to be
>     translated again later.
Store rev <--> commit mappings using marks and notes.
Store svn metadata.
> 
>  2. Teach the remote helper to import a single project from a
>     repository that houses multiple projects (i.e., path limiting).

I would plan to have this until the mid-term. From that point my summer 
holidays start ..

> 
>  3. Teach the remote helper to split an imported project that uses
>     the standard layout into branches (an application of the code
>     from (2)).  This complicates the scheme for mapping between
>     Subversion revision numbers and git commit ids.

Read ambigouos branches/tags from SBL.
> 
>  4. Teach the SVN dumpfile to fast-import stream converter not to
>     lose the information that is needed in order to get parenthood
>     information.

This means actually saving  svn:copyfrom properties. (right?)

> 
>  5. Use the information from step (4) to get parenthood right for a
>     project split into branches.

.. and using svn:copyfrom properties. (right?)

> 
>  6. Getting the second parent right (i.e., merges).  I mentioned
>     this for fun but I don't expect there to be time for it.

I think this needs a little morge discussion, let's do this if it's the time.
mergeinfo stores a list of revs merged for a file. This looks like a list of 
git cherry-picks to me ..
> 
> Does that seem right, or does it need tweaks?  How long would each
> step take?  Can the steps be subdivided into smaller steps?

What do you think?
I will finally add this strategy to the proposal.

-- Florian
