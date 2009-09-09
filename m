From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [RFC PATCH 2/2] INSTALL: Describe a few knobs from the Makefile
Date: Tue, 8 Sep 2009 20:12:06 -0400
Message-ID: <9908511C-448F-4E52-84B0-4C6BED3DC1DD@gernhardtsoftware.com>
References: <1252425313-69793-1-git-send-email-brian@gernhardtsoftware.com> <1252425313-69793-2-git-send-email-brian@gernhardtsoftware.com> <7vy6opxjx8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 02:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlAnR-0005CB-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 02:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbZIIAMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 20:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbZIIAMP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 20:12:15 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49789 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZIIAMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 20:12:14 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A64591FFC087; Wed,  9 Sep 2009 00:12:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id B6BB21FFC06B;
	Wed,  9 Sep 2009 00:11:59 +0000 (UTC)
In-Reply-To: <7vy6opxjx8.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128050>


On Sep 8, 2009, at 4:26 PM, Junio C Hamano wrote:

> [rewrite suggestions snipped]

I'll re-roll this and the other INSTALL patch as per your suggested re- 
wordings.  I tried to add the minimum needed instead of changing  
things, but many of your suggestions make sense.  And since I'm in  
here anyway, might as well change them.

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>> +	- "openssl".  Unless you specify otherwise (with NO_OPENSSL),
>> +	  you'll get the SHA1 library from here.
>
> It is not very clear what will be affected by disabling this.
>
> - SHA-1 is not used from OpenSSL, as stated;
> - imap-send won't be able to talk over SSL;
>
> Do we still able to walk https:// URLs?  If your cURL library is  
> linked
> with gnutls I think we can, but I never tried the combination.

Glancing at http*.[ch], it looks like we depend on curl's ability to  
speak https instead of using OpenSSL ourselves.

>> +	- "perl" is used for several scripts that are useful, but not
>> +	  required for git (e.g. "git add -i" and "git difftool").  If you
>> +	  don't need the *.perl scripts or the library contained in perl/,
>> +	  then use NO_PERL.
>
> I do not think moving "Perl" this low in the requirement level is  
> such a
> good idea, at least for now.  I'd suggest movign it back immediately  
> after
> POSIX-compliant shell, and would say something like this:
>
> 	- "Perl" is needed to use some of the features (e.g. preparing a
>          partial commit using "git add -i/-p", interacting with svn
>          repositories with "git svn").  If you can live without these,
>          say NO_PERL.
>
> Maybe they are Ruby, github, and general acceptance by many open  
> source
> projects these days, but it used to be that the initial entry points  
> to
> git were "git cvsimport" and "git svn" for a surprisingly large  
> number of
> people.

I didn't move it this low so much as not move it when I moved the  
POSIX shell requirement that we can't live without.  Although I use  
git-svn on a regular basis, I don't think of it as core, but you're  
right that it's one of the main tools for many users.  Will move.

~~ Brian
