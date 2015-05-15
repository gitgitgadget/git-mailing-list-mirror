From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 15:26:52 -0700
Message-ID: <xmqqegmhfpeb.fsf@gitster.dls.corp.google.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
	<5556582C.3010409@gmail.com>
	<xmqqmw15fu5m.fsf@gitster.dls.corp.google.com>
	<CAPig+cSjHyh5eO6KWYMo_OxUmDQWP9TnnuaBvnBGWVDh7pesOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 16 00:27:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtO4J-0003nc-KA
	for gcvg-git-2@plane.gmane.org; Sat, 16 May 2015 00:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946184AbbEOW0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 18:26:55 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36295 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422923AbbEOW0y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 18:26:54 -0400
Received: by iepk2 with SMTP id k2so132708721iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ekhKQhaXFQZRNHFsTu60WLr8ISqY+oyQd2IztNjYDtA=;
        b=LBf1o5vogBzqULbFeSacmOFIcXco85c6Ls+knm7TDgHjNdEZ20GrFa+ya8kCXj5Uk5
         /wo6D1Hxeos96o8LgU5NNNEDfxDWRaIbds20QBdALVOoYyVY9sG96nFF8n1Rxu9iGznz
         UONWKK4x/tj8QmIxXgJf8CJYOpXo0XCshv6F3hhQuIcpg8OIGlsOVRr5rRab4aFrwGnl
         AOCzPaSEiyR5iZvjidRqHgH7QYfFbWCMiXHSiu6T2axYlhFBQ6TUaNRfbVis2ZHgcZ+g
         4TIe3G2rXLWnQB8yqUF6gJRiS0jIh+L/2FJO19eLnF+FoECLcvm8YDRcQIieiRaVDbb4
         1N6Q==
X-Received: by 10.107.154.70 with SMTP id c67mr15803992ioe.22.1431728814075;
        Fri, 15 May 2015 15:26:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c15a:d232:e950:b701])
        by mx.google.com with ESMTPSA id p74sm2107320ioe.27.2015.05.15.15.26.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 15:26:53 -0700 (PDT)
In-Reply-To: <CAPig+cSjHyh5eO6KWYMo_OxUmDQWP9TnnuaBvnBGWVDh7pesOQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 15 May 2015 16:52:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269190>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 15, 2015 at 4:44 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>>>> You could for example have used the existing "# List of known git
>>>> commands" as such a signal to tell that all the no comment lines
>>>> below are commands.
>>>
>>> I tend to think that relying on comments as marks for parsers is br=
ittle,
>>> but indeed square brackets get in the way of sed regexes. I'll thin=
k of
>>> something better. Thanks.
>>
>> Heh, we, and more importantly our users, already rely on a marker in
>> comments when writing their commit log messages ;-)
>>
>> I would not be opposed to a new header that is outside comment, but
>> I do not think the marker line that is also a comment is "brittle"
>> and would not be opposed to that, either.
>>
>>     # do not molest the next line
>>     ### command list
>>     # name category
>>     git-add mainporcelain
>>     ...
>>
>> would be perfectly acceptable.
>>
>> I was just pointing out that you did not even have to have patch
>> 1/5.
>
> Is that entirely accurate? The machinery (Makefiles, cmd-list.perl)
> does have to be updated at some point to skip the "common" block whic=
h
> get added in patch 2/5.

That is true, but if "# List of known git commands" instead of
[commands] were used as the separator line, 1/5 wouldn't have needed
any change to the Makefile.

Of course, if you need to add lines that would appear as junk to the
old parser (e.g. the grouping info), at that point you would of
course need to tell the parser to skip them.
