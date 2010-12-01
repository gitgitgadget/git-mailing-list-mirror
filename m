From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 1 Dec 2010 10:05:03 -0600
Message-ID: <20101201160503.GB26120@burratino>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:05:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpBO-0005Dh-UX
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab0LAQFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:05:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58003 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab0LAQFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 11:05:14 -0500
Received: by vws16 with SMTP id 16so384875vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/oNdO6fQOG2MlLbuCKwQCJDiLpXIxvjo6sflmhOVfHY=;
        b=G9D33Pzp34bbQp36OkO4RuiytN7ul6r8pUapAOoQM8L7FxevY4JnXZ8Nlk30PbXvGM
         WiD23Gs6y88bGEZ8Lqwj6TNn0ljRDZuh0eAS43dbMrtM8xLOUAY5ThWXFVoFzw6MWEaE
         cEX+apXVoiDayUjvNGxeDfcoCwsTA4rO8pGio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JSLVFRPc817uwXWKXw9y0GkaB5e0rDU2CtNOCiG0ECCzPK6frVGseA0Gq1ZWQ0B3S0
         W9l+ZgHFexnBy9j6O9C8ErrTxy3IniaIjgL1wDEUiBIT73wABHgMr4+MvCEmdbY4ad5i
         l5of8X3CkdyAi4AXOumoTrogo+0Q8jWgReUtw=
Received: by 10.220.203.66 with SMTP id fh2mr2401703vcb.16.1291219511123;
        Wed, 01 Dec 2010 08:05:11 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id j7sm35462vcr.15.2010.12.01.08.05.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:05:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162541>

Martin Langhoff wrote:

> So cvsimport.remote (for -r) and cvsimport.revisions (or
> trackrevisions perhaps) seem more appropriate.

I somewhat like this idea.  So let's build a full table, shall
we?  The embedded dashes are meant for the command-line options
rather than the config file.

	-v	verbosity
	-d	cvsroot
	-C	[doesn't make sense in a config file; you've already
		 found where to read the configuration from, right?]
	-r	remote
	-o	mainline
	-i	import-only
	-k	kill-keywords
	-u	replace-underscores
	-s	replace-slashes
	-p	cvsps-options
	-z	fuzz
	-P	[doesn't make much sense in a config file; for one-shot use]
	-m	detect-merges
	-M	merge-regex
	-S	ignore-paths
	-a	import-all
	-L	max-commits
	-A	authors-file
	-R	track-revisions
	-h	[doesn't make sense in a config file]

Hmm?
Jonathan
