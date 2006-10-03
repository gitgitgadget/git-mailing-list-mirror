From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 3 Oct 2006 10:18:39 +0200
Message-ID: <200610031018.40273.jnareb@gmail.com>
References: <20061002191115.84730.qmail@web31811.mail.mud.yahoo.com> <200610022203.44733.jnareb@gmail.com> <7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 10:20:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUfTp-0002DV-Nv
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 10:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbWJCISS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 04:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965457AbWJCISS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 04:18:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:32551 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965456AbWJCISR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 04:18:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so597533ugd
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 01:18:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z4+bfRCzouiuogZQpCePLEPtCYJIC/xrWJIUUsfMQMnXtqBrgKqxkq1shZx9cR+e9u6hVAC5otYzMiiTpH5wJ+s3ftrjwrGCAvfWEl2F9JLHYbTdvfIxcHfb/JOKSaRSOz+QTN7RHzxahyVp8fkA1axDCcWEUv1Raap96gr+tJo=
Received: by 10.67.29.12 with SMTP id g12mr3470938ugj;
        Tue, 03 Oct 2006 01:18:15 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id e1sm3654107ugf.2006.10.03.01.18.14;
        Tue, 03 Oct 2006 01:18:15 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wpqujck.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28253>

On Tue, 3 Oct 2006, Junio C Hamano wrote:

> Honestly, I _hate_ to be in the position to decide in which
> color the bikeshed should be, but sometimes that is what a
> maintainer has to do.

Joys and tribulations of being maintainer... ;-)
 
> I personally feel that in a list that is one line per item, like
> the shortlog, we do not necessarily have to underline the log
> message even though they are clickable.  The purpose of the list
> is to show things so people can read them.  Readability matters.
> At the same time we would want to give access to object details;
> I think it is Ok not to give underline to them, as long as
> people can easily pick up the convention that each of these
> listed items is clickable to obtain details about it.

And the current convention of underlining "hidden links", like
the subject line in shortlog/log/heads/history view, is a good
hint of the convention.

> We should 
> probably make other clickable links at the right, such as "tree"
> and "snapshot", visually stand out, by giving underline as we
> already do.  They are not really "text", but clickable icons
> that happen to be done with text (as opposed to being done with
> img).

Additionally we use slightly smaller font for those links
(in addition to using default style for links).

> By the same logic, the purpose of the tree view is to show
> contents of a tree object.  If the user picks up the convention
> for the short log that each listed commit can be clicked to
> obtain details about it, it probably is natural for the user to
> expect that each listed entry in the tree view can be clicked to
> obtain details about it, so not showing the redundant tree/blob
> link is in line with that.  And it would be consistent not to
> give underline to the file or directory names.

I'd rather have underline for directory names to distinguish
it even more from files (blob entries), even for monochromatic
text display.


I am of two mind about removing "redundant" links movement.

First, I don't thing that avoiding redundancy in _user interface_
is a good argument. We sometimes add redundancy, for example in
commitdiff view for each patch we have sha1 of blob in the gitweb
header clickable, and obvously link, and we have the names of from
and to files in diff header "hidden links" and clickable. I could
agree with the argument about removing redundancy from the _code_,
and/or with the argument about _uncluttering_ interface.

Second, removing "redundant" links coupled with the fact that
the links the removed links duplicated cannot for mentioned resons
have default links style, so it is harder to guess that they are
links ("mystery meat navigation", although not in it's worst edition).
So there is tradeoff. Uncluttering the interface and simplifying
the code, but at the cost of gitweb interface being harder to beginners.
It is a question of policy then, do we cater to beginner users, or to
advanced users (which know/discovered that file name in tree view
and commit subject/title line in shortlog are links to respectively
blob view of a file and commit view of a commit).

Third, we should be consistent: either leave redundant links, perhaps
separating it by putting it into separate "selflink" column (see for 
example tags view), or remove redundat links where possible in all 
views.

-- 
Jakub Narebski
Poland
