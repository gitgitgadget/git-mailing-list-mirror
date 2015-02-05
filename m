From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s"
 as for "ln" / "cp"
Date: Thu, 5 Feb 2015 20:26:08 +0100
Message-ID: <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com>
	<D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com>
	<xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:26:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJS4E-0004zR-W6
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbBET0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:26:12 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:65454 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbBET0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:26:09 -0500
Received: by mail-yh0-f43.google.com with SMTP id 29so4242190yhl.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 11:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tJEvpmJcrzW0FvEHSafWMCmraqrDz/+lCtDvfMFGUbs=;
        b=qZbkMQYJaSgDJ6lTz6NJSKW9It/xY6y4ZsCx8kwjIzU+SetfsBmA6hhslxujh7/VMJ
         DlS7zX+vhv+wREC0rwf4W3z6sI/9U1WykHaNyOq+c0D+NzLy7LckF1014B0OcZvp23rk
         m6BMYu5uju9hzHUQay7oOyT7Va2IhhiHtSG4oULcXgWkAoBJjSkmV8KGgjmmfb9q+5X5
         flVaj7cNKwhoXgdv3KIyNxdLah86eaOjp4iMmqF3nz1VuYG0vm5NsP+1SbSe/9nZIDj+
         8PPH6ESdoxo+XeTNRG7BHeBHxNlCiRTAK8DB0vHBkrPAQtMCLiT4/puILDRV/Fc5qEcp
         NxOg==
X-Received: by 10.236.53.66 with SMTP id f42mr2338385yhc.92.1423164368457;
 Thu, 05 Feb 2015 11:26:08 -0800 (PST)
Received: by 10.170.132.133 with HTTP; Thu, 5 Feb 2015 11:26:08 -0800 (PST)
In-Reply-To: <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263390>

On Thu, Feb 5, 2015 at 8:23 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> This is wrong.
>>
>> Currently with symlinks you will get installed into bindir something
>> like this:
>>
>>   git
>>   git-tag -> git
>>   git-show -> git
>>
>> etc.
>>
>> With your change you would have
>>
>>   git
>>   git-tag -> /usr/local/libexec/git-core/git
>>   git-show -> /usr/local/libexec/git-core/git
>>
>> And I don't think we want that.  While those absolute path symlinks
>> are technically correct,...
>
> It is not even correct, is it?
>
> When DESTDIR is set to allow you to install into a temporary place
> only so that you can "tar" up the resulting filesystem tree, bindir
> points at the location we need to "cp" the built programs into, i.e.
> inside DESTDIR.

Agreed folks, please disregard this as well as 2/2 of this series.

-- 
Sebastian Schuberth
