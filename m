From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/7] submodule-config: keep labels around
Date: Wed, 11 May 2016 14:39:57 -0700
Message-ID: <CAGZ79kYfNyyLvhZKbmKNZV=2nR00HDEQcD_knPLo3OHRJY+yfg@mail.gmail.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-4-git-send-email-sbeller@google.com>
	<xmqqh9e5l7id.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYSxccNLvJ-=UghabQ_MG73jRSabVy5rgfNo-A6Fjz_yQ@mail.gmail.com>
	<xmqqfutojnd3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed May 11 23:40:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0brR-0003l9-1B
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 23:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcEKVj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 17:39:59 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35669 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEKVj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 17:39:59 -0400
Received: by mail-ig0-f169.google.com with SMTP id bi2so165505119igb.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JKM1xg0Uea6iejeXHybOOHFM/HP4YkDbOJSYkjJbWME=;
        b=iVoZ097x7l7sFGFPFElfDBDoRiUoupIsn8imklj/vimdqd1TLaAJj8Yh9WzaxKz2Qa
         kNvWAIivGzaUtouWEgbem2QgS5AzUeBm4q1W93MBWrLq3tCdOQS8Lc9E7V0b4oZo6WY9
         cM/KaLXa9gW6IYGtDpRqxMTYNdjyHehk7/GAo5YbNTyMLVqZPFYtWXtjMZYE03UbrRQ6
         HKpsPU1Hy0f7iUEGBCjdziGLK81/l8lvj2Sz+wIl2yqAfPwM0Qm6E/XuGDv/T1RTwEP3
         MBCXh9YheFH42/SLzC4lsJfFZJO1bxuTeC8fbOv4zrN9w2Af+r67RA4wKVFSm77U2nTj
         1WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JKM1xg0Uea6iejeXHybOOHFM/HP4YkDbOJSYkjJbWME=;
        b=EKNq8VPATVn3wXLPMq39/REJSMNW4JBBadI4n0zKDyOTKJk1tLF6QzuH5tZL1qwCke
         jgc4fiH0ME4oCMtmi43iYKsv2GgzDRks4HzeoAkFfrl7xXPhvkV0ARCdFmSXyTaaqvdj
         9C3XsWmFJkkzCykHhN/bDN2wk20nnkzITHqmjVmUCX2K3i2RN3tZ50+/DXxA6C2GHduW
         JIZ8SxrFxI7O1P54EOsiCsJCtrUvbd1ccggHGTs69ucBNDlvf4S5hG8P65TzfbHlrBMn
         ZfEeWxjJ8T7YtVB3HAFwJToED65LuBUzChHz16VTa1sEW1ZDM56TpUwpL2tG0nglsShG
         ohxw==
X-Gm-Message-State: AOPr4FXxhYSh5PTVoQEOgKFv08SoylyKu1IU5xVzi+BGGVEuuqQz65r6JDEBoUThEYvuyPh4OnR44ZwkSFHOxVTo
X-Received: by 10.50.29.45 with SMTP id g13mr24367125igh.93.1463002797944;
 Wed, 11 May 2016 14:39:57 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 11 May 2016 14:39:57 -0700 (PDT)
In-Reply-To: <xmqqfutojnd3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294371>

+Heiko

On Wed, May 11, 2016 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, May 10, 2016 at 6:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> @@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>>>>       submodule->update_strategy.command = NULL;
>>>>       submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>>>>       submodule->ignore = NULL;
>>>> +     submodule->labels = NULL;
>>>
>>> Hmph, is there a reason to do this, instead of embedding an instance
>>> of "struct string_list" inside submodule structure?
>>>
>>> I am not yet claiming that embedding is better.  Just wondering if
>>> it makes it easier to handle initialization as seen in the hunk
>>> below, and also _clear() procedure.
>>
>> Thanks for pointing out that alternative.  That looks so much
>> better in this patch. Let's see how the follow up patches develop.
>> As we'd not check != NULL first, but check against the count of the
>> string list. (I expect no problems down that road though).
>
> I also wonder if we can say the same for the .ignore field, by the
> way, if we agree that it is a better direction to go.

I don't think this is a good idea, as it's just a string, like .{url,
name, path}

Instead of storing the string we could store an enum {UNTRACKED,
DIRTY, ALL, NONE, NOT_INIT} though. That would be better I guess.
