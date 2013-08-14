From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 14:35:49 +0530
Message-ID: <520B486D.1040602@gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com> <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com> <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com> <7vk3jpy1qt.fsf@alter.siamese.dyndns.org> <520AC9A8.4030104@gmail.com> <7vmwolujvb.fsf@alter.siamese.dyndns.org> <520B2478.3000100@gmail.com> <CAPrKj1ZQL0N7VFfZ3qS14Nhp8O4Kaez9QWK7AvqCXZds1Q=mRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andres Perera <andres.p@zoho.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9X1p-0005Nm-35
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759552Ab3HNJGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:06:00 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:52469 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759501Ab3HNJF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 05:05:57 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so6078975pde.9
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zelK7Bpadhdyay0d6nqoKyhYyW6xmimMlZhHOHz3opE=;
        b=t5JriPIHNd/b62DQoy1U/CNxklu0vMJZMBh+oVcE2usi2gzFhZyeZwZ8XApwxPGhtj
         5IAEta079irVfGlne+FjQ1up2gMVhR8Q+W8RqcLt4CuEaQ5QULbkvxv82/TZ8eZAw+kU
         91AlHrsMzvGxn5/gcBaypMJG+R+3ldexQohn7GtJWva+EgCneYWF0lzc1MrKukgkTvtt
         WIqfqv2lLop2DMd05AxeBeMrIUOr18pRUcCSO0h3enfs2Azufxh1DXTelx7KlBBJLaot
         8qIcFwoEl52sPiGSvWkWO5mEC0k5LJ9W+9Q2EscTH8HO8ZgGXoxn8O3kBQkfm/z5QPdz
         /qGw==
X-Received: by 10.66.150.97 with SMTP id uh1mr8880919pab.118.1376471156849;
        Wed, 14 Aug 2013 02:05:56 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id tr10sm48954470pbc.22.2013.08.14.02.05.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 02:05:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <CAPrKj1ZQL0N7VFfZ3qS14Nhp8O4Kaez9QWK7AvqCXZds1Q=mRw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232274>

On 08/14/2013 12:40 PM, Andres Perera wrote:
> On Wed, Aug 14, 2013 at 2:02 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> On 08/14/2013 07:14 AM, Junio C Hamano wrote:
>>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>>
>>>>     # all reflog entries that are not on a branch, tag, or remote
>>>>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
>>>>     # all dangling commits not on a branch, tag, or remote
>>>>     d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes
>>>>
>>>> (Apologies if something like this was already said; I was not following
>>>> the discussion closely enough to notice)
>>>
>>> Yup.
>>>
>>> A potential problem is that the output from "log -g --pretty=%H" or
>>> "fsck | grep dangling" may turn out to be humongous.  Other than
>>> that, they correctly compute what you want.
>>
>> I thought I mentioned that but I can't find my email now so maybe I
>> didn't.
>>
>> In practice though, I find that, bash at least seems happy to take
>> command lines as long as 7+ million characters long, so with the default
>> reflog expire times, that should work out to 10,000 commits *per day*.
>> [Tested with: echo {1000000..1900000}  > junk; echo `cat junk` | wc]
> 
> echo is a builtin in bash, as is the case with other shell implementations
> 
> builtins may have different limit's than exec()'s ARG_MAX
> 
> $ getconf ARG_MAX
> 262144
> $ perl -e 'print "A" x (262144 * 2)' | wc -c
>   524288
> $ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; echo "$v"' | wc -c
>   524289
> $ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; /bin/echo "$v"' | wc -c
> sh: /bin/echo: Argument list too long
>        0
> 
> builtin's argument buffer limit tends to be aligned with the
> implementation's lexer buffer limit

Aah; good catch -- I did not know this.  Thanks!

My systems show 2621440 on CentOS 6 and 2097152 on Fedora 19, so --
dividing by 8 (abbrev SHA + space) then by 90, that's still 2900 commits
*per day* to run past this limit though!

(side note: making a single argument that long seems to have a much
lower limit than having multiple arguments:

    $ /bin/echo `perl -e 'print "A" x (1000000)'` | wc
    -bash: /bin/echo: Argument list too long
          0       0       0
    $ /bin/echo `perl -e 'print "A " x (1000000)'` | wc
          1 1000000 2000000

notice that the second one is twice as long in terms of bytes, but it's
not a single argument).
