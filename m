From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: vcs-svn: integrate support for text deltas
Date: Mon, 28 Mar 2011 02:00:15 -0500
Message-ID: <20110328070015.GE11987@elie>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:00:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q46R8-0001Bi-Ej
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab1C1HAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:00:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44782 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1C1HAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 03:00:20 -0400
Received: by iwn34 with SMTP id 34so3337039iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=G3cuKFILe8Ul/0oA9sG/gSINSLLY29AH1SIB31C50bk=;
        b=YwdeubZ5VoA1cdr71B3nUxFTxwE3YnHCnhHkJ0JAub13c9jsvxAi3pPrvUfMYR/VZi
         wxDTDImc/zhEYdJ3He9/eX/P/TKMeWe3e+PppKIg7Seq9z+gO1ocPuLZvauFllVuFnLj
         SGn1nD/dKleTmJsdrd1SzdgpKvlOC7nHckDBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wLuc7G/oopj1j/MVa+o2ToyUewBtafAybZokv5jNCvI3LuJsHiF8hYsUjCdQdy/eZv
         K/vXuk9xNPArGfPrSHNtQMd91ueChyI32ImljneYGjyVpxIuVCBHrmYGtfboOhFAEI0s
         Z/FWXlyfgmEQEd7iSuOzBHz1GK6Sh5xQED/0k=
Received: by 10.43.57.200 with SMTP id wh8mr6475407icb.29.1301295619831;
        Mon, 28 Mar 2011 00:00:19 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.ameritech.net [68.255.101.206])
        by mx.google.com with ESMTPS id d10sm2752468ibb.0.2011.03.28.00.00.17
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 00:00:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170101>

Hi,

David Barr wrote:

> As previously, I have tested against
> the ASF subversion repository to increase confidence in the series.
> Hopefully, this brings us a little closer to having full support for
> version 3 of the subversion dump format in master.

Thanks much for digging this up.  (To think, it's been half a year
since the svndiff0 parser was written!)  I've queued everything except
patch 16, and grabbing patch 16 on top of db/delta-applier +
db/vcs-svn-incremental should be just a formality.

The patches have had over three months to cook already.  Whether or
not a nice UI wrapper is ready[*], I'll be testing and then merging them
to svn-fe in the next couple of weeks.  Sorry to take so long at this.

[*] which will probably mean finally figuring out Tomas's work
