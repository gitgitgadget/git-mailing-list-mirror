Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB430202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdB1Wfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:35:39 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33631 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdB1Wff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:35:35 -0500
Received: by mail-pf0-f180.google.com with SMTP id w189so5824724pfb.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3wro5wgP0M/xNbdVDKdRA2Un6cAWr9arHBtfRYSLNgg=;
        b=GUbPUa0Eic8kRlmiql1j93cIY/7qEKVfdff9uNhElQ4xeYVc+3NvqyeTjdSCtvvJr6
         BLPmp8t6P/oQQziZnnhry4E+FH93JDtcjefjI9wZBi3Qg2k0uTM/pAmfOTXAp5JkxTi9
         4La2RqQYN9oADhjY7RN5cLc+isZUv0I8J0zE4XrCyVmr7kQnxNah28YjXVNOXYmA5dtk
         9TcyhIXhB0NbLm7XDBNApB0VPxx9nDFCNpUBLC/j59/HCjmvszrqly+prfiRaGf6F2OZ
         NmVojTFiZHccp4SGPps8Ly8vupdgBo8HxSbz/nNEOZ7JEtCtWhT2D5GnP/AaHonm1JXU
         nZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3wro5wgP0M/xNbdVDKdRA2Un6cAWr9arHBtfRYSLNgg=;
        b=a1CnoPi6CVSDXzIVwInZ9YQoxltJ3/rouWAKAaPRi9asiEDMY7nD9soDaoeNLsp6f9
         JWqlvM2tGjvreS3c1y0T205R+AWN0bM0JrC2xY3ke13beWexqPhdpgdtJej/W+dT8G57
         zURPf2dU1DmzDiHi4/YTKlI1c9sZf2H7gqjEddN/A2OwA9XmVmt2rGzhfiwj2AKY3mzi
         pmhdE8ltApvEI6IB6CVBou4X/LCySkFePazJVg271lPaikgMHMJw1kdeSwCt/RuEf0+O
         Ez7zqf6GSgtep06AhHHzSxnokv+WyRHSwgZR7agqTcj97yGyu/oIQzyuyDrkEcxJiNXE
         5OUg==
X-Gm-Message-State: AMke39kvS0pdGCrmjr+sHNdqHcxniM5K+v7V5237ZEKlAjZ5q3DOgkP9lfl0dgCustMaXw==
X-Received: by 10.99.125.19 with SMTP id y19mr4370244pgc.79.1488310436784;
        Tue, 28 Feb 2017 11:33:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id 187sm5781851pff.17.2017.02.28.11.33.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 11:33:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adrian Dudau <Adrian.Dudau@enea.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: format-patch subject-prefix gets truncated when using the --numbered flag
References: <1488297556.2955.11.camel@enea.com>
        <xmqqinnuky9e.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 28 Feb 2017 11:33:55 -0800
In-Reply-To: <xmqqinnuky9e.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 28 Feb 2017 09:42:37 -0800")
Message-ID: <xmqqzih6jejg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Adrian Dudau <Adrian.Dudau@enea.com> writes:
>
>> I noticed that the --subject-prefix string gets truncated sometimes,
>> but only when using the --numbered flat. Here's an example:
>>
>> addu@sestofb11:/data/fb/addu/git$ export longm="very very very very
>> very very very very very very very very very very long prefix"
>
> This looks like "dr, my arm hurts when I twist it this way---don't
> do that then" ;-).  Truncation is designed and intended to preserve
> space for the real title of commit.
> 
> Having said that...
> ...
> I think this is just an old oversight.  The latter should have been
> even shorter than the former one (or the former should be longer
> than the latter) to account for the width of the counter e.g. 01/27.

And having said all that, if we really want to allow overlong
subject prefix that would end up hiding the real title of the patch,
a modern way to do so would be to use xstrfmt() like the attached
toy-patch does.  Note that this is merely a small first step---you'd
notice that "subject" is kept around as a "static" and only freed
upon entry to this function for the second time, to preserve the
ownership model of the original code.  In a real "fix" (if this
needs to be "fixed", that is), I think the ownership model of the
storage used for *subject_p and *extra_headers_p needs to be updated
so that it will become caller's responsibility to free them
(similarly, the ownership model of opt->diffopt.stat_sep that is
assigned the address of the static buffer[] in the same function
needs to be revisited).

That "buffer" thing I think would need to be a bit more careful even
in the current code, which _does_ use snprintf() correctly to avoid
overflowing the buffer[], by the way.  If you have an overlong
opt->mime_boundary, the resulting "e-mail" looking output can become
structurely broken.  The truncation may happen way before the full
line for Content-Transfer-Encoding: is written, for example.

So this function seems to have a lot more graver problems that need
to be looked at.

 log-tree.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 8c2415747a..24c98f5a80 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -337,29 +337,23 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p)
 {
-	const char *subject = NULL;
+	static const char *subject = NULL;
 	const char *extra_headers = opt->extra_headers;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      &null_oid : &commit->object.oid);
 
+	free((void *)subject);
 	*need_8bit_cte_p = 0; /* unknown */
 	if (opt->total > 0) {
-		static char buffer[64];
-		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s%s%0*d/%d] ",
-			 opt->subject_prefix,
-			 *opt->subject_prefix ? " " : "",
-			 digits_in_number(opt->total),
-			 opt->nr, opt->total);
-		subject = buffer;
+		subject = xstrfmt("Subject: [%s%s%0*d/%d] ",
+				  opt->subject_prefix,
+				  *opt->subject_prefix ? " " : "",
+				  digits_in_number(opt->total),
+				  opt->nr, opt->total);
 	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
-		static char buffer[256];
-		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s] ",
-			 opt->subject_prefix);
-		subject = buffer;
+		subject = xstrfmt("Subject: [%s] ", opt->subject_prefix);
 	} else {
-		subject = "Subject: ";
+		subject = xstrdup("Subject: ");
 	}
 
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
