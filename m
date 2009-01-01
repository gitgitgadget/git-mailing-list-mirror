From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb $export_ok question
Date: Thu, 1 Jan 2009 23:51:26 +0100
Message-ID: <200901012351.28864.jnareb@gmail.com>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu> <6db6bed70812311013l3cf575c1y874e71e70d1dde57@mail.gmail.com> <6db6bed70812311027g3be1cfbei35c014243237fd59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Thomas Amsler" <tamsler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 23:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIWO0-0007Gk-1O
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 23:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbZAAWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbZAAWuF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 17:50:05 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:40205 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbZAAWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 17:50:03 -0500
Received: by ewy10 with SMTP id 10so6537936ewy.13
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 14:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qzci01uX740hcdskYANJZ4EiBYDzIMNVmnD/daWtJM0=;
        b=qO0bvJ8rCT6XIH+ZZU2V+jJuSnQ4/izkzDwY+KdNeDsKP/3Ls1vMz5tI3Q9LI1N/Oc
         9AK2pVL0WOo742SZFNZSoYn2b5eZMeheC4DstdXiWTsC/ATqyjYko2UBjTTr9rddDpwE
         ffdr1/3VcQSyE4mLxxXBFom01Dfb/Xie5YAMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MjlVzhvhLJKybgOhmpf75pKWRSszuctpdJvYm9PfB8bHvY7ESg+/RX3V1uEMWmUiad
         7FqeMx5O+GqCM8Ftr8av9wusheh3nIXN22Irueo5nEHCyLWcWd/8F/KK2mNfvuLHAws8
         vaOSnhBTXfg5XwTkjP9tcf/hZFBmqFw+GbbXc=
Received: by 10.210.43.11 with SMTP id q11mr6969231ebq.193.1230850200635;
        Thu, 01 Jan 2009 14:50:00 -0800 (PST)
Received: from ?192.168.1.11? (abwl150.neoplus.adsl.tpnet.pl [83.8.235.150])
        by mx.google.com with ESMTPS id y34sm44597323iky.1.2009.01.01.14.49.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jan 2009 14:49:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <6db6bed70812311027g3be1cfbei35c014243237fd59@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104338>

Two requests: could you please do not toppost, as it goes against
natural flow of discussion and reading, but rather quote relevant
parts and respond below? It would be good to not try to send HTML
mail, as it is forbidden by VGER anti-SPAM filter, so you trying
to send HTML-formatted email result in me getting two copies: one
with and one without HTML version.

On Wed, 31 Dec 2008, Thomas Amsler wrote:

> One more question. Now, on the gitweb home page, the project name hyper link
> shows up as:
> 
> authz.git/.git
> 
> where it used to be just:
> 
> authz.git/
> 
> is there a way to configure this so that it doesn't show the trailing .git?

I'm afraid it is not possible without modifying gitweb, unless you use
symlinks in place of real repositories, i.e. if you have authz.git in
$projectroot being symlink to authz.git/.git or even authz/.git (which
might be somewhere else).

For example I have /home/local/scm/git.git be symlink to ~/git/.git

The longer explanation (which probably should made into gitweb/README
or gitweb/INSTALL) is that gitweb is meant to deal with _bare_ 
repositories; gitweb doesn't touch and doesn't examine working area
of "live" (non-bare) repository. If you host git repositories (like
kernel.org, freedesktop.org or repo.or.cz) you usually host them bare
(public repositories should be bare); but you might want to have
gitweb for your own repository too.

-- 
Jakub Narebski
Poland
