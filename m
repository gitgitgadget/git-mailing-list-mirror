From: Serhat Sevki Dincer <jfcgauss@gmail.com>
Subject: Re: git svn problem
Date: Sat, 11 Feb 2012 12:19:43 +0200
Message-ID: <CAPqC6xR9LFgx4r1t0misYavPe8sky=VJf39N29CU-66Re7zL-Q@mail.gmail.com>
References: <CAPqC6xRtZXwv+U6AKRUXDz=m-G4AjgWksbwqeMD_qzS8YC=DoQ@mail.gmail.com>
	<4F358A53.8010409@vilain.net>
	<CAPqC6xSJ7pfUQJz8FQ743mJMNmZyfJfWxutOnt+FVkP76eXOGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 11:19:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwA3a-000855-9T
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 11:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab2BKKTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 05:19:45 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43905 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab2BKKTo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 05:19:44 -0500
Received: by qcqw6 with SMTP id w6so2130054qcq.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 02:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=uTvu2FknZqjBn/+o76BrAjy0d7Cn2eBXpUuUAArXjUQ=;
        b=O+07FEqwSy5ThiJtNBbqafkAPQlSIM1ZCBndJxch4W+uaKdDDslXinzj3CXoT06Iy8
         r9jO3Y881YnUZ2XvEUsZ4rFq2rfFCMY8viH/Rkl15AmfuJz//S7eVAu54E8O3XInOvlx
         UCyvBgxSV289ke5FPd1pKxM2nMle4wDcxSNUw=
Received: by 10.224.59.209 with SMTP id m17mr2615601qah.5.1328955583811; Sat,
 11 Feb 2012 02:19:43 -0800 (PST)
Received: by 10.229.144.196 with HTTP; Sat, 11 Feb 2012 02:19:43 -0800 (PST)
In-Reply-To: <CAPqC6xSJ7pfUQJz8FQ743mJMNmZyfJfWxutOnt+FVkP76eXOGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190506>

Ok, I figured out the rest, in case someone needs it:

> I have the following at the moment:
>
> rm -rf plone.app.locales ; mkdir plone.app.locales ; cd plone.app.locales
> git svn init -T trunk http://svn.plone.org/svn/plone/plone.app.locales
> touch start ; git add start ; git commit -m start
> git svn fetch -r49624:HEAD
> git rebase --onto master --root trunk --preserve-merges
> git checkout -b plone

# edit .git/config: s#/plone/#/collective/#  s#remotes/trunk#remotes/trunkcol#

git checkout master
git svn fetch -r248302:HEAD
git rebase --onto plone --root trunkcol --preserve-merges
git checkout -b collective
git branch -d master plone
