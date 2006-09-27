From: Dave Jones <davej@redhat.com>
Subject: Re: apply-mbox claiming corrupt patch.
Date: Tue, 26 Sep 2006 23:14:03 -0400
Message-ID: <20060927031403.GA31144@redhat.com>
References: <20060927024628.GA29182@redhat.com> <200609262301.12235.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 05:15:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPsv-0001DT-TQ
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWI0DOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWI0DOw
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:14:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932338AbWI0DOv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 23:14:51 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8R3E4f4023153;
	Tue, 26 Sep 2006 23:14:04 -0400
Received: from pressure.kernelslacker.org (vpn-248-4.boston.redhat.com [10.13.248.4])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8R3E3G8003998;
	Tue, 26 Sep 2006 23:14:03 -0400
Received: from pressure.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k8R3E3Du031371;
	Tue, 26 Sep 2006 23:14:03 -0400
Received: (from davej@localhost)
	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k8R3E3r6031370;
	Tue, 26 Sep 2006 23:14:03 -0400
X-Authentication-Warning: pressure.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Len Brown <lenb@kernel.org>
Content-Disposition: inline
In-Reply-To: <200609262301.12235.len.brown@intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27863>

On Tue, Sep 26, 2006 at 11:01:12PM -0400, Len Brown wrote:
 > I ran into a similar problem recently -- though looking
 > at the patch below I can't prove it is the exact same problem.
 > 
 > Patch appears to put a space, + or - on each line.
 > Somebody edited their patch with kate, and that automatically
 > "cleaned up" the lines with just a space on them -- leaving
 > them completely blank.
 > 
 > patch ate the result, but git-am (and git-apply) did not.
 > fixed it by refreshing with quilt.

Through some more trial and error, it turned out that chopping
off the footer of the email (the last two lines here..)

 > > @@ -716,7 +739,7 @@ static int __init longhaul_cpu_init(stru
 > >  	return 0;
 > >  
 > >  err_acpi:
 > > -	printk(KERN_ERR PFX "No ACPI support for CPU frequency changes.\n");
 > > +	printk(KERN_ERR PFX "No ACPI support. No VT8601 or VT8623 northbridge. Aborting.\n");
 > >  	return -ENODEV;
 > >  }
 > > 
 > > 
 > > ----------------------------------------------------------------------
 > > Jestes kierowca? To poczytaj! >>> http://link.interia.pl/f199e

Made it all work.
Very strange.

	Dave
