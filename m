From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Sat, 16 May 2015 11:44:02 +0200
Message-ID: <55571162.2040803@gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com> <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com> <CF195F7BDDED481EA064C0C30098017C@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Philip Oakley <philipoakley@iee.org>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 11:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtYdh-0001wf-MA
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 11:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbbEPJoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2015 05:44:08 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35087 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbbEPJoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2015 05:44:06 -0400
Received: by wicmx19 with SMTP id mx19so19470696wic.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=kwvDpugKqwYntprWBb0j33kOip5OZjoMamtjQM0DE3A=;
        b=bn192Z5YpNzx25PSxnpFKBq8S1+/TbdLj+pnNEqTRZZgSkPHXsPGRWh7Y6c88+K2hS
         6awXIVjaQP0NnMopfMyweV0y5eccsNq1ggKVVSaGHWqVsnYxYkFyB8s7E+gy7CnC+/7f
         I2YjpPZVPiyv8jGA8KByGUbk5ixLXbf5xs6oxwAvIGP3j2jL2aL5C45uCXniqcc5I9TZ
         cK8AtrTXEG2r3pbwXhQDezwIwgu8UV3dZ8RH0CqAP1jMNDbQkSH8L9UEMRRMgdbijHfw
         PhtlKykOa2c30YyzUzJHXPqPmp/trTnwykEBs3AhNVfpsgS7NalDY/3tNNkVb5SqooCa
         XdAg==
X-Received: by 10.195.17.232 with SMTP id gh8mr25608271wjd.145.1431769444774;
        Sat, 16 May 2015 02:44:04 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id u6sm6541740wjy.13.2015.05.16.02.44.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 May 2015 02:44:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CF195F7BDDED481EA064C0C30098017C@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269194>



On 05/16/2015 11:44 AM, Philip Oakley wrote:
> From: "S=C3=A9bastien Guimmara" <sebastien.guimmara@gmail.com>
>> Add a [commands] header before the actual command list, then make th=
e
>> following files ignore this header in their parsing:
>>
>> * cmd-list.perl
>> * Makefile (check-docks target)
>
> s/docks/docs/
> or even fuller as "(the check-docs target)"?
> I'd misunderstood this as (verb) check the doumentation targets withi=
n the Makefile, rather than the (definite article) 'check-docs' target =
within the Makefile ~#L2554.
> --
> Philip
>

That's right, thanks for pointing that out.

>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> Documentation/cmd-list.perl         | 4 ++++
>> Documentation/howto/new-command.txt | 4 +++-
>> Makefile                            | 3 ++-
>> command-list.txt                    | 1 +
>> 4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.pe=
rl
>> index 04f9977..06a5fd6 100755
>> --- a/Documentation/cmd-list.perl
>> +++ b/Documentation/cmd-list.perl
>> @@ -38,6 +38,10 @@ sub format_one {
>>  }
>> }
>>
>> +while (<>) {
>> + last if /^\[commands\]/;
>> +}
>> +
>> my %cmds =3D ();
>> for (sort <>) {
>>  next if /^#/;
>> diff --git a/Documentation/howto/new-command.txt b/Documentation/how=
to/new-command.txt
>> index d7de5a3..6d772bd 100644
>> --- a/Documentation/howto/new-command.txt
>> +++ b/Documentation/howto/new-command.txt
>> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>> that categorizes commands by type, so they can be listed in appropri=
ate
>> subsections in the documentation's summary command list.  Add an ent=
ry
>> for yours.  To understand the categories, look at git-commands.txt
>> -in the main directory.
>> +in the main directory.  If the new command is part of the typical G=
it
>> +workflow and you believe it common enough to be mentioned in 'git h=
elp',
>> +map this command to a common group in the column [common].
>>
>> 7. Give the maintainer one paragraph to include in the RelNotes file
>> to describe the new feature; a good place to do so is in the cover
>> diff --git a/Makefile b/Makefile
>> index 25a453b..0cb2045 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2454,7 +2454,7 @@ check-docs::
>>  esac ; \
>>  test -f "Documentation/$$v.txt" || \
>>  echo "no doc: $$v"; \
>> - sed -e '/^#/d' command-list.txt | \
>> + sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
>>  grep -q "^$$v[ ]" || \
>>  case "$$v" in \
>>  git) ;; \
>> @@ -2463,6 +2463,7 @@ check-docs::
>>  done; \
>>  ( \
>>  sed -e '/^#/d' \
>> +     -e '1,/^\[commands\]/d' \
>>      -e 's/[ ].*//' \
>>      -e 's/^/listed /' command-list.txt; \
>>  $(MAKE) -C Documentation print-man1 | \
>> diff --git a/command-list.txt b/command-list.txt
>> index 54d8d21..caed872 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,5 +1,6 @@
>> # List of known git commands.
>> # command name                          category [deprecated] [commo=
n]
>> +[commands]
>> git-add                                 mainporcelain common
>> git-am                                  mainporcelain
>> git-annotate                            ancillaryinterrogators
>> --
>> 2.4.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
