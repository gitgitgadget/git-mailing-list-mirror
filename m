Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E701FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbcKQWXd (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:23:33 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36840 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbcKQWXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:23:30 -0500
Received: by mail-qt0-f178.google.com with SMTP id w33so144917146qtc.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+rCuWYt/Hemi31exNUZROrYWoub+8xjJDupb+Pq9kFE=;
        b=eXsHH/5ANHVEK2s9slXBhRyy1NPvaKH+TARIAOoykhGGp1wZpTkHmYBa8rCRsBx2EE
         HjWBL6pmdAeP7/RFoED5Q03CZ9rqg0QEB1QnKME3v3a2o8HrafMELbPM784Zy851kShZ
         IJuu0mcflUANpcR2/sYaguEoqjx5+16Vig+21JpPia7CPzgXnmYCEn2VccM9PFPwprD+
         /SSS9RaIVTfUaPYaF86URSSnCwhV9jzyIYVmS68gEDOw4j3HXzk+Ky7IL8OW24SwItmR
         FHZ5cXnry6d1pJcgXylZkZppqNCByRpOBRgssCxtmZs5dF8FvMjULfEG4PXKv8RI32kw
         sgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+rCuWYt/Hemi31exNUZROrYWoub+8xjJDupb+Pq9kFE=;
        b=lPE2N0HEaPtbxN3inLzdYurXPDQ4y5UmIt92b5ttP0w9Vv812lskcesDjhKcU2GuzX
         zGnpvHpEdZ/S4TYOxymVfKoVGXlP6o9ieY6ScoGhINgB+O0bzBZW3MBZ3Xb1eMwbKoum
         fqemnb/9JT33l6bb82ULxxJxTu2Rp/F9gLmkpnxWplFbjV/ncMJEPZjliVx/o2zfiS4v
         3wLvOA1NNeYzZcYjYhgYy6+T9lDSk66S9m969aJ7e8dhgjFZ58Bnz08XR53u9v4sObYP
         kQ+WosAqWS7XjQjhnsifozdFn4cWKN9e9/f6NQ/+ex73AN/0BdRpIujzKci2eroujEYW
         eLzg==
X-Gm-Message-State: AKaTC00P+3UBOlGmFdcyARHiBigGFVrhddOsWTlJbbQn+CciqDsV7WoIvs0GcpoeNgEk0AN1gKh5Lxrz3Vx2x/8F
X-Received: by 10.200.37.221 with SMTP id f29mr4475395qtf.123.1479421409633;
 Thu, 17 Nov 2016 14:23:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 14:23:29 -0800 (PST)
In-Reply-To: <20161115234403.GE66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 14:23:29 -0800
Message-ID: <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 3:44 PM, Brandon Williams <bmwill@google.com> wrote:
> "to that a deleted"  did you mean "so that a deleted"

done

>> That will only work properly when the submodule uses a gitfile instead of
>> a .git directory and no untracked files are present. Otherwise the removal
>> will fail with a warning (which is just what happened until now).
>
> So if a submodule uses a .git directory then it will be ignored during
> the checkout?

Well first you get the warning:

    "cannot remove submodule '%s' because it (or one of "
    "its nested submodules) uses a .git directory"),

and in case a d/f/ conflict arises in a later stage (e.g. when the submodule
is replaced by a file or symlink), you get another related error with
less helpful description how to debug it.

>  All other submodules will actually be removed? Couldn't
> you end up in an undesirable state with a checkout effecting one
> submodule but not another?

Yes you could. Maybe it's time to add
"git submodule intern-git-dir", which can be given as a helpful hint
or even run here first.

>
> Should probably place an explicit 'extern' in the function prototype.

done
