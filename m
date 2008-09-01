From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Mon, 1 Sep 2008 12:36:47 +0200
Message-ID: <36ca99e90809010336k2afd1253vfcdb754b6af97143@mail.gmail.com>
References: <1218808427.25300.2.camel@heerbeest>
	 <36ca99e90809010231o439ab4acsaa3027366c551ff6@mail.gmail.com>
	 <1220263905.6278.13.camel@heerbeest>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22161_3942364.1220265407802"
Cc: git <git@vger.kernel.org>, "Jan Holesovsky" <kendy@suse.cz>
To: "Jan Nieuwenhuizen" <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6nE-0007eA-Ty
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbYIAKgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYIAKgv
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:36:51 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:16737 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYIAKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:36:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so295391and.103
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=Or2y3/rrqxbkNt0gL1wDJkReVa757R1GlwxGfnZgPJA=;
        b=I+nP5mSD39DWA09AInMCB5wYHjRMyy6Tt9DHDxWmuJWYtcTTdgLbEsC+DMdgcqP12v
         Hc/t2NR5+VHOn6f1vuigBYsMFcfq/IZgXQAvIFdcomKXI9MXbCIRUq7b/XA2XUofxULa
         A3gCFxiR8AAE82h8a0o0QZhb8n9tEChZzL6iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=XfP+lFoiyXJ4NNincc4isuZ/fGAwXN206jt6HuXS9RuvmrA5oMglOXxLnM8fVz1boB
         hQhVgMx/EZ4rV4CdMIrZeaYs7jhomDQvrhLXhsMI4Hr22dmgNQU/vBnjkjDvCL0Kjh6D
         PKjeLdY6LKyFEqzeNbrVmghQryWPST+oP9Cok=
Received: by 10.100.144.11 with SMTP id r11mr5701197and.52.1220265407789;
        Mon, 01 Sep 2008 03:36:47 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 03:36:47 -0700 (PDT)
In-Reply-To: <1220263905.6278.13.camel@heerbeest>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94567>

------=_Part_22161_3942364.1220265407802
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Sep 1, 2008 at 12:11, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> On ma, 2008-09-01 at 11:31 +0200, Bert Wesarg wrote:
>
> Hi Bert,
>
>>
>> On Fri, Aug 15, 2008 at 15:53, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
>> > As discussed previously
>> >
>> >    http://kerneltrap.org/mailarchive/git/2008/8/13/2925144
>> >
>> > Change a topgit branch's dependencies by doing a rebase-by-merge.
>> >
>> >
>> is this script in use by you, or is it abandoned in favor of another idea?
>
> I haven't had the time to digest the several new takes on this, esp.
> http://kerneltrap.org/mailarchive/git/2008/8/15/2954214 and combining
> my previous attempt's use of git revert and git cherry-pick with git
> read-tree to make for a much faster adding or removal of
> dependencies.
>
>> Anyway, I have tried it today but it looks like the top-bases wasn't
>> updated to the new deps.
>
> How odd.  It also looks like "redeps" contains the new set of
> dependencies, which is written to .topdeps.  I guess that most of
> this script will be abandoned anyway, but a nice bug report ie: how to
> reproduce this error never hurts ;-)
Yeah, sorry, here comes part two:

I have tried to switch the order of two topics, which are the only two
in this 'series'. T1 depdens on master, and T2 on T1 with definitive
merge conflicts.

first step was to redepend T2 to master:
$ tg redepend master

after that, I saw the above odds, i.e.:
 * the refs/top-bases/T2 points still to T1 not master
 * (NEW) the .topmsg is lost (which I discovered after step two)
 * a trailing empty line is in .topdeps

(NEW) step two was to redpend T1 on T2:
$ git checkout T2
$ tg redepend T2

after that, my T1 changes were lost, i.e. the worktree is in state of T2.

I have attached the log of this session (slightly edited).

Thanks anyway for working on this.

Regards
Bert

> Greetings,
> Jan.

------=_Part_22161_3942364.1220265407802
Content-Type: application/octet-stream; name=tg-redpend-log
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkkyfrn20
Content-Disposition: attachment; filename=tg-redpend-log

VDJAZ2l0ICQgdGcgcmVkZXBlbmQgbWFzdGVyCnRnOiBOZXcgbGlzdCBvZiBkZXBlbmRlbmNpZXM6
IG1hc3RlciAuCnRnOiBDcmVhdGluZyB0Zy1yZWRlcGVuZC90bXAvVDIuYmFzZV8gYmFzZSBmcm9t
IG1hc3Rlci4uLgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggInRnLXJlZGVwZW5kL3RtcC9UMi5i
YXNlXyIKdGc6IFRvcGljIGJyYW5jaCB0Zy1yZWRlcGVuZC90bXAvVDIuYmFzZV8gc2V0IHVwLiBQ
bGVhc2UgZmlsbCAudG9wbXNnIG5vdyBhbmQgbWFrZSBpbml0aWFsIGNvbW1pdC4KdGc6IFRvIGFi
b3J0OiBnaXQgcm0gLWYgLnRvcCogJiYgZ2l0IGNoZWNrb3V0IG1hc3RlciAmJiB0ZyBkZWxldGUg
dGctcmVkZXBlbmQvdG1wL1QyLmJhc2VfCkNyZWF0ZWQgY29tbWl0IDE5OTJjZTU6IHRnIHJlZGVw
ZW5kOiBhZGQgVG9wR2l0IC50b3AqIGluZm8uCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCAudG9wZGVwcwogY3JlYXRl
IG1vZGUgMTAwNjQ0IC50b3Btc2cKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICJ0Zy1yZWRlcGVu
ZC90bXAvVDJfIgpGaXJzdCwgcmV3aW5kaW5nIGhlYWQgdG8gcmVwbGF5IHlvdXIgd29yayBvbiB0
b3Agb2YgaXQuLi4KQXBwbHlpbmc6IEFMTE9DX0dST1cKZXJyb3I6IHBhdGNoIGZhaWxlZDogLnRv
cG1zZzoxCmVycm9yOiAudG9wbXNnOiBwYXRjaCBkb2VzIG5vdCBhcHBseQplcnJvcjogcGF0Y2gg
ZmFpbGVkOiBidWlsdGluLWZvci1lYWNoLXJlZi5jOjgyCmVycm9yOiBidWlsdGluLWZvci1lYWNo
LXJlZi5jOiBwYXRjaCBkb2VzIG5vdCBhcHBseQpVc2luZyBpbmRleCBpbmZvIHRvIHJlY29uc3Ry
dWN0IGEgYmFzZSB0cmVlLi4uCkZhbGxpbmcgYmFjayB0byBwYXRjaGluZyBiYXNlIGFuZCAzLXdh
eSBtZXJnZS4uLgpBdXRvLW1lcmdlZCAudG9wbXNnCkF1dG8tbWVyZ2VkIGJ1aWx0aW4tZm9yLWVh
Y2gtcmVmLmMKQ09ORkxJQ1QgKGNvbnRlbnQpOiBNZXJnZSBjb25mbGljdCBpbiBidWlsdGluLWZv
ci1lYWNoLXJlZi5jCkZhaWxlZCB0byBtZXJnZSBpbiB0aGUgY2hhbmdlcy4KUGF0Y2ggZmFpbGVk
IGF0IDAwMDEuCgpXaGVuIHlvdSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSBydW4gImdpdCBy
ZWJhc2UgLS1jb250aW51ZSIuCklmIHlvdSB3b3VsZCBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNo
LCBpbnN0ZWFkIHJ1biAiZ2l0IHJlYmFzZSAtLXNraXAiLgpUbyByZXN0b3JlIHRoZSBvcmlnaW5h
bCBicmFuY2ggYW5kIHN0b3AgcmViYXNpbmcgcnVuICJnaXQgcmViYXNlIC0tYWJvcnQiLgoKdGc6
IFBsZWFzZSByZXNvbHZlIGNvbmZsaWN0cyBhbmQgY2FsbDogdGcgcmVkZXBlbmQKdGc6IEl0IGlz
IGFsc28gc2FmZSB0byBhYm9ydCB0aGlzIG9wZXJhdGlvbiB1c2luZzoKdGc6IHRnIGRlbGV0ZSB0
Zy1yZWRlcGVuZC90bXAvVDIuYmFzZV87IGdpdCByZXNldCAtLWhhcmQgc29tZV9icmFuY2gKMTk5
MmNlNS4uLkBnaXQgJCBuYyBidWlsdGluLWZvci1lYWNoLXJlZi5jIAoxOTkyY2U1Li4uQGdpdCAk
IGdpdCBndWkKNDY5NGI5NC4uLkBnaXQgJCB0ZyByZWRlcGVuZCAKQXBwbHlpbmc6IEFMTE9DX0dS
T1cKTm90ZTogbW92aW5nIHRvICI4ZTg1ODZjMGZhNDA4OTQ5OTQ5OGFhMWJiMzYyOTAwMTkzYzM0
OTAyIiB3aGljaCBpc24ndCBhIGxvY2FsIGJyYW5jaApJZiB5b3Ugd2FudCB0byBjcmVhdGUgYSBu
ZXcgYnJhbmNoIGZyb20gdGhpcyBjaGVja291dCwgeW91IG1heSBkbyBzbwoobm93IG9yIGxhdGVy
KSBieSB1c2luZyAtYiB3aXRoIHRoZSBjaGVja291dCBjb21tYW5kIGFnYWluLiBFeGFtcGxlOgog
IGdpdCBjaGVja291dCAtYiA8bmV3X2JyYW5jaF9uYW1lPgpIRUFEIGlzIG5vdyBhdCA4ZTg1ODZj
Li4uIEFMTE9DX0dST1cKQXV0by1tZXJnZWQgLnRvcGRlcHMKQXV0by1tZXJnZWQgLnRvcG1zZwpB
dXRvbWF0aWMgbWVyZ2Ugd2VudCB3ZWxsOyBzdG9wcGVkIGJlZm9yZSBjb21taXR0aW5nIGFzIHJl
cXVlc3RlZApTd2l0Y2hlZCB0byBicmFuY2ggIlQyIgpEZWxldGVkIGJyYW5jaCB0Zy1yZWRlcGVu
ZC90bXAvVDJfLgp0ZzogUmViYXNlZC11c2luZy1tZXJnZSBvbnRvIG5ldyBkZXBlbmRlbmNpZXM6
IG1hc3RlciAuClQxQGdpdCAkIHRnIHJlZGVwZW5kIFQyCnRnOiBOZXcgbGlzdCBvZiBkZXBlbmRl
bmNpZXM6IFQyIC4KdGc6IENyZWF0aW5nIHRnLXJlZGVwZW5kL3RtcC9UMS5iYXNlXyBiYXNlIGZy
b20gVDIuLi4KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICJ0Zy1yZWRlcGVuZC90bXAvVDEuYmFz
ZV8iCnRnOiBUb3BpYyBicmFuY2ggdGctcmVkZXBlbmQvdG1wL1QxLmJhc2VfIHNldCB1cC4gUGxl
YXNlIGZpbGwgLnRvcG1zZyBub3cgYW5kIG1ha2UgaW5pdGlhbCBjb21taXQuCnRnOiBUbyBhYm9y
dDogZ2l0IHJtIC1mIC50b3AqICYmIGdpdCBjaGVja291dCBUMiAmJiB0ZyBkZWxldGUgdGctcmVk
ZXBlbmQvdG1wL1QxLmJhc2VfCkNyZWF0ZWQgY29tbWl0IGIwN2U1MWI6IHRnIHJlZGVwZW5kOiBh
ZGQgVG9wR2l0IC50b3AqIGluZm8uCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICJ0Zy1yZWRlcGVuZC90bXAv
VDFfIgpGaXJzdCwgcmV3aW5kaW5nIGhlYWQgdG8gcmVwbGF5IHlvdXIgd29yayBvbiB0b3Agb2Yg
aXQuLi4KRmFzdC1mb3J3YXJkZWQgdGctcmVkZXBlbmQvdG1wL1QxXyB0byB0Zy1yZWRlcGVuZC90
bXAvVDEuYmFzZV8uCk5vdGU6IG1vdmluZyB0byAiNDZjZGE2ZGM5ZWQ5MjlmNzM3MjU4MjFmZTk4
ZGJjY2VhYTk0ZTQ1OSIgd2hpY2ggaXNuJ3QgYSBsb2NhbCBicmFuY2gKSWYgeW91IHdhbnQgdG8g
Y3JlYXRlIGEgbmV3IGJyYW5jaCBmcm9tIHRoaXMgY2hlY2tvdXQsIHlvdSBtYXkgZG8gc28KKG5v
dyBvciBsYXRlcikgYnkgdXNpbmcgLWIgd2l0aCB0aGUgY2hlY2tvdXQgY29tbWFuZCBhZ2Fpbi4g
RXhhbXBsZToKICBnaXQgY2hlY2tvdXQgLWIgPG5ld19icmFuY2hfbmFtZT4KSEVBRCBpcyBub3cg
YXQgNDZjZGE2ZC4uLiBkb2l0CkF1dG9tYXRpYyBtZXJnZSB3ZW50IHdlbGw7IHN0b3BwZWQgYmVm
b3JlIGNvbW1pdHRpbmcgYXMgcmVxdWVzdGVkClN3aXRjaGVkIHRvIGJyYW5jaCAiVDEiCkRlbGV0
ZWQgYnJhbmNoIHRnLXJlZGVwZW5kL3RtcC9UMV8uCnRnOiBSZWJhc2VkLXVzaW5nLW1lcmdlIG9u
dG8gbmV3IGRlcGVuZGVuY2llczogVDIgLgo=
------=_Part_22161_3942364.1220265407802--
