From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 13:33:49 -0500
Message-ID: <1263321111-sup-4827@ezyang>
References: <1263319565-sup-1767@ezyang> <28c656e21001121029h42544f3er6eedf8465851fec1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: B Smith-Mannschott <bsmith.occs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:38:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUldq-0000Bg-7e
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab0ALSiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910Ab0ALSiy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:38:54 -0500
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:42958 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766Ab0ALSiy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 13:38:54 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2010 13:38:54 EST
X-AuditID: 12074423-b7c94ae000000269-5d-4b4cc09010d7
Received: from central-city-carrier-station.mit.edu (CENTRAL-CITY-CARRIER-STATION.MIT.EDU [18.7.7.72])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id BC.3A.00617.090CC4B4; Tue, 12 Jan 2010 13:33:52 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by central-city-carrier-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0CIYiAa000159;
	Tue, 12 Jan 2010 13:34:45 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0CIXk8i026564;
	Tue, 12 Jan 2010 13:33:47 -0500 (EST)
In-reply-to: <28c656e21001121029h42544f3er6eedf8465851fec1@mail.gmail.com>
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136748>

Excerpts from B Smith-Mannschott's message of Tue Jan 12 13:29:41 -0500 2010:
> How do you imagine that this would work in a distributed system such
> as git? What would it mean to have the lock for "a file", when each
> user effectively has their own branch?

Hi Ben,

Good question.  I don't intend for the locking mechanism to leak into
the distributed model of Git. It is solely for working copies, which /are/
centralized (just there can be a lot of them), when multiple people might
be editing the same working copy.

There is a somewhat natural question of: well, you should clone, make your
changes in your own copy, and then push them back.  That is arguably the
correct mechanism.  However, for casual users batonning changes from one
repository to another is often more overhead than is really necessary, and
I think a working copy locking mechanism will help for simple cases.

Cheers,
Edward
