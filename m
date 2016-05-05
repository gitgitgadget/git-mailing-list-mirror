From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 12:35:43 -0700
Message-ID: <CAGZ79kbsgddnrF+oibSrpRu9e3PP2DTWMesqsdHCDHdySnhTyQ@mail.gmail.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
	<CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
	<20160504235914.GD395@google.com>
	<xmqqmvo4bcwf.fsf@gitster.mtv.corp.google.com>
	<20160505192036.GA22726@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:35:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayP42-0004ig-K1
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbcEETfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:35:46 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33494 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918AbcEETfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:35:44 -0400
Received: by mail-io0-f171.google.com with SMTP id f89so94623339ioi.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BSoKW//MjXssWP8XAYG0nR7NajzYurjLXRBOetJc5Yw=;
        b=IZIi75C/YV8TSQH4DxI+fIb4upKkk4u+H85EnNTJEUM8bIblhdVUPyQg46/pPHfJ3h
         zzntXcs/wpdxcbZNkf8XR7oo7K9vwr9o91/x4lxplvTDiTxQd3NNHzE1Y+nDof043pJD
         owfssHb6T3T4qTaUrcUb615QRDJUrYzXO+6ljyIhqo4Bho4gqAQGDf/jYaRr/bF4kFFu
         tlYZe9y9s7IFJXA/sAnxIx0Toz39Pnui6ACP9tF0Me9a9u2yFE1hhEYWd3rR462oKOCI
         74c5ayUKBj6cX3qZyaXOTKajQy33741+g3EB6qYiCnhuisczUVVOrxcE+7QNep8eEe0r
         9kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BSoKW//MjXssWP8XAYG0nR7NajzYurjLXRBOetJc5Yw=;
        b=hnddm3RT2XMqz2Nryrbgn9C26PSOmQ3XTkW6r5dwCEIDiggi+j6VqtRvNyQGPyF9mm
         Fi+dgIXNdf9KABRDN6G85Cr4GPpbiAjcPYFthHbGTNakcFnbjpEPCAY50HFn1Jw0ABG5
         5xpNCPFelil2nMsD5WW71Hg+HbBpuXy1GJZFnehW/2pvyurifAhuNee+5ASXdynYBuCu
         6QS38p+t9Xe3KYmi7/UvG+sTIaMjzuu8t0sElPTF9Twyl/E1lCHV6BsCCXHekaA7dDg8
         b3gs6dhfl86Mx+doGgaKxsNltvQ9kOPeT0d6R0pYMEp5PsDguaStn+t/OsSeYwUTrnuE
         Qu/w==
X-Gm-Message-State: AOPr4FWXoKJkPnv6v/zDYW+v+YrWgnnTRkpAMqPiy25PopNl1glU/3GQTSbUzAPFMnqtHlMlbz7vQc9EdPc3xIYk
X-Received: by 10.107.161.68 with SMTP id k65mr21556768ioe.110.1462476943910;
 Thu, 05 May 2016 12:35:43 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 12:35:43 -0700 (PDT)
In-Reply-To: <20160505192036.GA22726@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293668>

On Thu, May 5, 2016 at 12:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> I mean low level as in implementation detail.  The human user would
>>> wonder "what is incompatible about them?  Why are you stopping me from
>>> what I am trying to do?"
>>
>> Maybe s/incompatible/inconsistent/ is what you are after?  Why are
>> you stopping me from what I am trying to do?  Because you are asking
>> to do two contradicting things.  Do you want to nuke everything, or
>> do you want to keep everything outside what you specified?
>>
>> After being saved countless times from a stupid mistake
>>
>>     $ git commit -a -s foo.c
>>
>> that was caused by habitually typing "-a", when I do want to limit
>> the changes to record to a specific path (or two) with similar
>> safety, I do not think "what is incompatible about them" is a valid
>> question.
>
> Yes, 'inconsistent' works better than 'incompatible'.  Stepping back,
> what I meant is that when I pass an invalid set of command line
> arguments, it's difficult to give advice back because it's not obvious
> what I intended to do.
>
> When I say "git submodule deinit --all -- foo/", I'm most likely trying
> to deinit all submodules within the foo subdirectory.  That's a
> perfectly consistent thing to want --- it just doesn't match what the
> command is expecting.  It is more helpful for the command to tell me
> what it is expecting me to do instead instead of just telling me that what
> I gave it is wrong.
>
> The ideal would be something like "git check-attr"'s error_with_usage.
> It tells in a targetted way where my error was and also gives a guide
> of what to do instead.
>
>         $ git submodule deinit --all lib/
>         error: paths with --all do not make sense
>         usage: git submodule deinit [-f | --force] (--all | [--] <path>...)
>
> Thanks,
> Jonathan
>
> -- >8 --
> Subject: git-sh-setup: add error_with_usage helper
>
> When given an impossible set of options, this allows a command to
> print a targetted message followed by a short usage string that tells
> the user both (1) what part of their command wasn't supported (what
> went wrong) and (2) what correct usage looks like (what to do
> instead).
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for this patch, I can take that as a preparation for the patch
under discussion.

> ---
>  git-sh-setup.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index c48139a..2b56636 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -63,6 +63,11 @@ say () {
>         fi
>  }
>
> +error_with_usage () {

As usage is the last thing (it's die(...) essentially),
I'd rename it to die_with_usage ?

> +       printf >&2 'error: %s\n' "$*"
> +       usage
> +}
> +
>  if test -n "$OPTIONS_SPEC"; then
>         usage() {
>                 "$0" -h
> --
