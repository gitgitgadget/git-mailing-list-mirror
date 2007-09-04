From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 12:47:16 -0400
Message-ID: <9e4733910709040947ia32bda4i6e30efb2d7848308@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <46DD887D.3090508@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISbYh-0007kD-2x
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbXIDQrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbXIDQrS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:47:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:38246 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbXIDQrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:47:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1215869rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 09:47:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GWthZA3RH/w9aJmhZ+xkyJEEkQat5JawV80/cJUOR8ufPRQ3raEqThE/0jdD9ofLvKE1PZjyvqoSN2pZEEMsXO7/kDZOOP+8vjl9pX4dGIN1hpCU063gQotjnDUoCzIxJLO0jZPYwSiW0gXpNmpQqrrtOM58EJPmDrE46QnE5q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P7GUBEFzNq1Qt+wkRH/3SNXQuadVJYOvaBdEYdWf3otpwyekSzZJPDHwtcRln87BIotm45rSznLPfQg6uds5VUShokRic+SPFZZUScjtFXLMxstCftHfeeT7bR6DWOFxvBimnwlRiRwmvs7TgpwFO6+zcOtDW+SbYg7fOnOKL9c=
Received: by 10.141.107.13 with SMTP id j13mr2365146rvm.1188924436989;
        Tue, 04 Sep 2007 09:47:16 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 09:47:16 -0700 (PDT)
In-Reply-To: <46DD887D.3090508@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57614>

On 9/4/07, Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> > Another way of looking at the problem,
> >
> > Let's build a full-text index for git. You put a string into the index
> > and it returns the SHAs of all the file nodes that contain the string.
> > How do I recover the path names of these SHAs?
> >
>
> I wouldn't know, but presumably any table can have more than one column.
>
> Is this a problem you face with git so often that it requires a complete
> re-design of its very core?

That's the whole point. We need to discuss the impact of merging a
field (path names) with an index (tree nodes) has on future things we
may want to do with the data stored in git.

Databases don't usually blend fields/indexes without also duplicating
the field in the table. You need all the fields in the table so that
it is possible to create indexes on other fields.


>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>


-- 
Jon Smirl
jonsmirl@gmail.com
