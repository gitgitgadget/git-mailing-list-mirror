From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 22:06:08 +0400
Message-ID: <20080625180608.GC5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZOg-0006oi-UE
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbYFYSGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYFYSGR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:06:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:18425 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYFYSGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:06:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1416113fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=jpmkX0P2IxOT67ZxFCoZ/UulGWLdnsESrb+E2qV8riI=;
        b=XEMIEUqVMrxPm5R/1YWCXMA9j47akoC1clfGSc9maWCGYAjaBiotLvOK3wTO/Gzp+1
         9FeD9G4gekEKFc2AkhAxwccQAXPPoP8opjIplbpv1twHp3Wj7e8ZOb6F5uF7bMz8WS6c
         42T+5CHTqccwbkckyhJIOZsccgwfVuW1yRYqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=YF62RHwmUjfwPgH+sn0RVaotG+5FsnjFrGlSvG34Z+Jj2bWLWHFkmQf6cOoKFwUFin
         MstBJEv1Vmgjj2jbPeZ4yI4qp5yRvpSwkrtd8S9A7wA7avZcGrUE4lt58j74IWVRhrBA
         rWhussnWV3ZFa9Uh1AdhT9sc7Gz/97C7mVa8c=
Received: by 10.86.25.17 with SMTP id 17mr10874648fgy.50.1214417172396;
        Wed, 25 Jun 2008 11:06:12 -0700 (PDT)
Received: from localhost ( [85.141.151.43])
        by mx.google.com with ESMTPS id e20sm14963563fga.1.2008.06.25.11.06.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 11:06:11 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86314>

On Tue, Jun 24, 2008 at 10:13:13PM -0000, David Jeske wrote:
> 
> Two things I'd like to make it easy for users to never do are:
> - delete data
> - cause refs to be dangling

Why? Let's suppose you work with CVS and you started to edit some
file and then realize than the change that you make is stupid, would
not you want just to discard these change without committing them to
CVS?

Perhaps, you are confused by thinking that git commit and cvs commit
are conceptually same commands. IMHO, far better to analogue to cvs
commit would be git push to a repository with denyNonFastForwards
policy. Git commit allows you to save your changes locally as series
of patches, but until you have not pushed them, they are not in a
permanent storage. You can change these patches, which implies that
old versions may become dangling and will be removed after reflog
expired. The idea of making of making difficult to remove some local
commits is alike the idea of an editor making difficult to remove a
line... You gain nothing from that. What editors do instead is to
provide the Undo action. Similarly, Git allows you to get back to an
old state using the reflog.

Dmitry
