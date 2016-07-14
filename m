Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF1720196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbcGNT1N (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:27:13 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35830 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcGNT1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:27:12 -0400
Received: by mail-io0-f175.google.com with SMTP id m101so84772865ioi.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 12:27:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9S1CVtk5ri4Hcj6igqHzPMC1wvjZqJjZfwn+vrrgZT0=;
        b=DMG+0kbxkURV8L3pRBOmsCyq0+wfDJAGeqt4u3YQ8QkgoNLOGpS9MVyEFwADS56iFz
         vJHLIU0Bbr/Q56c+kbvwKNCt3Oh6trpMBXLKn+E423hdZh/Zo7+yHIHl/5wifgzJU7mh
         6ttlazRdHFaslzMkNxV3RTJb6FzPWTSfSnW/tQ5v2l9j7gGndxsJE/+eS/TVCEbf16ma
         adWQEo3IZj5/ogP8gmJOGneROqbi+OF6icSe8trNl+qCSvsJR61814aBvLrSnIkiD05L
         7BTpVmoP2US/f4GCX6g6QxgYtTV5SzhftsP9nmVOSPkAnz3qK+uu9BKLYvgoukpeXGOz
         42AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9S1CVtk5ri4Hcj6igqHzPMC1wvjZqJjZfwn+vrrgZT0=;
        b=R7iz1v8pwIz3iMCiXYBXkJaULbvW37fsjZeQ/ZzbnF6mS1KtuTuBBzS579ACcUV0kP
         Igf9GYgKe+h4dKhwyXnJm4KaStn0ei3MXexBdq0Wz3Z4i0FgqD5jZq1G7bET5eLvb1L0
         T7doSOWaOJN9kHpr6UonAZUU36AWkGkn7sHBEvkrgwtTWJy+2TyRuQpaTGIUge65wwpI
         tF4ZEsTj5slKukLM1l09/dKx10mTsIUPCeBsfJCjHhHKpTGjUtkxwkhrDsR+gP+SOJ5r
         x+RNBpcZSCSY96bH+R+REH6gu3PwAz5DJ8PWpIF8zXmKsZL2ysZmFj1OQOQjRGbuTBfr
         t7rw==
X-Gm-Message-State: ALyK8tKBmjFFOwohsswUDbZRJRDIdBCTK2rNQhn7NZ6TknLNw1bJqMOhii0wHTvOyNke1inYaFHf12d2H+UnzjX1
X-Received: by 10.107.144.10 with SMTP id s10mr15823491iod.165.1468524431035;
 Thu, 14 Jul 2016 12:27:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 12:27:10 -0700 (PDT)
In-Reply-To: <xmqq7fcoqb5a.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fcoqb5a.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 12:27:10 -0700
Message-ID: <CAGZ79ka5ZB=vL3j0Zm3vAvdZi7jA1gPAs61NhkVABZepfcuLvw@mail.gmail.com>
Subject: Re: [PATCH] diff: document diff-filter exclusion
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 12:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In v1.8.5 days, 7f2ea5f0 (diff: allow lowercase letter to specify
> what change class to exclude, 2013-07-17) taught the "--diff-filter"
> mechanism to take lowercase letters as exclusion, but we forgot to
> document it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-options.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 3ad6404..073c7e5 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -399,6 +399,9 @@ ifndef::git-format-patch[]
>         paths are selected if there is any file that matches
>         other criteria in the comparison; if there is no file
>         that matches other criteria, nothing is selected.
> ++
> +Also, these upper-case letters can be downcased to exclude.  E.g.
> +`--diff-filter=ad` excludes added and deleted paths.
>

This looks good for the neighboring thread. :)
http://thread.gmane.org/gmane.comp.version-control.git/299512
