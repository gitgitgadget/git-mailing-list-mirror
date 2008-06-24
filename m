From: "David Jeske" <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 08:08:13 -0000
Message-ID: <47013.6552271017$1214295841@news.gmane.org>
References: <m3mylbl0xb.fsf@localhost.localdomain>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5kQf4FEDjCXUa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3oc-0006Je-Uh
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbYFXIWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755804AbYFXIWk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:22:40 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60064 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754012AbYFXIWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:22:37 -0400
Received: (qmail 10349 invoked by uid 90); 24 Jun 2008 08:22:14 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Tue, 24 Jun 2008 08:08:13 -0000
In-Reply-To: <m3mylbl0xb.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86014>

To re-ask the same question I asked in my last post, using your ascii
pictures...


Let's assume we're here..

.<---.<---.<---A<---X<---Y    <--- master
\
\--B<---C    <--- customer_A_branch <=== HEAD


And this person and everyone else moves their head pointers back to master
without merging:


.<---.<---.<---A<---X<---Y    <--- master              <=== HEAD
\
\--B<---C    <--- customer_A_branch


Now, five years down the road, our tree looks like:


.<---A<---X<---Y<---.<--.<--.(3 years of changes)<---ZZZ<--- master  <=== HEAD
\
\--B<---C   <--- customer_A_branch

And someone does:

git-branch -f customer_A_branch ZZZ

To bring us to:

.<---A<---X<---Y<---.<--.(3 years of changes)<---ZZZ<--- master  <=== HEAD
\                                           \
\--B<---C                                   \-- customer_A_branch


..at this point, will a GC keep "B<--C", or garbage collect the commits and
throw them away?
