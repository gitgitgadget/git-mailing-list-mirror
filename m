From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 3/5] gitweb: use_pathinfo filenames start with /
Date: Sun, 19 Oct 2008 10:43:14 +0200
Message-ID: <200810191043.16395.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <200810190126.06697.jnareb@gmail.com> <cb7bb73a0810181657i67d6b9f8o66db9f57bcf01dd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 13:44:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrTvM-0004BK-8U
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 10:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbYJSIng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 04:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYJSIng
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 04:43:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:19106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYJSIne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 04:43:34 -0400
Received: by ug-out-1314.google.com with SMTP id k3so441763ugf.37
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m0kC/SxSZLtkwKR6o062qjh9NvK6KwejA1RZBdO8Tgk=;
        b=vWnDmQJl+rQsAh4tO5qLkIwyITbrZ6YACpBMquJKWKTXYwvWpFpq/dylodJV34QEMj
         0Y52iNB5crrIAZM0zX24jZnDPr9A+7VmCw6O5jlEVylNA4izJUgBdunvt3/Qr2GyJQC+
         r2XKVQNgfdbXpJfoRewmhYSbU3tHWS4FAeDcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=epH9A2NTDIgYDO5E7lzkkmlxUknjAIIDKoFeRq+vrN4gq+9uFBMFJU0mBnw3Wgvfu+
         gEja+sZKIA17Sw0ynWYbCmBJkc/z+pvD9zx5GPvRsilLwPj0yILiD0nxzYcsqcbSVIV3
         ngYDNhEoSsCTb6Nze0D/eVWLHyaj+y5/i2Flw=
Received: by 10.67.93.16 with SMTP id v16mr1319575ugl.1.1224405811396;
        Sun, 19 Oct 2008 01:43:31 -0700 (PDT)
Received: from ?192.168.1.11? (abwr242.neoplus.adsl.tpnet.pl [83.8.241.242])
        by mx.google.com with ESMTPS id m38sm2321032ugd.34.2008.10.19.01.43.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 01:43:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810181657i67d6b9f8o66db9f57bcf01dd3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98599>

On Sun, 19 Oct 2008, Giuseppe Bilotta wrote:
> On Sun, Oct 19, 2008 at 1:26 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:
>>
>>> When using path info, make filenames start with a / (right after the :
>>> that separates them from the hash base). This minimal change allows
>>> relative navigation to work properly when viewing HTML files in raw
>>> ('blob_plain') mode.
[...]

>> For example for http://repo.or.cz/w/git.git/html:/git.html links leads
>> to correct HTML pages, while for http://repo.or.cz/w/git.git/html:git.html
>> they lead to empty gitweb page (no errors, so link checker would be
>> fooled).
> 
> An idea that could be taken into consideration, if the ability to
> navigate web documents is deemed of primary importance, would be a
> redirect from the no-slash URL (a hand-coded one, given that with this
> patch we only generate slashed URLs) to the slashed URL. Not sure it's
> worth the effort (and reparsing) though: it would obviously be MUCH
> nicer if we could change the URL without having to actually reload the
> document ...

I think that changing URL without reloading is impossible because of
security reasons. For example if you change document.location in
JavaScript changing the URL (you can add links to non-existing anchors
without reloading) then web browser reloads the page from new URL.

What you can do is early redirect using 301 Moved Permanently (or
similar) and Location: redirect, using $cgi->redirect() like in
git_object().

Also not sure if it is worth the effort...
-- 
Jakub Narebski
Poland
