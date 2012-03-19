From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
	what to push?
Date: Mon, 19 Mar 2012 14:26:35 -0400
Message-ID: <20120319182635.GA23181@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 20:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9i7p-00074l-HL
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 20:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab2CSTUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 15:20:06 -0400
Received: from mail.ladweb.net ([216.129.110.26]:58432 "EHLO mail.ladweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759219Ab2CSTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 15:20:04 -0400
X-Greylist: delayed 3207 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2012 15:20:04 EDT
Received: from people.danlj.org (danlj.colo.ladweb.net [10.0.0.2])
	by mail.ladweb.net (8.13.7/8.13.7) with ESMTP id q2JIQa6p011281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 19 Mar 2012 14:26:36 -0400
Received: from people.danlj.org (people.danlj.org [127.0.0.1])
	by people.danlj.org (8.14.2/8.14.2) with ESMTP id q2JIQaeY023473
	for <git@vger.kernel.org>; Mon, 19 Mar 2012 14:26:36 -0400
Received: (from johnsonm@localhost)
	by people.danlj.org (8.14.2/8.14.2/Submit) id q2JIQZ7l023472
	for git@vger.kernel.org; Mon, 19 Mar 2012 14:26:35 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193450>

Thank you for the public requests for comment on changing "git push"
semantics.  I don't have anything particularly new to say, so TL;DR
is: I think that changing the default value for push.default to
upstream would help advocate corporate Git adoption as potential
users experiment on their own, attracted by the benefits of "branchy"
development.  I don't think that my own ability to advocate for Git
is affected by this decision, but wanted to share the observation.

I am encouraging corporate adoption of Git for primary source
code control, and I see two reasons for making relatively centralized
workflows easy.

It is easiest to advocate for this change when more developers are
convinced that the initial adoption process will be relatively easy;
that they can change from existing centralized version control
to Git without synchronized, protracted productivity loss due to
a steep learning curve.  Don't get me wrong, they want to make
use of DVCS concepts, and they aren't interested in the change
without expecting benefits from the change, it's just that having a
centralized workflow available makes it easier to contemplate change.
The more developers involved, the harder it would be to try to
synchronize everyone's learning curve and the more value in a
centralized workflow being available.

As has been raised several times already, most corporations are most
comfortable with having one repository that is the official main
repository, a "primus inter pares" of repositories.  At least in
my own context, for business continuity we want developers to push
topic branches to the official central repository.  In practice, very
little truly disconnected development is done; the benefits of DVCS
in general and Git in particular lie mostly in the version graph, and
secondarily in the scalability derived from repository distribution.

The default setting of push.default=matching is confusing for new
users in practice, at least in centralized workflows.  It has been
confusing in practice that they need to synchronize their master
in order to synchronize their topic branch, and in order to find
the solution they need to have some idea what solution they are
looking for -- and expect that there is a solution.

Finally, my reasoning for "upstream" instead of "current" is that
I have heard in practice that quite a few developers who are interested
in Git but not yet familiar with it have heard that branches can have
different names in different repositories, and they like the idea.
They might want to track "origin/bug1234567" in "mybug" that is
shorter and easier to remember...  This is a minor point, in my
opinion.
