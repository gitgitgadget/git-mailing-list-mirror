Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B051F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeJLG26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:28:58 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49702 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLG26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:28:58 -0400
Received: by mail-pf1-f202.google.com with SMTP id a64-v6so9996267pfg.16
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cayZt+GTVSfUQsUx8VusOV0a0wAPZwQawdteJTATC2M=;
        b=jNntz+s41bspsWrd1LXSpS7AiwPUjt0s9rxkWh0AsHbE91PMraUH44X9l79wtfWsyL
         ARsC0wAigtIFWV/WtU/s027f6Ns7fOur/3gxZV9Kc+vQRim4m75i4sQqYxPYZCoSAXvc
         FiIoh+9Ko5FPCtiRltiTM3SSnADifwyUAoAcltvm9ZwB9NnEcbhllSlPDPKuLkv/VEnD
         3K7lqu5nnWQnCaY9eK8im2xA76qipaVr045GB9X5zR5C0373zBCdPqz/rXAhOTNThbaL
         El2EgxVpadY1ITGp9RZbQ88Uu234Jt2ckLgamYO/b1Xo6BGP+MEd6Ib9Ee9tAN9hIvRF
         vA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cayZt+GTVSfUQsUx8VusOV0a0wAPZwQawdteJTATC2M=;
        b=QeCeXnF5Tt5P5Z9lBPMnUGXFb2adWqYpKq2cfcndZmccZdYyDodl3Sjv1zDwnyKWZ7
         +spa7KHUdMzldVaChW+DdAweRbBXzSLpqIOqav8D7jnIMZTQvu+K3hjRJL5pYq5IqWPD
         SSg3Z6lVb5HHJv1uqfCadTl23bl+63UPx7/Zl6uECVmMIVLeEUYWhXS0oGKVBUKXVYEM
         D8UW2Xqwvq0lOEXPPoyWIngWB0n/wuS6TFZ97XjDDBd6ixgcd/dnzlUEvZcjKUYXFUr5
         9x9bkZSYZTXAljBZI3do2aQR0gxWDgd70bDolCfQ3q0SGKn53F12CJlilwDis9xd6WYT
         UKRw==
X-Gm-Message-State: ABuFfog4i9/hrOlHJgwHnammDOaC2nQcYSjbZva0dvIdaZb0l1U0GLQD
        MDfm+aliK52GIeHCFsJKzcuvuTWG9j8j
X-Google-Smtp-Source: ACcGV60uUqVeubpHxaZhR+BAXVysFoVRegkxpudv5n5TxFiDCc69wKomsgCmkiFXi4reatBmQo0Yi/xeIur0
X-Received: by 2002:a62:c29a:: with SMTP id w26-v6mr1903599pfk.13.1539298771935;
 Thu, 11 Oct 2018 15:59:31 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:59:28 -0700
In-Reply-To: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181011225928.76051-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] diff.c: die on unknown color-moved ws mode
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
--- 


   There is no "ignore-any" supported by the feature---I think that
   the parser for the option should have noticed and barfed, but it
   did not.  It merely emitted a message to the standard output and
   let it scroll away with the huge diff before the reader noticed
   it.
   
Addressed in this patch.

   Am I missing something [...] ?

Note that this parsing is used for both the parsing from command line
as well as options, i.e.

  git config diff.colorMovedWS asdf
  git format-patch HEAD^
fatal: ignoring unknown color-moved-ws mode 'asdf'
  git config --unset diff.colorMovedWS

(format-patch parses these color specific things, but doesn't apply it)
   
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 145cfbae59..bdf4535d69 100644
--- a/diff.c
+++ b/diff.c
@@ -313,7 +313,7 @@ static int parse_color_moved_ws(const char *arg)
 		else if (!strcmp(sb.buf, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
 		else
-			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
+			die(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
 
 		strbuf_release(&sb);
 	}
-- 
2.19.0

