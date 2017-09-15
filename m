Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D1D20A21
	for <e@80x24.org>; Fri, 15 Sep 2017 01:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdIOBun (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 21:50:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:49222 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdIOBum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 21:50:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id l188so633722pfc.6
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Np8XOxbnUXlo11kK/0sDrAebtn25gRqgpEAMYD/KDeU=;
        b=TTWszHDj82JnRzmR9Qn4RfA2HEB1DscUPPAMY5LlGCXVpHkc50p5bKc8TS2gBzgwxA
         4JS7W/g+EbKtBjZX1W+eJMJQyNA8wbbniiNv4BF7Or+YE+Ln7NhhKIkyJoj71wUw3TFy
         QF5+hdgRdkEKAfS6N78IvLBjkivHcFawXYPhjOprfM3nFE2MgUHpNLha7K10rZWKnJBt
         7a+vzFmFu2aplTZZgi7TP6XL4uQEug2mHJk67FMH/iw1PCul1GYhVFdD9deg1bbqe2GT
         OdnAW4mps9f6QEtLAB+4S/ET6euq3b+UxMDPfcmie42E2Cybn/fXDajjgWory2Hrq5co
         HX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Np8XOxbnUXlo11kK/0sDrAebtn25gRqgpEAMYD/KDeU=;
        b=FcvTGQWufMT07CoUzDgpqaEsCBFGrMjnsicI4rtyV/vMZbFxbIKMgOQCvnbUPnDx83
         QK4E4gnwaaBDqnm0D+yg0NOvroRnMSFOwfIC8ANXuk8OrUJpH+LI/An2bU7ABnqvImFP
         OAQm913krnvQkpG3HomnWaAPdYt/YBuLHtqXayDiEuXTd8j9P2mVotRPqxNVLnrWJTRR
         2baYVXAlBzWceNIxeRngkH37S6QFRGXYJubEPXyu8AVY8evbvWUVE5lxvnKPxTJvwztV
         lJQE6BiG863Uzn+tpdgwfDPGKtfpHaTD70Q6e3IWjH3sojluS4rwU88ccgnhB8fyYaF9
         +RGQ==
X-Gm-Message-State: AHPjjUh6Tg3C95llDFT9mbmYIoT//xqHrBcUmpNoP1KqxzyKlEeIQAhV
        UFITj1ExAZ75WA==
X-Google-Smtp-Source: ADKCNb6uL2MUFf8ta5D9J5IrqtWk+kfwb8nVzOlySfJL6pCJxqClWCn71wQCs9wiUnFlfRw/BqLJDQ==
X-Received: by 10.84.194.131 with SMTP id h3mr18049723pld.352.1505440241583;
        Thu, 14 Sep 2017 18:50:41 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id f9sm2899152pfe.150.2017.09.14.18.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Sep 2017 18:50:40 -0700 (PDT)
Message-ID: <1505440235.1862.9.camel@gmail.com>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Joseph Dunne <jdunne525@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com>
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
         <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
         <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 15 Sep 2017 07:20:35 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-09-12 at 13:24 -0500, Joseph Dunne wrote:
> Sorry I don't understand your question.  The commit-msg hook runs
> properly in all cases except when I perform a merge with the --no-ff
> option enabled.
> 

It's working just as the documentation says it does (emphasis mine),


    This hook is invoked by **git commit**, and can be bypassed with the --no-verify option.
    It takes a single parameter, the name of the file that holds the proposed commit log
    message. Exiting with a non-zero status causes the git commit to abort.


    It says that 'commit-msg' hook is invoked only for a "commit" (it's not
    a MERGE-msg hook you see, it doesn't exist anyway). In case you see the
    hook getting invoked for a merge then that's an issue, I guess. For
    what kind of merges do you see the 'commit-msg' hook getting invoked? 

        -- 
        Kaartic
