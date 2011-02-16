From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Consistent terminology: cached/staged/index
Date: Wed, 16 Feb 2011 18:11:27 -0500
Message-ID: <1297897887.24521.57.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	 <4D589CE0.7020203@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 00:13:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpqYn-0004ql-V1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 00:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab1BPXNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 18:13:21 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:55433 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab1BPXNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 18:13:20 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1GNBYtO014572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Feb 2011 18:11:34 -0500
In-Reply-To: <4D589CE0.7020203@pcharlan.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC--Metrics: beryl.its.maine.edu 1356; Body=5 Fuz1=5 Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1GNBYtO014572
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1298502694.50184@SujH3R77jJfoccFg/C7E3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167020>


On Sun, 2011-02-13 at 19:09 -0800, Pete Harlan wrote:
> On 02/13/2011 02:58 PM, Junio C Hamano wrote:
> >> --staged
> >> ~~~~~~~~
> >> diff takes --staged, but that is only to support some people's habits.
> > The term "stage" comes from "staging area", a term people used to explain
> > the concept of the index by saying "The index holds set of contents to be
> > made into the next commit; it is _like_ the staging area".
> > 
> > My feeling is that "to stage" is primarily used, outside "git" circle, as
> > a logistics term.  If you find it easier to visualize the concept of the
> > index with "staging area" ("an area where troops and equipment in transit
> > are assembled before a military operation", you may find it easier to say
> > "stage this path ('git add path')", instead of "adding to the set of
> > contents...".
> 
> FWIW, when teaching Git I have found that users immediately understand
> "staging area", while "index" and "cache" confuse them.
> 
> "Index" means to them a numerical index into a data structure.
> "Cache" is a local copy of something that exists remotely.  Neither
> word describes the concept correctly from a user's perspective.

According to the dictionary (actually, more than one) "cache" is a
hidden storage space. I'm pretty sure that's the sense most global and
therefore most appropriate to thinking about Git. (It certainly
describes correctly what web browser cache and on-CPU cache is doing.)
One would only think the definition you gave applied if they didn't know
that squirrels "cache" nuts. I don't think that the problem is the
idiom.

> I learned long ago to type "index" and "cached", but when talking (and
> thinking) about Git I find "the staging area" gets the point across
> very clearly and moves Git from interesting techie-tool to
> world-dominating SCM territory.  I'm surprised that that experience
> isn't universal.

Perhaps that helps you associate it with other SCM/VCS software, but it
didn't help me. When I realized that the "index" is called that BECAUSE
IT IS AN INDEX (of content/data states for a pending commit operation)
the sky cleared and the sun came out.

In all reality the closest thing Git has to an actual staging area is
all of the objects in .git/objects only recorded by the index itself.
Git-stored objects not compressed into pack files could technically be
described as "cached" using the standard definition--they aren't visible
in the working directory. Unfortunately this probably just muddies the
water for all too many users.

So, in summary--the index is real, objects "cached" pending
commit/cleanup/packing are real; any "staging area" is a rhetorical
combination of the two. Given that rhetorical device may not work in all
languages (as Junio mentioned earlier) I don't recommend that we rely on
it.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
