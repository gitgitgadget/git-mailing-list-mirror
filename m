From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 23:50:13 +0200
Message-ID: <200907102350.15511.jnareb@gmail.com>
References: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain> <200907101933.39424.jnareb@gmail.com> <alpine.LFD.2.01.0907101405480.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 23:50:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPNz8-0007Dy-6o
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZGJVuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZGJVuT
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 17:50:19 -0400
Received: from ey-out-1920.google.com ([74.125.78.150]:47959 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZGJVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 17:50:18 -0400
Received: by ey-out-1920.google.com with SMTP id 3so237140eyh.36
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4khicf6uAnL5f8vs9oyevz6Oum+lgl1nRvmTo8DwwC4=;
        b=iD/nW8+36vgnsEbvxuXa1djlSBZyLjsYj8tv6q1ENP9tL0yj7NPako1cM1QtYf9VIi
         zydBTXFPlCVNNByLfZhCxHiUTH22M3fOApOo/Hl+gx6mCQE59EH+U7FpWLJ7QOQOZ/k0
         OsCHV4cCw9oblazLt3EvfjxqtObNdHasf9wWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fvjYqAiOWd7I2Ui+9KMUvjFHezNmuxZDOBaJ7QNt2fd4suMjzBsKu9dax0PgBAy7T/
         P+bybDx1x8dX6TG/RU3Lpn+jI+Y4EV/wS1eO+CfECRfakMsL81Eaj4yO8tJ/zhFfCmNB
         WW/buw69uDihBfZX05Zb+x/Xmptw/bwMVNHK4=
Received: by 10.210.18.8 with SMTP id 8mr2760429ebr.85.1247262616347;
        Fri, 10 Jul 2009 14:50:16 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 10sm3518948eyz.11.2009.07.10.14.50.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 14:50:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.01.0907101405480.3352@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123084>

On Fri, 10 July 2009, Linus Torvalds wrote:
> On Fri, 10 Jul 2009, Jakub Narebski wrote:
>> On Fri, 10 July 2009, Linus Torvalds wrote:
>>> 
>>> It turns out that that duplication is because they use gitweb as a strange 
>>> patch distribution system (rather than emailing each other patches), and 
>>> download the 'commitdiff_plain' version of the diff and then apply it with 
>>> 'git am -s'.
>> 
>> First question: do they use gitweb from git.git repository, or a custom
>> fork of gitweb (like git.kernel.org gitweb, which has caching, but IIRC
>> does not have all new gitweb features)?
> 
> I have no idea. Afaik, it was on samba.org:
> 
> 	http://git.samba.org/?p=jlayton/cifs.git;a=commitdiff_plain;h=acc11a88a4cb4ba16777099da00664347e0683f0
> 
> and I have no clue whether samba org uses plain git gitweb or something 
> fancier.

Thanks. It looks on first glance like ordinary gitweb, only old.  It is
git and gitweb version 1.5.4.3 from 23 Feb 2008, while Giuseppe's patches
made it into git in v1.6.1 or v1.6.2 (commit is from 23 Dec 2008).

-- 
Jakub Narebski
Poland
