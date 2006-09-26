From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 14:32:36 -0700 (PDT)
Message-ID: <20060926213236.79160.qmail@web31815.mail.mud.yahoo.com>
References: <efc2no$eti$2@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 26 23:33:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKXp-00079t-0X
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWIZVch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWIZVch
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:32:37 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:22194 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964824AbWIZVcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 17:32:36 -0400
Received: (qmail 79162 invoked by uid 60001); 26 Sep 2006 21:32:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6BhmQwx61c08YbBtje127n9v7R2/qV5EGXlxp8QuHjmYQoMIUysEclPODoCeL8DkUWh3Ad9oqtS/+KB+4NjluV+Sd+f7meHOkTbZw8boS96/RBbuXwjQVE2taK6Um2exa7VvPSEILPaOQybG4PcBn6BGIqqqHwhCt5ZajRbuKDg=  ;
Received: from [64.215.88.90] by web31815.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 14:32:36 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efc2no$eti$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27825>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> This is example of where forefront has it wrong. I'm all for "list" entry
> to be link to default view, but I'm all against removing clearly marked
> link to "plain"/"tree" view.
> 
> And "invisible links" _especially_ if the link is not convenience only
> (i.e. it is not provided clearly as link somewhere else) is so called
> "mystery meat navigation" and is one of the most common mistakes in
> web development.
> 
> And is not as if "plain |" takes much space...

I think you would agree that gitweb is quite different than what is
commonly defined as "mystery meat navigation".

Gitweb is very well thought out interface, and self-contained.
There isn't much pondering about what and where to click, have newbies
too.

Think about the removal of the redundant "blob" and "tree" as database
schema normalization if you will.  The redundancy is so well defined that
even applying a simple algorithm to gitweb.perl will discover it.

Either that or you can think of it as "shortening" the line.
Wlg, suppose that I have a file called "blob" and a directory
called "tree":
    mode blob    blob | blame | history | raw
    mode tree    tree | history
Is equivalent to
    mode blob    blame | history | raw
    mode tree    history
For any name "blob" and any name "tree".

Plus the code (gitweb.perl) has less redundancy and overhead.

     Luben
