Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F6A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeCPSFu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:05:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeCPSFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:05:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id z9so4553134wmb.3;
        Fri, 16 Mar 2018 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a/ivzdOnbuVMyKjEYL1WtOR7JH2fAoGPU+lvpfkGgS8=;
        b=KAbvzCbUkEa44AijS8TGmyvh7BnTslzZDJ4ezWGAd2T594CLgIc77xVD5qLg9RCwvO
         WGW6ypJkvTzbHy+9NXyLJ+WjDzTD9wLggemWkHvzeyCY6HcwHsp+NdE5829T2BO9QhY3
         0MMfgL4GrRPF0OGY6vl9px2CxDj5pHrTV5GcvmzHO163IRehvkDwQLyIwmEyzYynyRXL
         qepxk+ndu1YqHb0RvhbBbut44Jt1CQulml3AeuEPwEHB9yzLMHsiwAiAbuWcwURsRYfb
         a7VghgbArVg2A4FM2B1mhn8ognUuXLArJg9VW8XIKmvk88o95UV1o247TRFnAHBdOoyG
         cDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a/ivzdOnbuVMyKjEYL1WtOR7JH2fAoGPU+lvpfkGgS8=;
        b=KIC/OQp3qCnoQPMvWS6xdeOUFL2KTDJgyHLszXnuhyoxk6dwuVMiHhUpzXt5IBkG8D
         0CPR+/FWi1pAxC00qjEsTtYqzTkEExwOh9DzIsF2+1R9bTz+HaKeTTTXz7uNLgVZ+YND
         BvXguX1DQph3NJ6oQCc3YB6yiiaE4w4Vd3zLrZ4F1YcNOT8kyyfjvk8wRlejp9VkrO9J
         z8BwCxeUmTzL/yk05MaDrx2sgXyzd6ZBimo8PKVqpcpYPqqnnkNwaxg0ZzzXW6jliy+W
         77J7/LocNUFnLrsNINhSMbCROOCqT/xE1xVa6TbdOHBHst+7Mt4aj9Y8TokyVJGczTxo
         s2AQ==
X-Gm-Message-State: AElRT7FZxrR+p5YGIXmoAlFLpaXKvrTdrygl9pjtM2xPnBUkWiX4NYjW
        YELaqbqMDqVyE5Wjy6lefAQ=
X-Google-Smtp-Source: AG47ELv2KqOjtR6WtcJsLl7EpSWpCqu0C8QqOnDLvVc6e+6d1O4NP3y11B/f61qVtQShde+XU0zjcg==
X-Received: by 10.28.230.79 with SMTP id d76mr2461979wmh.161.1521223547362;
        Fri, 16 Mar 2018 11:05:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 140sm9666640wmi.34.2018.03.16.11.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 11:05:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.17.0-rc0
References: <xmqqwoyc3kir.fsf@gitster-ct.c.googlers.com>
        <87fu50e0ht.fsf@evledraar.gmail.com>
Date:   Fri, 16 Mar 2018 11:05:45 -0700
In-Reply-To: <87fu50e0ht.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 16 Mar 2018 12:14:06 +0100")
Message-ID: <xmqqbmfn3ngm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Mar 16 2018, Junio C. Hamano jotted:
>
>>       gitweb: hard-depend on the Digest::MD5 5.8 module
>
> I've just noticed this now, but while this module is in 5.8 RedHat's
> butchered perl doesn't have it in the base system, thus this introduces
> the do-we-even-care regression that git's full test suite won't pass on
> a RedHat (or CentOS) base system, because the gitweb tests will fail to
> "use" Digest::MD5.
>
> I'm slightly leaning towards not caring about it, since there's no other
> perl distributor that does this sort of split-out of the core, and if
> you're on a RedHat system they're solving your package problems, so this
> really only impacts the edge case of git developers and redhat
> packagers, both of whom can just do "yum install -y perl-Digest-MD5" to
> fix it.

Thanks for noting.  I agree that this is not something that requires
more than a mention near the beginning of release notes.

I haven't wordsmithed it fully, but it should say something along
the lines of ...

 Documentation/RelNotes/2.16.0.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 8f0461eefd..8b4c24200b 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -6,6 +6,16 @@ Backward compatibility notes and other notable changes.
  * Use of an empty string as a pathspec element that is used for
    'everything matches' is now an error.
 
+ * Part of Git that depends on Perl have required at least Perl 5.8
+   since Git v1.7.4 released in 2010, but we used to assume some core
+   modules from Perl distribution may not exist on the system and did
+   a conditional "eval { require <<module>> }"; we no longer do this.
+   On a platform that ships a stripped-down Perl by default, the user
+   may have to install modules the platform chooses not to ship as
+   part of its core (e.g. Digest::MD5, File::Temp, File::Spec,
+   Net::SMTP, NET::Domain).  RedHat/CentOS excludes Digest::MD5 from
+   its base installation, for example.
+
 
 Updates since v2.15
 -------------------

