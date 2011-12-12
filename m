From: andreas.t.auer_gtml_37453@ursus.ath.cx
Subject: Re: Git blame only current branch
Date: Mon, 12 Dec 2011 18:19:21 +0100
Message-ID: <4EE63799.6020409@ursus.ath.cx>
References: <5e2440c1-8d11-4d92-b42f-14169a62ced1@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 18:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra9Y6-0003Kf-1S
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 18:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab1LLRUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 12:20:17 -0500
Received: from brln-4d0cbd2c.pool.mediaWays.net ([77.12.189.44]:11465 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753227Ab1LLRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 12:20:16 -0500
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 20AC719F1DA;
	Mon, 12 Dec 2011 18:20:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <5e2440c1-8d11-4d92-b42f-14169a62ced1@mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186920>



On 12.12.2011 18:05 Stephen Bash wrote:
>  ----- Original Message -----
> > From: "Jeff King" <peff@peff.net> Sent: Monday, December 12, 2011
> > 11:55:42 AM Subject: Re: Git blame only current branch
> >
> > On Mon, Dec 12, 2011 at 10:24:47AM -0500, Stephen Bash wrote:
> >
> > Usually when you are interested in seeing merges like this in
> > git-log, you would use one of "--first-parent" or "--merges".
> > However, though "git blame" takes revision arguments, it does its
> > own traversal of the graph that does not respect those options.
>
>  My first thought was --first-parent, and was disappointed when I
>  didn't find it in the blame documentation :)  I think for my purposes
>  --first-parent is better than --merges because there are non-merge
>  commits on the branch(es) of interest (and thus I think the problem
>  would become ill-posed in the --merges case).
>
> > Modifying it to do --first-parent is pretty easy: ... snip ...
>
>  That's pretty simple...  I'll try to do a little testing this
>  afternoon.

You might need to consider that if the master branch was first merged 
into topicA before topicA was merged back to the master that the master 
would only be fast-forwarded and so the first parent of M would be 3 not 
C. So depending how the developers merged you might get different results.
