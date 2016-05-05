From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Thu, 5 May 2016 12:02:31 -0700
Message-ID: <CAGZ79kbxDbmeh-rTHAqykjLBZ47HAviA11Q9LLYpcwT-Wr9X0A@mail.gmail.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
	<20160504232642.GC395@google.com>
	<CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
	<20160504235914.GD395@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:02:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayOXl-0005sC-18
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbcEETCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:02:33 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35185 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbcEETCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:02:32 -0400
Received: by mail-io0-f175.google.com with SMTP id d62so93766660iof.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+T5emyDANiwe1K+FSKuhdOcJ7oJW2uHzOvJPj3tBT2I=;
        b=k/wOPZQAywjwl1YyZhNP6XrGywmjT6DsbyWAS//weRd4m7NOPYY5oHe3PuGJfxohPk
         EtHHVed/SxundfHhHoZaJoJ59FSKjvWVpvbXbm6Q9JlFDO/QawfDRm0IMJ69Ts2O5skc
         bsDpXrX8mflQnq2xKq2AD+CmJogJK1VbT3L58uB+T6uEYLVfbULUHY3d3c6iGWXNn1A5
         URDDBbbkUUrmKI1OVB4bGCixlXRfUClhWzt2BaSxNbrkx+J1ah2ktKRk/tmHYOnRy2tG
         SQ/TkqKCres1Dsys7NTMZ8VoMzrqxE6BQiWiGhiII/qKw+68E8LqCungBO/ZuQDZ2/0s
         Lk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+T5emyDANiwe1K+FSKuhdOcJ7oJW2uHzOvJPj3tBT2I=;
        b=TzXTOCDwxmu+8HB0Z4LZtR5PB1aIq6icYXiMFzVq5Bik76RgHWTuDp+WrY3P6unuNK
         8tsbcZGvemCPnc4yMcIPbLsyEPNsg5jSotgG+W+F0quFyYNe8QQyv8B8VBfVw3UiKN7w
         y49Ab3N+wKSvgX2/ASLOKUxjEsf1U7Hk892G1zmqnFxC4CybuV/uj5i+vvSFcTCiZZ/w
         NvrxtH6FGJLZb8kCF6sPn7Jj5v6ICWbN8qReKSQ/g/Ix9qkBj9nRV5LKqNf2HSAXtS2Y
         Q4qm2SKGEWhM+/TnAyE3cHkkmRu2aVkf0kKQMw2IKOFIIMtQrJk7K3ybFkLBr5tatWh+
         my0g==
X-Gm-Message-State: AOPr4FUK0FWwl0T9bXcdTcrofWG+jfZLPu2lHSZfWWWRWDYK7kfLBPkAIVb4E2ieSUe9ALvSplhhCno5m2hZMOjV
X-Received: by 10.107.174.205 with SMTP id n74mr19002263ioo.96.1462474951448;
 Thu, 05 May 2016 12:02:31 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 12:02:31 -0700 (PDT)
In-Reply-To: <20160504235914.GD395@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293661>

On Wed, May 4, 2016 at 4:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>>
>>> Another option would be to call 'usage' and be done.
>>
>> I had that idea as well, but I think pointing out the low level is better
>> than giving the high level again, so the user immediately sees what's wrong.
>
> I mean low level as in implementation detail.  The human user would
> wonder "what is incompatible about them?  Why are you stopping me from
> what I am trying to do?"  Most likely the user was trying to do
> something other than specify a path, since they also passed --all.  If
> I run something like
>
>


    $ git submodule deinit force --all
    error: unknown option `all'
    usage: git submodule--helper list [--prefix=<path>] [<path>...]

        --prefix <path>       alternative anchor for relative paths

`force` is seen as the first pathspec, so "force --all" is given to the
`submodule--helper list`, which gives a less than optimal error message

    $ git submodule deinit --all force
gettext: unrecognized option '--all and pathspec are incompatible'
Try 'gettext --help' for more information.
envsubst: unrecognized option '--all and pathspec are incompatible'
Try 'envsubst --help' for more information.
envsubst: unrecognized option '--all and pathspec are incompatible'
Try 'envsubst --help' for more information.

We should not put --all as the first thing in the error message.

    $ git submodule deinit --all force
    pathspec and --all are incompatible

With the next patch this is the error message. I think the missing
dashes for force are quite visible as force is after --all.

>
> and the output tells me that --all and pathspec are incompatible then
> I just scratch my head more.
>
> We can do
>
>         USAGE="$dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)"
>         usage
>
> to print the subcommand's usage.  git commandline tools don't
> translate any usage strings today, so not getting translation here
> wouldn't feel out of place.

We can have both? I'd prefer not rewriting the USAGE string here
as it would easily be out of sync in the future?
I tried to just grep the deinit line from the USAGe though, but that doesn't
look right as it would need some post processing. (remove the "or:")
and processing the USAGE string also doesn't sound future proof.
