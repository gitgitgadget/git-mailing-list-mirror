From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] Speed up bash completion loading
Date: Tue, 17 Nov 2009 16:59:23 -0800
Message-ID: <20091118005923.GB11919@spearce.org>
References: <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com> <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock> <4AFDC4F3.1050607@gmail.com> <20091114110141.GB1829@progeny.tock> <7vd43krwd0.fsf@alter.siamese.dyndns.org> <20091115102912.GA4100@progeny.tock> <4B010D42.4090902@gmail.com> <20091118004910.GA5729@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	SZEDER G?bor <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:59:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYtN-0002p5-HO
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbZKRA7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbZKRA7R
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:59:17 -0500
Received: from george.spearce.org ([209.20.77.23]:32827 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZKRA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:59:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 58C9138425; Wed, 18 Nov 2009 00:59:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091118004910.GA5729@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133122>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Since git is not used in each and every interactive xterm, it
> seems best to load completion support with cold caches and then
> load each needed thing lazily.  This has most of the speed
> advantage of pre-generating everything at build time, without the
> complication of figuring out at build time what commands will be
> available at run time.
> 
> On this slow laptop, this decreases the time to load
> git-completion.bash from about 500 ms to about 175 ms.
> 
> Suggested-by: Kirill Smelkov <kirr@mns.spb.ru>

Yup, still...

> Acked-by: Shawn O. Pearce <spearce@spearce.org>

:-)

> I do not know whether it is kosher to carry over an ack like this.
> The interdiff is small, for what it???s worth:

Usually you leave it in if all you've done is address minor reviewer
comments and they had actually supplied an Acked-by line for the
prior version.

Its also usually fine to leave it like this, because there is a
good chance that the reviewer will agree with the new version and
it saves Junio from needing to insert the line himself later.

But it would be bad form to leave an Acked-by in if there was a major
rewrite.  E.g. this particular fix has gone through some really major
rework to reach this point, keeping an Acked-by from the very first
"speedup loading" patch (which IIRC computed them at build time) into
this one would be quite unfriendly.
 
-- 
Shawn.
