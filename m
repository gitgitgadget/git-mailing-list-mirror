Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646D72013A
	for <e@80x24.org>; Fri, 17 Feb 2017 09:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbdBQJ3m (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 04:29:42 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35158 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdBQJ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 04:29:41 -0500
Received: by mail-yw0-f170.google.com with SMTP id l19so20585579ywc.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J1T7pmwjlFpJxhbMtra/ycZQu4khTv56JEz0UuwiPeI=;
        b=cDHg9E078p4qdovC8bgFaUC+HGzleme7toe+OtsNxw6IWGw6ZfADrf9zstne8hC5Q6
         o/UwqQnextLwQOJyt+OWRt5YksXyP6dTluLr9dp+hz4vx0EZPBSODrjCVnjPM4CMKk5w
         ccTASpJDotxU0rvgjjpddzT55iTPLzdXPS7OATCCsPZPqr+ZuofxyrKM1WjwMEAAR2y4
         5xP7lllOMw8IcFkUqjVxhLkmem1+xxQ8IfPZjxeu/zmTq3wbJvSNySrR79LrZBMCYhfA
         MlACqQRJPPXXZ8gzcjLp66TivJ+ZDJsloMZSHYqE2mjErdYjizj+/MeCKRccSXwfBDlg
         FjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J1T7pmwjlFpJxhbMtra/ycZQu4khTv56JEz0UuwiPeI=;
        b=CqfwYpcL8pM6p46fTOc0z3KhSTQuEd5tDozmlbbJEhWJTyTSo+zoBEzVFfn9NUB8+z
         WADqY1yq+dFFFoMXChop//ODNJ/voVfZ8eGyfAh3XCUphwd43f1WO9r+vC4p+FajSGZU
         iWP2GWfyk4Nt1MhH+HvgMX3lE+iZaltNItlRc8k+v6yNJIDfAkrhSHiwqN5eC7IrCq0f
         4wXoReB21eWYvYno2XbrQWGq62HuYCpCNrEC/qDAzVmXWouEOSyB2ZtrSPl+3Lgbbk+e
         Y50We6bbbe4xUa8BIedDU07jKhzUfJxH9l9OIJw6cKY4AfwxHlJKHV3IcdTlcWL2b4IA
         oSLg==
X-Gm-Message-State: AMke39nS08W3x29udnmA5pzDBS9AFgnFMjR5sw0Zm8wCHDCCCJbHeHdtKy+kn4sTr7svvK3GlZXgxEQtyAYfXw==
X-Received: by 10.129.165.201 with SMTP id c192mr5015147ywh.192.1487323780136;
 Fri, 17 Feb 2017 01:29:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.25.12 with HTTP; Fri, 17 Feb 2017 01:28:59 -0800 (PST)
In-Reply-To: <20170217092616.ulassn3472stbfga@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com> <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com> <20160629220049.GA4416@sigill.intra.peff.net>
 <578EC0CA.8060501@gmail.com> <20160720130231.GB17469@sigill.intra.peff.net>
 <CANQwDwfk2k+qGtx-_RqoLKObAgyV+ebE57UAd-VXDv86HDw2vg@mail.gmail.com> <20170217092616.ulassn3472stbfga@sigill.intra.peff.net>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Fri, 17 Feb 2017 10:28:59 +0100
Message-ID: <CANQwDwe258tbv0cfPs5YQwu_KOt275X-c4-oMQLDqYVTVHqd=g@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 February 2017 at 10:26, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 04, 2017 at 02:43:01PM +0100, Jakub Nar=C4=99bski wrote:
>
>> >>>> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it =
still
>> >>>> limited to object counting?
>> >>>
>> >>> At GitHub we are using them for --contains analysis, along with mass
>> >>> ahead/behind (e.g., as in https://github.com/gitster/git/branches). =
My
>> >>> plan is to send patches upstream, but they need some cleanup first.
>> >>
>> >> Ping. have you got time to clean up those patches?
>> >
>> > No, I haven't. Don't hold your breath; it's something I hope to work o=
n
>> > in the next 6 months, not the next 6 weeks.
>>
>> Ping, Was there any progress on this front? It is now almost 6 months
>> later...
>>
>> Could those patches be made available in a "dirty" form?
>
> I just pushed them up to the "jk/ahead-behind" branch of
> https://github.com/peff/git.
>
> They were originally done on top of v1.9.1, but I forward-ported them to
> the current "master" just now. The result compiles, but I haven't really
> tested it extensively. Caveat applier.

Thanks a lot! I'll check this out.

--=20
Jakub Narebski
