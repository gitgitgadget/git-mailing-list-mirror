From: "Frank Li" <lznuaa@gmail.com>
Subject: Re: how to omit rename file when commit
Date: Mon, 19 Jan 2009 17:35:41 +0800
Message-ID: <1976ea660901190135k71087673p85e995878e539a8f@mail.gmail.com>
References: <1976ea660901190113l5407f108lff8f37d9a8331f58@mail.gmail.com>
	 <7v63kbr6zc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 10:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqZ9-0006p0-Cb
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbZASJfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbZASJfn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:35:43 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:3050 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbZASJfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 04:35:42 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1194997ywe.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tCT69PNS2PQNlApeSALuASpGzOR9Z9V8eb739n7gxL4=;
        b=lEjHe/H7xGasp5cQhSMNZhkQq0CgnhbmVKn051ApyIzPvhwpu1piSaP7+/oVbjzISP
         9fVVM75wAnj1FUXmTFb+PW8HnEU3AMXkI9Pi8iVzDxjdHOtevGIg29KBRYGSVEWs+Xsm
         V3vyGRkmF/7jg7VTVZxoZw7eWV7D3hq+Tcl9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fRaPGFAI+3gFbz13SlgCBDk2i2/qu0yCLxiI4cseGLFsidEkGHyRrBZSLSnSXK/gSr
         nMgTMJBP4tgZV35/KgJdofxfqELGXHPYELki5UaTCMU8SNNdaBsa9yAGnTqEi+ZSOtVW
         DjZH83PURP+zDNX5brU4EJI4uyELmANgkInhU=
Received: by 10.150.123.18 with SMTP id v18mr6146862ybc.80.1232357741791;
        Mon, 19 Jan 2009 01:35:41 -0800 (PST)
Received: by 10.151.139.13 with HTTP; Mon, 19 Jan 2009 01:35:41 -0800 (PST)
In-Reply-To: <7v63kbr6zc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106340>

For example:
there are 2 file. a.c and e.c
I modify e.c.
and git mv a.c b.c

git update-index e.c

I just want to commit e.c and don't commit rename(a.c -> b.c)

I am debuging a tortoisegit.  at commit dialog, there will be show all
changed as
[x] rename (a.c => b.c)
[x] modify (e.c)
button [OK]

assume user uncheck rename
[]rename (a.c=>b.c)
[x]modify (e.c)

then click okay.

I don't know use which git command to handle this case.
if git mv b.c a.c, local working copy will be changed.


2009/1/19 Junio C Hamano <gitster@pobox.com>:
> "Frank Li" <lznuaa@gmail.com> writes:
>
>> For example there are a file a.c at git repository.
>> use
>> git mv a.c b.c
>>
>> git status:
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #       renamed:    a.c -> b.c
>>
>> If we don't want to stage this change at this commit,  what can I do?
>
> I may be misunderstanding what you want to do, but wouldn't "git mv b.c
> a.c" undo whatever you did?
>
>
