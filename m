Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9DA1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 18:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbcF3SNK (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 14:13:10 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36819 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbcF3SNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 14:13:07 -0400
Received: by mail-oi0-f49.google.com with SMTP id f189so77018614oig.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 11:12:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0PBcLiHdWFcM32QIjz6YhchsXgSG6RsJRuVsSmKAmAQ=;
        b=qGYA1p/QlN7fOzgnQfz31G6KFuB4WNBqIppPxKTrUEnsT5/j5qkP35DX/Zf3wUKvNi
         qVHXkPDTGkChYh28NtPypzI9eKGyuUpqMNXH0tkOAPYiXaoAKbv7MBYAdtH5X1aok7Xz
         R7P4erYqF5i6q5vdcbLBRChaZrVVstPL0uopnt9Q/CHMVLuMkdeQZHy6HLMVXNfk7jCO
         IqMR9HDPzRjIny2dCD5HiRu0seVZvdrI5/ppvPpd4wWIPsI1vkjdCVn6GIyPKG8dRPgs
         gjPFrmqNUeOZF7Y0wQ3R89SIvyLaqi0nPcoxv+aGGCHm0F7CBgxfRrd0GI4H2WoapWRo
         ngLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0PBcLiHdWFcM32QIjz6YhchsXgSG6RsJRuVsSmKAmAQ=;
        b=E0Vxwqy/8ntEMi+Fyd0jQC7vEobOCrPIGdGuU718UHCte8UFT04Nms7C0/z4uRA+ei
         KwApVxl03yKhGh0OHfxtmTfSpjXXqFITDU/5KhEN2R8ShgbOOm5zb8JSzlYu1YBHX5C6
         l9UYAaL6TQ1H9R5G+S0R82kA+I8kTCblVh0ffK+gycEbDfoIe3B+TLApKnVuy7krU1Sw
         U8IluDJFC+ngqIfGcGXVcqzTOtCY+ejcr0nFn4PX0fbC2A3uMfjieyT6HVkIUVEGIz3s
         QtRxM/unEgaf6u2hAWC1b2pIhZJL7J9jloH2J9xU3AMge3KK2Z0nXg2PGNXcg68++u0i
         BY1w==
X-Gm-Message-State: ALyK8tJO7swL0cIJo5Las5rrTGN0pxtnKZYIhNwHfLtD2MKBbfHN+/7g0Kz/F19WGNPg8+/j1GWARUOOCq+RMQ==
X-Received: by 10.157.27.156 with SMTP id z28mr11255395otd.0.1467310373658;
 Thu, 30 Jun 2016 11:12:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Thu, 30 Jun 2016 11:12:52 -0700 (PDT)
In-Reply-To: <5774F4C7.805@gmail.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com> <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com> <20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Thu, 30 Jun 2016 11:12:52 -0700
X-Google-Sender-Auth: ZVZ-cTSvkupVmHA0aYZ1PTcdimo
Message-ID: <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11371390990246053682d1c4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--001a11371390990246053682d1c4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2016 at 3:30 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
>
> P.S. Having Git ensure that committerdate (as an epoch) is greater
> than committerdates of its parents at the commit creation time (with
> providing warning about time skew, perhaps not doing it if skew is
> too large) would be not costly. No need to add anything, and it would
> help future queries to be faster, I think.

So I think git should check the committer date (ie verify that the
commitetr date of a new commit is always equal to or more recent than
all the parents).

But we should probably allow some slop for when machines are out of
sync (think build farms etc automation that may do automated commits,
but the clocks on different machines may be off by a few seconds). We
already do things like that in some of the use of committer dates -
see for example CUTOFF_DATE_SLOP)

And we should probably allow the user to override the refusal to
create new commits with bogus dates - think importing repositories etc
where you may have reasons to just say "that's just how it was".

And it will take years for that to percolate out to all users, so it's
not like it will fix things immediately, but then some time from now,
we can consider commit dates to be more reliably generation numbers.

I do think that it's ok to cache generation numbers somewhere if there
is an algorithm that can make use of them, but every time this comes
up, it's just not been important enough to make a big deal and a new
incompatible object format for it. The committer date is preexisting
and has existing pseudo-generation-number usage, so..improving on the
quality of it sounds like a good idea.

The first step should probably be to make fsck warn about the existing
cases of "commit has older date than parents". Something like the
attached patch, perhaps?

              Linus

--001a11371390990246053682d1c4
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iq2mpfmz0

IGZzY2suYyB8IDEzICsrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZnNjay5jIGIvZnNjay5jCmluZGV4IDA1MzE1NDUxYzU2Zi4uNzIy
YjY1MzcxZDM4IDEwMDY0NAotLS0gYS9mc2NrLmMKKysrIGIvZnNjay5jCkBAIC02MCw2ICs2MCw3
IEBACiAJRlVOQyhOVUxMX1NIQTEsIFdBUk4pIFwKIAlGVU5DKFpFUk9fUEFEREVEX0ZJTEVNT0RF
LCBXQVJOKSBcCiAJRlVOQyhOVUxfSU5fQ09NTUlULCBXQVJOKSBcCisJRlVOQyhEQVRFX09SREVS
SU5HLCBXQVJOKSBcCiAJLyogaW5mb3MgKHJlcG9ydGVkIGFzIHdhcm5pbmdzLCBidXQgaWdub3Jl
ZCBieSBkZWZhdWx0KSAqLyBcCiAJRlVOQyhCQURfVEFHX05BTUUsIElORk8pIFwKIAlGVU5DKE1J
U1NJTkdfVEFHR0VSX0VOVFJZLCBJTkZPKQpAQCAtNjA0LDYgKzYwNSwxNyBAQCBzdGF0aWMgaW50
IGZzY2tfaWRlbnQoY29uc3QgY2hhciAqKmlkZW50LCBzdHJ1Y3Qgb2JqZWN0ICpvYmosIHN0cnVj
dCBmc2NrX29wdGlvbgogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBmc2NrX2NvbW1pdF9k
YXRlKHN0cnVjdCBmc2NrX29wdGlvbnMgKm9wdGlvbnMsIHN0cnVjdCBjb21taXQgKmNvbW1pdCkK
K3sKKwlzdHJ1Y3QgY29tbWl0X2xpc3QgKnA7CisKKwlmb3IgKHAgPSBjb21taXQtPnBhcmVudHM7
IHA7IHAgPSBwLT5uZXh0KSB7CisJCXN0cnVjdCBjb21taXQgKnBhcmVudCA9IHAtPml0ZW07CisJ
CWlmIChjb21taXQtPmRhdGUgPCBwYXJlbnQtPmRhdGUpCisJCQlyZXBvcnQob3B0aW9ucywgJmNv
bW1pdC0+b2JqZWN0LCBGU0NLX01TR19EQVRFX09SREVSSU5HLCAiQmFkIGNvbW1pdCBkYXRlIG9y
ZGVyaW5nIHdpdGggcGFyZW50Iik7CisJfQorfQorCiBzdGF0aWMgaW50IGZzY2tfY29tbWl0X2J1
ZmZlcihzdHJ1Y3QgY29tbWl0ICpjb21taXQsIGNvbnN0IGNoYXIgKmJ1ZmZlciwKIAl1bnNpZ25l
ZCBsb25nIHNpemUsIHN0cnVjdCBmc2NrX29wdGlvbnMgKm9wdGlvbnMpCiB7CkBAIC02NTAsNiAr
NjYyLDcgQEAgc3RhdGljIGludCBmc2NrX2NvbW1pdF9idWZmZXIoc3RydWN0IGNvbW1pdCAqY29t
bWl0LCBjb25zdCBjaGFyICpidWZmZXIsCiAJCQkJcmV0dXJuIGVycjsKIAkJfQogCX0KKwlmc2Nr
X2NvbW1pdF9kYXRlKG9wdGlvbnMsIGNvbW1pdCk7CiAJYXV0aG9yX2NvdW50ID0gMDsKIAl3aGls
ZSAoc2tpcF9wcmVmaXgoYnVmZmVyLCAiYXV0aG9yICIsICZidWZmZXIpKSB7CiAJCWF1dGhvcl9j
b3VudCsrOwo=
--001a11371390990246053682d1c4--
