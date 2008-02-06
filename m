From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make use of the $git_dir variable at sub git_get_project_url_list
Date: Wed, 06 Feb 2008 11:37:51 -0800 (PST)
Message-ID: <m3ve51511t.fsf@localhost.localdomain>
References: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMq6J-0006TF-6J
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYBFTh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbYBFTh5
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:37:57 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:21346 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824AbYBFTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:37:56 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2515979hsz.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 11:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=QZwdaqpkNfNX/1WK+oNh/cqMRi7h5wLn+iq7FYzRNRw=;
        b=iYE8RiJU6rqoRIIEHmeSpyhmGmkVAihjS19LXL+ZmVoedgZj+zrF/J8M6oD/uuCUD2KXj+iBKxtOLfB8DZxCGibAM455+tl0QOml2Ho2iJTuJ8pOGboLeKcvNeaeJJ9gdpHSWGirDSLmmLhGGCnSbVrlFsR16D2S/eQqKa/R2MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=fr9VL24UzWWrIzAazFi9DuaTz/kj8gdoRa3GTfHBEwl+WK3jx/55DgIUROcdxKbEHQbgRZxS8Ak9Av4loQg/T3BIEnea+4gpA8GKoWoMD5ISlQFhy/nqACMxWq5UDW3uh8KpTB+/HtNTVyUq7Gizv6ejLKxSLn13Jz6KRchNRnc=
Received: by 10.78.100.1 with SMTP id x1mr18478684hub.45.1202326672845;
        Wed, 06 Feb 2008 11:37:52 -0800 (PST)
Received: from localhost.localdomain ( [83.8.239.145])
        by mx.google.com with ESMTPS id z33sm7892092ikz.0.2008.02.06.11.37.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 11:37:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m16JbXpj014959;
	Wed, 6 Feb 2008 20:37:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m16JbJOI014955;
	Wed, 6 Feb 2008 20:37:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72831>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> @@ -1620,7 +1620,7 @@ sub git_get_project_url_list {
>  	my $path = shift;
>  
>  	$git_dir = "$projectroot/$path";
> -	open my $fd, "$projectroot/$path/cloneurl"
> +	open my $fd, "$git_dir/cloneurl"
>  		or return wantarray ?
>  		@{ config_to_multi(git_get_project_config('url')) } :
>  		   config_to_multi(git_get_project_config('url'));

Good catch (although it wasn't actually a bug).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
