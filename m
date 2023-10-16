Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2D31A75
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="c128TafZ"
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EFA1
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:41:05 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57bab4e9e1aso3120248eaf.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697492464; x=1698097264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvQds8YzW3T4fZEWsxWUOj7oaQ68zjgPmQI1XOUyMUU=;
        b=c128TafZ0LbTXFWSjbUrnosTJ+qpjcNKa6a5aa7Jz9Ee4sV/xCRXqHJRTBzGEx3ZBp
         r+tLPOEhqrFmYfVYhZflYEFcPHWlMK5bnNdgaTSSMehNeaIlwEaMEWqy5svZ2T5UB3S6
         v5nbASiZB64mdZTXIlz75tbASMXcHvPxADPOgvIlVUhwp+HLdrWthfLD6ergakOkMAZs
         2XQnMQ6t2w1udkWqTpazjOCoOwFrESqP+D+6QLGO06I4sEPUdJ6a/qhKDP05EFj+95zX
         iT3Lbdsu1u08ZrZx4HnPIuLkNtiRDvQtaZHr8pob89EuXvtKym12ahYdN4khj7rKura2
         rMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492464; x=1698097264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvQds8YzW3T4fZEWsxWUOj7oaQ68zjgPmQI1XOUyMUU=;
        b=MZAXkdoYGJgDT5/qA3xxOe5rIo97DsSzURfVfifklRb91zESbKfxQ7fjNQm2SauC/o
         yeqczvBDvQjC0beMqjjpHUfixRANGiFsUBzaX9OSxDyaJLQWcrvb/RuLENyd8wDJIlqT
         Ki3ZzeiV201BotiYDUfWCi//zrtKDbRDbuVkG7qT5TcjBZA5NleW76xJaLhxXOGEDaKh
         rtYMay9w306tYMDJ4CKNB/UmkViP/3zP/bPIsMl7xBUlA/H+DfLxWr213VaXSNGUi/iw
         02x28FaPjgKgqgSjjbSd/AIKTAaEXZyy1xAfqilgTEa2vtZ7Re8nrnU0654ReU/hOf6X
         OvnA==
X-Gm-Message-State: AOJu0YwJKyO5NxkDBMnz8vANIs+nPWGAARljdITSpLyNvCJo80BZItP3
	HJv4UKI4XcaIXKMPfaWe3Flb9OqrghGCzw9/K7A=
X-Google-Smtp-Source: AGHT+IFuOE9x5jexK2gNyDhypid7SESqcuyxD7NLTCDOx9+hazNefJJv37193mo3mdiszret4P8tVA==
X-Received: by 2002:a05:6358:7058:b0:166:d5af:3200 with SMTP id 24-20020a056358705800b00166d5af3200mr620051rwp.6.1697492463892;
        Mon, 16 Oct 2023 14:41:03 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b0068ffd56f705sm34574pfr.118.2023.10.16.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:41:03 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/1] bugreport: include +i in outfile suffix as needed
Date: Mon, 16 Oct 2023 14:40:44 -0700
Message-ID: <20231016214045.146862-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.297.g36452639b8
In-Reply-To: <20231015034238.100675-2-jacob@initialcommit.io>
References: <20231015034238.100675-2-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar functionality to the previous patch version but with the
following changes:

  * Remove the default_option_suffix variable and clean up the way the
    option_suffix value is set.

  * Refactor code for building report path and diagnostics zip file path
    into the new function build_path(...), which builds a fresh path
    from scratch each time it's called. Although it does take quite a few
    arguments, it reduces duplicated code and simplifies the code by
    removing the need for splicing or inserting the incrementable suffix.

  * Allow the increment value 'i' to grow as needed instead of stopping
    at 9.

  * Replace xopen() with open() so that the program doesn't die with an
    error if the file already exists.

  * Replace the while loop with a fallback loop to prevent TOCTOU.

  * Clean up commit message verbiage.

Some additional comments:

> Perhaps we should refine the error message we give in this case and
> we are done, then?

I had thought about this but due to the variable timed behavior I had
trouble coming up with a message that would convey clearly what's going
on and what the user should do. Here were some things that popped into
my head but they all sounded a bit silly to me:

"A bugreport with this name already exists, try again shortly"
or
"File exists: wait 1 minute and try again or use a custom suffix with -s"
or
"File exists: try again in 1 to 60 seconds :-P"

I think the reason they sound silly to me is that the user is only being
made aware of this info because the program happens to be operating this
way - instead of the program working in a smoother way where this type of
operational info wouldn't need to be conveyed.

> What downside do you see in using 2023-10-15-1008+10 after you tried
> 9 of them?  The code to limit the upper bound smells like a wasted
> effort that helps nobody in practice because it is "unlikely".

> And limiting the upper bound also means you now have to have extra
> code to deal with "we ran out---error out and help the user how to
> recover" anyway.

I completely agree with this and made these updates.

> Notice that you said "in a single minute" without "calendar" and the
> sentence is perfectly understandable?

I googled "calendar minute" and the only thing that came up was some
Java documentation... So I guess I just made it up... :'D

Jacob Stopak (1):
  bugreport: include +i in outfile suffix as needed

 builtin/bugreport.c | 83 +++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 26 deletions(-)


base-commit: 493f4622739e9b64f24b465b21aa85870dd9dc09
-- 
2.42.0.297.g36452639b8

