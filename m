From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 22:57:03 +0200
Message-ID: <1114203423.3207.24.camel@localhost>
References: <1114166517.3233.4.camel@localhost>
	 <20050422142342.GG30915@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:11:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP5Q4-0007yT-M2
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 23:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVDVVOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDVVOX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 17:14:23 -0400
Received: from shadow.prohost.de ([216.71.84.228]:34391 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S262136AbVDVVNs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 17:13:48 -0400
Received: from blue (p54A23F84.dip.t-dialin.net [84.162.63.132])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3MLDah03714;
	Fri, 22 Apr 2005 23:13:36 +0200
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050422142342.GG30915@delft.aura.cs.cmu.edu>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 10:23 -0400, Jan Harkes wrote:
> On Fri, Apr 22, 2005 at 12:41:56PM +0200, Christian Meder wrote:
> > -------
> > /<project>/blob/<blob-sha1>
> > /<project>/commit/<commit-sha1>
> 
> It is trivial to find an object when given a sha, but to know the object
> type you'd have to decompress it and check inside. Also the way git
> stores these things you can't have both a blob and a commit with the
> same sha anyways.
> 
> So why not use,
>     /<project/<hexadecimal sha1 representation>
> 	will give you the raw object.
> 
>     /<project/<hexadecimal sha1 representation>.html (.xml/.txt)
> 	will give you a parsed version for user presentation
> 
> And since hexadecimal numbers only have [0-9a-f] as valid characters,
> you can still have additional directories that can be guaranteed unique
> as long as the first two characters are not a valid hexadecimal value.
> So things like /branch/linus, or /changelog/, /log/, /diff/. Yeah, you
> can't use /delta/ without looking at more than the first two characters,
> but that's where dictionaries can come in handy.

Hmm. I'm not sure about throwing away the <objecttype> information in
the url. I think I'd prefer to retain the blob, tree and commit
namespaces because I think they help API users to explicitly state what
kind of object they expect. I can't think of a scenario where I'd want a
<sha1> of unknown type. Do you have a specific use case in mind ?



				Christian     
-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

