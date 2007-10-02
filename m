From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: git-http-push / webDAV
Date: Tue, 2 Oct 2007 12:54:16 +0400
Message-ID: <20071002085416.GW975@void.codelabs.ru>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru> <47020603.3080000@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcdWR-0002e4-Sb
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 10:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbXJBIyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 04:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXJBIyX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 04:54:23 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:52696 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbXJBIyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 04:54:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=Xh18Tprj9W5MlcnFldPYev4kKYrNM7j3U3I87zaMhHuVeb6+mE8DDH0eX7RM5l2ecWBVEov4/VAj+/XKmlNl4BpqOsOVvKsndwW3Y8c19XuAL5ZRMxEM7Pmdubqbfj8RWwtHWvRTXtQ3eLj5Pw4HPDCHp9aF8gzlYkTV2cL+q2s=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IcdWH-0001NN-7M; Tue, 02 Oct 2007 12:54:21 +0400
Content-Disposition: inline
In-Reply-To: <47020603.3080000@jentro.com>
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59675>

Thomas, good day.

Tue, Oct 02, 2007 at 10:49:07AM +0200, Thomas Pasch wrote:
> I've investigated my problem a little further. The nasty
> 'UNLOCK HTTP error 400' has come from a proxy that
> doesn't accept webDAV stuff. Thus I unset the 'http_proxy'
> env variable (looks like cadaver hasn't cared...).

Yep, proxies can be tricky with the DAV stuff.

> However, the main problem still remains. Using a non empty
> remote http repo, modifying and committing, then:
> 
> > git push -v
> Pushing to http://test@x.x.x.x/git/git.git
> 
> still waits for a long time and finally:
> 
> Error: no DAV locking support on remote repo http://test@x.x.x.x/git/git.git
> error: failed to push to 'http://test@x.x.x.x/git/git.git'

Try using URL with the slash at the end, like
'http://test@x.x.x.x/git/git.git/'.  This should help.
-- 
Eygene
