From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 23:53:58 -0500
Message-ID: <20091031045358.GA9565@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091031013934.GD5160@progeny.tock>
 <7vk4yccodl.fsf@alter.siamese.dyndns.org>
 <20091031022347.GA5569@progeny.tock>
 <7vws2cb8bp.fsf@alter.siamese.dyndns.org>
 <20091031040003.GA6022@progeny.tock>
 <20091031040436.GB6022@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 05:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N45ob-00028j-7A
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 05:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbZJaEnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 00:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbZJaEni
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 00:43:38 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48168 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbZJaEni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 00:43:38 -0400
Received: by yxe17 with SMTP id 17so3289761yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 21:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uy1y6mHJ8qFVWCA+6zUpWvtBebIG7kNvXBrUfn3Itw0=;
        b=Un8a6ztqjeyGYsnbXZHIy+EMQBlfcNOpByLcl8xTgDzPdYH4HOvPh5lbSvJL86CYJe
         w/V0eI63t2paiGCdhFir2ZDKS0/618SDqkmmcSL3b6di4wmne1pX04/Xz3Ee7fhGhuu3
         /9GG30ECvJJ98cHIpygwwEHbW3vJ8SuzvjHJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UGLv3ZNdVWyS63lHsvGfbnfWgbdL/dRHfrtvKaO3nG/AlA9yvFBFwPgqipgN3ImQVt
         o1ainGY7xhC3NJvCggNy90i0977j5b6c/gyzWiy6q7ddTQbZw+5ksq2Pr7TePq4fOi9d
         X2xZ4oHlcfALsGVVXgaY3lKkT20cJHOrk0jA4=
Received: by 10.150.130.24 with SMTP id c24mr4407179ybd.168.1256964222978;
        Fri, 30 Oct 2009 21:43:42 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm469721gxk.3.2009.10.30.21.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 21:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031040436.GB6022@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131833>

A typo fix --- sorry for the noise.

Jonathan Nieder wrote:

> --- a/var.c
> +++ b/var.c
> @@ -8,6 +8,16 @@
>  
>  static const char var_usage[] = "git var [-l | <variable>]";
>  
> +static const char *editor(int flag)
> +{
> +	const char *pgm = git_editor();
> +
> +	if (!pgm && flag & IDENT_ERROR_ON_NO_NAME)
> +		die("terminal is dumb, but VISUAL and EDITOR unset");

Agh...  s/VISUAL and //.

All right, time to sleep.  Apologies for all the mistakes, and thanks
for the help catching them.

Kind regards,
Jonathan
