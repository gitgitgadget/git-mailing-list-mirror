From: Mike Crowe <mac@mcrowe.com>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 16 Nov 2015 18:31:06 +0000
Message-ID: <20151116183106.GA31731@mcrowe.com>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
 <CAGZ79kacpWFFWiE-KjwEQZC+3PZw2MrpsgQWLJyS82X5LF+Lqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 19:39:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyOg3-0001pS-3O
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 19:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbKPSis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 13:38:48 -0500
Received: from avasout05.plus.net ([84.93.230.250]:57885 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbKPSio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 13:38:44 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2015 13:38:44 EST
Received: from deneb ([80.229.24.9])
	by avasout05 with smtp
	id iJX61r0020BmcFC01JX7ah; Mon, 16 Nov 2015 18:31:07 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17 a=0Bzu9jTXAAAA:8
 a=-An2I_7KAAAA:8 a=kj9zAlcOel0A:10 a=qtqOOiqGOCEA:10 a=UG7U4OztC97U5JdqIDkA:9
 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84)
	(envelope-from <mac@mcrowe.com>)
	id 1ZyOYU-0008Ga-6n; Mon, 16 Nov 2015 18:31:06 +0000
Content-Disposition: inline
In-Reply-To: <CAGZ79kacpWFFWiE-KjwEQZC+3PZw2MrpsgQWLJyS82X5LF+Lqw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281350>

On Monday 16 November 2015 at 10:15:24 -0800, Stefan Beller wrote:
> The code itself looks good to me, one nit in the tests though.
> 
> > @@ -79,6 +87,119 @@ test_expect_success 'push succeeds after commit was pushed to remote' '
> >         )
> >  '
> >
> > +test_expect_success 'push succeeds if submodule commit not on remote but using on-demand on command line' '
> > +       (
> > +               cd work/gar/bage &&
> > +               >recurse-on-demand-on-command-line &&
> > +               git add recurse-on-demand-on-command-line &&
> > +               git commit -m "Recurse on-demand on command line junk"
> > +       ) &&
> > +       (
> > +               cd work &&
> > +               git add gar/bage &&
> > +               git commit -m "Recurse on-demand on command line for gar/bage" &&
> > +               git push --recurse-submodules=on-demand ../pub.git master &&
> > +               # Check that the supermodule commit got there
> > +               git fetch ../pub.git &&
> > +               git diff --quiet FETCH_HEAD master
> 
> Missing && chain here.

Oh, well spotted! I'll provide an updated version.

Thanks.

Mike.
