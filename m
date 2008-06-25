From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 02:30:09 -0700 (PDT)
Message-ID: <m37icdkgkl.fsf@localhost.localdomain>
References: <20080625023352.GC20361@mit.edu>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6@3N@FEDjCXZO>
	<10634.0258535512$1214372002@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBRLL-0000y2-G5
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYFYJaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 05:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYFYJaO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 05:30:14 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:6453 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYFYJaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 05:30:12 -0400
Received: by hu-out-0506.google.com with SMTP id 28so14118478hub.21
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+DI6Lv5mS2VcnIhPlIgtkcovcnO1HopBPxaANNo6o2c=;
        b=Cvvw2/oFxBlPgkgTT79aEDRIXj1CXZmbCOjFwN19jCbNGSPsPD0GcRiXpoBIrRhOFM
         GrgLSW74HuzgF9zBtyu/95dlnI3UeIsemzL6oVJpXyJ8d8DwXh7tWGlp0F1M15XZM3DV
         2LDEbr9MOMbcn9e54tcqFzD5RThV2JXwdoMg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Q7sYUNYRelPAb/HVNir5qRsZaJaDyBUiVP8v/pYHoYWbjJUVIoLzv+RiewwLuaStFR
         4RSWaeJx1BU61F29ipueegRGAkxOPRbNa8D27V/LK8ZKXfHj13yDhWhZBvaRUPo02mQT
         zlojjmPa5GyTGOVZhaYY1Y/kuHG4j70Dn9IoI=
Received: by 10.86.66.19 with SMTP id o19mr10096611fga.62.1214386210507;
        Wed, 25 Jun 2008 02:30:10 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id e11sm12731983fga.4.2008.06.25.02.30.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 02:30:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5P9U480014401;
	Wed, 25 Jun 2008 11:30:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5P9U3cO014398;
	Wed, 25 Jun 2008 11:30:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <10634.0258535512$1214372002@news.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86262>

"David Jeske" <jeske@willowmail.com> writes:
> -- Theodore Tso wrote:
> > ???
> > > 
> > > (a) safely "share" every DAG, branch, and tag data in their
> > > repository to a well-connected server, into an established
> > > namespace, while only changing branches and tags in their
> > > namespace. This will allow all users to see the changes of other
> > > users, without needing direct access to their trees (which are
> > > inaccessible behind firewalls). [1]
> >
> > Right, so thats github and/or git.or.cz. Each user gets his/her own
> > repository, but thats a very minor change. Not a big deal.
> 
> ...most notably, all their DAGs in a single repository to save space
> is important. Thousands of copies of thousands of repositories adds
> up. Especially when most of the users who want to commit something
> probably commit <1-10k of unique stuff. Seems pretty easy to change
> though. git.or.cz and github will both be wanting this eventually.

repo.or.cz has support for forks, i.e. sharing object database (for
old objects) via alternates, although it is not "common object
database" (as in, for example, $GIT_DIR/objects symlinked to single
common parent repository)

GitHub has also some support for "forks", but as it is closed source I
don't think anybody knows how it is done.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
