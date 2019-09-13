Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECA61F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbfIMUQd (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:16:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfIMUQc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:16:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id g7so33334660wrx.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FA1IsDxJ9fZhcNzFTpw8b5J098ZtSWj1LArltBBwnl8=;
        b=uhMoL05G+B9ZnmRFLDml8CmXiAkl7mO6rOZ8GqJs3uh3T5mWUGM6Eug6LZb5k2QRVd
         yavgxE+TGJelT0eXywE9U9Qvl+8KvFt8jmt2BYTn7A8aMocqlb+uIzloQpbYJ1WmNBWf
         mZPp3CY2mjt1GhlnqE7QvvKeuHOXG7aAmfJY8jt/+bkvILTOo3bBgH3Mf/hO/313D3WH
         mVLXd4HpRIBSIvGYE427F3nIZ+2I3ID5qNcFBf182Ye7mn1ClosQqN59dpUpOKjutFmo
         ux93kOpSfngxxU6fHKQLqH96z7dDDCfhEKCwvRT+E79SyM4DjZJBRzIFCWN0ThKHkjJZ
         1Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FA1IsDxJ9fZhcNzFTpw8b5J098ZtSWj1LArltBBwnl8=;
        b=rbBZbXOEGZAlEMrCQHlBKQYctxIAkf9zFyCZThroeQnKLwMzZs4ObKolOPKgcOgoqS
         vbEHTr0fEpNdDDHNsnFis7G4DdEaj3zRPA9/hcT0ocXBOeklJg9qJqGs9J0+S6bHrJJO
         J2ASccvat5ngpxoqx6L5U9b3zv6nys7HpHCX89JjwH3kqX7njZ5JUAJHQbMdjHDKXMFp
         tms5JPlVcJDGH1uc8Bi0+JBHo/kv4wixt1R8iSlgO/+UhMSMIqN8FyEbJ8HBjYoj5f8I
         IQaX3bYpjhvaQfsJ6jIlLyH/xyG5mkhb+ITcwOPfeE/MkMiE0wRNwQ1RBQnPgcW9oDFw
         UKaA==
X-Gm-Message-State: APjAAAUp1EaYfoBv2FEDgfvOCpEInbT37CCzDhBha36aU5n9p94idhid
        fVpfp+qU1/osS+MQOSMGs6cm
X-Google-Smtp-Source: APXvYqylx+dVLGFNCisat4FDrQl49lT5ySyOZMEby4bsnIAR53OzbhPMiELyNd5KNYm2DW/EHhgj/A==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr1294189wrt.31.1568405790269;
        Fri, 13 Sep 2019 13:16:30 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id h17sm5915430wme.6.2019.09.13.13.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 13:16:29 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH v4] git-gui: add horizontal scrollbar to commit buffer
Date:   Fri, 13 Sep 2019 22:16:28 +0200
Message-Id: <20b0d8599099a412833af93f85e414fdc495dd76.1568405611.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the commit message widget has a configurable fixed width, it
nevertheless allowed to write commit messages which exceeded this limit.
Though there is no visual clue, that there is scrolling going on. Now
there is a horizontal scrollbar.

There seems to be a bug in at least Tcl/Tk up to version 8.6.8, which
does not update the horizontal scrollbar if one removes the whole
content at once.

Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..ad962d4 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3363,10 +3363,16 @@ ttext $ui_comm -background white -foreground black \
 	-relief sunken \
 	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
 	-font font_diff \
+	-xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
 	-yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
+${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
+	-orient horizontal \
+	-command [list $ui_comm xview]
 ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
+	-orient vertical \
 	-command [list $ui_comm yview]
 
+pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
 pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
 pack $ui_comm -side left -fill y
 pack .vpane.lower.commarea.buffer.header -side top -fill x
-- 
2.21.0.789.ga095d9d866

