From: Daniel Shahaf <d.s@daniel.shahaf.name>
Subject: RE: [PATCH] Add svnrdump
Date: Thu, 8 Jul 2010 11:17:53 +0300 (Jerusalem Daylight Time)
Message-ID: <alpine.561.2.00.1007081113210.3936@daniel2.local>
References: <20100708083516.GD29267@debian> <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Ramkumar Ramachandra' <artagnon@gmail.com>,
	dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Bert Huijben <bert@qqmail.nl>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWp7t-0001Lg-UP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab0GHLSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:18:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53328 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753513Ab0GHLSk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 07:18:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 37EE515CE1E;
	Thu,  8 Jul 2010 07:18:33 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 08 Jul 2010 07:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=smtpout; bh=vq2pTrdubAvQ4aDXwnj/dPGqwxQ=; b=bprFMGKzO36Kzg4gvHXSJHcfMk9PCrjFguzqpOhePFB2r9OmEmdrtV0E7fiybA9iVs9FG2efKBxMYQV8bh2epYXQ5ZQfx16tT/oqepvaPuJQnHR9i8ACzfZqSkcmGtilcBoXnjQahICkID+CPJEjl3Pgv6qL05bHCn6M/H89NsE=
X-Sasl-enc: zNZlGJVcRQtT8guzpPHZFKJ972EVIcV5tDOYsHaQPCXKS9wTtGQPzP8n0A9Xyg 1278587906
Received: from daniel2.local (bzq-109-65-49-152.red.bezeqint.net [109.65.49.152])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C36A4E753F;
	Thu,  8 Jul 2010 07:18:25 -0400 (EDT)
In-Reply-To: <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150561>

@Bert: could you please trim quoted patches to only the relevant parts?
Scrolling is tedious when I don't have have line folding available...

Bert Huijben wrote on Thu, 8 Jul 2010 at 12:28 -0000:
> > -----Original Message-----
> > From: Ramkumar Ramachandra [mailto:artagnon@gmail.com]
> > Sent: donderdag 8 juli 2010 10:35
> > To: dev@subversion.apache.org
> > Cc: Jonathan Nieder; Sverre Rabbelier; Git Mailing List
> > Subject: [PATCH] Add svnrdump
> > 
> > +  /* Use a temporary file to measure the text-content-length */
> > +  apr_err = apr_temp_dir_get(&tempdir, hb->pool);

svn_io_temp_dir()

> > +  if (apr_err != APR_SUCCESS)
> > +    SVN_ERR(svn_error_wrap_apr(apr_err, NULL));
> > +
> > +  hb->temp_filepath = apr_psprintf(eb->pool, "%s/svn-fe-XXXXXX",
> > tempdir);
> 

os.path.join()

Err, I mean, svn_dirent_join().
