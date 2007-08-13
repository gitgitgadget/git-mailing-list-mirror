From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git and linux kernel source
Date: Mon, 13 Aug 2007 11:27:14 -0400
Message-ID: <20070813152714.GF3122@fieldses.org>
References: <1186701106.3073.71.camel@localhost> <20070809231718.GH12875@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 17:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKbpZ-0000b2-Vj
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 17:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968388AbXHMP1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966736AbXHMP1U
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 11:27:20 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57008 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966577AbXHMP1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 11:27:16 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IKbp4-0002Hb-Nb; Mon, 13 Aug 2007 11:27:14 -0400
Content-Disposition: inline
In-Reply-To: <20070809231718.GH12875@fieldses.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55766>

On Thu, Aug 09, 2007 at 07:17:18PM -0400, bfields wrote:
> On Thu, Aug 09, 2007 at 04:11:46PM -0700, Joe Perches wrote:
> > A few linux kernel source and git questions:
> > 
> > What's the best procedure to handle a tree-wide source tranformation?
> > For instance:
> > 
> >   git branch foo2bar
> >   egrep -r -w --include=*.[ch] -l "foo" * | \
> > 	xargs perl -pi -e 's/\bfoo\b/bar/msg'
> >   git commit -a -m "use bar not foo"
> 
> 
> > Is there a way to separate the resultant single patch into multiple
> > patches by subdirectory?  Perhaps some git-rev-parse option?
> 
> Something like
> 
> 	for each sub/dir:
> 		git add sub/dir
> 		git commit -m "use bar not foo in sub/dir"
> 
> should do it.  (Of course, in the particular case above the patches you
> ended up with probably wouldn't compile individually.)

OK, now I feel like I have to ask--you're not seriously considering
doing anything like that, are you?

--b.
