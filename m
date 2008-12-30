From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb $export_ok question
Date: Tue, 30 Dec 2008 14:37:44 -0800 (PST)
Message-ID: <m3sko5b84t.fsf@localhost.localdomain>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Amsler <tpamsler@ucdavis.edu>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnEz-0002Y3-Ci
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYL3Whs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYL3Whs
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:37:48 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45545 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbYL3Whr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 17:37:47 -0500
Received: by ewy10 with SMTP id 10so5736034ewy.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Svev91cZZ/vrc6rDl5oh47E6Ei/VMjwF9kSOnKk7byA=;
        b=l7O7btnZQXam1raBqDSJzDPub90hXI9cipYSz5bQ9PuSKhqMS5N5J74YTB8DoHpFQP
         v0BbvsN3y/Lctc06WCmJxobs/To20V+SFM/lGxehurwOhBjSiH5Q0qUSWfEhWavTPEAK
         ieJi02BUu9qTGB/iAWyCu6xRrmREQL1ne7AZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=omSi4jgaXkkjwQPLwYylW2ig/WfKvSubIVaRbctNbmYEShqXd5yB0iWt3yfJ2f231R
         XuxY2PEzevT21vNB0VJ1jr66mOOZ+WEWaYjYtOc4b8zCYNjoElpIR56AsrFv0DngIRX8
         x1gg9hegod9GBo7cBHrYLQpo8L+uQVoEOeFVA=
Received: by 10.210.66.13 with SMTP id o13mr17949955eba.106.1230676665050;
        Tue, 30 Dec 2008 14:37:45 -0800 (PST)
Received: from localhost.localdomain (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id 10sm2595214eyd.16.2008.12.30.14.37.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 14:37:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBUMdHsJ028336;
	Tue, 30 Dec 2008 23:39:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBUMdFWl028333;
	Tue, 30 Dec 2008 23:39:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104218>

Thomas Amsler <tpamsler@ucdavis.edu> writes:

> Hello,
> 
> I am trying to get the gitweb $export_ok to work. According the
> installation instructions:
> 
>   Alternatively, you can configure gitweb to only list and allow
>   viewing of the explicitly exported repositories, via the
>   GITWEB_EXPORT_OK build configuration variable (or the $export_ok
>   variable in gitweb config file). If it evaluates to true, gitweb
>   shows repositories only if this file exists in its object database
>   (if directory has the magic file named $export_ok).
> 
> ... I set $export_ok = "true" in my /etc/gitweb.conf file.
[...]

$export_ok is not a boolean, is the _name_ of a file, which if it
is present, then repository is exported to gitweb, and if it is not,
it is invisible to gitweb. It means that if for example we have
  $export_ok = "gitweb-export-ok";
in the GITWEB_CONFIG file (usually gitweb_config.perl, installed
in the same place as gitweb.cgi), the repo.git is exported only
if it has file gitweb-export-ok in it.

This mechanism is similar to git-daemon and its magic file
"git-daemon-export-ok".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
