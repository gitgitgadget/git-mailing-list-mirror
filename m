From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] submodule: drop the top-level requirement
Date: Tue, 9 Apr 2013 22:29:46 +0100
Message-ID: <20130409212946.GH2222@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
 <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
 <7vobdnpgfv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 23:30:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPg7A-0006tg-QP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 23:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936314Ab3DIV36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 17:29:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34960 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934470Ab3DIV36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 17:29:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6C6D5CDA5A9;
	Tue,  9 Apr 2013 22:29:57 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tllEtO-861-a; Tue,  9 Apr 2013 22:29:56 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 10830CDA59C;
	Tue,  9 Apr 2013 22:29:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vobdnpgfv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220637>

On Tue, Apr 09, 2013 at 02:00:52PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > +	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
> 
> This may be handier than having to do the "for arg" loop git-am uses
> yourself.
> 
> >  	(
> >  		git ls-files --error-unmatch --stage -- "$@" ||
> >  		echo "unmatched pathspec exists"
> > @@ -335,6 +339,8 @@ cmd_add()
> >  		usage
> >  	fi
> >  
> > +	sm_path="$wt_prefix$sm_path"
> 
> But this is doing fine without "rev-parse --prefix" at all.

In this case we only have a single argument (and it must have a value).
In the cases using "rev-parse --prefix" we can have any number of
arguments (including zero).
