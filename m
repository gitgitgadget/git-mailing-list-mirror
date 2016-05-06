From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v16 7/7] commit: add a commit.verbose config variable
Date: Fri, 6 May 2016 01:07:40 -0400
Message-ID: <CAPig+cR=W3z-7RgWJ5QF8gNMdR_XA8q++K9MDdfeL+BePoOwCw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-8-git-send-email-pranit.bauva@gmail.com>
	<xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:07:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayXzR-0003d5-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 07:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcEFFHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 01:07:42 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33579 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcEFFHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 01:07:41 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so4089340igc.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 22:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jhpMSGysA38Wn3SFwS9et79nTnJ1r1+1YKU96kT50Os=;
        b=E58ovFOOR5KnnZV4N84sLBsmjghLotubNQ8OZCddDeMyHIdrnW3kthzjM6cRK0kf17
         flUpaP4847lmq+1jVsM4UnNMWT2OtlxOcm8abLmxHbdvR+oOE6Zw1P05Xty8Y9kE0Lx5
         hZvCGdh0Auw0rnNG1QM8VqysTfauHg/z96TasTvVJqGyt1/BeACVhQahHR/8hnjYWrHB
         ttH9OnPGZmejojxJtOc6JNuntrDspx+E1pQqoJaR27fZ/tVV4t8fdlHK26aGdxZf32qm
         4UhEm+8SKz9Ebrbop2ThNofNIFlcfvzhBagsfQ8TiigqzfPTsGggahIrBD8ER2twW7wP
         a4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jhpMSGysA38Wn3SFwS9et79nTnJ1r1+1YKU96kT50Os=;
        b=aFooyCb8gdAlb+IE4+VbcyBovGUXkx1t1So1LCRpqecYZZs1cdXh3NIRXeqH74dJyd
         MAA68cKDJqspf4uyTq2bXTeLRnvAvkBpwfhnPwA0ITVH3Mqi41j9D4lymp+zIs80pIin
         1rsYG0mC8sn4v9+kBMOh0yRInAATulpVj+5JiMTC8pHnmEe06wQclViOrJi0K1tMVEQg
         gfR2D+dWBY1h2H6eHCgOCGIYFe2ialgvIWvtBmntOebm6q/Y283iC/mUy1Y7idY9RHqK
         HLzaKnekPbv3U8RYr64L4QMIWIvEU9CltprJQTVZwhR4NDLuhzLvxewcG5BnNe6eXHev
         uB+g==
X-Gm-Message-State: AOPr4FUE40ML8zKiv0TpooPb+fhnT/e5pO0ZWFnpAVQBLocZMrcDtQHDexp/jZu7UguaA8FNeRhG0gNfu+yvxw==
X-Received: by 10.50.6.15 with SMTP id w15mr8436257igw.91.1462511260316; Thu,
 05 May 2016 22:07:40 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 5 May 2016 22:07:40 -0700 (PDT)
In-Reply-To: <xmqqbn4kb9m1.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: HDXOKrSCSsZDZ4HadEnL64LUW20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293739>

On Thu, May 5, 2016 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>> +static int config_verbose = -1; /* unspecified */
>
> The name does not make it clear that config_verbose is only for
> "commit" and not relevant to "status".
>
>> @@ -1364,6 +1366,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>>                            builtin_status_usage, 0);
>>       finalize_colopts(&s.colopts, -1);
>>       finalize_deferred_config(&s);
>> +     if (verbose == -1)
>> +             verbose = 0;
>
> Mental note: cmd_status() does not use git_commit_config() but uses
> git_status_config(), hence config_verbose is not affected.  But
> because verbose is initialised to -1, the code needs to turn it off
> like this.
>
>> @@ -1664,6 +1673,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>       argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>>                                         builtin_commit_usage,
>>                                         prefix, current_head, &s);
>> +     if (verbose == -1)
>> +             verbose = (config_verbose < 0) ? 0 : config_verbose;
>> +
>
> cmd_commit() does use git_commit_config(), and verbose is
> initialised -1, so without command line option, we fall back to
> config_verbose if it is set from the configuration.
>
> I wonder if the attached patch squashed into this commit makes
> things easier to understand, though.  The points are:
>
>  - We rename the configuration to make it clear that it is about
>    "commit" and does not apply to "status".
>
>  - We initialize verbose to 0 as before.  The only thing "git
>    status" cares about is if "--verbose" was given.  Giving it
>    "--no-verbose" or nothing should not make any difference.
>
>  - But we do need to stuff -1 to verbose in "git commit" before
>    handling the command line options, because the distinction
>    between having "--no-verbose" and not having any matter there,
>    and we do so in cmd_commit(), i.e. only place where it matters.

Hmm... if someday someone wants git-status to support a status.verbose
config variable, with Pranit's current implementation, it's a pretty
simple change: Just add to git_status_config():

    if (!strcmp(k, "status.verbose")) {
        int is_bool;
        config_verbose = git_config_bool_or_int(k, v, &is_bool);
        return 0;
    }

and in cmd_status() change:

    if (verbose == -1)
        verbose = 0;

to:

    if (verbose == -1)
        verbose = (config_verbose < 0) ? 0 : config_verbose;

It wouldn't be too hard with your proposal either: Either add a
'config_status_verbose' variable or rename 'config_commit_verbose'
back to 'config_verbose', initialize the global 'verbose' to -1, drop
the explicit 'verbose = -1' from cmd_commit(), and make the same
changes shown for Pranit's version. The diff would be a bit noisier.

I do like that your proposal makes it more difficult for
commit.verbose to break git-status, but otherwise don't feel that it
is significantly better. So, I dunno...
