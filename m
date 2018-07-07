Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9BE1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeGGUMq (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 16:12:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39781 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeGGUMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 16:12:45 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so21635300itp.4
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJz58dJHqV1bAFxw96P05f5X7sZwtyoz3LwpbDfKuWg=;
        b=X5IesuMD+Umvh89n6+6X0OgSVaY3oUdVCqBek5kS+J2dLsau9O1XBirM6rMAXMfhfo
         W7dGO2ygEbummkHKRxBM1g8vUmNv6nKxRW8BvuDfnlRMjkFfFZYD+/EWdUJnorZazL1+
         KygIntimU6qUaXnUKrFm7DY+Xb/afD2n+BJeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJz58dJHqV1bAFxw96P05f5X7sZwtyoz3LwpbDfKuWg=;
        b=HmEO8+mH4UhzMBXOql5+JzaVyMGFw286Es0Y8MIS+9aoGDRfX98T6oYtSpXh0cpnl6
         di5oFP5Rrl9THrfyUENO3PZRj3aXrHF66xHVPvZztbRuazinAS09KKVi4yhNzcDu4jzc
         67pZ5/dzHs21nKbIkH2I+xprAeRP9cVkRbEE0VddFfw7K8iu29hWmjhvXfcrBFW73qGE
         O9HTgWFFVOcrCAIGefnZMuxGxERfi7aUqZkWXwn2H1fnXRGWoWWsYWxV717HwuIh/T3K
         USgw7ibe1CNDjdyPCwkXIx9250LD/2OjIU/sACFezFUOPKjOt/HMCczQRmicxIUhZyEa
         eZKg==
X-Gm-Message-State: APt69E3qy6AKE/uPxzl5L6ujXVGfnvWLtdRvTL3rypoOR3ppMxrkAMXR
        Z0NzIb+A7VtDrmua2hJKL+8H3t0O0T5YkogPTXc=
X-Google-Smtp-Source: AAOMgpeNvn0XYrIVX5fcPM5ZZTzafBkY9vg0XaqwtIoRLmH7cArFO/u2XlZ/Fn0ZpeKL5woBfSImZphOwWHc474/TMo=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr11423754itg.1.1530994364869;
 Sat, 07 Jul 2018 13:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan> <CA+55aFyh4=Udhfn+L__9MiCbjqSLTWBGaAvDOPg5EJWs-DjjPQ@mail.gmail.com>
In-Reply-To: <CA+55aFyh4=Udhfn+L__9MiCbjqSLTWBGaAvDOPg5EJWs-DjjPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Jul 2018 13:12:33 -0700
Message-ID: <CA+55aFy=rUvt8kV==Zxvc02zaTQpd=Zc0p6dMN=vHvvoYE4bYw@mail.gmail.com>
Subject: Re: [RFC PATCH] Add 'human' date format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000458ccf05706e6792"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000458ccf05706e6792
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 7, 2018 at 12:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm playing with making all "today" dates just use the relative
> format.

Here's the incremental patch for that if people want to compare the output.

With this, you never get the "just time" case, because that will turn
into "2 hours ago" or similar. But you will get "Fri 19:45" for
something that happened yesterday.

So examples from my kernel logs look something like this:

  2 hours ago
  Fri 19:45
  Fri 10:44 +1000
  Fri Jun 22 15:46
  Tue Jun 19 15:41 -0600
  Thu Jun 15 12:57 2017 +0300

depending on how long ago they were and whether they were in the same
timezone etc.

              Linus

--000000000000458ccf05706e6792
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jjbu94fs0>
X-Attachment-Id: f_jjbu94fs0

IGRhdGUuYyB8IDE2ICsrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RhdGUuYyBiL2RhdGUuYwppbmRl
eCA5ODA5YWMzMzQuLmRlMGIwM2NmNCAxMDA2NDQKLS0tIGEvZGF0ZS5jCisrKyBiL2RhdGUuYwpA
QCAtMTk5LDcgKzE5OSw3IEBAIHN0cnVjdCBkYXRlX21vZGUgKmRhdGVfbW9kZV9mcm9tX3R5cGUo
ZW51bSBkYXRlX21vZGVfdHlwZSB0eXBlKQogCXJldHVybiAmbW9kZTsKIH0KIAotc3RhdGljIHZv
aWQgc2hvd19kYXRlX25vcm1hbChzdHJ1Y3Qgc3RyYnVmICpidWYsIHN0cnVjdCB0bSAqdG0sIGlu
dCB0eiwgc3RydWN0IHRtICpodW1hbl90bSwgaW50IGh1bWFuX3R6LCBpbnQgbG9jYWwpCitzdGF0
aWMgdm9pZCBzaG93X2RhdGVfbm9ybWFsKHN0cnVjdCBzdHJidWYgKmJ1ZiwgdGltZXN0YW1wX3Qg
dGltZSwgc3RydWN0IHRtICp0bSwgaW50IHR6LCBzdHJ1Y3QgdG0gKmh1bWFuX3RtLCBpbnQgaHVt
YW5fdHosIGludCBsb2NhbCkKIHsKIAlzdHJ1Y3QgewogCQl1bnNpZ25lZCBpbnQJeWVhcjoxLApA
QCAtMjI1LDYgKzIyNSwxNCBAQCBzdGF0aWMgdm9pZCBzaG93X2RhdGVfbm9ybWFsKHN0cnVjdCBz
dHJidWYgKmJ1Ziwgc3RydWN0IHRtICp0bSwgaW50IHR6LCBzdHJ1Y3QgdAogCQl9CiAJfQogCisJ
LyogU2hvdyAidG9kYXkiIHRpbWVzIGFzIGp1c3QgcmVsYXRpdmUgdGltZXMgKi8KKwlpZiAoaGlk
ZS53ZGF5KSB7CisJCXN0cnVjdCB0aW1ldmFsIG5vdzsKKwkJZ2V0dGltZW9mZGF5KCZub3csIE5V
TEwpOworCQlzaG93X2RhdGVfcmVsYXRpdmUodGltZSwgdHosICZub3csIGJ1Zik7CisJCXJldHVy
bjsKKwl9CisKIAkvKiBBbHdheXMgaGlkZSBzZWNvbmRzIGZvciBodW1hbi1yZWFkYWJsZSAqLwog
CWhpZGUuc2Vjb25kcyA9IGh1bWFuX3RtLT50bV95ZWFyID4gMDsKIApAQCAtMjY4LDEwICsyNzYs
NiBAQCBjb25zdCBjaGFyICpzaG93X2RhdGUodGltZXN0YW1wX3QgdGltZSwgaW50IHR6LCBjb25z
dCBzdHJ1Y3QgZGF0ZV9tb2RlICptb2RlKQogCQkvKiBGaWxsIGluIHRoZSBkYXRhIGZvciAiY3Vy
cmVudCB0aW1lIiBpbiBodW1hbl90eiBhbmQgaHVtYW5fdG0gKi8KIAkJaHVtYW5fdHogPSBsb2Nh
bF90aW1lX3R6b2Zmc2V0KG5vdy50dl9zZWMsICZodW1hbl90bSk7CiAKLQkJLyogU3BlY2lhbCBj
YXNlOiBpZiBpdCdzIGxlc3MgdGhhbiBhbiBob3VyIGFnbywgdXNlIHJlbGF0aXZlIHRpbWUgKi8K
LQkJaWYgKHRpbWUgLSBub3cudHZfc2VjIDwgNjAgKiA2MCkKLQkJCXR5cGUgPSBEQVRFX1JFTEFU
SVZFOwotCiAJCS8qIERvbid0IHByaW50IHRpbWV6b25lIGlmIGl0IG1hdGNoZXMgKi8KIAkJaWYg
KHR6ID09IGh1bWFuX3R6KQogCQkJbG9jYWwgPSAxOwpAQCAtMzMzLDcgKzMzNyw3IEBAIGNvbnN0
IGNoYXIgKnNob3dfZGF0ZSh0aW1lc3RhbXBfdCB0aW1lLCBpbnQgdHosIGNvbnN0IHN0cnVjdCBk
YXRlX21vZGUgKm1vZGUpCiAJCXN0cmJ1Zl9hZGRmdGltZSgmdGltZWJ1ZiwgbW9kZS0+c3RyZnRp
bWVfZm10LCB0bSwgdHosCiAJCQkJIWxvY2FsKTsKIAllbHNlCi0JCXNob3dfZGF0ZV9ub3JtYWwo
JnRpbWVidWYsIHRtLCB0eiwgJmh1bWFuX3RtLCBodW1hbl90eiwgbG9jYWwpOworCQlzaG93X2Rh
dGVfbm9ybWFsKCZ0aW1lYnVmLCB0aW1lLCB0bSwgdHosICZodW1hbl90bSwgaHVtYW5fdHosIGxv
Y2FsKTsKIAlyZXR1cm4gdGltZWJ1Zi5idWY7CiB9CiAK
--000000000000458ccf05706e6792--
