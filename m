From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Wed, 30 Mar 2016 08:05:45 +0700
Message-ID: <CACsJy8BtOR-0FNSP5cggAz=X3Vm-do_N4V-z7=tvW28p14FMkw@mail.gmail.com>
References: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
 <1458820579-31621-1-git-send-email-pclouds@gmail.com> <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4aU-00053x-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbcC3BGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 21:06:19 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35189 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbcC3BGS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 21:06:18 -0400
Received: by mail-lb0-f177.google.com with SMTP id bc4so21729793lbc.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YrF8ezwbOkfOTIOYn3Uh1lK+zImUYMabJvfXArOq1oQ=;
        b=iK3+H/Jsb0Noc/vKLee1N7W9q8QenT3rrHPAJV+t06SVF5bCrP4dqG0v9kxy/F+/FJ
         8lUxOuzKZWatEQtO23EE3ZWmVQVGCJup6fjssLQ+B4hxobTyMYgZnOsG4RLR3aqkhXSt
         REqD1VKtEuygbuYC3p92v3OZ8RVIATuBF/DjaGcybbKOWl1K8hEyCSRNHXA4Eutu70UO
         S8e5OJdrPElWlNOMtOBr+hSZJL898hFMTiDGCJtNkZqOs4dj6BX1UNXJg+6w8YDUkmtE
         82siA03nH5fESIfRHI/Rta6zmgXehPjIXjWtmf6kr5J6/rue95GZ3ZgaFz9HWWqKdkiD
         SchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YrF8ezwbOkfOTIOYn3Uh1lK+zImUYMabJvfXArOq1oQ=;
        b=VdT5zWyTGNK45rVLsCo2pJoF0TW0F1AJDbMSiJCVMOpJg1yQ5OcFEe29x5Yu9tZ+Hl
         WeSP1F5DDMTspgX6/KSXF1SiR1UEmgRAwlDxgdNTzuq2bgivTeVNbqrBAiijL143VMI8
         0kNq0gQGeqxZO4ZntW9NQIKgfltm6J/QcAF0tfq2zPL7x1tVl7rj422AhGFbS1rFbJ6J
         iUEfiT900VsFPHiNH1x7S1EM3D0PSlwHmwvmoLaTd29H3103r3hz6S5atuce8LbUu95N
         UQev5JIPEFz+RjIWpAlUMjjcDI2nnuOXIZGrgtJRRmlycFhjP5X0fObfch6lijhHqeIX
         07bg==
X-Gm-Message-State: AD7BkJId6aM5S+t3MwTGZNNcbcMtadCXP48J+6+0r+djNLYdf4hQ/1txXgd1x3+39Zkse/nZc9NwV6FGPbm6qg==
X-Received: by 10.112.157.105 with SMTP id wl9mr2497004lbb.137.1459299975283;
 Tue, 29 Mar 2016 18:06:15 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 29 Mar 2016 18:05:45 -0700 (PDT)
In-Reply-To: <xmqq8u17akgn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290244>

On Thu, Mar 24, 2016 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>> On Wed, Mar 23, 2016 at 11:55 PM, Junio C Hamano <gitster@pobox.com=
> wrote:
>>>> The include/exclude mechanism does use wildmatch() but does not us=
e
>>>> the pathspec mechanism (it predates the pathspec machinery that wa=
s
>>>> made reusable in places like this).  We should be able to
>>>>
>>>>     $ cd d/e/e/p/d/i/r
>>>>     $ git apply --include=3D:/ ../../../../../../../patch
>>>>
>>>> to lift this limitation.  IOW, we can think of the use_patch() to
>>>> include only the paths in the subdirectory we are in by default, b=
ut
>>>> we can make it allow --include/--exclude command line option to
>>>> override that default.
>>
>> I went with a new option instead of changing --include.
>
> It might be a "workable" band-aid, but would be an unsatisfying UI
> if it were the endgame state.  You do not say "git grep --whole" (by
> the way, "whole" is a bad option name, as you cannot tell "100% of
> *what*" you are referring to--what you are widening is the limit
> based on the location in the directory structure, so the option name
> should have some hint about it, e.g. "full-tree" or something) and
> this command will become an odd-man-out.
>
> I haven't thought things through, but thinking out aloud a few
> points...
>
>   An existing user/script may be working in a subdirectory of a huge
>   working tree and relies on the current behaviour that outside world
>   is excluded by default, and may be passing --exclude to further
>   limit the extent of damage by applying the patch to a subset of
>   paths in the current directory that itself is also huge.  And that
>   use case would not be harmed by such a change.
>
>   On the other hand, an existing user/script would not be passing an
>   "--include" that names outside the current subdirectory to force
>   them to be included, because it is known for the past 10 years not
>   to have any effect at all.

Real-world .gitignore patterns have taught me that even if it does not
have any effect, it might still be present in some scripts, waiting
for a chance to bite me.

> So a better alternative may be to conditionally disable the "Paths
> outside are not touched regardless of --include" logic, i.e. we
> exclude paths outside by default just as before, but if there is at
> least one explicit "--include" given, we skip this "return 0".
>
> That way, we do not have to commit to turning --include/--exclude to
> pathspec (which I agree is a huge change in behaviour that may not
> be a good idea) and we do not have to add "--full-tree" that is only
> understood by "apply" but not other commands that operate on the
> current directory by default.

But your suggestion is good and I can't think of any better. We could
introduce pathspec as ftiler after "--", but it does not look elegant,
and it overlaps with --include/--exclude.

Perhaps we can start to warn people if --include is specified but has
no effect for a cycle or two, then we can do as you suggested?
--=20
Duy
