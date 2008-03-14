From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Thu, 13 Mar 2008 20:27:34 -0400
Message-ID: <76718490803131727p451967hee96ff26206c97b7@mail.gmail.com>
References: <20080313231413.27966.3383.stgit@rover>
	 <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	 <20080314002205.GL10335@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxmT-00011O-8b
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYCNA1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbYCNA1f
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:27:35 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:2988 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYCNA1f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:27:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2223592rvb.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wBFuogiHll+RolsMMctxZhLYs+h0VcIXRaz9cLYm7X8=;
        b=Q0qgsbz8yXqKASjNg6UBfAEuT6or9mKnvy5JuS1xd27XyzulsGpNN4vnNKgGxRvJrBdJXjYOO95AotZy3+Pt6Y6iZtLcQGxmD40njLeoRytFnbjp3m6B1uKZBths+vxjj7OBUYjp64Dmc9vj9yXaJtbUWpP/IVorSOPV5fye75Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vm3Uedy681ez1PKeUwL1xDTVyMKP9g+Fvzb5OhkNz3mRCcWAnFQXIfOeayn0ISpJkQ/3LflJg8YV+j7ZhfNBvl8ZV8S2GkKyHbvdx+J2pVKlESSkVq25Gm8BW8LBiXDLvksmivGinRisQOXNL2271DRyzAqYDd3U9JpK9o//ahM=
Received: by 10.141.50.17 with SMTP id c17mr6229240rvk.191.1205454454762;
        Thu, 13 Mar 2008 17:27:34 -0700 (PDT)
Received: by 10.141.29.7 with HTTP; Thu, 13 Mar 2008 17:27:34 -0700 (PDT)
In-Reply-To: <20080314002205.GL10335@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77157>

On Thu, Mar 13, 2008 at 8:22 PM, Petr Baudis <pasky@suse.cz> wrote:

>  There is a more conceptual problem though - in case of such big sites,
>  it really makes more sense to explicitly regenerate the cache
>  periodically instead of making random clients to have to wait it out.

Fork off a child to update the cache?

>  Unlikely. Currently the machine is mostly IO-bound and only small
>  portion of CPU usage comes from gitweb itself.

Except that if it were FastCGI or mod_perl you could just keep the cache in
memory.

j.
