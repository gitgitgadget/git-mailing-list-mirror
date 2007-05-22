From: "Stian Haklev" <shaklev@gmail.com>
Subject: Re: Fwd: Problem: git doesn't update working dir (always) when checkout'ing other branch
Date: Tue, 22 May 2007 11:05:30 +0700
Message-ID: <566574ef0705212105k1387cf41n18e076c0bdf47ec6@mail.gmail.com>
References: <566574ef0705210157j14cb7c56h62392c6193472a98@mail.gmail.com>
	 <566574ef0705210159m69d4e32cjd4bc5db66c1677b1@mail.gmail.com>
	 <200705211016.58067.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 06:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqLcy-0000wV-5F
	for gcvg-git@gmane.org; Tue, 22 May 2007 06:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbXEVEFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 00:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbXEVEFc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 00:05:32 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:1665 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbXEVEFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 00:05:31 -0400
Received: by py-out-1112.google.com with SMTP id a73so521093pye
        for <git@vger.kernel.org>; Mon, 21 May 2007 21:05:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JLARK3H3uESOREKlgl4GzM+lioIvl0wlG+LNNjnMHfsl4gX1slNjQfBi0BpVwW73rXu1mIgGs23XEqWSMRcm4P2rfcqSUB0pIEhc1s8fAb8hG5Av2YMuTQ3WNU/5mk1utBdXNVSUIsrGy/inrKOIfFZ/49MwJKjNzMqQSZ9+nts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GwzQYRzj2tSMTRO1bliZaol+glqG3kxSv4to6wpSIAuqDiJKec/FISyCGZBNqbUW5F2uV89s7ErwwuZy7eq2wcSfA5edKTbXxxZh65sGFPbuQxlzTufm38lnxtPe8BYxjmeNgL44J+DFAs0//42XhjfB/bIk3Rm1p8FKG8G23C4=
Received: by 10.35.9.2 with SMTP id m2mr10005144pyi.1179806730914;
        Mon, 21 May 2007 21:05:30 -0700 (PDT)
Received: by 10.35.72.14 with HTTP; Mon, 21 May 2007 21:05:30 -0700 (PDT)
In-Reply-To: <200705211016.58067.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48068>

OK, I made the following script:

do.sh:
git --version > ../file1
date >> ../file1
git status >> ../file1
echo checking out works with old >> ../file1
git checkout works-with-old >> ../file1
git status >> ../file1
git checkout master >> ../file1
git status >> ../file1
date >> ../file1

I ran it, and I got the following result:
nurhaliza:~/wiki stian$ less ../file1
git version 1.5.2.14.g45bde
Tue May 22 11:05:19 WIT 2007
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       do.sh
nothing added to commit but untracked files present (use "git add" to track)
checking out works with old
# On branch works-with-old
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       do.sh
nothing added to commit but untracked files present (use "git add" to track)
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    NOTES
#       modified:   display-page.rb
#       deleted:    eee_darwin
#       modified:   gui.rb
#       modified:   htmlshrinker-data.rb
#       modified:   htmlshrinker.rb
#       modified:   mongrel-web-gui.rb
#       modified:   mongrel-web.rb
#       modified:   zarchive.rb
#       new file:   zcompress.rb
#       modified:   zdump-7z.rb
#       modified:   zdump.rb
#       modified:   zipdoc.rb
#       deleted:    zutil.rb
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       do.sh
Tue May 22 11:05:20 WIT 2007

...

I should add that I am working in OSX 10.4.9.

Thank you,
Stian
