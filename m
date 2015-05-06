From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Wed, 06 May 2015 22:31:45 +0200
Message-ID: <554A7A31.1080604@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com> <CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:31:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq5yz-0000wf-TK
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 22:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbbEFUbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 16:31:49 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38866 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbEFUbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 16:31:48 -0400
Received: by wiun10 with SMTP id n10so36117091wiu.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PI8wrDMlmrkcxHPvF+eBMvPuzN5IaHAthnlf0nu7/FI=;
        b=J28MsNVtK6hQbD9L1b3A6ns+Wh3ifp3u7Ra72xfdCG6k54fKt5ct5Jci8bSic1yVMr
         U+GWv1e4BwJYEwEKXDqMqYaiyoJKCHNgFPc96uB+BFmnjpRwJL8a0ZiHZQqSFwu1NQv0
         KJLCajht93PedPQlMlQIIOLAJHWdgUf/UfTCpu94FnbJeKbrROFUBrx/3tG8kxQmib3V
         aUy6abCeq39ZNA7b26djXVKR4ww9KrYGQ2fVhU1KyUmvSTTzqILdmNnSACdCPOxsKc9p
         LHa9POKcLxB6HFE3nLltRZPZ8tShXvSMZm0wwFDJsiBEHwWYaitSCNF4V1twcRbAGs0O
         a4hQ==
X-Received: by 10.194.79.199 with SMTP id l7mr916741wjx.158.1430944307535;
        Wed, 06 May 2015 13:31:47 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id l20sm4372628wjw.42.2015.05.06.13.31.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 13:31:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268496>

On 05/06/2015 05:16 AM, Eric Sunshine wrote:
> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> 'git help' shows common commands in alphabetical order:
>>
>> The most commonly used git commands are:
>>     add        Add file contents to the index
>>     bisect     Find by binary search the change that introduced a bu=
g
>>     branch     List, create, or delete branches
>>     checkout   Checkout a branch or paths to the working tree
>>     clone      Clone a repository into a new directory
>>     commit     Record changes to the repository
>>     [...]
>>
>> without any indication of how commands relate to high-level
>> concepts or each other. Revise the output to group commands by
>> concept, like this:
>>
>> The most commonly used git commands are:
>>
>>     * starting a working area:
>>        clone      Clone a repository into a new directory
>>        init       Create an empty Git repository or reinitialize an =
existing one
>>
>>     * working on the current change:
>>        add        Add file contents to the index
>>        reset      Reset current HEAD to the specified state
>>        [...]
>
> This looks better. A couple minor style nits and a question below...
>
>> ---
>> diff --git a/help.c b/help.c
>> index 2072a87..c8b0bb6 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -218,18 +218,44 @@ void list_commands(unsigned int colopts,
>>          }
>>   }
>>
>> +int cmd_group_cmp(const void *elem1, const void *elem2)
>> +{
>> +       int group1, group2;
>> +
>> +       group1 =3D ((struct cmdname_help *) elem1)->group;
>> +       group2 =3D ((struct cmdname_help *) elem2)->group;
>
> Style: Drop space after the cast: (type *)var
>
>> +
>> +       if (group1 =3D=3D group2)
>> +               return 0;
>> +       if (group1 > group2)
>> +               return 1;
>> +       else
>> +               return -1;
>
> Do you also want to sort the commands alphabetically within group?
> That is, something like this?
>
>      struct cmdname_help *e1 =3D elem1;
>      struct cmdname_help *e2 =3D elem2;
>
>      if (e1->group < e2->group)
>          return -1;
>      if (e1->group > e2->group)
>          return 1;
>      return strcmp(e1->name, e2->name);
>

Hmmm yes. Good idea.

>> +}
>> +
>>   void list_common_cmds_help(void)
>>   {
>>          int i, longest =3D 0;
>> +       unsigned char current_grp =3D -1;
>>
>>          for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>>                  if (longest < strlen(common_cmds[i].name))
>>                          longest =3D strlen(common_cmds[i].name);
>>          }
>>
>> +       qsort(common_cmds, ARRAY_SIZE(common_cmds),
>> +               sizeof(common_cmds[0]), cmd_group_cmp);
>> +
>>          puts(_("The most commonly used git commands are:"));
>> +
>>          for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>> -               printf("   %s   ", common_cmds[i].name);
>> +               if (common_cmds[i].group !=3D current_grp) {
>> +                       printf("\n   * %s:\n", _(common_cmd_groups[c=
ommon_cmds[i].group]));
>> +               }
>
> Style: Drop unnecessary braces.

Understood.
