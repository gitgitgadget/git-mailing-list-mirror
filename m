From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: strange "git clone" behavior wrt an active branch
Date: Sun, 28 Sep 2008 14:37:30 +0200
Message-ID: <adf1fd3d0809280537k7adffe3dte9579fe70c7f990e@mail.gmail.com>
References: <ee2a733e0809280505n69f62e0fy89667c175bcc16c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 28 14:39:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjvYm-0001bp-7a
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbYI1Mhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 08:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYI1Mhd
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 08:37:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:28318 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYI1Mhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 08:37:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1123175fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 05:37:30 -0700 (PDT)
Received: by 10.103.203.4 with SMTP id f4mr2785163muq.8.1222605450618;
        Sun, 28 Sep 2008 05:37:30 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Sun, 28 Sep 2008 05:37:30 -0700 (PDT)
In-Reply-To: <ee2a733e0809280505n69f62e0fy89667c175bcc16c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96961>

On Sun, Sep 28, 2008 at 2:05 PM, Leo Razoumov <slonik.az@gmail.com> wrote:
> Hi All,
> I am using the latest stable version git-1.6.0.2.
>
> The man page for git-clone states explicitly that "git clone"
>
> " Clones a repository into a newly created directory, ...[snip]...
>  and creates and checks out an initial branch equal to the
>  cloned repository's currently active branch. "
>
> I noticed that while my active branch "My" happens to point to the
> same commit as the "master" the git clone will check out master
> instead of My (currently active branch). Is it a bug?
>

Currently it is only guessed which is the active branch (with a
preference for the master branch as it is the default), as the current
protocol does not allow tranfering the ref links:

$ git ls-remote $url
$sha1 HEAD
$sha1 $branchname
...

instead of:
ref: refs/heads/master HEAD
$sha1 $branchname
...

So, I think it is a current limitation that maybe should be documented.

HTH,
Santi
