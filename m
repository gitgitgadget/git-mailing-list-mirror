From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Tue, 14 Oct 2014 23:31:14 +0300
Message-ID: <20141014203114.GB8157@wheezy.local>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 22:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe8lz-0006Ed-Sz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 22:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbaJNUco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 16:32:44 -0400
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:55502
	"EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755405AbaJNUcS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 16:32:18 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-07.prod.phx3.secureserver.net with 
	id 38Y81p00A5B68XE018YBUE; Tue, 14 Oct 2014 13:32:18 -0700
Content-Disposition: inline
In-Reply-To: <543D58D9.5060606@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 07:09:45PM +0200, Jens Lehmann wrote:
> Until that problem is solved it looks wrong to pass
> GIT_COMMON_DIR into submodule recursion, I believe
> GIT_COMMON_DIR should be added to the local_repo_env array
> (and even if it is passed on later, we might have to
> append "/modules/<submodule_name>" to make it point to the
> correct location).
 
Actually, why there should be an _environment_ variable
GIT_COMMON_DIR at all? I mean, gitdir is resolved to some
directory (through link or environment), and it contains the
shared data directly or referes to it with the commondir
link. In which case anyone would want to override that
location?

I searched though tests but they don't cover this.
