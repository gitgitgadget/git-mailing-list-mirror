From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Fri, 5 Jul 2013 17:56:59 +0000 (UTC)
Message-ID: <loom.20130705T195116-413@post.gmane.org>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com> <CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 19:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvAG2-0006Hh-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 19:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597Ab3GER5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 13:57:18 -0400
Received: from plane.gmane.org ([80.91.229.3]:49936 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab3GER5S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 13:57:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UvAFw-0006D7-97
	for git@vger.kernel.org; Fri, 05 Jul 2013 19:57:17 +0200
Received: from a88-157-197-173.static.cpe.netcabo.pt ([a88-157-197-173.static.cpe.netcabo.pt])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 19:57:16 +0200
Received: from vitor.hda by a88-157-197-173.static.cpe.netcabo.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 19:57:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.157.197.173 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229671>

Matthieu Brucher <matthieu.brucher <at> gmail.com> writes:
> 
> Hi,
> 
> I'm trying to convert a Perforce repository to git, knowing that:
> - I use client specs to remove a bunch of folders containing binaires
> (several GiB)
> - branch mappings may not be properly set, and I can't change them
> 
> Now, the branches are layout like this:
> - Branch/Main <- master
> - Branch/Feature1
> - ...
> - Releases/2013
> - ...
> I would like to have these branches and releases branches inside by
> cloned git repository, but this doesn't work. I keep on getting each
> file with Project/Branch/Main as well as Project/Branch/Feature1 and
> all others in my master branch.
> I tried to add branchLists like this:
>         branchList = Branch/Main:Releases/2013
>         branchList = Releases/2013:Branch/Feature1
> but it doesn't change a thing with the following command:
>  git p4 clone --verbose --use-client-spec --detect-branches
> //Depot/Project <at> specificrevision
> 
> I can see that branches are detected from the Perforce server, but
> none are actually detected for this specific project:
> p4-git branches: []
> initial parents: {}
> 
> Can someone give a pointer to a tutorial or something for a complex
> case like this?

Hi Matthieu,

Could you please try using //Depot/Project<at>all instead of selecting a
specific revision? 
Also, by using that command it means that the following depot paths must
exist:
//Depot/Project/Branch/Main
//Depot/Project/Releases/2013
//Depot/Project/Branch/Feature1

I've never used the --use-client-spec, so I'm not sure if that will not
break the branch detection code.

Cheers,
Vitor

P.S. - Please keep me in CC because I'm not subscribed to the mailing
list.
