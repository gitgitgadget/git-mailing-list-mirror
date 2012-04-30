From: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 01:35:20 +0200
Message-ID: <4F9F21B8.9070506@jk.gs>
References: <4F9F128C.5020304@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP07x-0003rP-5N
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444Ab2D3Xf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:35:29 -0400
Received: from zoidberg.org ([88.198.6.61]:42484 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638Ab2D3Xf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:35:28 -0400
Received: from [IPv6:2001:4dd0:ff1a:0:21b:77ff:fe59:7168] ([2001:4dd0:ff1a:0:21b:77ff:fe59:7168])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Tue, 01 May 2012 01:35:26 +0200
  id 00400E82.4F9F21BE.00004243
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <4F9F128C.5020304@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196637>

Hi Rich,

On 05/01/2012 12:30 AM, Rich Pixley wrote:
> I'm trying to do what seems like a simple thing in darcs, monotone,
> mecurial, gnu arch, etc, but seems nearly impossible in git.  There's a
> central repository, a long ways away on the other side of the internet. 
> So I want a local repository cache.  I'm going to be working on a number
> of different features and different machines all simultaneously so I
> really don't want them all to be pulling from the central repository.
> 
> In other systems, this is a simple star network.  Clone a repository,
> use, push, pull, etc.  But with git, I can't push unless the cache
> repository is bare, but if the cache repository is bare, then a change
> to the central repository will cause the two to become wedged since
> neither can push or fetch the other.

If the 'cache repository' is set up using "git clone --mirror" and you
push to the primary repository only, that makes the cache repo a
definite slave, so you can always run "git fetch" on it without any
trouble. You can even enforce this by denying all pushes to the cache
repo, thus eliminating any chance of accidental misuse.

Conveniently, git allows you to specify a different URL for fetch and
push in your local working repositories.

HTH,
Jan
