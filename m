From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove various dead assignments and dead increments
 found  by the clang static analyzer
Date: Sat, 26 Sep 2009 22:39:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909262235010.4985@pacific.mpi-cbg.de>
References: <87ab0hepcn.fsf@master.homenet> <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de> <871vltefdj.fsf@master.homenet> <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com> <87ske9cya9.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mre3D-0002Nw-53
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbZIZUhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZIZUhX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:37:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:54508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbZIZUhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:37:23 -0400
Received: (qmail invoked by alias); 26 Sep 2009 20:37:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 26 Sep 2009 22:37:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Y0rkp6ChYMrIHVPyDsxCTXcXy0LTX53gXQflstI
	u50PErDax9If88
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ske9cya9.fsf@master.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129177>

Hi,

On Sat, 26 Sep 2009, Giuseppe Scrivano wrote:

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 200ffda..331d2a0 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -1035,7 +1035,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			parents = reduce_heads(parents);
>  	} else {
>  		reflog_msg = "commit";
> -		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
> +		commit_list_insert(lookup_commit(head_sha1), pptr);
>  	}

Sorry, but from the context it seems as if the same remark I had for argc 
applies here, too.  There are exactly three other similar-looking 
assignments and it is too easy IMO to mess up when one want to rearrange 
things there.

In other words, I deem the removal of this assignment worse than what we 
have now -- at least in terms of how easy it is to modify the code safely.

I just looked further 3 hunks and had exactly the same impression there, 
so I stopped looking.

Sorry,
Dscho
