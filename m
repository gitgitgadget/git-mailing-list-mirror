Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154EF1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeCCI2t (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 03:28:49 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34232 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeCCI2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 03:28:48 -0500
Received: by mail-qt0-f174.google.com with SMTP id l25so14819843qtj.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 00:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4UR3cxNfRtPx2yaY8b5uJ7yX9QqF0GuJClrX9gFVmtE=;
        b=UpGLWEOgKyIwZpmb4Zs8yGKW5d7xvG1/oFTJ5wrC+3lmX/uPL2Cv8ap51MLbkJYse+
         dcpyQFyXvLL+TUiU252J3e9o9behkbTpbH5OCcxANMip70Swx95YgVpYAz4fGiuyGZFp
         ZrOE7fd9E+xOYGczxbSlr10qtuoH+XslLkjVy/EyjHYJPjr+J90nH9OJMBhGc+L0UwSC
         PxF3Zi0jg7ENpQuEySrXpPjU9rxFONgDwxy4lGQgVK0iKnzTf8siUIAGeD4GahYiFQze
         gerVPTXQkkI2bLn8O508oh503jPx3MHUlIvcxu21+aKw4huFMfIa450Mp6LTfkYhABKV
         cDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4UR3cxNfRtPx2yaY8b5uJ7yX9QqF0GuJClrX9gFVmtE=;
        b=gFftArNsdXTB4AhEmwHVF/ZlTZrA+L8AqdBO23zsMUDUUKs8q/6YPoN2sPGVP/fAud
         02qKr1Tqf25h+c21KzjS9e0z7oKuz2tuC5wyofvIDI2DE2PBc2iLhq1TUiH6543lC+G1
         4QuGtZUxNwGaEgOVtaRgMMkksZIIMxkuWhttCX9AexpqurzjgAfLPNH+KuMauiHasmSH
         YZNV3nFRSuu/h7p/GhWM4EZCRdPV0AfW7e4LzVER35RkgnbwpYYGM09GZwjifjRJPEa+
         5zItUECkQNaIA+6MsXlI97rGiQX1TacC+zTFiQ8ST+zQIR3lt77KVX8EcLFbUMfUnFla
         scWA==
X-Gm-Message-State: AElRT7FfZS8EjVlcpgzBzTtDLcEONXzpBN0wfqLycoaoKZXzI49gVSCI
        0g/9kutEcv0tLFniAXBkPFDZcgTeR40tW9fOQBg=
X-Google-Smtp-Source: AG47ELsDZuEPgdsli/D/rwwqN/yRcEqE354FApocd/dq0sPSmFqOAr/1tOraQC8ugBOvj3Y0l6H4yQfRUtZKCYvgD6Q=
X-Received: by 10.200.28.8 with SMTP id a8mr4417621qtk.280.1520065728066; Sat,
 03 Mar 2018 00:28:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 00:28:47 -0800 (PST)
In-Reply-To: <20180303052708.GF27689@sigill.intra.peff.net>
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
 <20180221221516.GA7944@sigill.intra.peff.net> <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
 <20180222053722.GB133592@aiede.svl.corp.google.com> <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
 <20180222100840.GD12442@sigill.intra.peff.net> <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
 <01B07AA7-B2A4-4A81-B1F0-E2EC3D6BFBF9@gmail.com> <20180303052708.GF27689@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 03:28:47 -0500
X-Google-Sender-Auth: rJX0DycZllIa4I50vY_ouudXsgM
Message-ID: <CAPig+cT4NhhZNaYYXZL3dqvVn++KrNSL1bQRtdPt4RqfPexAnA@mail.gmail.com>
Subject: Re: [PATCH] smart-http: document flush after "# service" line
To:     Jeff King <peff@peff.net>
Cc:     Dorian Taylor <dorian.taylor.lists@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 12:27 AM, Jeff King <peff@peff.net> wrote:
> Subject: smart-http: document flush after "# service" line
>
> The http-protocol.txt spec fails to mention that a flush
> packet comes in the smart server response after sending any
> the "service" header.

"any the"?

> Technically the client code is actually ready to receive an
> arbitrary number of headers here, but since we haven't
> introduced any other headers in the past decade (and the
> client would just throw them away), let's not mention it in
> the spec.
>
> This fixes both BNF and the example. While we're fixing the
> latter, let's also add the missing flush after the ref list.
>
> Reported-by: Dorian Taylor <dorian.taylor.lists@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
