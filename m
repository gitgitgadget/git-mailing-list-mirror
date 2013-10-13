From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH try2 09/14] apply: add --stage option
Date: Sun, 13 Oct 2013 05:16:26 -0500
Message-ID: <CAMP44s153nOGxS+Z_AYOUw+JxmOi_QSbweAb82AU8yy1H580kw@mail.gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
	<1381561488-20294-7-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 12:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIit-00057O-Vu
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 12:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab3JMKQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 06:16:28 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:61726 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab3JMKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 06:16:27 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so4893856lab.3
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=os0BvAkxEWcwdgbgbfmwPnObs9uZpdiNeEeP1KA/xRc=;
        b=CPeSH+VmVD0wGEaWm8FYyVdxQTQSa3gv8lffughbsR4D3DINShKUxzio3w/YZ4CwcU
         IG4tBYlaoyTGIfATphuMPzQs8vRbdFATZ0Spw5jTf4G/N88YDC3bqS3Gs6Okj8cSFZXQ
         pOPo+k9lvaOVW4noSZWtS96cBEtDqfGYA0Vr7H5Hrel0R7iNKKyvMYCtG8dLiJjTOiiS
         dws3G/m920h2JFQnqWbkhvCtemu0VIQyZ1sYYOPGZuxOOmkJxRkMZljlP2lj6wq2koDk
         EK00dNAaeapDEsQBal6gM5u7yg5pN+WfXvxJl0wcD8qyoMK+ZCy9t/Qx4ZkSewsDBs+f
         KD8w==
X-Received: by 10.112.146.200 with SMTP id te8mr988106lbb.32.1381659386263;
 Sun, 13 Oct 2013 03:16:26 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 13 Oct 2013 03:16:26 -0700 (PDT)
In-Reply-To: <CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236072>

On Sun, Oct 13, 2013 at 4:53 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 12, 2013 at 3:04 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Synonym for --index.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  Documentation/git-apply.txt | 5 ++++-
>>  builtin/apply.c             | 2 ++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
>> index f605327..ce44327 100644
>> --- a/Documentation/git-apply.txt
>> +++ b/Documentation/git-apply.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
>>           [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
>>           [--allow-binary-replacement | --binary] [--reject] [-z]
>> -         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
>> +         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached|--staged]
>
> Here "staged".
>
>>           [--ignore-space-change | --ignore-whitespace ]
>>           [--whitespace=(nowarn|warn|fix|error|error-all)]
>>           [--exclude=<path>] [--include=<path>] [--directory=<root>]
>> @@ -67,6 +67,9 @@ OPTIONS
>>         up-to-date, it is flagged as an error.  This flag also
>>         causes the index file to be updated.
>>
>> +--staged::
>> +       Synonym for --index.
>> +
>
> Also "staged".
>
>>  --cached::
>>         Apply a patch without touching the working tree. Instead take the
>>         cached data, apply the patch, and store the result in the index
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 50912c9..42b5a4b 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -4377,6 +4377,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>>                         N_("instead of applying the patch, see if the patch is applicable")),
>>                 OPT_BOOLEAN(0, "index", &check_index,
>>                         N_("make sure the patch is applicable to the current index")),
>> +               OPT_BOOLEAN(0, "stage", &check_index,
>
> But here "stage".

Right. Should be "staged".

-- 
Felipe Contreras
