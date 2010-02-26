From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Having keywords without value is not a global error.
Date: Fri, 26 Feb 2010 18:44:31 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002261838360.8597@vqena.qenxr.bet.am>
References: <c28821e9079f35e7267a1e7381ccf7793c12bf24.1267156694.git.sdrake@xnet.co.nz> <7vk4u0efxy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 06:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkt86-0004h2-Df
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 06:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab0BZFwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 00:52:41 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:33218 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab0BZFwd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 00:52:33 -0500
Received: from idran.drake.org.nz (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id 0BAF717079C;
	Fri, 26 Feb 2010 18:52:30 +1300 (NZDT)
In-Reply-To: <7vk4u0efxy.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141108>

On Thu, 25 Feb 2010, Junio C Hamano wrote:
> Steven Drake <sdrake@xnet.co.nz> writes:
> 
> > It is not a good Idea to give a config_error for _any_ keyword without a
> > value as it means that
> >
> > 	[section]
> > 		keyword
> >
> > sytle can not be using for setting bool type keyword.
> >
> > Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
> > ---
> >  builtin/init-db.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 9273942..edc40ff 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -170,8 +170,6 @@ static void copy_templates(const char *template_dir)
> >  
> >  static int git_init_db_config(const char *k, const char *v, void *cb)
> >  {
> > -	if (!v)
> > -		return config_error_nonbool(k);
> >  	if (!strcmp(k, "init.templatedir"))
> >  		return git_config_pathname(&init_db_template_dir, k, v);
> 
> But then don't you need to catch init.templatedir does have a string
> value?

Yes, but the change dose not touch that test, it removes two lines that I
can't remember why a put there.

-- 
Steven
