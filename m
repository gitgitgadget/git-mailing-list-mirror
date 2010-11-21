From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebuild repo from data, packfiles?
Date: Sat, 20 Nov 2010 18:16:48 -0600
Message-ID: <20101121001643.GB27666@burratino>
References: <auto-000024044659@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tom fogal <tfogal@sci.utah.edu>
X-From: git-owner@vger.kernel.org Sun Nov 21 01:17:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJxcA-0000Rv-51
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 01:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab0KUARA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 19:17:00 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32939 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0KUAQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 19:16:59 -0500
Received: by gwb20 with SMTP id 20so701875gwb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 16:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lQGJvZG1lCeyOZ8nhDKgn5K16agZfU5JmzMAIbNUV8w=;
        b=smA98R6yIiWZFTR9h66m5OBzJop2pHu/HvQP5F0zkJ7kj7K3f2fDR3zYEry93DwWK5
         2PemUyKK/hAdVy9KqHJBLNBPKWcOGrsTwyIeyZIoaMWGPnsIhlfLuei6un5NExGaBSNO
         lwzPYR9pe2FV0aJ0wMX517ozb6/CQ+0zoZlRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W+KcIkPGzh+CTI4y+pMGaptBanfv20v+4Nm9oQ+9xMLCj37FOsUa6P35Ya2ovkacOH
         2n6KHSJMvDtRA6TqR8iibSagZrPbdysbqW3U6I1UkfWD6Y8aWXpLlW9C7itCFCMvCne9
         TEd3+ULkUF+sXDGhnZXh2vKnTjMmRBKNMCqU0=
Received: by 10.150.50.1 with SMTP id x1mr6233100ybx.432.1290298618510;
        Sat, 20 Nov 2010 16:16:58 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d47sm1205177yhe.38.2010.11.20.16.16.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 16:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <auto-000024044659@sci.utah.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161850>

Hi Tom,

tom fogal wrote:

> Long story short, I lost some metadata in a repo I've got.  However,
> my entire .git/objects/ && subdirs is intact, so I'm hopeful my data's
> still accessible in some form.

Here's what I'd suggest.

 1. Backup what you have.
 2. git init newrepo
 3. rsync -a .git/refs .git/objects .git/packed-refs newrepo/.git/
 4. cd newrepo && git fsck --lost-found

See the repository-layout manual page[1] for details.

Hope that helps,
Jonathan

[1] http://www.kernel.org/pub/software/scm/git/docs/gitrepository-layout.html
