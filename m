From: Stefan Beller <sbeller@google.com>
Subject: Re: git pull not ignoring the file which has been sent to the
 temporary ignore list
Date: Fri, 23 Jan 2015 12:12:26 -0800
Message-ID: <CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
	<xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
	<4004424.cytMaov38D@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:12:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkal-0007BA-KD
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365AbbAWUM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:12:28 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:49160 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbbAWUM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:12:27 -0500
Received: by mail-ig0-f182.google.com with SMTP id r10so3913774igi.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nWWx7/X7tQYSRdqqL8yiMF9tXRnbnmFN9Brx716LBy0=;
        b=XtNFaPTeoU2mTB0JSXOeQ0xI6ByDm/y54tHIp1Eh9Hs/XC6DB6RSJzuNc1pMS13RxT
         dOnLzgKQOuF8U3l/hNDR1Z7lR5K0XeE2VGD2Hw1HTl0DTXVwnbdvCWKwfJP/JHayE+9N
         aGH23EQbkG9gypw1gmYgYSVlvoaQZ242f68fQts1t0bNlqea5lirXWbQ0Q5PVSdUMOQb
         dCgmNwUP9B0p7fX2WhuM7VB6StlOuMbnDXAlv/J64lcVh1D0rNqj8BHX0Fhh2y+JtH4D
         1TSJsLykaPVenvwSnm3O0NtkNZswQVt/xEYqWfPlCJ9E21X/pp2pvBy4eiW2kjUyz10y
         UbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nWWx7/X7tQYSRdqqL8yiMF9tXRnbnmFN9Brx716LBy0=;
        b=YoF7luBJ+edkj1pBxToelv8JzsnVUTdVdvI0QcLV/QaC+5N3u4mq0QAcZVaw+/8a3M
         rgtY4FavHsGJakCifzVH+xTliSB7dOrhwv7xOLqHxFIB4aG45gEYxKARdb6hPCttZT57
         nFMgxQr++fJ8Fk/3DOz+C66ZzB8MrfvxYtHqG2/BOm4hYdDPzle4EzyyRRQc6AKUoIHh
         pIJwth4fHcsQ2ySGriybck98y1pKsFaDMdgPg97w87CKPx2AEFgr3PdQmBUz1OR3wkV0
         Jh/7CKs62ihU5xQh5qRWhdxrnFJx8DIxT2E54AgP92JlKRgtiOF5wPq/ID8EWzxG8GIQ
         T/1Q==
X-Gm-Message-State: ALoCoQkOR5PP6BaoiGc46nEqpOfC7qhYWexpYTvb2gY2tvGAqEpaqXlkMi17kFI6pbj5r0qeS3nZ
X-Received: by 10.50.108.108 with SMTP id hj12mr3854799igb.47.1422043946401;
 Fri, 23 Jan 2015 12:12:26 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 23 Jan 2015 12:12:26 -0800 (PST)
In-Reply-To: <4004424.cytMaov38D@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262960>

On Fri, Jan 23, 2015 at 10:35 AM, Arup Rakshit
<aruprakshit@rocketmail.com> wrote:
> On Friday, January 23, 2015 11:31:40 AM you wrote:
>> Arup Rakshit <aruprakshit@rocketmail.com> writes:
>>
>> > I asked git not to track any changes to the file .gitignore. To do
>> > so I did use the command - git update-index --assume-unchanged
>> > .gitignore.
>>
>> You are not asking Git to do anything. You promised Git that you
>> will make no changes to .gitignore, and then broke that promise.
>>
>> Assume-unchanged is *not* "Ignore changes to this path".
>
> Ok. How should I then ignore any local changes to the .gitignore file ? And while taking pull, git should skip this file ?

Look at .git/info/exclude

When looking for a reference to that path (I am bad at remembering
which man page that is)
I found https://help.github.com/articles/ignoring-files/ as Googles
first hit, which advises to use
    git update-index --assume-unchanged path/to/file.txt
Not sure if that is most helpful advice there.

See http://git-scm.com/docs/gitignore instead
