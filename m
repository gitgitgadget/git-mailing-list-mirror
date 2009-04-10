From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
	in git
Date: Fri, 10 Apr 2009 01:18:44 -0700
Message-ID: <20090410081843.GB9369@gmail.com>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl> <20090410032731.GA1545@gmail.com> <49DEEE22.5030500@pelagic.nl> <20090410074327.GA9369@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 10:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsByW-0003Tv-Q1
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 10:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013AbZDJITC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 04:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbZDJITB
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 04:19:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:20321 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067AbZDJIS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 04:18:59 -0400
Received: by wa-out-1112.google.com with SMTP id j5so527129wah.21
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DhxrOIbV00tuRlcT/F9F4iwxKgAEpkUXS7Qo+PZWAFo=;
        b=Taa78XXBll6Lz9KFli7CuH/p23fKEMsEqW6JBYPZopIgL57ZOiIB86+NpIMOeCsFXh
         KpDEZgSPKJU7U2OruomQb2uiV+qlyEUc82/I27brq17BOLMDM7x9bW28HF7AkAV9hPOY
         JRynRVSVMxkh8epnEJBojSCe8p/JIvRcLzQ1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qRsuCjG01XUgzsbGXZ1wAttti2bmnUSlQjOPLtAfeo/fFW43mq7EfdpkWYsFYzO9Rd
         2UmIXXFPT/J8lo1sMaXxQxrb74NtHti8hABEzuzo4/qQ32q1typuKk3KE3igOzDzs63g
         nTxdi6Ow2EOxdE3HCZeWWPwNJsnopVOTidTBM=
Received: by 10.114.198.1 with SMTP id v1mr1822184waf.78.1239351537880;
        Fri, 10 Apr 2009 01:18:57 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m25sm1127434waf.44.2009.04.10.01.18.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 01:18:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090410074327.GA9369@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116246>

On  0, David Aguilar <davvid@gmail.com> wrote:
> 
> It /seems/ like the docs and completion should be updated.

Though my guess is as good as any....
I'd rather hear someone else's opinion.

$ git log -p 44c36d1c
commit 44c36d1ccc9a40bfb31910dfd7e18d59fa8be502
Author: Charles Bailey <charles@hashpling.org>
Date:   Thu Feb 21 23:30:02 2008 +0000

    Tidy up git mergetool's backup file behaviour
    
    Currently a backup pre-merge file with conflict markers is sometimes
    kept with a .orig extenstion and sometimes removed depending on the
    particular merge tool used.
    
    This patch makes the handling consistent across all merge tools and
    configurable via a new mergetool.keepBackup config variable
    
    Signed-off-by: Charles Bailey <charles@hashpling.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


The commit comment says mergetool.keepBackup, even though the code always
had it as merge.keepBackup.

$ git log -p 7e30682c

Right now more people have merge.keepbackup already set since git-gui
has had it that way for the last 7 months or so.  Nevertheless,
Shawn's already applied the git-gui patch which hints that maybe
we should just make the code match the docs.  In which case, a
patch against pu would be a good thing, but I would like to
hear someone else's opinion just so that you don't waste time
going down the wrong route.

-- 

	David
