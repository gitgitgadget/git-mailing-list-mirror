Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BD6202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 02:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCLCMN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 22:12:13 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:36206 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfCLCMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 22:12:13 -0400
Received: by mail-it1-f178.google.com with SMTP id v83so1994978itf.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 19:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=CGxvL0qihKb0bjPr+mA0S3goL0pb3AVrZWEuYqlhsk0=;
        b=Pz0vDt+UQV/bXhkDprPAcmGELVXY/ricpm2g1xhpbustM9xbZ8ITfIJKvol2TGPeqh
         NmSuu9zuyNyJtNlkyGgJgioFzdj3oBXY2hR+VeebBOflWf4zvdvBQRtn2p4S1bH4F8k2
         3yHStv6stjbnQMiSoIgrdBQ7Vq/mah+SDe0B/d+IukdiV28iqgo50KxUhDWpJTOaWUG+
         +5ttGF+mIjREUl7vQgtVGKskvjwNMhXvM2rscXYH3Wq/ri+2bud5VQyvZ2RVT/XS+42b
         H3zu2wqRntTHKNJZRAfTXQsBQPfkCRPxtfZmX9iBP8BEPuoePAeFSj3bJTT/5KwsQAqK
         ohJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=CGxvL0qihKb0bjPr+mA0S3goL0pb3AVrZWEuYqlhsk0=;
        b=VPNf3s7YKuFf0QLsEfCtye/9eO9K0oKc4PQJw+fbReOXmYHyLI84rzhFqCf+GIXLkK
         bSgLr+BwPnmH4vvjE7N/mGbpUT6qoD1ngzcTZfILLhne03T/dHf/EBD0K6MXyhwJwSqi
         vTYSF4BJr9Uf7n0pbUFxWnNgGf5yeLwDucm+RMx4vfkJ59oEvfimxVe7Rq1mb90IUseg
         63bmx8l/m0pM6eOdrHWQlDmuMZMbYWE+ps4AvUxWTvtiVmGnx1hXIwd6vO+IUUWfudUV
         jUtC7wSzZI+4Ps82m+hAOQ2qLjlIwNs5mMZClxc3GXdQImHLASIuOxr1AoAUrKlPDK4V
         b7gA==
X-Gm-Message-State: APjAAAUtnu+rtUyLN+wr2TMdisevYuvbASmc7OCNPdI9rnykjxK+dZMo
        PvPXCArOC6CqIVMrgI0QPok1xrDY1PEnjbhPotI=
X-Google-Smtp-Source: APXvYqxvKHk24p0BfJhEuv7+tVd5Sw/K32k4bDLrCdiw3hAd0aqdtn2ZWHD8bbjXmhENNAHNaHiYwPuCmMsealCMgO0=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr763868itd.171.1552356732304;
 Mon, 11 Mar 2019 19:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
 <20190311222805.GA6215@flurp.local> <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
 <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com>
In-Reply-To: <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 22:11:41 -0400
Message-ID: <CAH8yC8kD3XkYP2o6k3ioCcNB_+wwQ=H2=V03z7Han1K8t2aUsg@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000098af3b0583dc37a5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000098af3b0583dc37a5
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 11, 2019 at 9:55 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 9:07 PM Jeffrey Walton <noloader@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 6:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 05:43:55PM -0400, Jeffrey Walton wrote:
> > > > On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > > > > > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > > > > > I put /usr/gnu/bin first on-path.
> > > > >
> > > > > The first question is if you are really running GNU 'sed'? My guess is
> > > > > "no, it's still picking up Solaris's 'sed'".
> > > >
> > > > I believe so. After modifying PATH, command -v returns:
> > > >
> > > >     Solaris tools:
> > > >          sed: /usr/gnu/bin/sed
> > > >          awk: /usr/gnu/bin/awk
> > > >         grep: /usr/gnu/bin/grep
> > > >
> > > > (This was added to my scripts to confirm).
> > > ...
> > >
> > > > Maybe Git would benefit from SED, AWK and GREP variables like PERL.
> > >
> > > Very possibly.
> >
> > Another potential workaround is to use Perl. Perl is already a
> > prerequisite, it get passed to the test gear through PERL_PATH, and it
> > avoids Solaris' anemic tools.
> >
> > Sadly my Perl sucks. You would be disappointed if I tried to whip up a patch.
>
> Oh man, you're using GNU make. I thought Git was using that anemic
> Posix Make. See attached.
>
> I think Solaris provides an older gawk. Is this an easier problem:
>
>     awk: chainlint.sed:88: :squash
>     awk: chainlint.sed:88: ^ syntax error
>     awk: chainlint.sed:91:  s/\\\n//
>     awk: chainlint.sed:91:    ^ backslash not last character on line
>     Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
>     Usage: awk [POSIX or GNU style options] [--] 'program' file ...

My bad , there was a typo... 'awk' got assigned to SED variable.

This patch works as expected.

Jeff

--00000000000098af3b0583dc37a5
Content-Type: application/octet-stream; name="git3.patch"
Content-Disposition: attachment; filename="git3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jt553gee0>
X-Attachment-Id: f_jt553gee0

ZGlmZiAtLWdpdCBhL3QvTWFrZWZpbGUgYi90L01ha2VmaWxlCmluZGV4IGM4M2ZkMTg4NjEuLjEw
YWJiMWMzNGMgMTAwNjQ0Ci0tLSBhL3QvTWFrZWZpbGUKKysrIGIvdC9NYWtlZmlsZQpAQCAtMTEs
MTEgKzExLDI1IEBAIFNIRUxMX1BBVEggPz0gJChTSEVMTCkKIFRFU1RfU0hFTExfUEFUSCA/PSAk
KFNIRUxMX1BBVEgpCiBQRVJMX1BBVEggPz0gL3Vzci9iaW4vcGVybAogVEFSID89ICQoVEFSKQor
QVdLID89ICQoQVdLKQorU0VEID89ICQoU0VEKQorR1JFUCA/PSAkKEdSRVApCiBSTSA/PSBybSAt
ZgogUFJPVkUgPz0gcHJvdmUKIERFRkFVTFRfVEVTVF9UQVJHRVQgPz0gdGVzdAogVEVTVF9MSU5U
ID89IHRlc3QtbGludAogCisjIEZpeCBTb2xhcmlzIHRvb2xzLiBUaGVzZSBhcmUgUG9zaXguIEdO
VSB0b29scyBsb2NhdGVkIGF0IC91c3IvZ251L2Jpbi4KK2lmbmVxICgkKHdpbGRjYXJkIC91c3Iv
Z251L2Jpbi9ncmVwKSwpCisgIEdSRVAgOj0gL3Vzci9nbnUvYmluL2dyZXAKK2VuZGlmCitpZm5l
cSAoJCh3aWxkY2FyZCAvdXNyL2dudS9iaW4vc2VkKSwpCisgIFNFRCA6PSAvdXNyL2dudS9iaW4v
c2VkCitlbmRpZgoraWZuZXEgKCQod2lsZGNhcmQgL3Vzci9nbnUvYmluL2F3ayksKQorICBTRUQg
Oj0gL3Vzci9nbnUvYmluL2F3aworZW5kaWYKKwogaWZkZWYgVEVTVF9PVVRQVVRfRElSRUNUT1JZ
CiBURVNUX1JFU1VMVFNfRElSRUNUT1JZID0gJChURVNUX09VVFBVVF9ESVJFQ1RPUlkpL3Rlc3Qt
cmVzdWx0cwogQ0hBSU5MSU5UVE1QID0gJChURVNUX09VVFBVVF9ESVJFQ1RPUlkpL2NoYWlubGlu
dHRtcApAQCAtMzUsNyArNDksNyBAQCBUID0gJChzb3J0ICQod2lsZGNhcmQgdFswLTldWzAtOV1b
MC05XVswLTldLSouc2gpKQogVEdJVFdFQiA9ICQoc29ydCAkKHdpbGRjYXJkIHQ5NVswLTldWzAt
OV0tKi5zaCkpCiBUSEVMUEVSUyA9ICQoc29ydCAkKGZpbHRlci1vdXQgJChUKSwkKHdpbGRjYXJk
ICouc2gpKSkKIENIQUlOTElOVFRFU1RTID0gJChzb3J0ICQocGF0c3Vic3QgY2hhaW5saW50LyUu
dGVzdCwlLCQod2lsZGNhcmQgY2hhaW5saW50LyoudGVzdCkpKQotQ0hBSU5MSU5UID0gc2VkIC1m
IGNoYWlubGludC5zZWQKK0NIQUlOTElOVCA9ICQoU0VEKSAtZiBjaGFpbmxpbnQuc2VkCiAKIGFs
bDogJChERUZBVUxUX1RFU1RfVEFSR0VUKQogCkBAIC00NCw4ICs1OCw4IEBAIHRlc3Q6IHByZS1j
bGVhbiBjaGVjay1jaGFpbmxpbnQgJChURVNUX0xJTlQpCiAKIGZhaWxlZDoKIAlAZmFpbGVkPSQk
KGNkICckKFRFU1RfUkVTVUxUU19ESVJFQ1RPUllfU1EpJyAmJiBcCi0JCWdyZXAgLWwgJ15mYWls
ZWQgWzEtOV0nICouY291bnRzIHwgXAotCQlzZWQgLW4gJ3MvXC5jb3VudHMkJC8uc2gvcCcpICYm
IFwKKwkJJChHUkVQKSAtbCAnXmZhaWxlZCBbMS05XScgKi5jb3VudHMgfCBcCisJCSQoU0VEKSAt
biAncy9cLmNvdW50cyQkLy5zaC9wJykgJiYgXAogCXRlc3QgLXogIiQkZmFpbGVkIiB8fCAkKE1B
S0UpICQkZmFpbGVkCiAKIHByb3ZlOiBwcmUtY2xlYW4gY2hlY2stY2hhaW5saW50ICQoVEVTVF9M
SU5UKQpAQCAtNzMsNyArODcsNyBAQCBjaGVjay1jaGFpbmxpbnQ6CiAJZXJyPTAgJiYgXAogCWZv
ciBpIGluICQoQ0hBSU5MSU5UVEVTVFMpOyBkbyBcCiAJCSQoQ0hBSU5MSU5UKSA8Y2hhaW5saW50
LyQkaS50ZXN0IHwgXAotCQlzZWQgLWUgJy9eIyBMSU5UOiAvZCcgPickKENIQUlOTElOVFRNUF9T
USknLyQkaS5hY3R1YWwgJiYgXAorCQkkKFNFRCkgLWUgJy9eIyBMSU5UOiAvZCcgPickKENIQUlO
TElOVFRNUF9TUSknLyQkaS5hY3R1YWwgJiYgXAogCQlkaWZmIC11IGNoYWlubGludC8kJGkuZXhw
ZWN0ICckKENIQUlOTElOVFRNUF9TUSknLyQkaS5hY3R1YWwgfHwgZXJyPTE7IFwKIAlkb25lICYm
IGV4aXQgJCRlcnIKIApAQCAtODEsNyArOTUsNyBAQCB0ZXN0LWxpbnQ6IHRlc3QtbGludC1kdXBs
aWNhdGVzIHRlc3QtbGludC1leGVjdXRhYmxlIHRlc3QtbGludC1zaGVsbC1zeW50YXggXAogCXRl
c3QtbGludC1maWxlbmFtZXMKIAogdGVzdC1saW50LWR1cGxpY2F0ZXM6Ci0JQGR1cHM9YGVjaG8g
JChUKSB8IHRyICcgJyAnXG4nIHwgc2VkICdzLy0uKi8vJyB8IHNvcnQgfCB1bmlxIC1kYCAmJiBc
CisJQGR1cHM9YGVjaG8gJChUKSB8IHRyICcgJyAnXG4nIHwgJChTRUQpICdzLy0uKi8vJyB8IHNv
cnQgfCB1bmlxIC1kYCAmJiBcCiAJCXRlc3QgLXogIiQkZHVwcyIgfHwgeyBcCiAJCWVjaG8gPiYy
ICJkdXBsaWNhdGUgdGVzdCBudW1iZXJzOiIgJCRkdXBzOyBleGl0IDE7IH0KIApAQCAtOTcsNyAr
MTExLDcgQEAgdGVzdC1saW50LWZpbGVuYW1lczoKIAlAIyBXZSBkbyAqbm90KiBwYXNzIGEgZ2xv
YiB0byBscy1maWxlcyBidXQgdXNlIGdyZXAgaW5zdGVhZCwgdG8gY2F0Y2gKIAlAIyBub24tQVND
SUkgY2hhcmFjdGVycyAod2hpY2ggYXJlIHF1b3RlZCB3aXRoaW4gZG91YmxlLXF1b3RlcykKIAlA
YmFkPSIkJChnaXQgLWMgY29yZS5xdW90ZXBhdGg9dHJ1ZSBscy1maWxlcyAyPi9kZXYvbnVsbCB8
IFwKLQkJCWdyZXAgJ1siKjo8Pj9cXHxdJykiOyBcCisJCQkkKEdSRVApICdbIio6PD4/XFx8XScp
IjsgXAogCQl0ZXN0IC16ICIkJGJhZCIgfHwgeyBcCiAJCWVjaG8gPiYyICJub24tcG9ydGFibGUg
ZmlsZSBuYW1lKHMpOiAkJGJhZCI7IGV4aXQgMTsgfQogCg==
--00000000000098af3b0583dc37a5--
