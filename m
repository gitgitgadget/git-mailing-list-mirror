Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27AC2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 02:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935205AbcJ0CWj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 22:22:39 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36522 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbcJ0CWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 22:22:37 -0400
Received: by mail-qt0-f179.google.com with SMTP id 12so13932946qtm.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dCmMU5DKm/+yskWbWGQjEHGgz+x/QbsHOIKHoNCIQfI=;
        b=Netzh+QgykpSEh1NqzaAS8EaT7S3KYSsEHD9TZiDuP8mFNY+VdCFykr21ASILTjOa7
         lhhEg+BW3v2EQrM2nTuqTLqjWsRwevSm4fTMWOehBYFwIt6eh0lqvWMFG6Lc0N/Fjw/d
         1/GehJ1kLDx1rxCWPdVYxVqQ3IUIUvp5gDKAisijhOGRMzh8Jah+X4luLEDE7CcHS4i1
         rTTNhtJP4khRdyPmn9eRFJBDqfO13bKe+fz3aC1XYKJRrx310S7Zth2nLMJEp22zpVg5
         Kcb/Oj6Qo+V141Wx8mOmOB39SvqitH4YzXuDETshEfRgIoQx89fqpC/uVEB6GuE8CVLu
         MngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dCmMU5DKm/+yskWbWGQjEHGgz+x/QbsHOIKHoNCIQfI=;
        b=XfMujYObcnRu7hJrtsOMkQabIFlrcazT5SDc/8NBaCaMJruWktqVPoRoMYssWcgav+
         9TwS61faH0AKCNslOujeEwfU4lRUPd9xBrce6TVlTav644ejp0NEYK3jKyu7lLVBD5QZ
         sisSBbr1Sf5sFnJC8UM5OIWpggcxNnOBLvCPSroSVlboK7cQxsf7h21SSpEQNI1ou03x
         nJnS/Ts9tJh6E9iYvUBcTViY4wjgokOlTLIbpuCMX7QL0zpgeP+kg5aJOOgv9w8QZ814
         WsD+U/FHB3rTMi8/i3127Skxn4A3cbD1Zqqfp5M9AqaSvsKO62O/nc7mUH7aiIRWIz37
         pECQ==
X-Gm-Message-State: ABUngvcARO/7btvw0m3+Ki9lBsdRBDPAyTI+7N0JhdZAywi37yJhkCGiaZQUoPvywPupPL6GyUuvmplkn356Y5Dz
X-Received: by 10.200.51.240 with SMTP id d45mr4368933qtb.18.1477534956831;
 Wed, 26 Oct 2016 19:22:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 19:22:36 -0700 (PDT)
In-Reply-To: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 19:22:36 -0700
Message-ID: <CAGZ79kasr6ubuOm01rLtdK7pfWqriZE1vioLyxAr2G2Hd1xGhg@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Aaron Pelly <aaron@pelly.co>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The use case for this is where I did not write my own rules, but I want
> to keep them updated. https://github.com/github/gitignore is a damn good
> resource, but I want to pull it and include relevant bits project by
> project and/or system wide. I don't want to have to update many projects
> manually if that, or any other, repo changes.

.git/info/exclude could be a (sym)link to an up to date version
of the gitignore repo as a hack?
