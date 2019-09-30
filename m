Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977F91F463
	for <e@80x24.org>; Mon, 30 Sep 2019 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfI3MRS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 08:17:18 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44117 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfI3MRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 08:17:18 -0400
Received: by mail-vk1-f193.google.com with SMTP id j21so2595339vki.11
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLBk8bRiEmf/CTjewJthNw9rSXw0Jshs1tyLsIE90Dc=;
        b=mk7mhRStMpaD97cuZNgkzS9Qky0QBvobuCl5CtTcGcpxUejMqh7qmprdAtUGX8JqYe
         5W919MIXEwwrUT5TaYog0B379GCpt77qAPCHPLlJ8eQowwWzn/AUn8N13s9TejQoF6KB
         WB5B15jJ+hzjWUsKHb8hGy+IyMbnWSvaZ8PPNn1ZMdXd8xuh87U8wyBP4wMIn09mFigt
         7RoGPbo/EE8Zk9MtMPRoYDwwxokqqavOzfvfRCNOA6X5m7JJN9pUeU8Or4vM9GUtto2p
         lOMUw7AmYy+fjOHzTweYV2lxnRom9Z8/PLTtP58qA9GH8Z38f/ahYawTCswBUHkQ1qP+
         +fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLBk8bRiEmf/CTjewJthNw9rSXw0Jshs1tyLsIE90Dc=;
        b=izvVYu7et4C5CrEg/msRSJcVWwav3ayIeRltH0EAKxQ99yr1NYQE32Y00VxTwV0Eo0
         KhSN16RtMdfwrysaNTmI5NOE0vymZIE4BWULCQ2EDA1paT2v+/3SrB+zX/tM9X3ZNj1g
         mHTfD7i7ImBFF/P2gAdrrVWXDvURlVPWqrIrqFQeRyAgLgbdvGF9AV0sDPkjfdKGMwvy
         JjBAtmYH/TEX7EcYnZuTp2lUbJcQOSUtwboScjJPpZh/rmvPxDBjixrQ58ryZmFrGZHS
         R03oFeSkvpROPlNtJRSNnTN1b38m38lG+z7vVwpMP0EVnNh1QlWTgrFPnplipSvxzkK1
         VmDA==
X-Gm-Message-State: APjAAAXWKYZP2RBNStRvmaQLhufHNitaj0iluWsJbKHqOeDX/1F3hGTR
        CkMfWoPuyCaI6hw3o06ObaZlk2Vv7TPgqaKg3bODfdZZ
X-Google-Smtp-Source: APXvYqxbX2LbXTFgxRfAdQz8EibyiKJIsYoopKZ8Tskaz3eyAsGeqczldu5ARCgE406ncmVrA2Ei8JfCR0LP5QwLZjU=
X-Received: by 2002:a1f:3cc9:: with SMTP id j192mr4473117vka.58.1569845836219;
 Mon, 30 Sep 2019 05:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
 <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
 <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
In-Reply-To: <20190929150406.s57pmb3dggfbcqhr@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 30 Sep 2019 14:17:04 +0200
Message-ID: <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: multipart/mixed; boundary="0000000000006bbece0593c437a6"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000006bbece0593c437a6
Content-Type: text/plain; charset="UTF-8"

Pratyush,

On Sun, Sep 29, 2019 at 5:04 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi Philip, Bert,
>
> Is there any way I can test this change? Philip, I ran the rebase you
> mention in the GitHub issue [0], and I get that '9c8cba6862abe5ac821' is
> an unknown revision.
>
> Is there any quick way I can reproduce this (maybe on a sample repo)?

The easiest way to produce a merge conflict, is to change the same
line differently in two branches and try to merge them. I added a
fast-import file to demonstrate this for you.

$ git init foo
$ cd foo
$ git fast-import <../conflict-merge.fi
$ git reset --hard master
$ git merge branch

this gets you into the conflict, probably the usual style. Which looks
in liek this on the terminal:

@@@ -2,7 -2,7 +2,11 @@@ Lorem ipsum dolor sit amet, consectetu
  Sed feugiat nisl eget efficitur ultrices.
  Nunc cursus metus rutrum, mollis lorem vitae, hendrerit mi.
  Aenean vestibulum ante ac libero venenatis, non hendrerit orci pharetra.
++<<<<<<< HEAD
 +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
++=======
+ Proin placerat leo malesuada lacinia lobortis.
++>>>>>>> branch
  Pellentesque aliquam libero et nisi scelerisque commodo.
  Quisque id velit sed magna molestie porttitor.
  Vivamus sed urna in risus molestie ultricies.

and this in git gui: https://kgab.selfhost.eu/s/gHHaQqowGp7mXEb

Git gui removes the '++' in front of the marker lines. It therefor
already 'changes' the 'diff'. Though git-apply cannot handle such
'diffs' anyway.

To get the diff3 style do:

$ git merge --abort
$ git -c merge.conflictStyle=diff3 merge branch

This is how it looks in the terminal now:

@@@ -2,7 -2,7 +2,13 @@@ Lorem ipsum dolor sit amet, consectetu
  Sed feugiat nisl eget efficitur ultrices.
  Nunc cursus metus rutrum, mollis lorem vitae, hendrerit mi.
  Aenean vestibulum ante ac libero venenatis, non hendrerit orci pharetra.
++<<<<<<< HEAD
 +Proin bibendum purus ut est tristique, non pharetra dui consectetur.
++||||||| merged common ancestors
++Proin in felis eu elit suscipit rhoncus vel ut metus.
++=======
+ Proin placerat leo malesuada lacinia lobortis.
++>>>>>>> branch
  Pellentesque aliquam libero et nisi scelerisque commodo.
  Quisque id velit sed magna molestie porttitor.
  Vivamus sed urna in risus molestie ultricies.

As you can see, there is not the usual 'I removed this, and added
that' experience, everything is 'added'. Thus I inverted the pre-image
to '--'. Here is how it looks in the gui:
https://kgab.selfhost.eu/s/5c8Tosra7WRfjwJ

> [0] https://github.com/git-for-windows/git/issues/2340
>
> On 25/09/19 10:38PM, Bert Wesarg wrote:
> > This adds highlight support for the diff3 conflict style.
> >
> > The common pre-image will be reversed to --, because it has been removed
> > and either replaced with ours or theirs side.
> >
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  git-gui.sh   |  3 +++
> >  lib/diff.tcl | 22 ++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index fd476b6..6d80f82 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -3581,6 +3581,9 @@ $ui_diff tag conf d_s- \
> >  $ui_diff tag conf d< \
> >       -foreground orange \
> >       -font font_diffbold
> > +$ui_diff tag conf d| \
> > +     -foreground orange \
> > +     -font font_diffbold
> >  $ui_diff tag conf d= \
> >       -foreground orange \
> >       -font font_diffbold
> > diff --git a/lib/diff.tcl b/lib/diff.tcl
> > index 0fd4600..6caf4e7 100644
> > --- a/lib/diff.tcl
> > +++ b/lib/diff.tcl
> > @@ -347,6 +347,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> >       }
> >
> >       set ::current_diff_inheader 1
> > +     set ::conflict_state {CONTEXT}
> >       fconfigure $fd \
> >               -blocking 0 \
> >               -encoding [get_path_encoding $path] \
> > @@ -450,10 +451,28 @@ proc read_diff {fd conflict_size cont_info} {
> >                       {++} {
> >                               set regexp [string map [list %conflict_size $conflict_size]\
> >                                                               {^\+\+([<>=]){%conflict_size}(?: |$)}]
> > +                             set regexp_pre_image [string map [list %conflict_size $conflict_size]\
> > +                                                             {^\+\+\|{%conflict_size}(?: |$)}]
> >                               if {[regexp $regexp $line _g op]} {
> >                                       set is_conflict_diff 1
> >                                       set line [string replace $line 0 1 {  }]
> > +                                     set markup {}
> >                                       set tags d$op
> > +                                     switch -exact -- $op {
> > +                                     < { set ::conflict_state {OURS} }
> > +                                     = { set ::conflict_state {THEIRS} }
> > +                                     > { set ::conflict_state {CONTEXT} }
> > +                                     }
> > +                             } elseif {[regexp $regexp_pre_image $line]} {
> > +                                     set is_conflict_diff 1
> > +                                     set line [string replace $line 0 1 {  }]
> > +                                     set markup {}
> > +                                     set tags d|
> > +                                     set ::conflict_state {BASE}
> > +                             } elseif {$::conflict_state eq {BASE}} {
> > +                                     set line [string replace $line 0 1 {--}]
> > +                                     set markup {}
> > +                                     set tags d_--
>
> I'm afraid I don't follow what this hunk is supposed to do.
>
> You set the variable ::conflict_state to the values like OURS, THEIRS,
> CONTEXT, but I don't see those values being used anywhere. A quick
> search for these words shows me that you only set them, never read them.

the last elseif depends on it.

I actually only need to detect the pre-image lines, which starts with
the ||| conflict-marker and ends with the === conflict-marker, instead
of all possible states.

>
> Is there some extra code that you have and I don't?
>
> Also, this function is long and complicated already. A comment
> explaining what this code is doing would be nice, since it is not at all
> obvious at first read-through.

Will re-send.

Bert

>
> >                               } else {
> >                                       set tags d_++
> >                               }
> > @@ -505,6 +524,9 @@ proc read_diff {fd conflict_size cont_info} {
> >                       }
> >               }
> >               set mark [$ui_diff index "end - 1 line linestart"]
> > +             if {[llength $markup] > 0} {
> > +                     set tags {}
> > +             }
> >               $ui_diff insert end $line $tags
> >               if {[string index $line end] eq "\r"} {
> >                       $ui_diff tag add d_cr {end - 2c}
> > --
> > 2.21.0.789.ga095d9d866
> >
>
> --
> Regards,
> Pratyush Yadav

--0000000000006bbece0593c437a6
Content-Type: application/octet-stream; name="conflict-merge.fi"
Content-Disposition: attachment; filename="conflict-merge.fi"
Content-Transfer-Encoding: base64
Content-ID: <f_k160m4g10>
X-Attachment-Id: f_k160m4g10

YmxvYgptYXJrIDoxCmRhdGEgNDM2CkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0LCBjb25zZWN0
ZXR1ciBhZGlwaXNjaW5nIGVsaXQuClNlZCBmZXVnaWF0IG5pc2wgZWdldCBlZmZpY2l0dXIgdWx0
cmljZXMuCk51bmMgY3Vyc3VzIG1ldHVzIHJ1dHJ1bSwgbW9sbGlzIGxvcmVtIHZpdGFlLCBoZW5k
cmVyaXQgbWkuCkFlbmVhbiB2ZXN0aWJ1bHVtIGFudGUgYWMgbGliZXJvIHZlbmVuYXRpcywgbm9u
IGhlbmRyZXJpdCBvcmNpIHBoYXJldHJhLgpQcm9pbiBpbiBmZWxpcyBldSBlbGl0IHN1c2NpcGl0
IHJob25jdXMgdmVsIHV0IG1ldHVzLgpQZWxsZW50ZXNxdWUgYWxpcXVhbSBsaWJlcm8gZXQgbmlz
aSBzY2VsZXJpc3F1ZSBjb21tb2RvLgpRdWlzcXVlIGlkIHZlbGl0IHNlZCBtYWduYSBtb2xlc3Rp
ZSBwb3J0dGl0b3IuClZpdmFtdXMgc2VkIHVybmEgaW4gcmlzdXMgbW9sZXN0aWUgdWx0cmljaWVz
LgoKcmVzZXQgcmVmcy9oZWFkcy9icmFuY2gKY29tbWl0IHJlZnMvaGVhZHMvYnJhbmNoCm1hcmsg
OjIKYXV0aG9yIEJlcnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29nbGVtYWlsLmNvbT4gMTU2OTgy
MjUxNCArMDIwMApjb21taXR0ZXIgQmVydCBXZXNhcmcgPGJlcnQud2VzYXJnQGdvb2dsZW1haWwu
Y29tPiAxNTY5ODIyODkxICswMjAwCmRhdGEgNQppbml0Ck0gMTAwNjQ0IDoxIGxvcmVtCgpibG9i
Cm1hcmsgOjMKZGF0YSA0NTEKTG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVy
IGFkaXBpc2NpbmcgZWxpdC4KU2VkIGZldWdpYXQgbmlzbCBlZ2V0IGVmZmljaXR1ciB1bHRyaWNl
cy4KTnVuYyBjdXJzdXMgbWV0dXMgcnV0cnVtLCBtb2xsaXMgbG9yZW0gdml0YWUsIGhlbmRyZXJp
dCBtaS4KQWVuZWFuIHZlc3RpYnVsdW0gYW50ZSBhYyBsaWJlcm8gdmVuZW5hdGlzLCBub24gaGVu
ZHJlcml0IG9yY2kgcGhhcmV0cmEuClByb2luIGJpYmVuZHVtIHB1cnVzIHV0IGVzdCB0cmlzdGlx
dWUsIG5vbiBwaGFyZXRyYSBkdWkgY29uc2VjdGV0dXIuClBlbGxlbnRlc3F1ZSBhbGlxdWFtIGxp
YmVybyBldCBuaXNpIHNjZWxlcmlzcXVlIGNvbW1vZG8uClF1aXNxdWUgaWQgdmVsaXQgc2VkIG1h
Z25hIG1vbGVzdGllIHBvcnR0aXRvci4KVml2YW11cyBzZWQgdXJuYSBpbiByaXN1cyBtb2xlc3Rp
ZSB1bHRyaWNpZXMuCgpjb21taXQgcmVmcy9oZWFkcy9tYXN0ZXIKbWFyayA6NAphdXRob3IgQmVy
dCBXZXNhcmcgPGJlcnQud2VzYXJnQGdvb2dsZW1haWwuY29tPiAxNTY5ODIyNjY3ICswMjAwCmNv
bW1pdHRlciBCZXJ0IFdlc2FyZyA8YmVydC53ZXNhcmdAZ29vZ2xlbWFpbC5jb20+IDE1Njk4MjMw
NDQgKzAyMDAKZGF0YSA4CmNoYW5nZWQKZnJvbSA6MgpNIDEwMDY0NCA6MyBsb3JlbQoKYmxvYgpt
YXJrIDo1CmRhdGEgNDI5CkxvcmVtIGlwc3VtIGRvbG9yIHNpdCBhbWV0LCBjb25zZWN0ZXR1ciBh
ZGlwaXNjaW5nIGVsaXQuClNlZCBmZXVnaWF0IG5pc2wgZWdldCBlZmZpY2l0dXIgdWx0cmljZXMu
Ck51bmMgY3Vyc3VzIG1ldHVzIHJ1dHJ1bSwgbW9sbGlzIGxvcmVtIHZpdGFlLCBoZW5kcmVyaXQg
bWkuCkFlbmVhbiB2ZXN0aWJ1bHVtIGFudGUgYWMgbGliZXJvIHZlbmVuYXRpcywgbm9uIGhlbmRy
ZXJpdCBvcmNpIHBoYXJldHJhLgpQcm9pbiBwbGFjZXJhdCBsZW8gbWFsZXN1YWRhIGxhY2luaWEg
bG9ib3J0aXMuClBlbGxlbnRlc3F1ZSBhbGlxdWFtIGxpYmVybyBldCBuaXNpIHNjZWxlcmlzcXVl
IGNvbW1vZG8uClF1aXNxdWUgaWQgdmVsaXQgc2VkIG1hZ25hIG1vbGVzdGllIHBvcnR0aXRvci4K
Vml2YW11cyBzZWQgdXJuYSBpbiByaXN1cyBtb2xlc3RpZSB1bHRyaWNpZXMuCgpjb21taXQgcmVm
cy9oZWFkcy9icmFuY2gKbWFyayA6NgphdXRob3IgQmVydCBXZXNhcmcgPGJlcnQud2VzYXJnQGdv
b2dsZW1haWwuY29tPiAxNTY5ODIzMDc3ICswMjAwCmNvbW1pdHRlciBCZXJ0IFdlc2FyZyA8YmVy
dC53ZXNhcmdAZ29vZ2xlbWFpbC5jb20+IDE1Njk4MjMwNzcgKzAyMDAKZGF0YSA5CmNvbmZsaWN0
CmZyb20gOjIKTSAxMDA2NDQgOjUgbG9yZW0KCg==
--0000000000006bbece0593c437a6--
