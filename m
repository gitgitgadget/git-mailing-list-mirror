From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 4/4] git update-index --cacheinfo can be used to select a
 stage when there are merged and unmerged entries
Date: Thu, 21 Aug 2014 15:57:01 +0200
Message-ID: <CAPuZ2NHMjo996rqNPhpt6MJ5bCbT_zUCfjQUVmDip4dmqiP+yQ@mail.gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<af54b2b3e80a6ff76b07ea129ead43079ef06a7a.1408533065.git.jsorianopastor@gmail.com>
	<xmqq38cquavu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 15:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSrX-0004KL-UB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 15:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbaHUN5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 09:57:05 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:52992 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117AbaHUN5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 09:57:01 -0400
Received: by mail-pd0-f175.google.com with SMTP id r10so13630156pdi.20
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=isinzFe4Al9Y73mjyJpFMb7KBlxW04gV9hknr5sI1tU=;
        b=cwS4PA8EUw/MSVGoeKMwyvrjf3Ct+j7C0zMY3TkBdO1Pj8u430IGb0DV7A7ftFUCV3
         ETV4AMxwjLyVECOjqtga9WVpq8q/auh1soiV4UhwbNfa4daJnPd2Z2NIg+j4j2tP4I46
         8uwRrncVCQBcJGr5Cy8JyMJhFcEdgPs1ne4M1/osi6hrf0HxS1i3mIC4I4AmhAE7755v
         amJfvJqHQ91nkVK3alftCkh8957+XomnhjblZDdkOOqcgX6pPllaZyg6yXayXGSmqAKy
         yYpJjpWea7JfmbgK1/QLmfBpcgQD3V4Iso9bIxLsleqpFpgwIzn8CF//5hJoZKjpRYD6
         5xnQ==
X-Received: by 10.66.251.132 with SMTP id zk4mr62244697pac.47.1408629421523;
 Thu, 21 Aug 2014 06:57:01 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Thu, 21 Aug 2014 06:57:01 -0700 (PDT)
In-Reply-To: <xmqq38cquavu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255615>

On Wed, Aug 20, 2014 at 11:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
>> Subject: Re: [PATCH 4/4] git update-index --cacheinfo can be used to select
>>  a stage when there are merged and unmerged entries
>
> Hmph, what does it even mean?  Shared with your [1/4] is that it is
> unclear if you are stating an existing problem to be fixed or
> describing the desired end result.
>
> Also "update-index --cacheinfo" is not about "selecting" but is
> about stuffing an entry to the index, so "can be used to select"
> is doubly puzzling...
>
Well, somehow I understand "update-index --cacheinfo" as a low level
version of add. I was trying to explain the desired end result, yes.

>>   ...
>> +test_expect_success 'git update-index --cacheinfo to select a stage to use' '
>> +     setup_stage_state &&
>> +     git cat-file blob :1:conflict > conflict &&
>
> Style: no SP between redirection and its target.
>
Ok.

>> +     git update-index --cacheinfo 100644,`git hash-object conflict`,conflict
>
> Style: we prefer $() over ``
>
Ok.

>> +     git ls-files -s conflict > output &&
>> +     test_line_count = 1 output
>
> Is "we have only one line" the only thing we care about?  Don't we
> want to check which stage the entry is at?
>
Yes, it'd be better.

Thanks.
