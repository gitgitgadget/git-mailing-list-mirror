Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6581C1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdJKOr2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 10:47:28 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:56938 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdJKOr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 10:47:27 -0400
Received: by mail-qt0-f171.google.com with SMTP id z28so3422838qtz.13
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=/XgfINm1s/kMHW1YCNICUOJb7qNI9lv9UYxHMZrKKLw=;
        b=uHmE8j2nbq2eB+UHcvIDO8JuD5Pa5ZB40wvpz7IRtLPDJAnYMm892VGkiLuDjBxXxQ
         rhfq1j7WhW4WZYO6XYC7/cEriUbJDH/c9Hlk1FGTUyLDNA/HYyEUEj4IVvB65+NRR/kJ
         wXWeLQC10TSXrPamCUpTZihVHNVEqQRzx9Mi7v4Mxkczz2zaLm4WssYSbXiN7hzhLFwc
         sHWWUfKu/JLZYcGqTjuzBSl+CuaPIiEkqDiBNJEH3EmOafJrZQlhu4jMRYAq74gP7RpO
         3FG8K9p6hOmhhl2YIqNSR0cMLCPEB44l3n/RzokWASGHr4pw3U8FVje/bGTKkzw9s5Ny
         Niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=/XgfINm1s/kMHW1YCNICUOJb7qNI9lv9UYxHMZrKKLw=;
        b=KBD19cSlfo1X0A1gNw40CYfh6rWxEYFn1wBKEa1cKWkk92soch7cLZ4YvIDFHWYdgq
         dn2ZY8z4xWheXuk2xIffL0EWjmMyeCN/N0sXZU9/B7m9DaJtF2fDABoCFoTMM7pJa2R4
         /3aPzrPy9Heh0t8eGrdNPJEMnCzNm7QQl4Cx/tHo5fPB2p69Ijl8LTr0xAJ40atrVZDy
         x1+ZoVnInniMEsVUAqUFkv+qx9ZRlKnjN2wy4C4QYfEqqMwuqr86Vm3wB7ICqqifHLUJ
         DDC1tQAMxmpagNx6sEWfqckZ9MbWrD0DffmlEJwT0pil+wMZADwLvxz2vnr1DhY0p+uY
         hDqg==
X-Gm-Message-State: AMCzsaX+PmAsIDqCtQlvl2oazPUKVcwzWuymDeLNTge0VqpaaforU5OX
        Pd1hTIePDTrhwvYVUvOGL/PX1/85fXFb12leehXBsjSG
X-Google-Smtp-Source: AOwi7QD7pg6H23IxrT7PVx5+Lfx9EZnTGv0iA9IXqDfRdC7h6NKvoir6qs78O/zg9raUxXN7UC4tw5r7Nn7rAq9SICM=
X-Received: by 10.37.102.74 with SMTP id z10mr4298103ybm.487.1507733246624;
 Wed, 11 Oct 2017 07:47:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.95.73 with HTTP; Wed, 11 Oct 2017 07:47:06 -0700 (PDT)
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Wed, 11 Oct 2017 10:47:06 -0400
X-Google-Sender-Auth: JvGIGPVlC1UDUhuF2AG3KQjvJ9E
Message-ID: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
Subject: No log --no-decorate completion?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently noticed that in the git-completion script, there's
completion for --decorate={full,yes,no} for git log and family, but
not for --no-decorate. Is that intentional? If not, I *think* I see
how it could be added.

Thanks,
Max
