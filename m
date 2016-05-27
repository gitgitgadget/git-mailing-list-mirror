From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RFC: dynamic "auto" date formats
Date: Thu, 26 May 2016 20:36:57 -0700
Message-ID: <CA+55aFzWEf2sN647v0mfiPOFE=KindQpweoHwdPmDshUb0YVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c11171665dba50533ca9eb6
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 05:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68hU-0000Ij-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 05:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbcE0Dog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 23:44:36 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36906 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbcE0Dof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 23:44:35 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2016 23:44:35 EDT
Received: by mail-it0-f41.google.com with SMTP id z123so57259693itg.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc;
        bh=3cM4plRFC0YpHhk3a0VtaBaGYxrq+30iCa6+iL67Qtc=;
        b=ETQvvFoUtNn2gMSqZj3FlVOyrZqIhUCApB6OdbV3IuWHMoXombKUzcJcenL+5P6lxV
         FwP6xlgZy7H6gKq5xIdodkUutUvIblwZWpCLZ7YOuU/wNBQbN4tSeILIH8lhbbL3W/Nz
         uKfD4krM/KnoobmuURSe+ftTYE3QSJxz8d3cisNcsoJQBOjthwk4xwj2C5NpKCLyaL7q
         uK3d83ets2hw6QlFPlOPboRJc2+aEyS9XJZRFU7Dy+ZumX3K8mU5TAA6r71aBNh4fmxh
         oCZAY9eVT5s3a/gbjU5ASlyTdo+rPsw+3YD6yj1to3zIiG4m65EO+9x/bJ7orA43VTCl
         c8YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc;
        bh=3cM4plRFC0YpHhk3a0VtaBaGYxrq+30iCa6+iL67Qtc=;
        b=hQsx5fgk+MrOYVvstrswbgh0aWt5MBLpX5/MR2IXdzq7DRhw/WLMV/HCTvjfr4VZio
         SraLqnJERNIEdPD3tRUq7/ilzCDvfygnfByBXy0O/Q3LLr1I/GH+6CacShWhXaAcLOYw
         mpQnq2OpI1g76ILC30uW/xLASAgS906VLvkRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:cc;
        bh=3cM4plRFC0YpHhk3a0VtaBaGYxrq+30iCa6+iL67Qtc=;
        b=cEzoJYB1CHF8V5Kng3Ys1FuCGPRXAYXuPnxrPzqvGsWAcmL6wpPG/z4K0FsMBp/LHG
         sGQC4R1BMUu6j4MQTOgP8BTtBJlL4UgiONn3nugJcW7auJMHSqQs/0FFEDJTS5p7eVGD
         wl5mtEdx+j7hgQ7CtEi+/zk6mLcRll4LnrXmQqRVAtuPcrD1OddXKLvpm4/fvAVH5JXq
         vbzleSbgH2bbYtyKFlcI/cD2C558tJGwSs3YLINZcHVJkB71wnJFnMBYRUXAcdNRb9Xk
         0Qfpo76BCpVrx486Zg2Gq27rkw49usFRhEGz2Wv+2SDUOxqK0hX/lyIO3Wfu9QzmD72W
         jnVQ==
X-Gm-Message-State: ALyK8tKqfL7qG2adTXF6pY/ei1jregddfUUPJ3lxEQVd1HZskdtfWOGBl+Zt5n5+Os2fmNa6/RfH8WjgSb5X+A==
X-Received: by 10.36.227.12 with SMTP id d12mr6104936ith.49.1464320217430;
 Thu, 26 May 2016 20:36:57 -0700 (PDT)
Received: by 10.36.131.132 with HTTP; Thu, 26 May 2016 20:36:57 -0700 (PDT)
X-Google-Sender-Auth: 7sZZFE5A3T5SucEZZMBz4p1xblA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295721>

--94eb2c11171665dba50533ca9eb6
Content-Type: text/plain; charset=UTF-8

This is a throw-away idea with a simple patch attached, which I don't
think anybody should really take all that seriously per se, but I
thought I'd throw it out and see if it generates any discussion.

I almost never use anything but the default date format (DATE_NORMAL),
but every once in a while I will use "--date=relative", typically
because I'm looking at my own commits and I'm just checking when I did
something.

It struck me that I've made the default for most of the logging things
be that when I'm just browsing with the pager, git will automatically
do the right thing. So I have

  [color]
      ui=auto

  [log]
      decorate = auto

in my ~/.gitconfig, and it shows me all those other things I tench to
want to know (like "thar's what I've pushed out" thanks to
decorations).

So I started thinking about when I care about dates, and decided that
maybe I can have a "--date=auto" too. It basically uses relative date
formats for the last 24 hours, and then switches over to the default
format.

I've used it a bit, and like Katy Perry said, I think I might like it.

Note that this doesn't add any gitconfig setting to do this, which
would be part of the whole point if this is actually sensible. But I'm
not entirely convinced it's worth it in the first place, thus this
email to see how people react ("That's just stupid" vs "yeah, I didn't
even know I wanted it, but now I need it").

And no, I'm not at all sure that the 24-hour cut-off is the right
thing, but it didn't seem completely crazy either. I tend to like the
relative date format when it is "19 minutes ago" vs "2 hours ago", at
some point it's long enough ago that it's more useful to know "Tuesday
at 3pm" than about how long ago it was.

(And yes, it would be even better to have the "short term relative
date" turn into a "medium-term 'day of the week at time x'" and then
turn into "full date" when it's more than a week ago, but this patch
only has the two modes of "short term" and "long term" and nothing in
between).

               Linus

--94eb2c11171665dba50533ca9eb6
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iop6fkqy0

IGJ1aWx0aW4vYmxhbWUuYyB8ICAxICsKIGNhY2hlLmggICAgICAgICB8ICAzICsrLQogZGF0ZS5j
ICAgICAgICAgIHwgMTAgKysrKysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4vYmxhbWUuYyBiL2J1aWx0
aW4vYmxhbWUuYwppbmRleCAyMWY0MmIwYjYyYjguLjRkODcxODFkYzZjZCAxMDA2NDQKLS0tIGEv
YnVpbHRpbi9ibGFtZS5jCisrKyBiL2J1aWx0aW4vYmxhbWUuYwpAQCAtMjY0MCw2ICsyNjQwLDcg
QEAgcGFyc2VfZG9uZToKIAkJICAgZmV3ZXIgZGlzcGxheSBjb2x1bW5zLiAqLwogCQlibGFtZV9k
YXRlX3dpZHRoID0gdXRmOF9zdHJ3aWR0aChfKCI0IHllYXJzLCAxMSBtb250aHMgYWdvIikpICsg
MTsgLyogYWRkIHRoZSBudWxsICovCiAJCWJyZWFrOworCWNhc2UgREFURV9BVVRPOgogCWNhc2Ug
REFURV9OT1JNQUw6CiAJCWJsYW1lX2RhdGVfd2lkdGggPSBzaXplb2YoIlRodSBPY3QgMTkgMTY6
MDA6MDQgMjAwNiAtMDcwMCIpOwogCQlicmVhazsKZGlmZiAtLWdpdCBhL2NhY2hlLmggYi9jYWNo
ZS5oCmluZGV4IDYwNDlmODY3MTEzOC4uNjI0ODE3YzIwNDE0IDEwMDY0NAotLS0gYS9jYWNoZS5o
CisrKyBiL2NhY2hlLmgKQEAgLTEyMjMsNyArMTIyMyw4IEBAIHN0cnVjdCBkYXRlX21vZGUgewog
CQlEQVRFX0lTTzg2MDFfU1RSSUNULAogCQlEQVRFX1JGQzI4MjIsCiAJCURBVEVfU1RSRlRJTUUs
Ci0JCURBVEVfUkFXCisJCURBVEVfUkFXLAorCQlEQVRFX0FVVE8sCiAJfSB0eXBlOwogCWNvbnN0
IGNoYXIgKnN0cmZ0aW1lX2ZtdDsKIAlpbnQgbG9jYWw7CmRpZmYgLS1naXQgYS9kYXRlLmMgYi9k
YXRlLmMKaW5kZXggN2M5Zjc2OTk4YWM3Li5jMzg0MTRhM2Q5NjggMTAwNjQ0Ci0tLSBhL2RhdGUu
YworKysgYi9kYXRlLmMKQEAgLTE4NCwxMyArMTg0LDE1IEBAIGNvbnN0IGNoYXIgKnNob3dfZGF0
ZSh1bnNpZ25lZCBsb25nIHRpbWUsIGludCB0eiwgY29uc3Qgc3RydWN0IGRhdGVfbW9kZSAqbW9k
ZSkKIAkJcmV0dXJuIHRpbWVidWYuYnVmOwogCX0KIAotCWlmIChtb2RlLT50eXBlID09IERBVEVf
UkVMQVRJVkUpIHsKKwlpZiAobW9kZS0+dHlwZSA9PSBEQVRFX1JFTEFUSVZFIHx8IG1vZGUtPnR5
cGUgPT0gREFURV9BVVRPKSB7CiAJCXN0cnVjdCB0aW1ldmFsIG5vdzsKIAogCQlzdHJidWZfcmVz
ZXQoJnRpbWVidWYpOwogCQlnZXR0aW1lb2ZkYXkoJm5vdywgTlVMTCk7Ci0JCXNob3dfZGF0ZV9y
ZWxhdGl2ZSh0aW1lLCB0eiwgJm5vdywgJnRpbWVidWYpOwotCQlyZXR1cm4gdGltZWJ1Zi5idWY7
CisJCWlmIChtb2RlLT50eXBlICE9IERBVEVfQVVUTyB8fCB0aW1lICsgMjQqNjAqNjAgPiBub3cu
dHZfc2VjKSB7CisJCQlzaG93X2RhdGVfcmVsYXRpdmUodGltZSwgdHosICZub3csICZ0aW1lYnVm
KTsKKwkJCXJldHVybiB0aW1lYnVmLmJ1ZjsKKwkJfQogCX0KIAogCXRtID0gdGltZV90b190bSh0
aW1lLCB0eik7CkBAIC03OTIsNiArNzk0LDggQEAgc3RhdGljIGVudW0gZGF0ZV9tb2RlX3R5cGUg
cGFyc2VfZGF0ZV90eXBlKGNvbnN0IGNoYXIgKmZvcm1hdCwgY29uc3QgY2hhciAqKmVuZCkKIAkJ
cmV0dXJuIERBVEVfUkFXOwogCWlmIChza2lwX3ByZWZpeChmb3JtYXQsICJmb3JtYXQiLCBlbmQp
KQogCQlyZXR1cm4gREFURV9TVFJGVElNRTsKKwlpZiAoc2tpcF9wcmVmaXgoZm9ybWF0LCAiYXV0
byIsIGVuZCkpCisJCXJldHVybiBEQVRFX0FVVE87CiAKIAlkaWUoInVua25vd24gZGF0ZSBmb3Jt
YXQgJXMiLCBmb3JtYXQpOwogfQo=
--94eb2c11171665dba50533ca9eb6--
