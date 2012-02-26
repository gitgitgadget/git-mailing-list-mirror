From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about your comment on the git parable
Date: Sun, 26 Feb 2012 15:10:32 +0100
Message-ID: <201202261510.32978.jnareb@gmail.com>
References: <A98A438D-76DD-41B5-B8E1-6FA170B00801@gmail.com> <201202261303.38957.jnareb@gmail.com> <4B4C5353-9820-4068-92DA-50665B1011E1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Federico Galassi <federico.galassi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 15:11:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1eoY-0000Op-BD
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 15:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2BZOKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 09:10:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64219 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2BZOK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 09:10:29 -0500
Received: by eaah12 with SMTP id h12so1819652eaa.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 06:10:28 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.32.133 as permitted sender) client-ip=10.213.32.133;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.32.133 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.32.133])
        by 10.213.32.133 with SMTP id c5mr2929282ebd.119.1330265428495 (num_hops = 1);
        Sun, 26 Feb 2012 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=345eq+o4K/A/PRUKG+3HvTvDW4m1Q9RToU0NCHpRiTU=;
        b=KR3S7Ol+DrbIPod/fD4S/9GoCXSf6j3nwfiHBylJW9N7DWTO7I8xErZJmZ2iGU/EMB
         e8etXf34haR/HKNiTiwPLE4MK3G4I8/XO8RMK0jjyiKVHyBodn0OlXVg7/GlO+/DR5rt
         UsG7TMqGlN5lDEoxytpHVNMAjJwP+geyDLM54=
Received: by 10.213.32.133 with SMTP id c5mr2199708ebd.119.1330265428376;
        Sun, 26 Feb 2012 06:10:28 -0800 (PST)
Received: from [192.168.1.13] (abwe206.neoplus.adsl.tpnet.pl. [83.8.228.206])
        by mx.google.com with ESMTPS id v51sm45479521eef.2.2012.02.26.06.10.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 06:10:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B4C5353-9820-4068-92DA-50665B1011E1@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191561>

Federico Galassi wrote:
> On 26/feb/2012, at 13:03, Jakub Narebski wrote:
>> Jakub Narebski wrote:

[...]
>>> Note also that the staging area is also a performance hack (perhaps it
>>> began as such; I am not sure about this aspect of git history).  Git uses
>>> it to be able to _cheaply_ check which files were changed.
>> 
>> The first name for staging area, _dircache_, hints at this.
> 
> Unfortunately, i'm not into git development. Do you have a clue on why
> the index, apparently a tree referring to objects, is much faster than
> reading that stuff right from the database?  

The index (at the very beginning "dircache"), or the staging area, stores
more information that are saved in object database, for example stat
information (file metadata).  Most of file metadata is highly local, so
it doesn't make sense to save it in object database of repository, but
it is used to avoid a file read: usually stat-ing a file, which is much
more cheap, is enough to notice that the file did not change.

-- 
Jakub Narebski
Poland
