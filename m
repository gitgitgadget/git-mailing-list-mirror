From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Wed, 6 Jan 2016 02:08:28 +0100
Organization: Opera Software
Message-ID: <568C690C.7050007@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
 <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com> <5681D02C.1040609@opera.com>
 <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com> <5684702C.3040802@opera.com>
 <xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com> <5684FE61.4010701@opera.com>
 <xmqqmvslp799.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:08:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGcac-00049s-08
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 02:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbcAFBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 20:08:34 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35170 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbcAFBIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 20:08:32 -0500
Received: by mail-wm0-f51.google.com with SMTP id f206so42977233wmf.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 17:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=juV5KJxlpUwMVqU0D4Q9PQjBWpEa5UijKIUNjw+k/QU=;
        b=q6dD6KtNIQEmKTSa9+QCLxvYTweoHHY+bHJ6cqtovud1ZXRhACxg1r8y/Ei3OJfvxx
         0bShrwaSBHiITZxXyGYxC0zim69g70oxLxCLN2qmpsA+1YdAfuW4AL1+IDesLEGrKHyf
         5366F5gOZBhxdMAFX7n+L5qj8nor+bQVosaFtdlzSop7pEmCJIsI3qMOiJRTxiLfP2MK
         0afG5JTolf7V1W0IIgqsnblMJBpVnHxYeH0WYmp6lVBRJVfYT3uAC9MD/rc2EhEUj1fS
         fdXmR0IC38W6/xotv2HIezWWxTBrY4FqJBU51IFjeriXeZ9hapc7z1J+/2Z//NVIKLJK
         F1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=juV5KJxlpUwMVqU0D4Q9PQjBWpEa5UijKIUNjw+k/QU=;
        b=Z4xveN9GZP048kRiVc0b7ZDfxTLYZ4uQvPt403NC85BKAWd7CZRbX5Hpo5BPVSgpSH
         uK7TlHYowr47FdjYrDi8FO+CmZNK6EPtM+Z8rP50U6621XFKng36aKkmylc9YcV2Jm44
         5UGYhSAJ8INoiBaRF9nxWZDIOpmMlzj6LUfPDQj5cBbcIV+CTgBPk3e51S41HXHWbzJV
         OwHZKhLbt0Sm3/ID4q7gJv3cmICGyphC3HQBMdHbjLsyrspk8qNhCgnYL1S3b3efdaZg
         uG0bo0PsZfby4rvMgufBKQTDW43wyYQH1rUdcJHgraiqQABnOsw+hIqA6+od/87syLct
         FTuw==
X-Gm-Message-State: ALoCoQm/7c7xGgRwzZqB8mVeNGcEPGHlY8m+oo7Gf+ZVmymUX7fO4kK8jZV0zY/1BxpquAFW4rbiISeqje9l66YCUesbHCsyXA==
X-Received: by 10.28.144.196 with SMTP id s187mr7267120wmd.9.1452042511316;
        Tue, 05 Jan 2016 17:08:31 -0800 (PST)
Received: from [10.0.0.50] (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id y8sm6106579wmg.9.2016.01.05.17.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 17:08:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <xmqqmvslp799.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283412>

On 01/04/2016 06:46 PM, Junio C Hamano wrote:
> Mostyn Bramley-Moore <mostynb@opera.com> writes:
>
>> On 12/31/2015 01:23 AM, Junio C Hamano wrote:
>> ...
>>> Swapping the option key and value may not be a bad idea, but one
>>> problem that the above does not solve, which I outlined in the
>>> message you are responding to, is that "match-pattern-type" does not
>>> give any hint that this is about affecting the match that is done to
>>> "refs", e.g. you cannot tell in
>>>
>>>     $ git mgrep --match-pattern-type=perl-regexp -e foo --refs 'release_*'
>>>
>>> if the perl-regexp is to be used for matching branch names or for
>>> matching the strings the command looks for in the trees of the
>>> matching branches.
>>
>> There is a hint: --foo-pattern-type applies only to --foo.
>
> Hmph.
>
>> In your mgrep example --match-pattern-type would apply to --match
>> patterns only, and if we choose to implement it then
>> --refs-pattern-type would apply to --refs patterns only.
>> eg:
>> $ git mgrep --match '^foo' --match-pattern-type=perl-regexp --refs
>> release_*' --refs-pattern-type=glob
>
> Most likely the hypothetical "mgrep" would not use "--match" but use
> "-e" to retain similarity to "grep", and "--e-pattern-type" would be
> confusing.  But I agree that "--refs-pattern-type" uniformly used
> where we take pattern parameter on the command line to match with
> refs may make it clear that you are only affecting the matches
> against refs.

I don't think -e foo --e-pattern-type=bar would be confusing.

>>> Magic pattern annotation like we do for pathspecs Duy raised may not
>>> be a bad idea, either, and would probably be easier to teach people.
>>> Just like in Perl "(?i)$any_pattern" is a way to introduce the case
>>> insensitive match with $any_pattern, we may be able to pick an
>>> extensible magic syntax and decorate the pattern you would specify
>>> for matching refnames to tell Git what kind of pattern it is, e.g.
>>>
>>>     $ git mgrep -P -e foo --refs '/?glob/release_*'
>>>
>>> I am not suggesting that we must use /?<pattern type name>/ prefix
>>> as the "extensible magic syntax" here--I am just illustrating what
>>> I mean by "extensible magic syntax".
>>
>> I hadn't seen the pathspec magic patterns before- interesting.  We
>> could possibly share syntax with pathspecs, ie
>> :(?pattern-options...)pattern
>
> Even though we have DWIM between revisions and paths on the command
> line when the user omits "--" for disambiguation, I do not think we
> look at the shape of the string to DWIM/decide that it is a pattern,
> so as long as the magic syntax cannot be a valid pattern to match
> against refs right now (and your ":(?...)"  qualifies as such, as a
> refname would not contain a component that begins with a colon), it
> would be possible to introduce it as the magic syntax for matching
> refs.
>
> Or did you mean to use this syntax also for patterns that match
> strings in contents, e.g.
>
>      $ git grep -e ':(?perl-regexp)...'

I think it would be nice to support this syntax in every command that 
does pattern matching.

Corner case: what if we want to search for ":(?perl-regexp)", eg in 
git's own source?  I suppose this would do:
git grep -e ":(?fixed-strings):(?perl-regexp)"

> I am not bold enough to say that it would be a good idea, but I
> offhand do not think of a reason why we shouldn't go that route,
> either.
>
>> Would this be confusing for commands that already have --perl-regexp
>> etc?  What should happen if you specify both --perl-regexp and and a
>> different type of pattern like :(glob)foo (error out, I suppose)?
>
> If we were to go that route, ideally, I would say that
>
>      $ git grep --perl-regexp -e 'A' -e ':(?basic-regexp)B' -e ':(?fixed-string)C'
>
> should match with A as pcre, B as BRE and C as a fixed string.

That makes sense.

> I do not offhand remember if we built the underlying grep machinery
> in such a way that it is easy to extend it to allow such mixture,
> though.

I believe this would require some moderate refactoring, but I have only 
looked briefly so far.  If we can settle on a preliminary design 
(--foo-pattern-type vs magic pattern option strings), I can try 
implementing a proof-of-concept.


-Mostyn.
-- 
Mostyn Bramley-Moore
TV and Connected Devices
Opera Software ASA
mostynb@opera.com
