From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 3/3] git abbref-ref: new porcelain for abbreviate_ref()
Date: Mon, 22 Sep 2008 18:45:54 +0200
Message-ID: <36ca99e90809220945s50e30a24v2c88b50982d34274@mail.gmail.com>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com>
	 <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com>
	 <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
	 <20080922153222.GD3669@spearce.org>
	 <7vtzc8xjiv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	szeder@ira.uka.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 18:47:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhoYz-00050u-Pz
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbYIVQp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 12:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYIVQp5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 12:45:57 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:49026 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYIVQp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 12:45:56 -0400
Received: by el-out-1112.google.com with SMTP id z25so372627ele.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+3wTBWD65LKXaMKYlNYc/6fJlpNtUt/EwmXRwp8WHRc=;
        b=kBawNBMhkmVgJ+jYrZ3Voqaa90u+DuT1mooMED6KqCBHtWXg1LcgglIN7mcUCUEZih
         hJ1C5AaFjv9eOg+CZBj2kBXANhQuWb8YdgSuEWzOBPy/bcNgoaDWPyAc5nqozjHPkLxH
         a8w31b8lVwNI/MReu54k1sBqw7GkBZet33hVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ng5LeEjl2R1X+5sp6Lk2hz7pW6Ca7XwrqauMjHC6Med6X+lGV/1+MP8Z+GZ+2EDxNr
         oW/KBxYO5UUibqr5dAQ+LI9j3PPAgUVKXdMf3QsX6+z1b7qWglMISl0oobtdtn7ms7xi
         zb7ziexEcb5+0F7I6fazR+qcp0gzrgWx6FjH0=
Received: by 10.150.133.18 with SMTP id g18mr7597302ybd.137.1222101954113;
        Mon, 22 Sep 2008 09:45:54 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 09:45:54 -0700 (PDT)
In-Reply-To: <7vtzc8xjiv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96496>

On Mon, Sep 22, 2008 at 17:55, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>>> This gives direct access to the abbreviate_ref() function. The operation
>>> mode defaults to the core.warnambiguousrefs value, like the refname:short
>>> format, but can be explicitly changed with the --{,no}-strict option.
>>>
>>> The bash completion script utilizes this new command.
>>
>> And it slows down too, doesn't it?  Now we are doing a fork per
>> branch during completion.  Yikes.  Didn't you just post a series
>> about making completion faster?
>>
>>> Junio, if this is not a porcelain, tell me.
>>
>> IMHO its plumbing.  Porcelain is used by a human.  Plumbing is the
>> bits needed to make human interfaces.
>
> Shawn is right.
>
> I wouldn't be taking this patch to add a new command, but I suspect that
> this could be an option to rev-parse that is similar to --symbolic.
>
> Teach SHOW_SYMBOLIC_SHORTEST to builtin-rev-parse.c::show_rev(), teach the
> parser cmd_rev_parse() a new option --symbolic-abbrev and you are done,
> right?
>
You are probably right, that this small functionality could fit into
an existing program.
But I haven't look for one.

> By the way, I found it amusing to see Cc: lines _after_ three dashes to
> control send-email --- nice trick I didn't think of ;-)
The only problem is, that git format-patch outputs '---\n'
unconditionally, so I had to remove the second one by hand.

Bert
>
>
>
>
