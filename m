From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: started a cvsps testsuite Was: Re: [PATCH v3 0/2] cvsimport: add 
	test illustrating a bug in cvsps
Date: Mon, 23 Mar 2009 20:06:55 +0100
Message-ID: <46a038f90903231206i9f1dde2pb12fab3764e55cbd@mail.gmail.com>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu>
	 <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net>
	 <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net>
	 <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
	 <49C22166.3000807@drmicha.warpmail.net>
	 <49C47DF7.9000601@alum.mit.edu> <20090323181110.GB26678@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>, ydirson@altern.org,
	git@vger.kernel.org, CVSps@dm.cobite.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlpVl-0003vf-Lv
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 20:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZCWTG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 15:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbZCWTG7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 15:06:59 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:15389 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZCWTG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 15:06:58 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1884425qwh.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zSvBmZANRe7sK3x/2WwN7uXUprZvAk40xNK+HEw3k6E=;
        b=xzLF8ZPSLwkSNEF7Bk9u03Ikjvkaj04bsHrFFEpKkhwuTC1pKLL4rcNSzMpNuROXKz
         9ITX5v51RPH/XR0yM1mso605u0yS82qQjnqAS3Qrpd2T6hr8raG3i7xUgdhLy/8YD8K4
         W8BsM3GtjG+ofTck1aAei6DEe2b0JZa/akY10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=knnzZFY0FAoQnDJqPoF0KfbPVu1nzkMgV8rKH8NKlnDcWFNvD+hDDMuv3baE2WcM6y
         P/eIZ6reyM4fpd2d7sb7BtIPip4oL+7lxaARthPSfPXUr6eFqDBqUda/dfMwTM/qX5DX
         t3Wv+CDBDTPrE1MWJzAs3zx79xo11ZpxNdObY=
Received: by 10.143.158.2 with SMTP id k2mr2977598wfo.245.1237835215577; Mon, 
	23 Mar 2009 12:06:55 -0700 (PDT)
In-Reply-To: <20090323181110.GB26678@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114342>

On Mon, Mar 23, 2009 at 7:11 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> I just started a very simple but hopefully effective testsuite to
> collect all the issues we found with cvsps.

Excellent effort. One thing I found when I was debugging (and trying
to understand) corner cases in cvs imports was the test suite for the
cvs2svn importer. It had a number of tiny cvs repositories that were
broken in various ways.

The test cvs repos, straight from the svn repo for cvs2svn are in
http://cvs2svn.tigris.org/svn/cvs2svn/trunk/test-data/ - access with
user:guest and an empty password.

...
> Hopefully we can collect some more specifics about the situations where
> cvsps fails and most importantly the amount of coding needed for fixing.
> From there on it should be easier to decide which route to follow for
> a robust inbuild git cvsimport.

Some cvs repos are ambiguous. Others are "impossible", fruits of
direct file manipulation. cvs2svn has a fairly robust (and
inordinately slow!) approach, but you cannot rerun it to get
incremental imports.

It is certainly possible... and bloody hard!

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
