Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3464C20437
	for <e@80x24.org>; Tue, 31 Oct 2017 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbdJaQbZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 12:31:25 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:46182 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJaQbY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 12:31:24 -0400
Received: by mail-yw0-f182.google.com with SMTP id t71so15247517ywc.3
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=VQpWuikov+if99f9NTzbls4j1LLZvZjfJzetKNtso6w=;
        b=NHaMyRSweRQv0jPBCn9WrxpqiKHD11/j5zgpnPIk/oLKuMa1vOPgHJeMR58YAty7/v
         5iqxQcsnck5QNHmBDljoK45t9NAtuv7kk5aqA+U3AQ+LCYSEmpF9o6I/IhVYTBcwt7R6
         +OSSdMRTZZFq3NRzVy1c60udLcbLu30fqb5vH8t2iXVRgBbqKfGy+bQrhxhbrONmlfT+
         pskjAndQeYSzEh3DaN1avg31ZiSowzR4PH9+1XGnAfXP3IPNJJiVE3Jce0nZUTMMP+2h
         9OQRLVDbM1EEASXNccaiGDeSbl5MLmKN4rTk5lUVuJgjzJlu8DcY49QNj6Si8ZmisH0y
         ynuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=VQpWuikov+if99f9NTzbls4j1LLZvZjfJzetKNtso6w=;
        b=jNsROxFP2ehnWniQPABLem9NAVufcXrkdRohE172cBMBtlDfbuUQoUxBTKOLGHjxn/
         8Fo4cp3wKPNpQi3NcE1QFVkS538apOOWyqtdSt1n/HBRIP31OwXbLD27coMAMe1Clpl9
         P+Ziy5wKdyEzkODwWsFhhQ4p14KDVhkN+yLgFzIwGjf/YlXBrcTWMVuj42eYvKyb0Far
         EISP5XsXhg8ehnj8EX9eW3KAKt2ksKFtAqg6ElhtoUbB1AzIV8575hDpoRige7+Csh/K
         ++a4xT4ZU9WUF+qyvrXkmYXbx3yrS6GzFSN96XGL0zYfGaiQePaMogqZQfp2TGnxUvme
         n9gA==
X-Gm-Message-State: AMCzsaUUy5KIkSAt/b2D515ZbJEFeyQOegylMEaOOX+ZYr1gAvjkCQT8
        gkXEoXm7lA5E1sKakb8vWOS4hP2Qo4wfFr+30lI91hTI
X-Google-Smtp-Source: ABhQp+RMn4pXTJj2mfUQ7wAs63MyH8dfo1xUnYsuS3ar+8vaLZuqW36d5gstdfbQcNpN+0wDPFiPd6p0PaAnSuYPaTM=
X-Received: by 10.129.36.1 with SMTP id k1mr1612048ywk.485.1509467483465; Tue,
 31 Oct 2017 09:31:23 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Tue, 31 Oct 2017 09:31:22 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 31 Oct 2017 11:31:22 -0500
X-Google-Sender-Auth: DvbWcsJ2R5rbAxh4lGgOCiTKx00
Message-ID: <CAHd499AsY30b8LuCvjap-mZyzBEVsjK__We6Yh-y=5GqijObhw@mail.gmail.com>
Subject: How to resolve mixture of modified and deleted conflicts easily in git?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a rebase, sometimes I will get `DU` and `UU` conflicts
(locally deleted and locally modified, respectively). Furthermore, in
some of these cases, I want to take "ours" for all conflicts,
including ones where the local file is deleted. Ideally, it's just one
command:

    $ git checkout --ours .

However, this fails for the locally deleted conflicts:

    error: path 'foo.xml' does not have our version

Even more annoyingly, the fact that these failures occur prevents the
`UU` conflicts from being resolved. The whole operation fails
atomically. I am not aware of a straightforward and uniform way to
resolve conflicts with "ours" during a rebase when locally deleted
files exist in the list of conflicts. What is the most elegant
solution in this situation?

I'm running Git for Windows v2.13.1.
