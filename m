Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C411F453
	for <e@80x24.org>; Mon,  4 Feb 2019 11:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfBDLpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 06:45:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:60735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfBDLo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 06:44:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMQR-1gqLy23xoV-004BNG; Mon, 04
 Feb 2019 12:44:50 +0100
Date:   Mon, 4 Feb 2019 12:44:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Dan McGregor <dan.mcgregor@usask.ca>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] http: cast result to FILE *
In-Reply-To: <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902041243220.41@tvgsbejvaqbjf.bet>
References: <20190201193004.88736-1-dan.mcgregor@usask.ca> <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com> <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZjvM61qwmCVFDjbTLnnqK2DNXCC1jRyGmMfm537zLbt7uUBq4ms
 md5TgdTbq8RWtgjOelS8weVGnlvVMSp4zkg/OhS4dheeMz2IVPbcbgr9Bdk6bMMJLjEhFkq
 7ex/VXyBs8qxrRUuKekOFk3jqF46lsf7qsYpx0LvfR0jNT8s5zrEGtNBPQgnh35b/7h6a+D
 7K7CdrAPIiZt686iWa4Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wVdT/c3wU0o=:ID8Y1ZLmh2Jd+DrY1tlSqw
 qymHdf6Fdi6tX5Dw/7vApLgLuPnztkAR/fGZozAEwEEB47Pwto7aaUNiKMu8I6CrogJF1/JbV
 mWlKnnse/Ef1fDzTv1fRD9QdS36W/rWgPzgsbVnWixcR/X8NbgPu2NE1EQfpF3jQ9F7pX5vQ3
 z30eBfA5Ou4ke8J0x14n1iJh5ICgcr25N1RA3ctF7Raab3pzITLiFqaWGj6vvHcL33CZTa12P
 NF/9y4q3dRDGqLkWV1F4J0fKOVRh2aK93l45CF1XHQynhOfTYM8wfGOo3asVejCceJdt4IeEk
 G7lj4JrUMLHh5i36lnxTjundG6O+sLe5JPKpo38lv7tE0fWLe0aLwVox+x6g23ur7N/4paNjq
 16s5ouif18v3PNuvkAHaTuelF6tI3GDwqvTDYQHl7XBNY/xnHuGgM0l8Adp24yRc+zlFlMSgF
 wTipjOhiTpd+tUCDMXVLX5aINEf0TG04syvQJSsHgXBO+8OaQEm5oCySfm/10shlqipeROMu/
 bRbhrAgfdYRPNfvM1skefk1xUiesDhA2RKLsNGWQuz+Cg2ovv75FKcOMIFnUF63Gja/B0WhpS
 AirG9zcFLY/6ysVRi4tUgqckpkEB9ztmQelfKdXlc/GM1jb8w8vkr/aaFqSgIcgnxGy7DRRNb
 uA1xcl8T4vj6w7K8U3YC64I0EPtrPef1ukdEQc5q95JTMK+4NgtJjWSTRpU0U5ChRoJ/PGGLl
 tKLViY30yfaSyJUsmYNlsoYnJ7okKFS4qVU0DjTy8zFhtPugtGAkIGOc9X/Ux0f7fM0UKByGZ
 qBrPeedftD7lTbr2IwUlUxooOyKofQJJ5RfzrPN5kxAPGsOejgW2oRUAyQy+cunN50SxHPMm7
 nkx3Uu/knumdeYpp4wtJ30V540RM4M48mS0JgABkPoN/9041VQhFrcI2rdMNGVhYt392llr75
 o8uiY6nAUZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sat, 2 Feb 2019, Duy Nguyen wrote:

> On Sat, Feb 2, 2019 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Dan McGregor <dan.mcgregor@usask.ca> writes:
> >
> > > Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
> > > 2019-01-10) introduced an implicit assumption that rewind, fileno, and
> > > fflush are functions. At least on FreeBSD fileno is not, and as such
> > > passing a void * failed.
> >
> > I am not strongly opposed to this patch,
> 
> Even if this is needed, should it be done behind git-compat-util.h
> instead? That way if fileno(void*) is used elsewhere, we don't have to
> do the casting again.

The disadvantage, of course, would be that other call sites would not
benefit from a manual auditing whether the argument has side effects (and
thus, whether a macro using the argument multiple times would result in
very unexpected multiple side effects).

I'd rather not paper over this issue and thereby open even larger
problems.

Ciao,
Dscho

> 
> > but shouldn't you be filing
> > a bug report against FreeBSD instead?  The implementation is free to
> > define fileno(fh) as a macro, but it shouldn't force such a change
> > to conformant programs.
> >
> > https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=206146
> >
> > > Explicitly cast result to a FILE * when using standard functions that
> > > may ultimately be macros.
> > >
> > > Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
> > > ---
> > >  http.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/http.c b/http.c
> > > index 954bebf684..8b9476b151 100644
> > > --- a/http.c
> > > +++ b/http.c
> > > @@ -1996,12 +1996,12 @@ static int http_request_reauth(const char *url,
> > >               strbuf_reset(result);
> > >               break;
> > >       case HTTP_REQUEST_FILE:
> > > -             if (fflush(result)) {
> > > +             if (fflush((FILE *)result)) {
> > >                       error_errno("unable to flush a file");
> > >                       return HTTP_START_FAILED;
> > >               }
> > > -             rewind(result);
> > > -             if (ftruncate(fileno(result), 0) < 0) {
> > > +             rewind((FILE *)result);
> > > +             if (ftruncate(fileno((FILE *)result), 0) < 0) {
> > >                       error_errno("unable to truncate a file");
> > >                       return HTTP_START_FAILED;
> > >               }
> 
> 
> 
> -- 
> Duy
> 
