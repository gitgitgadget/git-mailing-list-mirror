From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 22:26:35 +0530
Message-ID: <20101020165630.GB13716@kytes>
References: <1287563970.2673.12.camel@wpalmer.simply-domain>
 <30010681.536316.1287584507672.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 18:57:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8byd-0005Ye-DY
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 18:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab0JTQ5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 12:57:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56328 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab0JTQ5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 12:57:15 -0400
Received: by yxm8 with SMTP id 8so1732688yxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o/NB0Ri39LDby3ClO9xX9pNS5cmApbefH0ohi4CYBvc=;
        b=Xta4RW6IODeEa890Ke5sGMnEOnw6kIQz7vyHfqhfFrk/Pe7LObuPDoFZwuCqiTLhGe
         u3W2bUJn5cYHfuR+VbNkahHm4GBTmIPEaNgZQ1iD7kWxuDF3H2P61qHaglEkSWGNBCib
         m7wn20ykVnuVbA355cK+6TG8o/Tf/WVA7y8jE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TrUUw7omVICl/FIQtz9VP7Ywl8fk27PcGuD9hATJsHNdU+43sSbShAJn2x3CRn+9W8
         DkLohQfUHSkXJCuM+UD5pG6mH6JFvWhGrVJ8i+7APRLhXKfzHDDIx6845LH1WbRJIIUg
         38La8Vh/QkxK9DtBXCQuDssxOnvQ+H+6v/N3g=
Received: by 10.90.36.6 with SMTP id j6mr626354agj.28.1287593834973;
        Wed, 20 Oct 2010 09:57:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f50sm324428yhc.38.2010.10.20.09.57.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 09:57:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <30010681.536316.1287584507672.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159417>

Hi Stephen,

Stephen Bash writes:
> > From: "Will Palmer" <wmpalmer@gmail.com>
> > I was under the impression that there
> > would be one "one-to-one" mapping branch (which would never be checked
> > out), containing the history of /, and that the "real" git branches,
> > tags, etc, would be based on the trees originally referenced by the root
> > checkout, with git-notes (or similar) being used to track the weirdness
> > in mappings.
> 
> Admittedly I'm not in the inner circle, but this is the first time
> I've heard the idea.

Do hang out on the development channel - a lot of stuff cooks there :)

> It's certainly intriguing.  In this case would
> the one-to-one branch include the full SVN repository history (all
> projects), or would svn-fe/git-fast-import filter down to
> subdirectories of interest?

Full history. Atleast that's what I was thinking about sometime ago.

> Along those lines I can contribute the following data point: my
> initial fast-import repository weighs in at 1.3G, while after my
> scripts run the final product is 659M (and no, they are not hard
> linking to each other).  Unfortunately I don't have a good
> accounting of the size difference (obviously some is filtering down
> to a single SVN project).

Yeah, David reported similar statistics after repacking the ASF
repository.

-- Ram
