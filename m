From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 22:33:48 +0200
Message-ID: <5556582C.3010409@gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com> <xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:33:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMIv-0004nj-4H
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934547AbbEOUdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:33:52 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36409 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934285AbbEOUdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:33:52 -0400
Received: by wizk4 with SMTP id k4so3454465wiz.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t0y8b47cshxgyq8rvqbnpn5xAn4Y3uYg6hTZLhi2q9g=;
        b=YeFl66lkixSTpFvmfmq7HpwKVOfXhHVZesjZL13kj6jGRMSCP2lnmtL15OqcFFbBwm
         HXSxCboq8EjJYpJlMUVuGRD50TY1hHZ9pt3EM+54zkfywsmvzzYeXqm5G0XOzdmKmNuD
         s4Afwk5smCTRRFYgXOsgnn/PNvgehrX9/9bZD+PYUCVrljI7C3RBneb7KPEE5OohvoJa
         MBkOcaz1ItpwixPCCVKOGe06mFUct7lTz+Nu47MnZniVTbx7KPEn+cCCD5FT94i+ERgG
         gzN8xKvAzt3bBjdJ9g88zn5iHYST/JC1vTzRAAPvwPN5K4s1BSVLTdlXkEN2EVZjHfW8
         LxBg==
X-Received: by 10.194.63.80 with SMTP id e16mr22129792wjs.56.1431722031023;
        Fri, 15 May 2015 13:33:51 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id yz3sm4129985wjc.19.2015.05.15.13.33.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 13:33:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269179>

On 05/15/2015 10:26 PM, Junio C Hamano wrote:
> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>
>> diff --git a/Makefile b/Makefile
>> index 25a453b..0cb2045 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2454,7 +2454,7 @@ check-docs::
>>   		esac ; \
>>   		test -f "Documentation/$$v.txt" || \
>>   		echo "no doc: $$v"; \
>> -		sed -e '/^#/d' command-list.txt | \
>> +		sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
>>   		grep -q "^$$v[ 	]" || \
>>   		case "$$v" in \
>>   		git) ;; \
>> @@ -2463,6 +2463,7 @@ check-docs::
>>   	done; \
>>   	( \
>>   		sed -e '/^#/d' \
>> +		    -e '1,/^\[commands\]/d' \
>>   		    -e 's/[ 	].*//' \
>>   		    -e 's/^/listed /' command-list.txt; \
>>   		$(MAKE) -C Documentation print-man1 | \
>> diff --git a/command-list.txt b/command-list.txt
>> index 54d8d21..caed872 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -1,5 +1,6 @@
>>   # List of known git commands.
>>   # command name                          category [deprecated] [com=
mon]
>> +[commands]
>>   git-add                                 mainporcelain common
>>   git-am                                  mainporcelain
>>   git-annotate                            ancillaryinterrogators
>
> This is largely just a "taste" thing, but with all these backslashes
> in the supporting infrastructure you had to add in Makefiles and
> scripts, don't you think the choice of the way you designed the
> format to use '[commands]' was a rather poor one?  After all, all
> you need is a clear separator line for a block of commands and
> another block of groups, and there wasn't a reason why you needed to
> use square brackets for that, and the sed scripts are suffering from
> that poor choice.
>
> You could for example have used the existing "# List of known git
> commands" as such a signal to tell that all the no comment lines
> below are commands.
>

I tend to think that relying on comments as marks for parsers is brittl=
e,
but indeed square brackets get in the way of sed regexes. I'll think of
something better. Thanks.
