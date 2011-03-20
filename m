From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/3] gitweb: Always call format_date with timezone parameter
Date: Sun, 20 Mar 2011 12:07:55 +0100
Message-ID: <201103201207.56639.jnareb@gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost> <b599dae39131b90d0970a1ef63e6599b@localhost> <201103201137.18619.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 12:08:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1GUT-0003aT-GX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 12:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab1CTLIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 07:08:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34201 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab1CTLID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 07:08:03 -0400
Received: by wya21 with SMTP id 21so5039522wya.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=0/F0hihDhQn/FDboVwB4YK59UTMXO9g6aU3SHmj3AAU=;
        b=GhS2BruddHjd0NZdfUsky/KC2daK9eoUfq3NsIFNzLj84lNjjLyZgk045Wr5Uj5Jwh
         Eh8NYCVxJoyJTg398JYQn8JxIiqPVty16FUmLMe1hVhjyujHj+BpUrHSBmx0LCPmRiEj
         cFYU6ibjhfwSJC2270uvq7TOSdkpx74DrsINM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=An05oBzqZSX+4Bd/VDvcZ9Mr7x6vAveQCw12ISs2pEuEZrDrH/zYXNuPvwiBStA/W1
         9pZsIcILmgcHh0NGWg+3mTSQm/8ubbxUZutfHuCDdYFMexkpFdNuWRgPrUzXWxNXG+I8
         TUampAyv5KbuUfE05mrqLgGfi1vSwhrsle38Q=
Received: by 10.216.171.68 with SMTP id q46mr3995081wel.98.1300619281646;
        Sun, 20 Mar 2011 04:08:01 -0700 (PDT)
Received: from [192.168.1.13] (abwj177.neoplus.adsl.tpnet.pl [83.8.233.177])
        by mx.google.com with ESMTPS id p5sm2242443wbg.45.2011.03.20.04.07.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 04:08:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201103201137.18619.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169499>

Jakub Narebski wrote:
> On Sun, 20 Mar 2011, Kevin Cernekee wrote:

> > Rebase on top of my patch 3/3 (as applying -1/3 then 1/3 would create a
> > merge conflict).
> 
> You are right, that is better solution.

Well, better for you, as it makes things easier for you: no need to
resolve conflict, or to rerun update script:

  $ git checkout HEAD^ -- gitweb/gitweb.perl
  $ sed -e 's/\bparse_date\b/\bformat_date\b/' \
    <gitweb/gitweb.perl >gitweb/gitweb.perl+  &&
    mv -f gitweb/gitweb.perl+ gitweb/gitweb.perl

But it takes bugfix hostage to applying new feature series.
-- 
Jakub Narebski
Poland
