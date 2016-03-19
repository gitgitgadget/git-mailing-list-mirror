From: Josh Triplett <josh@joshtriplett.org>
Subject: Properties of trees referencing commit objects (mode 160000)?
Date: Sat, 19 Mar 2016 15:13:48 -0700
Message-ID: <20160319221348.GA5247@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 23:14:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahP8C-0002gi-M1
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbcCSWN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 18:13:57 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41360 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbcCSWNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 18:13:55 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id EE11B17209D
	for <git@vger.kernel.org>; Sat, 19 Mar 2016 23:13:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 7nWTd1JmUkp6 for <git@vger.kernel.org>;
	Sat, 19 Mar 2016 23:13:51 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F0FC7172098
	for <git@vger.kernel.org>; Sat, 19 Mar 2016 23:13:50 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289325>

I'm building some tools to track commit objects, and I'm thinking of
using submodule-style references to commit objects in tree objects (mode
160000) to do so.  I'm trying to figure out some of the properties of
that.

Can a commit object referenced that way live in the same repository,
rather than some external repository?

Will git treat such a reference as keeping the commit object (and
everything recursively referenced by it) live and reachable?  If that
commit object is only reachable by the tree, and not by following the
parents of any commit directly referenced from refs/*, will git discard
it as unreachable?

- Josh Triplett
