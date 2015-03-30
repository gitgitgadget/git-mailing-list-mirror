From: Mike Hommey <mh@glandium.org>
Subject: Re: Walking children commits?
Date: Tue, 31 Mar 2015 08:44:45 +0900
Message-ID: <20150330234445.GA23391@glandium.org>
References: <20150330230209.GA20421@glandium.org>
 <20150330233552.GA22637@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 01:45:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcjMd-0000oE-13
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 01:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbbC3Xov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 19:44:51 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:56721 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbC3Xov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 19:44:51 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YcjML-00067X-MX
	for git@vger.kernel.org; Tue, 31 Mar 2015 08:44:45 +0900
Content-Disposition: inline
In-Reply-To: <20150330233552.GA22637@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266491>

On Tue, Mar 31, 2015 at 08:35:52AM +0900, Mike Hommey wrote:
> On Tue, Mar 31, 2015 at 08:02:09AM +0900, Mike Hommey wrote:
> > Hi,
> > 
> > I am trying to get all the children commits of a set of commits. To do
> > that, I'm using this:
> > 
> >   git rev-list --topo-order --ancestry-path --boundary <all heads> ^A ^B ...
> > 
> > where A, B, and following are those commits I want the children of. From
> > the gitrevisions documentation, it seems that should get me what I want,
> > but if I build a dag manually (from the output of rev-list --parents)
> > and get all the children of those commits, I get more results than what
> > the command above returns (and that command also gives false positives).
> 
> The false positives are actually boundaries other than A, B, etc. so I'd
> actually need to remove --boundary and add A, B to the result manually.
> That still leaves the missing results, though.

Ah, the missing results are commits that both are part of the set of
commits and are heads...
So all in all --ancestry-path works for my use case, but I need
post-processing.

Mike
