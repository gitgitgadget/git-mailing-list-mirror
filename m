From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:25:07 -0800
Message-ID: <CAGZ79kYUkgbHSXYmOXRKhju1QQwiw9EU+VoO-AMZL_nMCf0NNg@mail.gmail.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
	<1456441708-13512-1-git-send-email-sbeller@google.com>
	<20160225231904.GT28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:25:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5HY-0001UF-3r
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbcBYXZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:25:10 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:33031 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbcBYXZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:25:09 -0500
Received: by mail-io0-f180.google.com with SMTP id z135so106098040iof.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3mM9np9Byc6DP64iaWlzvLyOvo41oH+E1HSCk9UWxeU=;
        b=V4n0fQ8pFcCboENGGCZ3Nt+XunzLrw+y1CxFSNao1jYJRZcc3n9EN3CzhrusrW2ID6
         j+vedts7liXQA18GVGWTULG7Ed5BaUwRL0EieN30ltBciHVRJpoZFHVXXxcQnMNeOfiR
         l+zGIrX//c5tLrD254iDOZYgF/E2xv1BoOpl7GBGNP1ZdKYb2NCksAzUsL1pFzl76Apx
         e2P/5PlXq6ymfUm+gIWcpAqHz+JcAk7zRe+waSq/99Ul0ZMM4TCQZ7IDy1tek0zuYfXa
         DCeWkrjvSA5t9MuTRfz3Oc53pJsyAcJ9yUVfNJbYkwA/6j0hZfpkRjU8NcB/+DKPsn9z
         Q39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3mM9np9Byc6DP64iaWlzvLyOvo41oH+E1HSCk9UWxeU=;
        b=RjlZLvMOFLKgKyh6d/PLzYORhuc59mec6OuGSwR2OV5wCZlL9+ah/0lR2xPY3nrltO
         QkZGrypeN6fGfjHuFJrAwhB0qTpDRnh0rbyNbt8ZFlPLBJvDEmawwr7Yp5RmVVPOJKBF
         UnjQ/HgsK8IT37gWJ5/2VZ8WpaEe1uunyYgi9+Dt5QJRQUGvZiU/mjgdUHj1t1KpQ6/D
         cFlO4qcQbg8SbGzxhQwKOrsUokd/e2Cbv4ER6xYenfF/Bd8l1/iV2NxvCyve1fQZu5bT
         p6hVNfNCjPnM5ct8UMGm4cmvSIHuj8D56JJIWehWw26oReoR77jKlSMagkKAVfI6hJtJ
         aG1A==
X-Gm-Message-State: AG10YOSdisFPg0k/wJPs7l3traWVSYgyxc9XsCOwubO89g+lb0uiMp9hI4F43jKRMV4JPAmFIrZhtiASvhcjxvkH
X-Received: by 10.107.158.138 with SMTP id h132mr5338447ioe.174.1456442708045;
 Thu, 25 Feb 2016 15:25:08 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 15:25:07 -0800 (PST)
In-Reply-To: <20160225231904.GT28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287490>

On Thu, Feb 25, 2016 at 3:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -465,14 +465,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>>               NULL
>>       };
>>
>> -     argc = parse_options(argc, argv, prefix, module_update_clone_options,
>> +     argc = parse_options(argc, argv, suc.prefix, module_update_clone_options,
>>                            git_submodule_helper_usage, 0);
>
> I would have expected this to use 'parse_options(argc, argv, prefix, ...' since
> I wouldn't expect a command-specific --prefix= parameter to affect the
> interpretation of relative filenames in other parameters.
>
> Now that I look around more, it seems that other submodule--helper subcommands
> have the same strange behavior of overwriting the 'prefix' var.  So I take
> back my suggestion of using a different variable --- that can be addressed in a
> separate patch that deals with them all at once.
>
> Sorry to flip-flop like this,
> Jonathan

I plan to fix that up in all the submodule--helper commands once this
long running series is in,
but for now we want to keep it consistently awkward?

The way all submodule helper commands are currently "working" is

    (in git submodule.h:)
    wt_prefix=$(git rev-parse --show=prefix)
    cd_to_toplevel
    git submodule--helper <command> --prefix $wt_prefix

which makes the command a bit awkward with having the prefix in the
signature and the
prefix as an option. the prefix as given in the signature ought to be
empty for now and
we always rely on the prefix option.

I plan to replace that to be

    git -C $wt_prefix submodule--helper <command>

which then doesn't carry a prefix option, but can rely on the prefix
from its function
signature.

So I flip-flop that change of 'prefix' back to the way all submodule
helper operate for
now and then send a cleanup once this series is done.

Thanks,
Stefan
