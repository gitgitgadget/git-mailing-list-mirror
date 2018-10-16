Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81D61F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJPUMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:12:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:46749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJPUMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:12:24 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYbFe-1g8UKB1EHa-00VM6J; Tue, 16
 Oct 2018 14:22:01 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYbFe-1g8UKB1EHa-00VM6J; Tue, 16
 Oct 2018 14:22:01 +0200
Date:   Tue, 16 Oct 2018 14:22:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks
 in cURL
In-Reply-To: <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810161225310.4546@tvgsbejvaqbjf.bet>
References: <pull.46.git.gitgitgadget@gmail.com>        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com> <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ylYoOHNCCtT1ESMIKsK9S7RzvAoKzpLZLnEZsrsT17qVaHTCetS
 drrpzzTAbGrZuwVGQebvtMLualsmBwl0Ii4IeKLrR1Eg48+sVvL7sXDK5Nk/TM9BoUeutBO
 G/e+dzogjgTJ/MfyL/MZmd8yMtPmfbPgKEbSx6J7v+hYYpD5UEKMoqbxD8zI5gtx/3VcUU3
 Y9SkJh1PINsLyo9WWkTCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e37QFYeygrI=:eBCVU5gnp0HEweOsDek92H
 AHJxpLmzJ3mCFf1iHb67H3K6f25JHwHwUpU7I/h45ZHFbCse+nJ8e6gLUYEaoZArj7RQ9jP5z
 9TGdQKvwvcH/b9L9befOJ1JMRMA5K+7o2i5ftSYMNLFygHWSqaPcWUsCO28CD8gyE6wEpKjIa
 Xn7ds/M4Ssw3POfwL6fJfqYcW5q4UazyrHakkd/rJeUGLV1tJPnF4L3ykkuamqPfkjQyjKZ8R
 EIm7QA31SZ1lwyQVe4FhHQ4CJ2TJdIFszZy/T9rrb2SMRErX8dybia10TlZgWLyWVxI+vYdLR
 3MbjhZCgd0S5Glr1+GQF/SXF7Pwdh1SAGBAQH45VPPbkRfw1wxR6MsACI4AG36qhUVdCYGpS2
 XmDI/ntnYcvp5uVdxRItC/S8UOVk82laDBN0rQpLPXgOMw3NpEPYHCPzl/FpT1FmxRNptKWOL
 6pZjrPLWdZdesQ8RTimt8/yknhAeQLv8YLxOl9uM5OHANyr1z6J/99ALowfdXjFhg3dXNql3C
 AR6+oCLLqqbd4oU5HTE6Wzxc2czQn2JM32y+yJLzPyfPjzSiYAO6sSOhrSL3cZhyFGq7K24qT
 fWrReniyNDhd0lMFsSJIZeod1qZUhYpS9VDljRgrBJbtZEFxn0Hlc69HamsxzAajfxTBZ3tfK
 gjIiznqJQcP/C0x7ZlbrbPyLfRmOs5NCHnPlZpQ/gd635PcxnEJYImcDFwSMtAjW7ZPcZt9go
 LcjNmDp/g70Z0/0M5ylbLnyvRh5mG4PXyu7T/M9WS7xfiL7euJGc55N3rJfp0hIpXx9v2dCWI
 R5atMy66TStYxFpaZcHQGV/t3+ioMkDvjHMIwdwAGKxNEcsed4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Oct 2018, Junio C Hamano wrote:

> "Brendan Forster via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Note: an earlier iteration tried to use the config setting
> > http.schannel.checkRevoke, but the http.* config settings can be limited
> > to specific URLs via http.<url>.* (which would mistake `schannel` for a
> > URL).
> 
> Yeah, "http.schannel.anything" would not work, but is this note
> relevant here?  As far as the git development community as a whole
> is concerned, this is the first iteration of the patch we see and
> review.

I did review that commit message before typing /submit, and I figured that
it would still make sense to leave a comment there why we did *not* use
http.schannel.checkRevoke. I know that *my* review comments would include
a question about this, had I not been part of the development of this
patch.

> In any case, you can use "http.<url>.$variable" to say "I want the
> http.$variable to be in effect but only when I am talking to <url>".
> Does it make sense for this new variable, too?  That is, does it
> benefit the users to be able to do something like this?
> 
>     [http] schannelCheckRevoke = no
>     [http "https://microsoft.com/"] schannelCheckRevoke = yes
> 
> I am guessing that the answer is yes.

Frankly, I do not know.  Does it hurt, though?

This patch neither introduces the `http.<url>.<key>` feature nor prevents
it. Its original design (which I found more logical than the current one),
however, clashes with that feature.

> I guess the same comment applies to the previous step, but I suspect
> that the code structure may not allow us to switch the SSL backend
> so late in the game (e.g. "when talking to microsoft, use schannel,
> but when talking to github, use openssl").

That's a really good question, and I suspect that it is actually not too
late. Let me try.

*clicketyclick*

-- snip --
$ git config --show-origin http.sslbackend
file:C:/Program Files/Git/mingw64/etc/gitconfig schannel

$ GIT_TRACE_CURL=1 git -c 'http.https://github.com/dscho/images.sslbackend=openssl' ls-remote https://github.com/dscho/images
14:03:52.319986 http.c:724              == Info: Couldn't find host github.com in the _netrc file; using defaults
14:03:52.366858 http.c:724              == Info:   Trying 192.30.253.113...
14:03:52.366858 http.c:724              == Info: TCP_NODELAY set
14:03:52.482825 http.c:724              == Info: Connected to github.com (192.30.253.113) port 443 (#0)
14:03:52.721173 http.c:724              == Info: ALPN, offering http/1.1
14:03:52.721173 http.c:724              == Info: Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
14:03:52.721173 http.c:724              == Info: error setting certificate verify locations:
  CAfile: C:/Program Files/Git/mingw64/libexec/ssl/certs/ca-bundle.crt
  CApath: none
fatal: unable to access 'https://github.com/dscho/images/': error setting certificate verify locations:
  CAfile: C:/Program Files/Git/mingw64/libexec/ssl/certs/ca-bundle.crt
  CApath: none
-- snap --

Please allow me to help understand this log. First, I verified that the
currently-configured backend is Secure Channel. Then, I ask Git to list
the remote refs of a small repository, special-casing it to the OpenSSL
backend.

Crucially, this fails. The short version is: this is good! Because it
means that Git used the OpenSSL backend, as clearly intended.

<skip if="uninterested in the details">
Why does it fail?

Two reasons:

1) Git for Windows has to disable the certificate bundle. The gist of it
is: Git LFS uses Git for Windows' certificate bundle, if configured, and
that would override the Windows Certificate Store. When users configure
Secure Channel, however, they *want* to use the Windows Certificate Store,
so to accommodate Git LFS, we "unconfigure" http.sslCAInfo in that case.

2) The libcurl used by Git for Windows has some smarts built in to
understand relative paths to its "Unix pseudo root". However, this fails
when libcurl is loaded from libexec/git-core/ (which is the case, to avoid
any libcurl-4.dll in C:\Windows\system32 from being picked up by mistake).

If this explanation sounds obscure, the reason is that it *is* obscure. If
you are truly interested in the details, I can point you to the relevant
tickets on Git for Windows' bug tracker.
</skip>

> > +#if LIBCURL_VERSION_NUM >= 0x072c00
> > +		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> > +#else
> > +		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> > +			"your curl version is too old (>= 7.44.0)");
> > +#endif
> 
> That ">=" is hard to grok.  I think you meant it to be pronounced
> "requries at least", but that is not a common reading.  People more
> commonly pronounce it "is greater than or equal to".

Eric made the same point. I will change it to '<'.

Side note: this is the kind of change that I am completely comfortable
making, even on patches that were battle-tested, because those kind of
changes are certain not to affect the correctness of the patch.

Thanks,
Dscho

> 
> > +	}
> > +
> >  	if (http_proactive_auth)
> >  		init_curl_http_auth(result);
> 
