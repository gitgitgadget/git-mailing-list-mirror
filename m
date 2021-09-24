Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABBC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9256103D
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348353AbhIXUIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346803AbhIXUIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:08:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722EC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:07:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dj4so40478989edb.5
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KJ/BzqOVyHPFONbAOk/DcVqpWMOvZi0F0BK5b0zeqdY=;
        b=CktTHHXkFbV9J2ZaCYznCTB/kpRmV6nar7zAssDiuwisLg9ewsoKG9ievByQd8m+zW
         0pIy96NMK5axgswMSjnFNCcffeEiE97bJerLlzVMI8uAUOxx8BDkVC0pHLnpTcxl8/nl
         I182i2Efv/4HpB3VqrhN13KhHFM+Kmqxdt5qt2FaJeW9nziisVGwGRZDrKAyPV+Giisc
         HDiYoI9ib/BHYIgkcM3GYUf62FeqKVAp5SreilbHzvNFg2afKljFyhX6wTSSiLzT4wJM
         nV57RijoSwKfVe1p/dgXeJ/kpTvy+e3yNFcmkbCgcFIn64IfLtBh4XY1B4K8utSjB+Nd
         O1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KJ/BzqOVyHPFONbAOk/DcVqpWMOvZi0F0BK5b0zeqdY=;
        b=irVQCXCKoia/8O/E2N9c+I8gH6W9j1AYPJFswZvr6HZh/qB4xfmZ4MLEMaicExGv0X
         PS987zpkYxjKt9y+ydiyaI7bBMTiyH65b4KpizwmW7EZ1bxvygCK0T3zd5rgHltAzflB
         WMhYF33uNhU6MTycCHqQbK26zDB+YHxzL5HXocHZwWJ+/O2zhlIFC5V54458y/M9lvFY
         7MBwvO+iP+YZ/1q6kjgOFIuKZimwlUyvhC2mLEBtPcJkBlGazmUl/Xd0nY3pbswsK2RP
         pqj0oWLSYu/IQIpGQM6+JScW8nXjv9OGhkzcV6YaNl0DkZeld6PCWS9KUeWN6VScV2jD
         89/w==
X-Gm-Message-State: AOAM530I6Z9dZZGkMYCJmzC1rEsik1NyWheEBYNNRH96BAlm1Ml4MGKc
        vVuuhUMTJhMpnR4PD1loAlJGzMLerrANxQ==
X-Google-Smtp-Source: ABdhPJxg0w2LkfGklhlxQznUvH7XOpnWLnuUT2nUXzA8lFEIeUdsRholaytY+ld5Rz5jA+9jui1qyg==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr7288758edk.154.1632514033453;
        Fri, 24 Sep 2021 13:07:13 -0700 (PDT)
Received: from evledraar ([109.38.130.174])
        by smtp.gmail.com with ESMTPSA id d15sm5450583ejo.4.2021.09.24.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:07:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] send-email: shell completion improvements
Date:   Fri, 24 Sep 2021 22:02:25 +0200
References: <87zgs34ccx.fsf@evledraar.gmail.com>
 <20210924024606.20542-1-tbperrotta@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210924024606.20542-1-tbperrotta@gmail.com>
Message-ID: <87bl4h3fgv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021, Thiago Perrotta wrote:

> Thanks for the heads up, I am slowly getting used to this email
> workflow, this is my first contribution. Hopefully I got it right this
> time.
>
>> Isn't this just:
>
>> my @params = <getopts list>;
>> GetOptions(@params);
>
> Let me know if the regex approach I went with is OK. You seem to have
> suggested me to do something with the `GetOptions` module, but I'm
> afraid I only know the basics of Perl.
>
> I tried to do something like `GetOptions($USAGE)` but it didn't quite
> work (clearly I have no idea how to do that :P). If you have something
> specific in mind, I'd appreciate if you could send a small patch back
> that I can incorporate. Otherwise, either way, the current regex
> approach isn't too horrible and seems to be reasonably reliable.

I meant something like the below patch, feel free to incorporate it if
you'd like with my signed-off-by, i.e. there's no reason to parse the
usage message, or hardcode another set of options, we've got it right
there as structured program data being fed to the GetOptions() function.

All we need to do is to assign that to a hash, and use it both for
emitting the help and to call GetOptions().

What I have doesn't *quite* work, i.e. the --git-completion-helper
expects "--foo=" I think for things that are "foo=s" in perl, so the
regex needs adjusting, but that should be an easy addition on top.

-- >8 --
diff --git a/git-send-email.perl b/git-send-email.perl
index 5262d88ee32..221115fbbdd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,8 +114,18 @@ sub usage {
 }
 
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
-    exit(0);
+	my ($options) = @_;
+
+	my @gse_options = sort map {
+		"--$_"
+	} map {
+		s/(?:[:=][si]|!)$//;
+		split /\|/, $_;
+	} keys %$options;
+	my @fpa_options = Git::command('format-patch', '--git-completion-helper');
+	my @options = sort @gse_options, @fpa_options;
+	print "@options\n";
+	exit(0);
 }
 
 # most mail servers generate the Date: header, but not all...
@@ -449,7 +459,7 @@ sub config_regexp {
 usage() unless $rc;
 die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
-$rc = GetOptions(
+my %options = (
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_in_reply_to,
 		    "reply-to=s" => \$reply_to,
@@ -508,7 +518,8 @@ sub config_regexp {
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
-	 );
+);
+$rc = GetOptions(%options);
 
 # Munge any "either config or getopt, not both" variables
 my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
@@ -516,7 +527,7 @@ sub config_regexp {
 my @initial_bcc = @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bcc);
 
 usage() if $help;
-completion_helper() if $git_completion_helper;
+completion_helper(\%options) if $git_completion_helper;
 unless ($rc) {
     usage();
 }
