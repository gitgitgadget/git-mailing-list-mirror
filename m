From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 14:05:58 +0200
Message-ID: <87lh4kic49.fsf@gmail.com>
References: <1460296343-17304-1-git-send-email-mst@redhat.com>
	<1460296343-17304-2-git-send-email-mst@redhat.com>
	<alpine.DEB.2.20.1604111239100.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 14:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apabf-0006eM-F8
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 14:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbcDKMGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 08:06:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:52437 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbcDKMGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 08:06:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1apabU-0006aN-1m
	for git@vger.kernel.org; Mon, 11 Apr 2016 14:06:04 +0200
Received: from host120-2.natpool.mwn.de ([138.246.2.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:06:04 +0200
Received: from chneukirchen by host120-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:06:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host120-2.natpool.mwn.de
In-Reply-To: <alpine.DEB.2.20.1604111239100.2967@virtualbox> (Johannes
	Schindelin's message of "Mon, 11 Apr 2016 13:02:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291212>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about making it easier to use, and much, much more generic, like this?
>
> 1. introducing an `--add-footer` flag to `git commit` that you could use
> like this:
>
> 	git commit --amend --add-footer "Acked-by: Bugs Bunny"

I have a script where I currently do this ala:

GIT_EDITOR="git -c trailer.closes.ifExists=replace interpret-trailers \
        --trailer 'Closes: #$PR [via git-merge-pr]' --in-place" \
git commit --quiet --amend

But I think it could be a good addition to porcelain.
(interpret-trailers still feels hard to drive by a script...)

-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
