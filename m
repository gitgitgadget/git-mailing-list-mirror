Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C4E1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 23:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdEPXWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 19:22:53 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33469 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdEPXWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 19:22:53 -0400
Received: by mail-lf0-f54.google.com with SMTP id m18so20195733lfj.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=FedsgBo3L3k3o/0LDro9mpcWsf/EJD8gCBpc2vXgNoI=;
        b=a/uG8qErLdUC3i8iVaWwxTHkyu+1//w/AmA+I3bB7ZU9m2bt+cNuEBkHDJnf1kCz5u
         iFxay7uDYmUhcgb/ojF7DBXWJTJvO8ZBA9ecMxoww4XTLcXST0tgt8avkEe+ml2Tf9Gv
         TtBVo2qGl/bMqEcZAswx7ut0Z8dFFlAzzNMkPJ2L+nrT+HmD85Ext6GvZaEWg2FLAcVi
         DgNsixueYY9Ld7V7BGrCb8riAB0rcQ++hGn67Y2POQvW71Z/11CW37wjaRSheUcJUcoG
         +SSZ73dCTwBaUrXlLV5gKQV7vNfYViq9Yi2M8cOTI7wwSFctl0FQ+SB/blZncMy+wthp
         qqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=FedsgBo3L3k3o/0LDro9mpcWsf/EJD8gCBpc2vXgNoI=;
        b=pFFAmQWrouIsApskpPNDmIegYRlRiRGD9btv40kzBkmR1aW/6ww037YCkuGcp6A6vK
         KVJV1vTlSFG68Tp/SQYg+Yn2RpNRphf60SU7JL4xs2RLyZ5Xq4w7yEzAvKO+9oibXea9
         9gPZ+ogeshTAHfXw2TlThaVZzq2CkkQqTbwrgNaJmo4WTMAVqJDi4vbZMBZacJvnyD1G
         Lty3bUP4LAgnz9exfXomjZG8AC0Ikiq0huhsOsPT5iDuz2ZpB7b7Z6P4Z1kB+iiSkqyo
         dVmIOCHjwl57BbNVN68DRMn8bS2ARWeKrs+746m+q1KFWmjF4WRULLsBBkk/M48AkH0B
         c+Lw==
X-Gm-Message-State: AODbwcDbxC3yReJeaUV6mnSnOdsJpRPwD14ottwPb+lAQaUSFh075J9D
        7DLC9bqHRH7afoaBjWeWfYtd1fPHpMDhgY8=
X-Received: by 10.46.71.14 with SMTP id u14mr113562lja.104.1494976971251; Tue,
 16 May 2017 16:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.20.93 with HTTP; Tue, 16 May 2017 16:22:50 -0700 (PDT)
From:   Animi Vulpis <animi.vulpis@gmail.com>
Date:   Wed, 17 May 2017 01:22:50 +0200
X-Google-Sender-Auth: pVmOv0phhJTcAkOwSNtQRRr79vc
Message-ID: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
Subject: [Bug] git branch -v has problems with carriage returns
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I upgraded to git v2.13.0 and since then git branch -v has problems
with carriage returns in subject lines.

We are using gitlab (not the newest version). So this bug (It's about
carriage returns in auto-generated merge messages (\r\n)) is not yet
fixed in our version:
https://gitlab.com/gitlab-org/gitlab-ce/issues/31671
That's were the carriage returns are coming from.

In my specific case the auto-generated merge message has three lines
with empty lines in between.
So every line ends with `\r\n\r\n`

If I do `git branch -v` with such a subject line somehow the third and
second line get combined before the hash. Example:

$ git branch -v
See merge request !XXXX temp space 84e18d22fd Merge branch
'feature-XXX' into 'develop'
# <begins with third line> <ending of seconds line (if longer than
third)> <commit hash (correct)> <subject line (correct)>

Before git v2.13.0 `git branch -v` worked completely normal.

I was not able to create a minimal local example, because my manually
created \r\n in commit messages were transformed into \n\n

Please let me know if I can provide any more information that would be helpful.

Cheers
