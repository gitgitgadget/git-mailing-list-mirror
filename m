From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] revert: only suggest to commit if not passing -n
Date: Fri, 23 Jul 2010 12:42:18 -0400
Message-ID: <20100723164218.GA2284@localhost.localdomain>
References: <1279806692-6762-1-git-send-email-carenas@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 18:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLKd-0003IM-F3
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 18:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760688Ab0GWQmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 12:42:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42708 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760660Ab0GWQmY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 12:42:24 -0400
Received: by qwh6 with SMTP id 6so3678386qwh.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7ChiaCYyNgrtyVYTeS+0iZpCSlM0wf88byzGwQQho0M=;
        b=Wm+6QG45859+lvH5XQVivvt27DKdmaX+ANA3vrUMxzxgUCA3Bl+OgpXC4zo1aOb2jA
         1cEJwNdJR4xmUMXvccoopekVk9bCDCT9/93+/wjwZQoklKVAe1yNqj5M7m8/QHafNZ6O
         uRwAHZYgt/Oa1MKB6Zm0bsMaQ4LTVJcsZBsN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hd0Lm/nh2UWTnpdyHivkqs7BRsMwdLZif9U7/bdVjSjT5fNNN2eCHANC928NsIUf4x
         4axeIsCdas7lFwWEespH7iAGEPyf4GmXUt7HyYkUC920XPchb8ltPDes9l+4urrdydrR
         trw5MNwwK5TvE9TjWhOqDES6gAaAC0TAIl6yI=
Received: by 10.224.28.213 with SMTP id n21mr2888621qac.53.1279903343199;
        Fri, 23 Jul 2010 09:42:23 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id js14sm432841qcb.30.2010.07.23.09.42.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 09:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279806692-6762-1-git-send-email-carenas@sajinet.com.pe>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151547>

On Thu, Jul 22, 2010 at 06:51:32AM -0700, Carlo Marcelo Arenas Belon wrote:
>  	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
> -		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
> -		"and commit the result");
> +		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'");
> +	if (!no_commit) {
> +		strbuf_addf(&helpbuf, "\nand commit the result");

Shouldn't we use strbuf_addstr here? We aren't using the formatting
part of strbuf_addf.
