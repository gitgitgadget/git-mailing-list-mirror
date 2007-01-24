From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 21:40:06 +0100
Message-ID: <200701242140.07459.jnareb@gmail.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:39:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9otw-0005Dt-Ro
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAXUjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbXAXUjP
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:39:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:57540 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXAXUjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:39:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so266979uga
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 12:39:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MYFJiYoQDepCqfFF/PiMA3SsqDenvJMtVZx6LJLiEZ/cviV2e1JmSs9hHCMOivEztSU7NIFMJ0M/KGTq3+Zx/2p4dTaTonQ35iB8QAHSbNy1FmjbuLm2wbYFGuoDQ+s1Z/3Q3WmZahJ/BnWPP4fwYcMZ65nkKsSHLka3FXcwsvE=
Received: by 10.67.22.14 with SMTP id z14mr1577564ugi.1169671151028;
        Wed, 24 Jan 2007 12:39:11 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id l40sm1375499ugc.2007.01.24.12.39.09;
        Wed, 24 Jan 2007 12:39:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <45B7818F.6020805@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37674>

H. Peter Anvin wrote:
> Jakub Narebski wrote:

>> Besides, we can't rely that .git/info/refs is up to date, or even exists.
>> It is for dumb protocols, not for gitweb.
> 
> Well, SOMETHING needs to be done for this page, since it can take 15 
> minutes or more to generate.  Caching doesn't help one iota, since it's 
> stale before being generated.

The simple and fast solution would be to make post-update hook contain
the git-for-each-ref with parameters like in git_get_last_activity,
saving e.g. to .git/info/last-committer, and in gitweb read this file
if it exist, run git-for-each-ref otherwise (similar to what we used to
do with .git/info/refs and git-peek-remote in gitweb).

-- 
Jakub Narebski
Poland
