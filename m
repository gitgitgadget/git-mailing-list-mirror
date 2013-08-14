From: Andres Perera <andres.p@zoho.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 12:10:49 -0430
Message-ID: <CAPrKj1acdFGqkpzSANq_jUst_994e0sFFq+m4Q3wa7qT81uV5A@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
	<7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
	<520AC9A8.4030104@gmail.com>
	<7vmwolujvb.fsf@alter.siamese.dyndns.org>
	<520B2478.3000100@gmail.com>
	<CAPrKj1ZQL0N7VFfZ3qS14Nhp8O4Kaez9QWK7AvqCXZds1Q=mRw@mail.gmail.com>
	<520B486D.1040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9e80-0008SC-AC
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810Ab3HNQkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:40:51 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:61617 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795Ab3HNQku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:40:50 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so7698214vbh.20
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XlGENmdjx53hac0dscruzhQ4HpLc92BRadjHhosrfH8=;
        b=eNFPko+nZZkLh98qoKPkbxGH6hsN+D+6sLP6epKr8ntpydEDjdkBJ1vIefsSqL1UrT
         cgIeXSprt6MwdDaHiicKDUMVB1LlB1v4fcV+V07A2c5uFgH5Vm/YiGm6IWUshmS8M2GW
         /G4Za/M5LrFIBzGktuMSGU9C2yD/EvBtnpTZ8veDQ6KaQW99c7kBMe6MzM7C1Pa1IXgK
         NMVskA+noqx7YwlZJxIyvSs3Glo98tApHETy6WyVTiRNUlW9kpwHrtpZF+pLO0GRRPXt
         lZwnMocJrLzrJZLCX2yE2GYySOXK7nI6u9yBHxJU1uecHeNVjRjpLh4J7onUQJvos3+r
         3lOw==
X-Received: by 10.52.171.111 with SMTP id at15mr74933vdc.79.1376498449469;
 Wed, 14 Aug 2013 09:40:49 -0700 (PDT)
Received: by 10.58.207.110 with HTTP; Wed, 14 Aug 2013 09:40:49 -0700 (PDT)
In-Reply-To: <520B486D.1040602@gmail.com>
X-Google-Sender-Auth: 2uDVKZ4O2YtofmnaN-DXDIXGdow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232294>

On Wed, Aug 14, 2013 at 4:35 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 08/14/2013 12:40 PM, Andres Perera wrote:
>> On Wed, Aug 14, 2013 at 2:02 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>>> On 08/14/2013 07:14 AM, Junio C Hamano wrote:
>>>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>>>
>>>>>     # all reflog entries that are not on a branch, tag, or remote
>>>>>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
>>>>>     # all dangling commits not on a branch, tag, or remote
>>>>>     d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes
>>>>>
>>>>> (Apologies if something like this was already said; I was not following
>>>>> the discussion closely enough to notice)
>>>>
>>>> Yup.
>>>>
>>>> A potential problem is that the output from "log -g --pretty=%H" or
>>>> "fsck | grep dangling" may turn out to be humongous.  Other than
>>>> that, they correctly compute what you want.
>>>
>>> I thought I mentioned that but I can't find my email now so maybe I
>>> didn't.
>>>
>>> In practice though, I find that, bash at least seems happy to take
>>> command lines as long as 7+ million characters long, so with the default
>>> reflog expire times, that should work out to 10,000 commits *per day*.
>>> [Tested with: echo {1000000..1900000}  > junk; echo `cat junk` | wc]
>>
>> echo is a builtin in bash, as is the case with other shell implementations
>>
>> builtins may have different limit's than exec()'s ARG_MAX
>>
>> $ getconf ARG_MAX
>> 262144
>> $ perl -e 'print "A" x (262144 * 2)' | wc -c
>>   524288
>> $ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; echo "$v"' | wc -c
>>   524289
>> $ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; /bin/echo "$v"' | wc -c
>> sh: /bin/echo: Argument list too long
>>        0
>>
>> builtin's argument buffer limit tends to be aligned with the
>> implementation's lexer buffer limit
>
> Aah; good catch -- I did not know this.  Thanks!
>
> My systems show 2621440 on CentOS 6 and 2097152 on Fedora 19, so --
> dividing by 8 (abbrev SHA + space) then by 90, that's still 2900 commits
> *per day* to run past this limit though!

ARG_MAX may also include the process environment, which needs to be
copied over to the new vm

the limit may also include the argv pointer sizes

those calculations based on SHA string length are just approximates

>
> (side note: making a single argument that long seems to have a much
> lower limit than having multiple arguments:
>
>     $ /bin/echo `perl -e 'print "A" x (1000000)'` | wc
>     -bash: /bin/echo: Argument list too long
>           0       0       0
>     $ /bin/echo `perl -e 'print "A " x (1000000)'` | wc
>           1 1000000 2000000
>
> notice that the second one is twice as long in terms of bytes, but it's
> not a single argument).

the behaviour is different in OpenBSD-amd64:

perl -e 'print "A " x ((262144/2)-5)' | env -i sh -c 'unset PATH; read
v; /bin/echo $v' | wc -c

a bigger size and i get E2BIG. if i pass the env or let PATH get
exported, again, i need to reduce the multiplier

apparently Linux is doing copyin() for each argument. that seems
excessive to me :)
