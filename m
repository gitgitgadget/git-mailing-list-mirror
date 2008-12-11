From: "James Youngman" <jay@gnu.org>
Subject: Re: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Thu, 11 Dec 2008 23:59:29 +0000
Message-ID: <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
	 <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
	 <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
	 <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jim Meyering" <jim@meyering.net>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Dec 12 01:00:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAvSg-00033d-Ue
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 01:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbYLKX7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756486AbYLKX7b
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 18:59:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:8082 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbYLKX7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 18:59:30 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1116642rvb.1
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 15:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=qTdKYmYMPC9c4nDJvlyATBOniyUNbGLFLumFQyyuQPY=;
        b=yDeQ6dahYuF7WXiVaWfHMsDNGmMB5vH4D1EfTgjl5npbKURWM7lLxJPci/TUUfMpRM
         ZvCgfpRMw4Qt3beEBnsE+RzQUt5mac7zxHQqO1sSQ7xtvP486u7hcPr6MKYCTlpAuYm8
         pEVfPLCeWzXxFYspXJmUbSn6DWHfBGmF2+spM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=lJWOOfweDO/YDgl/CblDvUg5IPgM5GclJOK7BqusmWUKwB0UQzMboa67IXuOO19vKc
         wf9EM9/FvW5DoLY7WpI4DdrF07yYH0ogko+Qqss/03/yq+IXt9gasP4E372NwgsQS/R0
         TOEudeQGz+2LWA8xgCb2gOs6J1VcYlwB4MF7E=
Received: by 10.140.207.2 with SMTP id e2mr1577645rvg.65.1229039969195;
        Thu, 11 Dec 2008 15:59:29 -0800 (PST)
Received: by 10.141.22.4 with HTTP; Thu, 11 Dec 2008 15:59:29 -0800 (PST)
In-Reply-To: <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: 8243eba296b469c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102848>

On Thu, Dec 11, 2008 at 11:13 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:

>> Before conversion:
>> $ git cat-file tag FINDUTILS-4_1-10
>> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>> type commit
>> tag FINDUTILS-4_1-10
>> tagger Kevin Dalley
>
> The tagger field is missing an email address, a timestamp, and a timezone. It
> should look something like:
>
>  tagger Kevin Dalley <kevin.dalley@somewhere.com> 1229036026 -0800
>
> git-mktag prevents improperly formatted tags from being created by checking
> that these fields exist and are well formed.
>
> If you know the correct values for the missing fields, then you could

Yes for the email address.      But as for the timestamp, it's not in
the tag file; that only contains the sha1.
There is a timestamp in the object being tagged, is that the timestamp
you are talking about?

$ git show --pretty=raw  ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
commit ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
tree 752cca144d39bc55d05fbe304752b274ba22641c
parent 9a998755249b0c8c47e8657cff712fa506aa30fc
author Kevin Dalley <kevin@seti.org> 830638152 +0000
committer Kevin Dalley <kevin@seti.org> 830638152 +0000

    *** empty log message ***

diff --git a/debian.Changelog b/debian.Changelog
index e3541eb..d0cd295 100644
--- a/debian.Changelog
+++ b/debian.Changelog
@@ -1,5 +1,7 @@
 Sat Apr 27 12:29:06 1996  Kevin Dalley
<kevin@aplysia.iway.aimnet.com (Kevin Dalley)>

+       * find.info, find.info-1, find.info-2: updated to match find.texi
+
        * debian.rules (debian): update debian revision to 10

        * getline.c (getstr): verify that nchars_avail is *really* greater





> recreate the tags before doing the filter-branch. If they are unknown, it
> seems valid enough to use the values from the commit that the tag points
> to.
>
> i.e.
>
>  tagger Kevin Dalley <kevin@seti.org> 830638152 -0000
>
> What tool was used to convert this repository to git? It should be corrected
> to produce valid annotated tags. Especially if it is a tool within git.

I don't know, Jim Meyering will know though, so I CC'ed him.


> The tag below was actually not converted. filter-branch bailed
> out during the conversion and so left it alone.

I see.

Thanks,
James.
