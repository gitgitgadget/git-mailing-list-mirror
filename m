From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Subversion integration with git
Date: Fri, 26 Mar 2010 10:50:26 +1100
Message-ID: <4170AB98-B7C4-4351-B793-351B3DE74A4F@cordelta.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>  <40aa078e1003250731y2c900605k9c681475621a1ff2@mail.gmail.com>  <E560EF9A-AF07-4316-9047-6D1A1802F743@cordelta.com> <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 00:55:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuwty-0002pW-1i
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 00:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab0CYXzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 19:55:41 -0400
Received: from mail-ew0-f221.google.com ([209.85.219.221]:56740 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab0CYXzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 19:55:40 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2010 19:55:39 EDT
Received: by ewy21 with SMTP id 21so1963798ewy.25
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 16:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=RYy0x63r6urkhtcOG8Fqb2+IvyrlqXr126Hlm3KzfuM=;
        b=CLn1T9fDoUrgw9u1pHznoNHFpjo20B+s5/7t8dtQ8Y5eGgdM+9kaJbJSUJ4lMAxBev
         J+sjPQqrsPMztgeFGJOoadeBLeOaJPExOFeisjfRbAEE280IE4Gcmn7xWylJZ9JCz9J0
         CM2n78MGpBL6GDbbp6Xcs45+QazI75eUQA/YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=x891XtdiTwy0AajS3lZBRnp8CLGZ4EK8rOJfyig66e5Rji/WZGLb2unysnH9gicfvC
         v/Umd3+vuZyqucgalb51ShIUZRYANSnPBKidJtLGQhr7dkH95OOtCUDJVq8UCNz7G+Vm
         j1cOeJYjm4S9jvICLWeiK3qPJOFbqVBX0oFMk=
Received: by 10.213.97.129 with SMTP id l1mr93420ebn.76.1269561035416;
        Thu, 25 Mar 2010 16:50:35 -0700 (PDT)
Received: from [192.168.123.113] ([202.78.40.185])
        by mx.google.com with ESMTPS id 16sm211896ewy.7.2010.03.25.16.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 16:50:34 -0700 (PDT)
In-Reply-To: <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143201>

Hi,

>> I think it falls very close to the native-git-svn Google SoC
>> project[1], and if you are able to share what you have I'm sure
>> Ramkumar (I hope you don't mind me CC'ing you, and that I spelled your
>> name right) would appreciate having a look.
> 
> Yes. Thank you for CC'ing me, Erik.
> 
>> Is it worthwhile to start a new project - or would it be better to grok the internals of existing projects and try to make them scale?
> 
> However, if my proposal gets accepted, I
> could work with you to get it integrated into the remote helper that
> I'll be building. Depending on the complexity of your project, this
> might only be possible at the end of my GSoC term.

>From Ramkumar's proposal[1]:

> The distinct components I plan to write are:

> 2. An exporter for SVN repositories, which will extract all the
> relevant revision history and metadata to import into Git.
> 3. A remote helper for Git that takes the data from this SVN exporter,
> and uses git-fast-import to create corresponding commits in Git.

The scope of my project roughly corresponds to these two components.

With regard to licensing issues, I opted to work only with import/export streams so that no linking is required.

In the context of GSoC, I am studying my final year of a Bachelor of Science (Computer Science x 2) at Australian National University, Canberra.
As for FOSS contributions, the last time I released something was when I helped port the iBurst wireless broadband driver (USB interface) [2] a few years ago; the demands of life vs. one's passion.
