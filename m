From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Mon, 7 Mar 2011 20:44:27 -0600
Message-ID: <20110308024427.GA21471@elie>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 03:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwmug-0005Hr-FF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 03:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab1CHCof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 21:44:35 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38792 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab1CHCoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 21:44:34 -0500
Received: by qyk7 with SMTP id 7so2518659qyk.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xfsgfIFp5UeisxWci9Sp/Z52D3jL835cHMtubsroKGI=;
        b=RkVhXCdkUXoHiRP45xDL0gXdSmS3K3sqHHk+aEAIic6+uGPpEsbb5c3Sh1eJHIuLqN
         npG3c0VxZtBeX0AShVt2otbTJQWlYJ+VAPszH3+5TajKzcPNsh9TBwUN69uRgeQVTisg
         EeDGo+VM/gyTeK6kvspmc+2UO++Ie2fAlwuLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Erxvc+uODolv4gqzEOSabPk9nxmPrIP3Ad2b5hzr0DldAuxbWsYlS+rL8r9fBzxLCX
         lTVYFzDBAOprye3JlO0gqk6wFUa62F/wiYkSP+AKC/E0Eu1Lmg1rxWqroZjTqKFZBx6Q
         KvzpP7cMfIAvx65OQUBhDCPPa7svotm3isz8A=
Received: by 10.229.220.149 with SMTP id hy21mr3590777qcb.51.1299552273184;
        Mon, 07 Mar 2011 18:44:33 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.ameritech.net [69.209.61.99])
        by mx.google.com with ESMTPS id y17sm218832qci.9.2011.03.07.18.44.31
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 18:44:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168632>

Hi,

Vitor Antunes wrote:

> Is it possible to change the parent of a commit during fast import?
> I've tried using "reset" command and making a new commit pointing to a
> new parent, but in both cases I get a "new tip ... does not contain
> ..." error message.

Have you tried "git fast-import --force"?

> Providing a bit of context. I'm trying to improve git-p4 to detect the
> parent commit of a new branch.
[...]
> To achieve this I used the checkpoint command to flush the list of
> imported commits to disk and then used standard rev-list and diff-tree
> commands to make find the parent commit. I am now at a point where I
> am able to correctly identify the parent commit, but when trying to
> update the from information I get the above message.

The advice in the section "Use Tag Fixup Branches" of git-fast-import(1)
might be useful.

Thanks for an interesting example, and hope that helps.
Jonathan
