From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Demonstrate breakage: checkout overwrites untracked
 symlink with directory
Date: Thu, 10 Feb 2011 22:49:01 +0100
Message-ID: <20110210214901.GA25437@localhost>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org>
 <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org>
 <20110205183351.GA25717@localhost>
 <7vpqr0n51f.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 22:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PneMa-00018C-DV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 22:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab1BJVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 16:47:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55103 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab1BJVrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 16:47:39 -0500
Received: by fxm20 with SMTP id 20so1967456fxm.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3srjsMEZ6ZcyMVzaXm28mdMAI0bzN+E+zjqUbESKlmc=;
        b=VvKPvb+E9sD1nuyXhOCS1rPRA3eipl0CrlEzD9RKmTWeVKlJl7eWNUkPs1hZ6USwpU
         qaXmWAhSBkeJ9ovWeqkJlDLwdBOVePu5AofFTb/4Rz7F2A/RikE5xbwQUIWP3/7UWA2K
         1y305SeV3om7P3ViJr3pH0zsmjShgrBfKMPTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=knN3zQgePGzkvlr9XWs0ZcdNxmQ3eJQzN6ThnfXzF/LALMFERszfGbttOkaMlqmEJS
         L48fpRlKxzXjXdF5kQxic1o2hpvWfrPm1lY9qhuEu7xtzWhZYY6CiZlNQ9zD+AjtHlL3
         p88gEcTeCcK9yJUEEjCw0M8IMbb+kCSpKgRzI=
Received: by 10.223.83.11 with SMTP id d11mr3049565fal.37.1297374457636;
        Thu, 10 Feb 2011 13:47:37 -0800 (PST)
Received: from darc.lan (p5B22DF92.dip.t-dialin.net [91.34.223.146])
        by mx.google.com with ESMTPS id j12sm54725fax.9.2011.02.10.13.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 13:47:36 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PneNp-0006dI-4n; Thu, 10 Feb 2011 22:49:01 +0100
Content-Disposition: inline
In-Reply-To: <7vpqr0n51f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166502>

On Wed, Feb 09, 2011 at 03:48:12PM -0800, Junio C Hamano wrote:
> 
> Perhaps can-clobber-to-checkout would be a good candidate.

How about leading_path_in_use() instead? Whether files in the path
can be clobbered or not is checked in a separate step, which is
currently called ok_to_remove().

Clemens
