From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 20:58:50 +0200
Message-ID: <200909292058.53045.jnareb@gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org> <m33a66br69.fsf@localhost.localdomain> <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 29 21:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msi1d-0000QQ-CM
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 21:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbZI2TGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 15:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZI2TGD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 15:06:03 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41030 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbZI2TGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 15:06:01 -0400
Received: by fxm18 with SMTP id 18so4743618fxm.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=oME0MUuBDOnY20VpCjp956I6PVU0xFGBsuQx8Pt+wlM=;
        b=pOYR9JRJxtKqLKKJrRKVnWKcWvR1riaNSZ3pcjKR/wdEK8AnzhycGtXJprhVFv5hVk
         EIu6I7Gj88FpgPyrYzxJAGgP5b/fWQ5x4WWGZMF62uZflpONr2fz69/npsSKSMlOCZRF
         GargmktK44zymRMHDGrs3/CD6tXNjrvMLz5Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aaozmSImp8ymWihUs2l0htfxVKlLP7LGgCGlQqbCmRxP7tLSH/r8oSw8fEHFj23iec
         2y8X5XmGgB8rwMcdA03zhrGJdAczQnqVFEpV5qwe6n6E29i4qA/iI6hWKXf9zvEH1SGn
         wdjA9+omJVq+2EafcwxPFmL3txEMys4GQDAk0=
Received: by 10.204.5.138 with SMTP id 10mr4456103bkv.110.1254250735869;
        Tue, 29 Sep 2009 11:58:55 -0700 (PDT)
Received: from ?192.168.1.13? (abvc3.neoplus.adsl.tpnet.pl [83.8.200.3])
        by mx.google.com with ESMTPS id 26sm6752138fks.31.2009.09.29.11.58.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 11:58:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129324>

On Tue, 29 Sep 2009, Leo Razoumov wrote:
> On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:
> > [..snip..]
> >  Besides with nonlinear history with
> >  revision numbers such as 12678 and 12687 you know that 12678 is older
> >  than 12687 if and only if 12678 and 12687 are on the same line of
> >  development.
> 
> The statement above is incorrect!! In a Mercurial repo local revision
> numbers are strictly ordered in commit time. 12678 < 12687 means that
> 12678 was committed prior to 12687. But these two commits could belong
> to two completely unrelated lines of development.

This is impossible with distributed development.  If the second branch
comes from other repository, with commits _created_ (in that repository)
earlier than commits in current repository, but commits in first
branch (from current repository) were created earlier than _fetching_
those commits in second branch:

  .---.---.---.---x---1---2---3---M---.    
                   \             /
                    \-A---B---C-/             <-- from repository B


Either you would have to change commits numbers, and therefore they would
be not stable, or you would have to change commit time to mean 'time this
commit got into current repository', which would kill performance for sure.

-- 
Jakub Narebski
Poland
