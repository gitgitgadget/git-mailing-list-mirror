From: Kevin Daudt <me@ikke.info>
Subject: kd/
Date: Sat, 4 Jul 2015 23:00:32 +0200
Message-ID: <20150704210032.GB7345@vps892.directvps.nl>
References: <1433625145-29668-2-git-send-email-me@ikke.info>
 <1434538880-15608-1-git-send-email-me@ikke.info>
 <xmqqh9q64a9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 10:48:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBfb4-0006Hf-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbbGEIsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 04:48:18 -0400
Received: from ikke.info ([178.21.113.177]:40206 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbbGEIsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 04:48:17 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 4A13E4400AA; Sat,  4 Jul 2015 23:00:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqh9q64a9p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273352>

On Wed, Jun 17, 2015 at 08:36:34AM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > -		require_clean_work_tree "pull with rebase" "Please commit or stash them."
> > +		if [ $(git config --bool --get rebase.autostash || echo false) = false ]
> 
> Style (use of []).

Fixed it.

> 
> Shouldn't you be doing
> 
> 	if ...
> 	then        	
> 		on an unborn
> 	elif we are not doing autostash
> 		require clean work tree
> 	fi
> 
> which does not need unnecessarily deep nesting?
> 

You are right, much simpler. New patch is underway.
