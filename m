From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 3/3] git help: group common commands by theme
Date: Fri, 08 May 2015 23:08:01 +0200
Message-ID: <554D25B1.8050605@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<13c3dcbd2c5c9dfc0453381b5da53b5d68af7afe.1430770308.git.sebastien.guimmara@gmail.com> <CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:08:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqpVB-0000OR-TP
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbbEHVIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 17:08:05 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37027 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbEHVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:08:04 -0400
Received: by widdi4 with SMTP id di4so40443770wid.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+S23h5KDm0UJw/tSf0+LFPhSAfBYn/LXZJwKe/AGR58=;
        b=klUVW+1735ix5IPrFsMdA+Tz/Qi5bcZz1bjo9fjBytFMGteAsdtyKVixvO9MSbtUAx
         dewwWD6JcFWbgIrzLCcF0Wcw3JjbUay7tNKTQQwHON495MVt5ANkYnYs3DHqA98tZTOu
         0D2Rx7ha9VwK+c65b0qSLu/WQUi8knK+/kwxTPICr5IQ0wj0Y8XnPc31EmwdLsIuUXzY
         1A8ZTEWdGCH7WlmCoE+EOdGuyLY/FFzVdaywYMUcOq2FYnQbPMUsKJRtSczF2i+SLejh
         h4TJ5UkQV+eQhKm3Oy1o4iI3byne/Rtht9h7gkVPDknYYjNijv9YT1Xv87ga8SHbaUNL
         BqCQ==
X-Received: by 10.194.192.72 with SMTP id he8mr11032296wjc.11.1431119283167;
        Fri, 08 May 2015 14:08:03 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id df1sm553204wib.12.2015.05.08.14.08.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 14:08:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cS=u-HK1qNicWiLOQC6RPkR7QueX+kOu8fQwpHekgs1yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268668>

On 05/06/2015 05:16 AM, Eric Sunshine wrote:
> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
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
>> +}

Your version raises:

help.c: In function =E2=80=98cmd_group_cmp=E2=80=99:
help.c:223:28: warning: initialization discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [enabled by default]
   struct cmdname_help *e1 =3D elem1;
                             ^
help.c:224:28: warning: initialization discards =E2=80=98const=E2=80=99=
 qualifier from pointer target type [enabled by default]
   struct cmdname_help *e2 =3D elem2;
                             ^

With the cast:

struct cmdname_help *e1 =3D (struct cmdname_help*)elem1;

It compiles without a warning (gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2)

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
>
>> +               current_grp =3D common_cmds[i].group;
>
> Alternately, move this assignment inside the braces.
>
>> +               printf("      %s   ", common_cmds[i].name);
>>                  mput_char(' ', longest - strlen(common_cmds[i].name=
));
>>                  puts(_(common_cmds[i].help));
>>          }
>> --
>> 2.4.0
>
