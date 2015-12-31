From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Thu, 31 Dec 2015 01:00:44 +0100
Organization: Opera Software
Message-ID: <5684702C.3040802@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
 <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com> <5681D02C.1040609@opera.com>
 <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:01:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQgN-00007R-NA
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbLaAAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:00:50 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35874 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbLaAAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:00:48 -0500
Received: by mail-wm0-f46.google.com with SMTP id l65so73212752wmf.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lnkbjsKxo+zXTDxwB3J9lHvBvlarITKTLgck/kyjqek=;
        b=UKmv3K3HO6B3VCjPzJ8RsqeyBwVTyJvtldOhWLBCEuvVdI5I5V//x95C3tN8FjjtVQ
         /7NUE7Sib09bDkL0MpHJW11ZZGV5eZQTnsSiqBaX/UYqua1aTdJxP7yHNHhA+NZbYRT8
         vtnlaLg/HSzkpcIP84TS5XxloJXaYBhnmm0YhrZwJtnjdhYtkd//RX124S2+XRY6EzUq
         XNVIDAkKtw04e9OAbT4x4UmkJQBmwrg3NkUVYVZYBAuKMUJ6hQmE5CM2mDIan+0aAPnf
         ydQaBQM0qvLVa5z4gAl2dZva4ZoSpJpjzrDeBhWTUeX2gx1WtKlU9VuZKaHDktd9XTWY
         n2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lnkbjsKxo+zXTDxwB3J9lHvBvlarITKTLgck/kyjqek=;
        b=R2yRmusilpnDVoLhNVXDAa6dbyx5KuUCtzXTuAMyaMZslEK/lsYwoyTQTSvcTuK3Ou
         4kMs086NiIpVwyLnw34ZcSxEih/hBWfVVYwxY3NkDmLH+rnvCD1Uz0F3M6z+KN8UxYsx
         Gmhm/WOnrQMMnmUrP4aA/v2Q0eQHAAA6Bg0rRNXp8qlrYtqgeywCYo00kLppZbFEXYXC
         QP5qPJcbb0DE8xMl9q70JfZ/fQEDBpWTL4HYc3ZAJLR8d2iyERRLtwt6IeZAaCnE1FgU
         l6ru8IioifNMNvNnCfFh989aajnPpCFNoMpCJ1eAouV4H4eA7Sp2C7lpFELZxyd0ygMO
         M3Fw==
X-Gm-Message-State: ALoCoQm9T8M/q+qkX9moOT8BFurdLOSKR4Yktuw4vkhtd0/9Q+8dDf9pqOfTErNBGUImwDWt/dmnXK2uldF3ZNfFv2uNfYSNqg==
X-Received: by 10.28.73.135 with SMTP id w129mr57157146wma.55.1451520046632;
        Wed, 30 Dec 2015 16:00:46 -0800 (PST)
Received: from [10.0.0.50] (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id a126sm9017283wmh.0.2015.12.30.16.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 16:00:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283218>

On 12/29/2015 07:27 PM, Junio C Hamano wrote:
> Mostyn Bramley-Moore <mostynb@opera.com> writes:
>
>>> I do not think it is wrong per-se to add an option to use regular
>>> expressions instead of globs, but if we are to do so, the endgame we
>>> aim for MUST be that we do so consistently to all the other commands
>>> that iterate over refs and limit their output to the ones that match
>>> given pattern (or a set of patterns), not just 'describe'.
>>
>> There is one important distinction between 'git describe' and the
>> other commands that iterate through refs- it applies an internal
>> search strategy and outputs at most one match.  This makes it
>> difficult to search for the closest matching tag...
>
> If that was what you were trying to solve, then it sounds like a
> typical XY problem.  You do not need custom matching flags; you need
> a "give me N (or all) names based on possible tags" option.

I can submit a separate patch for this, if you think it makes sense. 
Some possibilities that spring to mind:
* --results=<all|N>
* --num-results=<all|N>
* --show-matches=<all|N>
* --multiple-results[=<N>]
* --all-matches
* -<N>

> And I do not think it is a bad thing to add.  I already
> said that an option to match with a regular expression is not a bad
> thing to add, either ;-)
>
>> Besides 'git grep', the only regex type flag that is given a short
>> option seems to be -E for 'git log' and 'git rev-list'.  I have no
>> objection to dropping the short options, or leaving only -E.
>
> They also take -F, but "log" and friends do not pattern match the
> refnames, so I do not think you have to worry about them at the
> moment.
>
> It is more important to envision what we would do in the future when
> a command that takes a pattern (or a set of patterns) to match the
> refnames with _and_ another pattern (or a set of patterns) to match
> something else, and take that into account when designing this
> "allowing matching logic for refnames to be customized from glob to
> something else" feature, so that we do not paint outselves into a
> corner we cannot later get out of.  Imagine a hypothetical command
> 'git mgrep' that can look for a pattern in tips of multiple branches
> that can be used this way:
>
>      $ git mgrep -e 'froo*tz' --refs 'refs/heads/release/*'
>
> which may look for strings that match "froo*tz" in the trees of
> all branches whose name match the pattern 'release/*'.  In this
> example, the pattern to match strings is a BRE (same default as
> "git grep"), and the pattern to match refnames is a glob.
>
> Consistency & similarity with "git grep" would most likely lead us
> to add -E/-F/-G/-P options to this command and to make it affect how
> the pattern to match strings works.  For example:
>
>      $ git mgrep -E -e 'fro+tz' --match-refs 'refs/heads/release/*'
>
> may look for the same strings that would match the first example,
> but the pattern is expressed in ERE.  "-P", "-G", and "-F" options
> would also work the same way.
>
> Now, the question is what this "-E" (or -P/-G/-F) should do with the
> matching the command does with the refnames.  The easiest (and
> laziest) way out from the implementors' point of view might be to
> declare that they affect both at the same time.  But is that useful
> in practice?  It probably isn't, as it forces the users to write
>
>      $ git mgrep -E -e 'fro+tz' --match-refs 'refs/heads/release/.*'
>
> because the ref matching suddenly starts to use ERE (not glob),
> which most likely is not something users would expect.  So we may
> need a separate set of options to affect the way how refs are
> matched.
>
> We cannot just say "but we do not have that 'mgrep' command yet, so
> we can do whatever we want to do with 'describe' today".  When the
> need eventually arises that requires us to be able to specify how
> strings are matched and how refnames are matched independently, we
> would end up with an inconsistent UI where 'describe' takes '-P' (or
> '--perl-regexp') to affect the way how refnames are matched, while
> commands like 'mgrep' would need to use '--refmatch-perl-regexp' (or
> any other name that can be distinguished from '--perl-regexp') to do
> the same thing because they do not want '--perl-regexp' to affect
> the matching of refnames.
>
> And at that point in the future, it is too late to fix 'describe',
> as people are so used to use '--perl-regexp' to match with refs.  We
> will forever regret that we did not give the option a name that can
> be used independently from the existing '--perl-regexp' that is
> about matching for strings, not refnames.
>
> That is exactly the kind of thing that would paint us in a corner
> that we cannot get out of, which we need to avoid, hence we need to
> think ahead now.

OK, brainstorming a bit, how about either of these:

1) 
--match-pattern-type=<glob|fixed-strings|basic-regexp|extended-regexp|perl-regexp>

It's a bit lengthy (maybe --match-type would be sufficient), but I like 
that the value names are shared with git grep etc option names.  And it 
seems future-proof- if we ever need to support different pattern types 
for other arguments, a --foo-pattern-type flag could be added and make 
obvious sense.

2) Interpret --match patterns that start and end with / as regular 
expressions, and just pick one regex type to support.  I would suggest 
extended posix regex (since it's supported in all builds unlike PCRE). 
Downsides: some people might assume this is PCRE, also if we ever wanted 
to support other regex types we would need to add another option like 
(1), which would then make this feature redundant.

I prefer (1).


-Mostyn.
-- 
Mostyn Bramley-Moore
TV and Connected Devices
Opera Software ASA
mostynb@opera.com
