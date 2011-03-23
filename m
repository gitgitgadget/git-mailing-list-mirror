From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Re: [PATCH 2/2] Actually use retval
Date: Tue, 22 Mar 2011 20:26:54 -0500
Message-ID: <20110323012654.GA10621@elie>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <91afab0d46939238dd7c90ea2902b02cae083316.1300798069.git.johannes.schindelin@gmx.de>
 <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 02:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Cqr-0004SB-BB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 02:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab1CWB1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 21:27:03 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61469 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab1CWB1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 21:27:02 -0400
Received: by yia27 with SMTP id 27so3147463yia.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K7qur+nUfePDErTQX1Ekfj6tkfB9PhHFZgLapmf4jvI=;
        b=Qj0uQe57Vye6Y//z4iMqOK7nw2Vc+1L58dNlISS7N4jwGK+IQSGTOTVwkfLUC1WTLq
         HjLqmXUSeypLsQ/xNjOWQICveAMuUPxRth9LZEezmpli01IoMjYQjgbaj+A0eDf5i7hD
         F4aKzmAJ5u30rNDKPGpIvXLbIQpT3eSi7BPXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vL8Q/rF7ethZABo217UmFuUZf14wt45sTRPznIj9rJsYfwJMv/hQVBZlaAG5ta84Rk
         6pP3YaZ7s1y6NMTC7Aw+mSOx8PqlTDBtarR15IpKUP4oYpoXAtWQaR4SqtdarvmgjMvS
         FrFrmzTL7P6uc0YIAHEevj3wu7WfVGB2IMINw=
Received: by 10.236.18.13 with SMTP id k13mr6915491yhk.61.1300843620596;
        Tue, 22 Mar 2011 18:27:00 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.ameritech.net [68.255.102.141])
        by mx.google.com with ESMTPS id f50sm3199341yhc.79.2011.03.22.18.26.58
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 18:26:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hbrkovz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169792>

Junio C Hamano wrote:

> The likely fix would be to remove assignment to retval instead.

Like this, maybe?

Jonathan Nieder (2):
  tree-diff: make diff_tree() return void
  tree-diff: make diff_tree_sha1() return void

 diff.h      |    4 ++--
 revision.c  |    9 +++------
 tree-diff.c |   17 ++++++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)
