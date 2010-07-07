From: Daniel Shahaf <d.s@daniel.shahaf.name>
Subject: Re: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed, 7 Jul 2010 20:51:17 +0300 (IDT)
Message-ID: <alpine.561.2.00.1007072048100.569@daniel1.local>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com> <1278461693-3828-3-git-send-email-artagnon@gmail.com> <20100707162516.GA1529@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 20:08:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZ2u-0007Te-D3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 20:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab0GGSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 14:08:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41103 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754435Ab0GGSIF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 14:08:05 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2F7111326DD;
	Wed,  7 Jul 2010 14:08:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 07 Jul 2010 14:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:subject:in-reply-to:message-id:references:mime-version:content-type; s=smtpout; bh=V/6i5EQ9R5FCLYdHDhPlZEdu1WE=; b=ixnko0k/kZWlxnnPQgHy8ls8QCoMkRi7NWxmbJ7OHOnZ5hXhtU1ccUMgeY3G7TivIckOwIQyoREwuJDqxyFXn3ZWxUDG7x4CT+BhCGL61HgsGSCdVJpVsF7Rfohz2hDcI9r/E9aBfFP+trweMD+MPDZgvWKVU1kl2ZSBtNzyD+8=
X-Sasl-enc: vAGajJ+a9Q5IC6rIAvPuOIGmObH7ioACq2Fa3I5yh/hUxNa2LgF84uOm5axgCQ 1278526082
Received: from [192.168.168.65] (bzq-109-65-49-152.red.bezeqint.net [109.65.49.152])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FE5B5CB49
	for <git@vger.kernel.org>; Wed,  7 Jul 2010 14:08:02 -0400 (EDT)
In-Reply-To: <20100707162516.GA1529@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150489>

Jonathan Nieder wrote on Wed, 7 Jul 2010 at 11:25 -0500:
> Ramkumar Ramachandra wrote:
> > +svn_error_t *populate_context()
> > +{
> > +	const char *http_library;
> > +	
> > +	SVN_ERR(svn_config_get_config(&(ctx->config), NULL, pool));
> > +	
> > +	http_library = getenv("SVN_HTTP_LIBRARY");
> > +	if (http_library)
> > +		svn_config_set(apr_hash_get(ctx->config, "servers", APR_HASH_KEY_STRING),
> > +		               "global", "http-library", http_library);
> 
> I tried googling for this SVN_HTTP_LIBRARY setting, but no
> useful hints.  I take it that this overrides the [global] http-library
> setting from ~/.subversion/servers?  Do other commands honor this
> environment variable or just svndumpr?

Other commands use --config-option.  SVN_HTTP_LIBRARY is not recognized
by any released Subversion, nor by trunk@HEAD of Subversion.

It's a debugging relic, anyway.  Can be removed.  The functionality is 
provided by editing $CONFIG_DIR/servers.
