From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 9/9] Add a sample user for the svndump library
Date: Wed, 30 Jun 2010 14:09:33 +1200
Message-ID: <1277863773.23613.14.camel@wilber>
References: <20100624105004.GA12336@burratino>
	 <20100624110752.GI12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 04:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTmkJ-0003TN-B6
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab0F3CJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:09:29 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52967 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab0F3CJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:09:28 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7C793FCD30; Wed, 30 Jun 2010 14:09:27 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 20BF4FCD2D;
	Wed, 30 Jun 2010 14:09:22 +1200 (NZST)
In-Reply-To: <20100624110752.GI12376@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149934>

On Thu, 2010-06-24 at 06:07 -0500, Jonathan Nieder wrote:
> +To support incremental imports, 'svn-fe' will put a `git-svn-id`
> +line at the end of each commit log message if passed an url on the
> +command line.  This line has the form `git-svn-id: URL@REVNO UUID`.

If you are importing from an svk mirror or svnsync mirror, it will be
required to rewrite this portion.

> +Empty directories and unknown properties are silently discarded.

Yeah.  These should probably be carried over in this pass.  Revision
properties could possibly be converted to extra RFC822-style headers in
the commit message.  Directory properties can go under $dir/.svnfe-props
(use an empty file to mark empty directories) and $filename.svnfe-props
- it is up to the data mining phase whether it wants to actually do
anything with that data later.

Sam
