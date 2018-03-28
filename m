Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE671F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC1APo (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:15:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34625 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC1APn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:15:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id q9so293488pff.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QRndHMATYOCyFN/YzAKmTSMcpQcV7uG4ZIoSm9dsY6Q=;
        b=FQn9zwqqIfxnHQIb4KJDQ7WBXmA6vz8PS0eJtFoN1oNn/A6JprP0Wh8xliAcRNLUPW
         BxRLeJphXQxKCs3ETn55rk18lXpdJCWME2PF5cc6lklpvuQdE9aXl/xa8dRcmWk1N3sb
         x/W8SaHJUHPKBRyfgK7iLZwnAeGVn23lLQ4xFlFAsD27qJCTpKGKi6QOItxhexI442C/
         rJzCd1w7nYm8v1KWljVLBHSMiJthXpwBLSNwHcx89leYE1tfIadRZSihv00jIhqiClHr
         2lmxgo6ZYf52j6Q86r3GMh7E5GcMxmlhQMwo88RSSdV+AEuG01Obg2u/UjdvFLqssDIi
         wKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QRndHMATYOCyFN/YzAKmTSMcpQcV7uG4ZIoSm9dsY6Q=;
        b=hKLZ4WGmQsS+8cQoRTA0KXguD9+gEYPml8e9F1lPt2iA5ktDMFKqOf6mgKEgHobS+K
         ROq65SlkEN1+NonOSwBxI6/LlT28/W65ZeVT3bG7FUaO0LTQBQJTaqC19f1iMHxFahCc
         Ee+dW/nfPzc1dWhWWUNAqdaYiVmn96HIZCN7dXDFxu0JzOGWms2ZejslUgusA0QB55kO
         BNw67RNkzskXmYFX7ZlwKNKxm3UvnMosjdI2Wj8nsOh4IZgV/U7GqILc4OzJD7VECBYy
         y7+lEeGo56N/Jwm4wnoIwT5QisYnncavIE8Ke1irCy+RUmJlrl/TiSHs6tk3sbbK6XNq
         XH4A==
X-Gm-Message-State: AElRT7FEgt50QGXflQwaOhFOlNKW5ItNQEn1yVYyhEgqRWBCU21JNi+c
        PeFGF8E3aDKiNRatIV5bQnwzH8SB2wI=
X-Google-Smtp-Source: AIpwx48NVkUBMSF7vhaCzD6t4bQsJ1qTIDwP73wDVoxm2hun1/JaD9kXEVCPvuqGSTMBomWr7xf79g==
X-Received: by 10.98.76.68 with SMTP id z65mr1081308pfa.181.1522196142391;
        Tue, 27 Mar 2018 17:15:42 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id j65sm4315423pge.58.2018.03.27.17.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 17:15:40 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>
Subject: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
Date:   Tue, 27 Mar 2018 17:15:34 -0700
Message-Id: <cover.1522190580.git.wink@saville.com>
X-Mailer: git-send-email 2.16.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add bdl-lib.sh which provides functions to assit in debugging git
shell scripts and tests. The primary public interace are two routines,
bdl and bdl_nsl which print strings. The difference between the two
is that bdl outputs location of the statement optionally followed by
a string to print. For example:

  $ cat -n bdl-exmpl1.sh
       1  #!/usr/bin/env bash
       2  . bdl-lib.sh
       3  bdl "hi"
       4  
       5  # If no parameters just the location is printed
       6  bdl
  $ ./bdl-exmpl1.sh 
  bdl-exmpl1.sh:3: hi
  bdl-exmpl1.sh:6:

bdl_nsl means bdl with no source location being printed and at least
one parameter is required. For example:

  $ cat -n bdl-exmpl2.sh 
       1  #!/usr/bin/env bash
       2  . bdl-lib.sh
       3  bdl_nsl "hi"
       4	
       5  # If no parameters nothing is printed
       6  bdl_nsl
  $ ./bdl-exmpl1.sh 
  hi

These routines can also take two parameters where the first parameter is
the destination for the string. There are two types of destinations,
either a single digit file descriptor 1..9 or a file name. For example:

  $ cat -n bdl-exmpl3.sh
       1  #!/usr/bin/env bash
       2  . bdl-lib.sh
       3  
       4  # Output to STDOUT
       5  bdl_nsl 1 "hi there"
       6  
       7  # Map 5 to STDOUT
       8  exec 5>&1
       9  bdl 5 "yo dude"
      10  
      11  # Output to a file
      12  bdl bdl_out.txt "good bye!"
      13  cat bdl_out.txt
      14  rm bdl_out.txt
  $ ./bdl-exmpl3.sh 
  hi there
  bdl-exmpl3.sh:9: yo dude
  bdl-exmpl3.sh:12: good bye!

If a destination is not provided as a parameter than there are two
variables, bdl_dst and bdl_stdout, that can be used to provide a
defaults. With bdl_dst taking presedence over bdl_stdout and a
destination parameter taking presedence over the variables. For example:

  $ cat -n bdl-exmpl4.sh 
       1  #!/usr/bin/env bash
       2  . bdl-lib.sh
       3  
       4  # Set defaults with bdl_dst taking presedence
       5  bdl_dst=bdl_dst_out.txt
       6  bdl_stdout=5
       7  
       8  bdl_nsl "printed by bdl_nsl to bdl_dst_out.txt"
       9  bdl "printed by bdl to bdl_dst_out.txt"
      10  
      11  # But the parameter the ultimate presedence
      12  bdl bdl_out.txt "good bye to bdl_out.txt"
      13  
      14  cat bdl_dst_out.txt
      15  cat bdl_out.txt
      16  
      17  rm bdl_dst_out.txt
      18  rm bdl_out.txt
      19  
      20  # Now clear bdl_dst and bdl_stdout takes presedence
      21  # but parameters take presedence
      22  bdl_dst=
      23  exec 5>&1
      24  
      25  bdl_nsl "monkeys via 5"
      26  bdl 1 "horses via 1"
      27  bdl bdl_out.txt "orcas to bdl_out.txt"
      28  
      29  cat bdl_out.txt
      30  rm bdl_out.txt
  $ ./bdl-exmpl4.sh 
  printed by bdl_nsl to bdl_dst_out.txt
  bdl-exmpl4.sh:9: printed by bdl to bdl_dst_out.txt
  bdl-exmpl4.sh:26: orcas to bdl_out.txt
  bdl-exmpl4.sh:12: good bye to bdl_out.txt
  monkeys via 5
  bdl-exmpl4.sh:26: horses via 1
  bdl-exmpl4.sh:27: orcas to bdl_out.txt


TODO: More tests and documentation needed.


Wink Saville (1):
  bdl-lib.sh: add bash debug logger

 bdl-exmpl.sh       |  46 ++++++++++++
 bdl-lib.sh         | 215 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0014-bdl-lib.sh | 115 ++++++++++++++++++++++++++++
 t/test-lib.sh      |   4 +
 4 files changed, 380 insertions(+)
 create mode 100755 bdl-exmpl.sh
 create mode 100644 bdl-lib.sh
 create mode 100755 t/t0014-bdl-lib.sh

-- 
2.16.3

