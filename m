From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 12:58:04 +0200
Message-ID: <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
 <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 12:58:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av0hP-00007M-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 12:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbcDZK60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 06:58:26 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34437 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbcDZK6Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 06:58:25 -0400
Received: by mail-qk0-f193.google.com with SMTP id i7so687365qkd.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hkrc5PIsKvKC8lGob8C/p/bsbAkGhN5MNrd2SO4V42k=;
        b=kLdBCW+mlUER2bq8nh7sHJ6hEbIEJiP0Mx/Q3G+x9vYL3+f+uRQc6ASsPbBJ3ZbdQ+
         dtAdvfN111frFLTvqhMpPUZk0ejiSUhJtu5mMnp1SI3afxz737/crIPlyUMNU+HCra1y
         UPsotCHV2Ky5aVWzuQQ1638wajaVQdkUY0fwys9fJc7t8W5iDN+xTVnCT/Dpe3+cTayA
         oLVei76/HEw0BPNB+WxnmeKecEY3BSZ5aoKTl2rLPYXmnca1tepsAMpXZoTqHd3PKKqw
         WBrFTnBgallTdZRe3NPQsq8QwCeN3vz30L91koBGKKeEKfjiGwg8cE6hxmlX38sPkjIO
         As3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hkrc5PIsKvKC8lGob8C/p/bsbAkGhN5MNrd2SO4V42k=;
        b=KkFB4jezKiA/IEyy0fPXeshbUGWJkguciiGa2YHZrDFf5GvxHbpqojx0ImdcFAOAmo
         n+bQ619MVJo3R/vLRn35cmW48Gre9EF4DxnYXix1BmGZELM1KxDJz54AENmrlEsMgUWE
         bz7p+S6t8PfhuHshfkugKmekGtOTZZBIkkuLvN87I0PuzKxYuwxoppsPZRLjJRXb/Ma7
         lDxdS/uoCltpukBf5okRESpqFKgPiChde5h4x7JRc70Aptrq/3Z9VLAMvmeUNG2ZlIq5
         /rBpDF9epJE2QahfmyOQC62spuW0dQrQZCGxyLS/M4fUBmsXDlc50P+C5GroeU7W38Gp
         5Ufg==
X-Gm-Message-State: AOPr4FWVpdfht3u9B3O2TL1QfVbrFSMBBj6xP/j3FM+nV15QneJKZA2Lq1nKSUM85eKjjo1a+EQzrUaiSYGZ0g==
X-Received: by 10.55.161.7 with SMTP id k7mr1531908qke.112.1461668304333; Tue,
 26 Apr 2016 03:58:24 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 03:58:04 -0700 (PDT)
In-Reply-To: <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292597>

On Mon, Apr 25, 2016 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The reason for supporting the *.d directories was that I spotted a l=
ot
>> of hooks people had hacked up at work using the pee(1) command[1] to
>> run sequences of other unrelated hook commands.
>
> IIRC, we wanted to do this several years ago but after discussion
> decided that we didn't want to have this in the core, because we
> didn't want to hardcode the policy on interaction among multiple
> hooks.

Ah, would be interesting to see that discussion if someone knows
enough to dig it up, didn't find it with some brief searching.

> You can easily resolve the ordering of hooks--just declare that they
> are executed sequentially in strcmp() order of filenames and users
> will know to prefix them with fixed-number-of-digits to force their
> desired ordering without complaining.

In principle you're describing glob() order here:
http://pubs.opengroup.org/onlinepubs/7908799/xsh/glob.html

We don't set LC_COLLATE in git so this'll be C order, which I think
will just fall back to strcmp().

If it doesn't and there's a functional difference, I'm not sure, it's
probably less confusing to use glob() order, since that's what you'll
get with shell expansion.

I.e. it would be confusing if you expand the hooks in the shell, and
git executes them in a slightly different order.

> What is harder and the core part cannot unilaterally dictate is what
> should happen after seeing a failure/rejection from a hook.  Some
> hooks among the remainder would not want to be even called.  Some
> others do want to be called but want to learn that the previous
> hooks already have decided to fail/reject the operation.  There may
> even be some others that cannot be moved to earlier part of the hook
> chain for other external constraints (e.g. side effect of some
> previous hook is part of its input), but would want to override the
> previous decision to reject and let the operation pass.

I think it's fair enough to say that if we had this facility this
would be good enough:

 * Your hooks are executed in glob() order, local .git first, then /etc=
/git/...

 * If it's a hook like pre-commit that can reject something the first
hook to fail short-circuits. I.e. none of the rest get executed.

 * If it's not a hook like that e.g. post-commit all of the hooks will
get executed.

 * If you need anything more complex you can just wrap your hooks in
your own shellscript.

I.e. it takes care of the common case where:

 * You just want to execute N hooks and don't want to write a wrapper.

 * For pre-* hooks the common case is it doesn't matter /what/
rejected things, just that it gets rejected, e.g. for pre-receive.
Also if you care about performance you can order them in
cheapest-first order.

> I am happy to see that the idea brought back alive again, but I
> think we prefer this start its life clearly marked as "highly
> experimental and subject to change", then invite interested and
> brave users who tolerate backward incompatible changes to
> experiment, in order to allow us to gauge what the right semantics
> and flexibility the users would want.  One way to do so may be an
> opt-in configuration variable e.g. "experimental.multiHooks";
> another may be to implement the logic as a pair of scripts (one for
> the command line argument variant, the other for stdin variant) and
> ship them in contrib/.

Makes sense to have an experimental.* config tree for git for stuff lik=
e this.

> The latter approach (i.e. scripting) might be easier for people to
> experiment and tweak, and in the olden days that would certainly be
> the approach would would have taken, but I am not too afraid of
> appearing uninviting to casual scripters anymore these days, so...

Yeah, actually one thing I didn't think of is that the core.hooksPath
patch I submitted makes this rather trivial to implement as a
collection of scripts...
