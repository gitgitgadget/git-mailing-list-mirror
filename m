From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Mon, 22 Jan 2007 16:33:48 +0100
Message-ID: <81b0412b0701220733j1002bd9dse8db491512c7a500@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701191310.32417.jnareb@gmail.com>
	 <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200701192344.11972.jnareb@gmail.com>
	 <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701220706w65ed0657h1d69819e7879ed40@mail.gmail.com>
	 <Pine.LNX.4.63.0701221619110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 16:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91Bb-0008KC-1F
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 16:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAVPdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXAVPdw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 10:33:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:16469 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXAVPdv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 10:33:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1347221nfa
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 07:33:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fYhoduOwE8WrucxOrFBxyoUJ1yTVdvK4OaT8DpfUzsjrq3Dz6bISvFjHmHwqZLTErdvhMeI4hIkL6QHSvjbkLkP036GOizhDNTkyugUffkprzJZUzQQHITvVkiubEbZMlGqZ48f6OHHxSKoR2EMq8q0YBOvKWIFbHgZeWcTIZ2k=
Received: by 10.82.105.13 with SMTP id d13mr6905756buc.1169480028750;
        Mon, 22 Jan 2007 07:33:48 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 07:33:48 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701221619110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37418>

On 1/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> BTW IMHO we will probably never libify git; too many too complicated cases
> exist already.

We probably don't need it libified completely. Just reading and writing of
the object database and tags/references and very simple revision walking
will be a very good start and possibly enough for anything which _uses_ the
database, like importers and exporters.from other VCS or just programs which
need a versioned storage. Comparing, archeology and maintenance tasks are
more often done manually and can wait (they do now, don't they?) until the
rest of diff, patch and revision walking machinery libified properly.
