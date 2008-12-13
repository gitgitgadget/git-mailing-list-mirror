From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Sat, 13 Dec 2008 23:23:09 +0100
Message-ID: <cb7bb73a0812131423h1f629ec1n9e8eacd657a4901@mail.gmail.com>
References: <1229195421.3943.8.camel@mattlaptop2.local>
	 <1229202689.31181.1.camel@mattlaptop2.local>
	 <m3tz97g329.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matt McCutchen" <matt@mattmccutchen.net>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcuV-0007Eg-4Q
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYLMWXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYLMWXN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:23:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:12181 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYLMWXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:23:12 -0500
Received: by nf-out-0910.google.com with SMTP id d3so324723nfc.21
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Tc7Mptk7ckedKSZrBIs4CvU8iC5eBq+7SPtsMMpqsC8=;
        b=DdvspVjZiHlal1+15WQ/235ESsK3HMaKjZLCVH3JppaB0nks71NNKfAqK6UnzW3RKF
         hWKTH2Pg+CW4d45V55s60cFAqxWd/1pVD8iW2CidF0IxvYxHFCWQaxuS1FwLu90j2gaq
         9jLYmtWTYZJJaPTEy3+RWQ+5utmk4DiYtHKmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Rryqg43ei3Zluiq37LA0GZ0mpiWfK4ii4mBaq9I5VsJRby0gZ6O5KMF6WEVu6otaSR
         XKtCH4kwV8fOdRdzH/Xw7tvdTLUTKjz61lV0iaX4pEzDhq/fP7k8J+5SIXNs7u/KCNbt
         yXzS/gFd7RmLDcYkXPJOwXKx/wdfPb7bF8Rxk=
Received: by 10.210.88.7 with SMTP id l7mr2657389ebb.124.1229206989824;
        Sat, 13 Dec 2008 14:23:09 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 13 Dec 2008 14:23:09 -0800 (PST)
In-Reply-To: <m3tz97g329.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103030>

On Sat, Dec 13, 2008 at 10:47 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>
>> My Web site uses pathinfo mode and some rewrite magic to show the gitweb
>> interface at the URL of the real repository directory (which users also
>> pull from).  In this case, it's desirable to end generated links to the
>> project in a trailing slash so the Web server doesn't have to redirect
>> the client to add the slash.  This patch adds a second element to the
>> "pathinfo" feature configuration to control the trailing slash.
>>
>> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
>
> Did you check that it does not confuse gitweb if filename parameter is
> passed using pathinfo?  Gitweb used to rely on final '/' to
> distinguish directory pathnames from ordinary pathnames, but I think
> currently thanks to the fact that gitweb now embeds action in pathinfo
> URL, and does not need to guess type, it is not an issue.
>
> Or only project URLs (i.e. only with project parameter, i.e. only
> "http://git.example.com/project.git/" but not other path_info links)
> have trailing slash added?
>
> Errr... I see that it adds trailing slash only for project-only
> path_info links, but the commit message was not entirely clear for me.

If indeed the additional / is only asked for in summary view, I think
there's no need for a feature toggle, we can always put it there. If
not, I'm really curious about seeing the rewrite rules (they might
also be worth adding to the gitweb documentation as examples of 'power
usage').

-- 
Giuseppe "Oblomov" Bilotta
