From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] rev-parse: add --filename-prefix option
Date: Mon, 8 Apr 2013 18:36:04 +0100
Message-ID: <20130408173604.GP2222@serenity.lan>
References: <cover.1365364193.git.john@keeping.me.uk>
 <ba2c7aa9eaa982306f1d5ad5ff2d26a6e2b8df85.1365364193.git.john@keeping.me.uk>
 <20130407221458.GE19857@elie.Belkin>
 <20130408083123.GN2222@serenity.lan>
 <7vmwt9ysaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:36:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFzQ-0000ax-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935043Ab3DHRgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:36:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:54614 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934068Ab3DHRgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:36:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 29DC96064E1;
	Mon,  8 Apr 2013 18:36:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdJ-Y1nT16JS; Mon,  8 Apr 2013 18:36:13 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8C18F6064D3;
	Mon,  8 Apr 2013 18:36:06 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vmwt9ysaz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220472>

On Mon, Apr 08, 2013 at 08:07:32AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Yes (ish), the intended usage is something like this:
> >
> >     prefix=$(git rev-parse --show-prefix)
> >     cd_to_toplevel
> >     ... parse options here ...
> >     # Convert remaining arguments (filenames) into top-level paths:
> >     eval "set $(git rev-parse --prefix "$prefix" --sq -- "$@")"
> >
> > The "ish" is that my current implementation introduced a new variable
> > instead of simply resetting the existing "prefix" variable, which I
> > assume is what you mean.
> 
> This is very sensible.

Which bit specifically?  I assume you agree with the intended usage, but
do you also mean that resetting the prefix returned from
setup_git_directory is the right way to approach this?
