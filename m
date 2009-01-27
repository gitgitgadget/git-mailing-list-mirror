From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 00:37:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com> <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: PJ Hyett <pjhyett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRxW7-00071q-3z
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZA0Xh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbZA0Xh0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:37:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:43887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753187AbZA0XhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:37:25 -0500
Received: (qmail invoked by alias); 27 Jan 2009 23:37:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 28 Jan 2009 00:37:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8qfh6I7m83VBZISsmj4DBw6SQJ9q7PqtjBj3qO6
	TEGYejC66mhuF7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107426>

Hi,

On Tue, 27 Jan 2009, PJ Hyett wrote:

> To expand further, here's the output from the command line when this happened.
> 
> ~/Development/github(jetty)$ git push pjhyett jetty
> fatal: bad object e13a86261c6e710af8fd4b5fb093b28b8583d820
> error: pack-objects died with strange error
> error: failed to push some refs to 'git@github.com:pjhyett/github.git'
> 
> ~/Development/github(jetty)$ git fsck --full
> warning in tree 0d640d99b492b0c7db034e92d0460a7f84b22356: contains
> zero-padded file modes
> warning in tree 56fe2a1a3da446606aadf8861feccd592b636a34: contains
> zero-padded file modes
> warning in tree 99e2a89db2aa9846fc2491b3e4ccd8861e8d3283: contains
> zero-padded file modes
> warning in tree a6e532d7451bc4aadab86ade84df69180fab4765: contains
> zero-padded file modes
> dangling blob 43611213c3eff91e5fe071cf2907f69a99b630b2
> dangling commit b28b3ecd85a04ecbd1dcb8aedc6886a465f6ab18
> dangling commit 13a70c8687527936d2c375f0f7aefe71142de3c7
> dangling commit 2aa94c1199cb332f58b70c6ce19d8de3c45c6f3c
> dangling blob 61b910e7a97600691fd279e4db3662e751fb5fb7
> dangling commit c4f19e16208d59666323ae0575435720be9b865d
> dangling commit 19245f5d77aa449eebb4a0521b5ff4f6ce1865ab
> dangling commit 122995fb7c9a7e459b0801e0647eb918bea878bf
> dangling commit 7d51e3926b8720d1c7cad19aeb35d6ab4af755fd
> dangling commit 1162dd21370439416967a34915832125e4975239
> dangling blob 8c630b66927f6022a72e457be308de5c9ad9f4e6
> dangling blob 827d4d8855fe6a3a7856ea35cd641192140f2dcd
> dangling commit c9824506855d6cad9b52df115aa267d70872c2cc
> dangling blob fb9bbfc3aa17c5d1ae4e15c862bd874e3476fcfc
> dangling commit 46a4b39245a58ad867010f272991d6233db6288b
> dangling commit d6bf5f30853fecea745559dc3a718113f3619634
> dangling blob d4d66fc4c3a2cbc94d8ed9cb30a6b56daa86e58f
> dangling commit b4f8d7766e8905e5ac6d6cfeeaf7370a716c24a2
> 
> Very odd that the bad object didn't appear in the fsck output.
> 
> I was able to fix the error by copying a non-corrupted version of the
> object back into .git/objects and then running a git fetch.

Hmm.  The only thing I could think of is that the pack-objects used by 
your git-daemon is somehow not at the right version...

Do you have copies of the "corrupt" objects?

Ciao,
Dscho
