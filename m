From: John Tapsell <johnflux@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 09:56:49 +0100
Message-ID: <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org> <7vd2towdiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:57:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTq5F-0003Dd-1c
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab3DUI5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:57:12 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43683 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3DUI5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:57:10 -0400
Received: by mail-ia0-f174.google.com with SMTP id m10so2552129iam.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NbUIKsSYIT9W7vGKjYAskq0StjI9KsFqPESGyzBlDZs=;
        b=N2J7cm8gZ0p+PAMOGIveAyiHH6hCRI2NktDpZUhD+LT0np+QWhXqGuF9t0XtIN0I1j
         FsT2Z8t6/cxG8tSoyDvgLICgSU3NEvkOtKDBLjWnnfB440NZJVaSjk8OL7xd1g0Mmpke
         yLz7zDO7R7LSdo1Y2am8UMQplKTamJotIksJN5ffOKWTTqS3nZLGtCCieCyu097xZg2r
         pWPkX6+1LB8zB+U8e9XobIC4D6qNC2/l/NCTt/Xk7DXDlOMK00RXOIT7urA5p6KZYia/
         o7qQthHe7aWqQ+A2k4uqkYHUil+po40K+jcuD3EedOCYx1a2oQMTd7OvgOjEl6/boKQ/
         yr7w==
X-Received: by 10.50.119.39 with SMTP id kr7mr5431300igb.19.1366534630029;
 Sun, 21 Apr 2013 01:57:10 -0700 (PDT)
Received: by 10.64.8.235 with HTTP; Sun, 21 Apr 2013 01:56:49 -0700 (PDT)
In-Reply-To: <7vd2towdiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221935>

On 21 April 2013 08:26, Junio C Hamano <gitster@pobox.com> wrote:
> Simon Ruderich <simon@ruderich.org> writes:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 104579d..cd35ec7 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -24,6 +24,10 @@ ifndef::git-format-patch[]
>>  --patch::
>>       Generate patch (see section on generating patches).
>>       {git-diff? This is the default.}
>> +ifdef::git-log[]
>> +     Changes introduced in merge commits are not displayed. Use `-c`,
>> +     `--cc` or `-m` to include them.
>> +endif::git-log[]
>
> It probably is a better change to drop "Use `-c`..." and refer to
> the "Diff formatting" section.
>
> And then add '-p' and the fact that by default it will not show
> pairwise diff for merge commits to the "Diff Formatting" section.
> That is where -c/--cc/-m are already described.

Why not have it in both places?  This is really important.

I'm concerned that noone is taking this security risk seriously.  Just
because it doesn't show up in certain workflows doesn't make the risk
go away.

What about all the people who use git internally?  They aren't using
github and almost certainly aren't using a mail based system.

It's bad that we can't even set the right behaviour as a default.

John
