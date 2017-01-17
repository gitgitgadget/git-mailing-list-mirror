Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585751F89C
	for <e@80x24.org>; Tue, 17 Jan 2017 11:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdAQLgY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 06:36:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:64412 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdAQLgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 06:36:23 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqRKT-1cygAE49VB-00e0vA; Tue, 17
 Jan 2017 12:29:24 +0100
Date:   Tue, 17 Jan 2017 12:29:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [RFH - Tcl/Tk] use of procedure before declaration?
In-Reply-To: <F9099DB3F0374D898776BD2621BF36FA@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1701171218260.3469@virtualbox>
References: <F9099DB3F0374D898776BD2621BF36FA@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3wkPadYUq6R5I0ohd9ihqbpMkpZTV7gqSwrMm7+J3KJW5Zx6dSF
 r94TsDocjCfv+yMmKNzjNrFSbYviwNZn8bVAVJdgzI6Zo3k6e2AVnujpZIRfyPX8oRr85TP
 AxDFkRtixfCa6lORdAn2zHv50jmVsqZN5Ooe3FsYQE+ULe11CvsfJugACSYqXwKGz2TtyVV
 nbEGJo6VQN9svZ2+lzzBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yUKeJWpZShM=:QwQxctdgVWLtKIKUZ7j2kR
 uh2BAzowunQ/KS7lBVza9cu86np1YmMsAoqQksdO10o5S2Vd+CdyST6zsbMP7MrKYnjMsoNfl
 IQWbtEOtLkPm3BGlHccuYwOM9o9khEajvSCqIgj0HugraTzDeST/dQyP5+XfcFmzjaub+pPPe
 1evIZ5WmCbfbI5Wl4Pm/9eswiErZ7i6pyTrLtV5QKp9GukuC7oZsKq/7qzuRMbnl7fsWT/c5c
 jbWQIKPONt5rIh40YEpbrONxl9lXQoyUJEmGkJ+pRUU/PLT4VFc//6c91GWNNV7x73yoSd1N9
 cPPNmzYYvKxyZyUKCeyzt+28O5vIMJZ86LzWncIhPWyHIsAK24ZLS3t2Zpaom3chYYrnAYnbI
 xW1dcavcvzpTk58tcvb47zUyaHJXlmImwqrbbteHX3BgS0mFYyb9mWy0OBI4E2Gt9SgsGQxrO
 TJqK5hMPpiQ16s8xIoVWakeU3g5JhM59QB4q6aKSZOLjBauk6dmzeTJF9ed6D8NmvOrrXIw7j
 4gWTyEdkjgTP9C8JXqtU8NBT2XeunRB/uw+quIcVORaezKN0qJvpHo9WU4Q/QBeZRZxuUu7hY
 cehU83h/xdkQQNHNluI6Mp1vkx8lR2Y/3riOl20icW3JtlMi0NTeRdZrM7DK3f5BjEmQ/PcPc
 2923rbWqt43cPKIm+hdz4C1rFoVzxB7tF3ZzIbRzeXaQj9lBTlyRHTpjRuWaeoCKm6zu6eyQ0
 wt7pzgvrLm+3RqXPQArjuqcBunmLg7K8oI7kszYSJbn5YyJtEVMVjq/Qy67UpnvxfNmOAYdeG
 KgTkHa/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 16 Jan 2017, Philip Oakley wrote:

> In
> https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L242
> the procedure `_unset_recentrepo` is called, however the procedure isn't
> declared until line 248. My reading of the various Tcl tutorials suggest
> (but not explictly) that this isn't the right way.

Indeed, calling a procedure before it is declared sounds incorrect.

Since documentation can be treacherous, let's just test it. With a `tclsh`
whose `$tcl_version` variable claims that this is version 8.6, this
script:

```tcl
hello Philip

proc hello {arg} {
        puts "Hi, $arg"
}
```

... yields the error message:

	invalid command name "hello"
	    while executing
	"hello Philip"

... while this script:

```tcl
proc hello {arg} {
        puts "Hi, $arg"
}

hello Philip
```

... prints the expected "Hi, Philip".

Having said that, in the code to which you linked, the procedure is not
actually called before it is declared, as the call is inside another
procedure.

Indeed, the entire file declares one object-oriented class, so no code
gets executed in that file:

https://github.com/git/git/blob/d7dffce1c/git-gui/lib/choose_repository.tcl#L4

(I guess proper indentation would make it easier to understand that this
file is defining a class, not executing anything yet).

And it is perfectly legitimate to use not-yet-declared procedures in other
procedures, otherwise recursion would not work.

> Should 3c6a287 ("git-gui: Keep repo_config(gui.recentrepos) and .gitconfig
> in sync", 2010-01-23) have declared `proc _unset_recentrepo {p}` before
> `proc _get_recentrepos {}` ?

Given the findings above, I believe that the patch is actually correct.

Ciao,
Dscho
