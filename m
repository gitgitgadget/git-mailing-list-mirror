From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb: Show git clone url on projects list
Date: Thu, 07 Oct 2010 03:00:56 -0700 (PDT)
Message-ID: <m3iq1efhlp.fsf@localhost.localdomain>
References: <AANLkTi=5P1OiKprOifyu2xuFjVToL5kE9dXrEr3gSr+_@mail.gmail.com>
	<AANLkTimGhR_64CDKuN0x4Lk6Ve8rr7BAOCL1uGUkQv6v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Manuel Doninger <manuel@doninger.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3nHi-00036Y-4r
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251Ab0JGKBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 06:01:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57895 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760244Ab0JGKBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 06:01:00 -0400
Received: by wwj40 with SMTP id 40so691402wwj.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=H3Aiy78B/+a/0B7yPZO88wKUFDj7z9jiABbsmhUYk6Q=;
        b=oes/jsRPIUaIc2bUWecpM0mwZP6P6DdtG2LA3yZeAqvYqmHIDIiPkM8I2kocBopvWr
         LRqpP6i5XeMwMlT4BwhCqeYX7VIagJy7pXuTQ3d5uRfbXNm9IuOyLaKbN6Hdjhar19YH
         JmSM3KVUHqRdaQlJ+zicMdR85BUzPkZQh9WRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TAFwxk4pZ1IgtZ+YTXnsWEFv223ZleCFqA39AgAbR10rYETmQyhaDMrngPmet2SrZi
         KWOBgG9AarzpN+98QxKYOr8nc9XtbfvVFljSFDoP8J3HCPX7jXMydA3xdAO5BU5oR0t1
         Ln0u2DfNeSFy/6ytOZuSp7OqNLw3ySF6uGuEY=
Received: by 10.227.135.141 with SMTP id n13mr547190wbt.97.1286445658785;
        Thu, 07 Oct 2010 03:00:58 -0700 (PDT)
Received: from localhost.localdomain (abvx243.neoplus.adsl.tpnet.pl [83.8.221.243])
        by mx.google.com with ESMTPS id o49sm1285083wej.43.2010.10.07.03.00.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 03:00:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o97A0JwQ020900;
	Thu, 7 Oct 2010 12:00:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o97A03ef020893;
	Thu, 7 Oct 2010 12:00:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimGhR_64CDKuN0x4Lk6Ve8rr7BAOCL1uGUkQv6v@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158390>

Manuel Doninger <manuel@doninger.net> writes:

> I installed gitweb on my server, and it works great.
> In gitweb.conf I defined @git_base_url_list, an on every projects
> status page the clone url is shown.
> But I want also the clone url shown on the projects list, like on
> http://git.kernel.org/ (the "git" link on the right border of every
> line).
> How can I do this (i use git 1.7.3)?

The http://git.kernel.org site uses *modified* gitweb, which among
others include support for _git_ link on projects_list page.  You can
get it from
  http://git.kernel.org/?p=git/warthog9/gitweb.git      (gitweb)
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git  (clone url)
You would need only `--depth=1` shallow clone.

There were multiple attempts to add such link to core gitweb (i.e. the
one present in git 1.7.3), but were not merged in due to runing
aground the following problems:

1. There might be more than one link for one git repository.  One can
   provide git://, http:// and ssh:// URLs.  Which one to chose?

   This issue might be solved by either using first one on the list,
   or filtering and showing link(s) to anonymous unauthenticated ones,
   i.e. _git_ link (if git:// URL exists) and perhaps _http_ link (if
   http:// URL exists).

2. More important issue is that besides @git_base_url_list the URL or
   URLs for a repository can come from various other places: from
   'cloneurl' text file and from `gitweb.url' configuration variable.
   It it was taken into account (even to check that such configuration
   does not exist) it would badly affect performance of generating
   projects list page.

   The git.kernel.org gitweb doesn't have this problem because it uses
   @git_base_url_list (I think unconditionally); also it supports
   output caching, so eventual performance hit is migitated.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
