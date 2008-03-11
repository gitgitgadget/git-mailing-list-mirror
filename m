From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to ignore deleted files
Date: Tue, 11 Mar 2008 07:10:57 -0700 (PDT)
Message-ID: <m3y78pxsf5.fsf@localhost.localdomain>
References: <47D68203.10905@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5Co-0005HQ-Nl
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbYCKOLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbYCKOLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:11:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33250 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbYCKOLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:11:06 -0400
Received: by nf-out-0910.google.com with SMTP id g13so975503nfb.21
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=1/y+J8JVA8/80wKs37v2EU6FXWQSnXyhv3kGrIemj7E=;
        b=uKtiCEFz/sVssQmPGkJDV6GpqKONafnmZ7vBRn4PEZb5jljmSKCV4lhZ+iJQeEmPoifofjC0yrtGqcyExuabO916wzN97irNEuks1V7gCOEjJUo0TKij/K3u3G8c5Tx2Y4wfCA10Q2JSGoY1igDvrn0z4JbsFErwSX/CQROz12A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=tVtLNzDz54FkU4yAgD5UzVe3OcXtiuQG0l5Yye0+jXSZosqd7NqrTkbFN/bxgEdfoKEtukxJskBTyX4lAiSeq3EJsO6qEHSZUqiL7ryNo1zMbNd7UEsyQON43x7u6vumbeKSy+ZZOLeopW8xpqaIOlcfqPV9FhPlfffhd91MmhE=
Received: by 10.78.168.1 with SMTP id q1mr17971456hue.2.1205244662077;
        Tue, 11 Mar 2008 07:11:02 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.132])
        by mx.google.com with ESMTPS id c22sm3325398ika.3.2008.03.11.07.10.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 07:10:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2BEAetx005196;
	Tue, 11 Mar 2008 15:10:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2BEAc88005193;
	Tue, 11 Mar 2008 15:10:38 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47D68203.10905@bioinf.uni-sb.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76853>

Andreas Hildebrandt <anhi@bioinf.uni-sb.de> writes:

> Dear all,
> 
> our git repository contains a number of .tar.gz - files that are
> automatically extracted and then deleted during the build process.
> Unfortunately, commiting any changes after that step will mark those
> files as deleted and try to commit that to the repository. Is there any
> way to tell git to ignore those files automatically (apart from changing
> our build process not to use or not to delete those files)?

I don't quite understand: are those .tar.gz files stored in _source_
repository? That would be a bit strange...

I guess that you have tried adding "*.tar.gz" to either .gitignore or
.git/info/excludes file?

Another solution would be (if they are truly needed to reside in
repository) to re-checkout them as a last part of build process /
after-build process.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
