From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 to deepen
 into full repo again
Date: Fri, 20 Aug 2010 14:58:51 +0530
Message-ID: <20100820092847.GF12794@kytes>
References: <201008180854.18474.ComputerDruid@gmail.com>
 <m362z6pact.fsf@localhost.localdomain>
 <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
 <201008201122.09392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>,
	computerdruid <computerdruid@gmail.com>, joey <joey@kitenet.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 11:30:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNw4-0000RR-0t
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0HTJas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 05:30:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60451 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0HTJaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:30:46 -0400
Received: by pwi7 with SMTP id 7so945556pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7CZbUhc9n9TVxpEbelNkDBmDhzqg8iLpiDlaLia1LC4=;
        b=j++TMK+i2ukW83moSnizqmb1xe6Ua9z4cMz9QhyrHy3O/IHrR8ZKcJnlMAbnaK70vZ
         +F8ZFcj9DpIcR8/3ZDzMkyMZ56oh21KZosaLll6F7nCd5v06hHI+9jDilzuZ14k0FTnQ
         RSpmS3f6N8PaInw0fFn8Z2vPY6HGGOFvGVvj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CrX8xAT4sLh/3K3mXZJaeMVZXMe7MIRAFFqQV4vNjXIOUjrHklO/Xj7CNSNPjGqKtr
         lCO3iXT1XfmdHCgxA0MbBE6TtO08Ny2NNM0FKGAZB7MCOEiK7e4HIXVLrxJd8XXJdmid
         Wf3As76E3Vs13lryH5jIPoTCbfTupD99ZlVaI=
Received: by 10.114.120.4 with SMTP id s4mr1202511wac.212.1282296646030;
        Fri, 20 Aug 2010 02:30:46 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x9sm4484579waj.3.2010.08.20.02.30.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 02:30:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008201122.09392.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153992>

Hi Jakub,

Jakub Narebski writes:
> >> Second, it would be nice (though probably not easy with parseopt, as
> >> it would require hacks/extensions) to be able to use --depth=inf
> >> (like wget supports '-l inf') to mean infinite depth...
> > 
> > Hmm.. make --depth a string parameter and fetch-pack should parse the
> > parameter itself, like git-clone. Good idea.
> 
> If there were more options that use <n> == 0 to actually mean unlimited
> (infinity), perhaps it would be better to extend parseopt to provide for
> such situation, e.g. OPT_INT_INF or something.  This way we would avoid
> code duplication.
> 
> ... oh, wait, the newly introduced[1] git-merge `--log-limit' option
> uses --log-limit=0 to mean unlimited.
> 
> [1] http://permalink.gmane.org/gmane.comp.version-control.git/153984
>     Message-ID: <20100820081641.GA32127@burratino>
>     Subject: Re: wishlist bugreport: make limit configurable for do_fmt_merge_msg (merge.log)

Just outdated by a few seconds. Johannes suggested that we reuse
merge.log, making it a bool_or_int option. I What about using -1 to
mean infinity and reserving 0 for false instead?

-- Ram
