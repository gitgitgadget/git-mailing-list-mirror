From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 19:20:03 +0200
Message-ID: <CAN0XMOK-7xok+3drBD-MhubSu9fjeHqunu8S5+1MB_BW6COW4Q@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqlwi-0002wb-2I
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbbEHRUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:20:08 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36915 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbEHRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:20:05 -0400
Received: by widdi4 with SMTP id di4so34748924wid.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2nWSvHdvc4vYSwl7vR3NMaaS5ZuNBjiJ+yHxM23nLK8=;
        b=CBrK+INOCIODzgVDvRbrUUeYxRNsT4P3d60np4CEwJ0ttn5NINqQtC7oOtEFyuTH18
         GEs62R8g227nkqzqsF/uiDr/+5EZht8oIzBzvQg4Ou5OXih/B5kwg5ISt+ASv8hh2KaT
         q9feXWufPAuE6xBDqEsst0IIlIX2EoFzqC1SbtA1BcVy/bXO3SEF/M68cADnnTIQwEr6
         XeQB8yfJStOQJtsg7IHUlmM2TRbRrFfuOpRJCq1KEl/dtKvONqwHW2l399o+JMjwcRyq
         dfzXP29ZdlFtDhFRR6KsIPdUebfCsSXiI0JauBjnZu7AItcrdo071WPo0FM8K0njRs0y
         GCbg==
X-Received: by 10.180.10.102 with SMTP id h6mr7744943wib.37.1431105603859;
 Fri, 08 May 2015 10:20:03 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Fri, 8 May 2015 10:20:03 -0700 (PDT)
In-Reply-To: <CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268626>

Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Fri, May 8, 2015 at 12:53 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> sequencer.c: abbreviate hashs placed in the middle of messages
>
> s/hashs/hashes/

Thanks

>
>> Printing a 40 character sha1 hash in the middle of a message
>> stretches the sentence a lot. Print the abbreviated version
>> instead.
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> index c4f4b7d..2a39ab6 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -498,20 +498,21 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>>                 struct commit_list *p;
>>
>>                 if (!opts->mainline)
>> -                       return error(_("Commit %s is a merge but no -m option was given."),
>> -                               sha1_to_hex(commit->object.sha1));
>> +                       return error(_("Commit %s... is a merge but no -m option was given."),
>> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
>
> Are short SHA1's followed by "..." anywhere else in the project? It
> seems strange to introduce such usage here.
>

Yes, that's why I used it.
