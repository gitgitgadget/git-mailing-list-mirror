From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Locally manage user/branch setting files without pushing them
	remotely
Date: Wed, 11 Nov 2009 20:24:49 +0100
Message-ID: <20091111192449.GH27518@vidovic>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:25:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8IoP-0005EY-DP
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 20:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbZKKTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758617AbZKKTYt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 14:24:49 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:35195 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591AbZKKTYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 14:24:48 -0500
Received: by ey-out-2122.google.com with SMTP id 9so344587eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rl9e796UPEewheW8TSpRXfi8sZkmoc8iX1w7VaOGjiQ=;
        b=A0bUVsEPM9tSmfBZyMXNCCh6FF1UZY7NJArJtHxLU15DjoaVKAlGeWlMvaO3zNAaeD
         40XXSqjdeCGD46SXDeTSimbRuiIf5G4SAAzAeSREdzJCBW1HrKAOu3eIN+faboI9XB+Z
         lDp3ToE4PXNQI/CclfIPdJ+GsUtRcyMzpBcE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SyNY8V6MpeAU7BoPIXOjhKceywcWoGlIpHP0LYe/oOwxoTNs5wPL8GPjcV1uBOGQ+W
         zasDox39gE0F0o9rSKJF2eWji8u5CEKi2O92uXVzWiveKaMZEAxleN5fwZnIU1S2wGtS
         WdMBrxsxOqJR+3iuvfWl8u75qUipxOSXLD3/A=
Received: by 10.213.100.11 with SMTP id w11mr1955154ebn.34.1257967493083;
        Wed, 11 Nov 2009 11:24:53 -0800 (PST)
Received: from @ (88-121-116-229.rev.libertysurf.net [88.121.116.229])
        by mx.google.com with ESMTPS id 24sm1214923eyx.29.2009.11.11.11.24.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 11:24:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132689>

The 11/11/09, Daniele Segato wrote:

> The project has a lot of setting that are really binded to the user
> and should not go pushed in a remote repository (example: database
> connections parameters / filesystem paths)
> We have a .template file for those settings but the actual settings
> are really binded to the user environment.

This looks to _not_ be a piece of the development project. Settings used
for the tests suites, company where you work, etc _are_ clones (from the
abstract POV, at least) of the maintainer public repository.

If you want to track changes of settings in a per-production-repo basis,
you should do it _out_ of your main development repository. The latter
should have a publishable template instead (eg. "user = user_login",
"password = set_your_password").

-- 
Nicolas Sebrecht
