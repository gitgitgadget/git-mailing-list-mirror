From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v1 06/25] contrib: remove 'diffall'
Date: Fri, 9 May 2014 12:26:04 -0700
Message-ID: <CAFouethK=VKYzTOW7dDi7tmOHaGtNp_xHxk3MSf+n1QNuXbEdQ@mail.gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-7-git-send-email-felipe.contreras@gmail.com>
	<CAFouetj4A+z2xzciGAbsQ8th8CNwYMd5QTapar4TXRLzGdAqeQ@mail.gmail.com>
	<20140509185035.GL9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 21:26:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqQu-0005OQ-BH
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbaEIT0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:26:07 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:50256 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaEIT0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:26:06 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so5802570veb.34
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rDC3A7UXSFXeE5+8OBJhXlG8uBjncVJxFolXnPVYd1o=;
        b=s7guH01t/HK7iFOltTcNO8M6fXw9zlPaNV0SU3ck+x5rShVB0GUueeaiPD/JpUSkJU
         r2t8AOOPWPaplMXXD2S0sR4fpvKLUHnvIMtTxTA7Ma/0jE6IDoc0xddod11pddrtLnjV
         gxJr8vTjCq6X6xAdxjeNQkgmQMYAOqI2PW4LZM+/NuzJP128Bhxi+fn9g6uIdJ+OQx04
         TZ/jCP5upeae297fWR+f2WPobARQpq6D3X7rZHP8pGG9XYyS0PpiPTU3ZRHbui80vMyX
         8Z18EhbXYsFzGELFgrj9UgqZES9hswiMw7XPnx3t6aQQSk3jXpwPF8JPhID4bcg2h69s
         eJCw==
X-Received: by 10.220.163.201 with SMTP id b9mr15786vcy.79.1399663564784; Fri,
 09 May 2014 12:26:04 -0700 (PDT)
Received: by 10.220.95.207 with HTTP; Fri, 9 May 2014 12:26:04 -0700 (PDT)
In-Reply-To: <20140509185035.GL9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248631>

Hi Jonathan,

On Fri, May 9, 2014 at 11:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Tim,
>
> Tim Henigan wrote:
>> On Thu, May 8, 2014 at 5:58 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>
>>>  contrib/diffall/README      |  31 ------
>>>  contrib/diffall/git-diffall | 257 --------------------------------------------
>>>  2 files changed, 288 deletions(-)
>>>  delete mode 100644 contrib/diffall/README
>>>  delete mode 100755 contrib/diffall/git-diffall
>>
>> I see no problem with removing this script from contrib.  However, the commit message
>> should mention that git-difftool learned all the features of git-diffall when the '--dir-diff'
>> option was added in v1.7.11 (ca. June 2012).
>
> A few questions:
>
>  * Do you still use git-diffall?  Since it hasn't been a maintenance
>    burden, I wouldn't mind keeping it if it still has users.

I have not used diffall since a few months after the difftool '--dir-diff'
option was released.  Once difftool learned those features, the
diffall script became obsolete.

For people using older git (i.e. before v1.7.11), it may still be useful.
For them, the original out-of-tree repo remains available on github [1].

[1]: https://github.com/thenigan/git-diffall


>  * Any thoughts about how to help people who have been using it to
>    migrate to difftool?  Would a note in the release notes to look
>    into the --dir-diff option to difftool be enough, or are there
>    more specific pointers that could be useful?

Pointing to 'difftool --dir-diff' should be enough.

The only change in behavior is that when a working tree file is part
of the diff and is modified during the diff, 'difftool --dir-diff' automatically
keeps the modifications.  The 'diffall' script required the user to use
the '--copy-back' option to do the same.

All other options are exactly the same.


> Once those questions are dealt with, this seems like a nice small
> cleanup.  Thanks for the quick feedback.

If it would be helpful, I can send a patch that replaces the contents
of 'contrib/diffall' with a README that explains the above and points
to the github repo for people using versions of git prior to v1.7.11.
This would be similar to what was done for 'contrib/vim'.

However, I like the idea of simply removing the directory from contrib
and pointing to 'difftool --dir-diff' in the release notes.
