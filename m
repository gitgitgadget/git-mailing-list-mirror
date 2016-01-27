From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: shorten glob error message
Date: Wed, 27 Jan 2016 02:54:08 +0000
Message-ID: <20160127025408.GA17600@dcvr.yhbt.net>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
 <20160113031601.GA28224@dcvr.yhbt.net>
 <20160114040759.GA7671@dcvr.yhbt.net>
 <xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com,
	Victor Leschuk <vleschuk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 03:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOGFK-0007EX-F0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 03:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbcA0CyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 21:54:10 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbcA0CyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 21:54:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4895F63380A;
	Wed, 27 Jan 2016 02:54:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284868>

Junio C Hamano <gitster@pobox.com> wrote:
> I am not sure if it is a good idea to show */*/* as an example in
> the message (that is an anti-example of 'one set of wildcard' by
> having three stars, isn't it?), but that is not a new issue this
> change introduces.

Actually, going back to commit 570d35c26dfbc40757da6032cdc96afb58cc0037
("git-svn: Allow deep branch names by supporting multi-globs"),
having equal '*' on both sides is all that is required.

Not sure how to improve the wording, though...

> >  	my $state = "left";
> > -	my $die_msg = "Only one set of wildcard directories " .
> > -				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
> > +	my $die_msg = "Only one set of wildcards " .
> > +				"(e.g. '*' or '*/*/*') is supported: $glob\n";
> >  	for my $part (split(m|/|, $glob)) {
> >  		if ($pattern_ok && $part =~ /[{}]/ &&
> >  			 $part !~ /^\{[^{}]+\}/) {
