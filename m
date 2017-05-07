Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A3731F71C
	for <e@80x24.org>; Sun,  7 May 2017 22:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbdEGWi3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:38:29 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36637 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdEGWi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:38:28 -0400
Received: by mail-io0-f195.google.com with SMTP id f102so3265230ioi.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwHM0gkIXCoFDsTuXDLAKsj7hQIzYlwKCUpiE4skSQE=;
        b=pcVNwKKdhvaHtkoa9ky3dj5dlrfnz43OBdpjMEUscQ5hdkiexRbr/Arkc6xIeTE9f0
         eyFkrQe9G0iG5Bk7izEZqkxvHxgDNRUjP+b76MEMdvsB5TZU4qPIiTWZ2ZOEMCj7Xpn+
         EH6MpuCzUVQhuIC8mTydGQ2h6fGcZcIwvyIsIA9gWexwct+loMi1yefpY0rttTK35Q1P
         TQ7yixQswNde7SQ9Mm75r2M+lDeJb3/+iNUVHADu7s4FfbyCv9txCzhgZBoKsGW38V7/
         lWL7BlA+HXfA+rQVX1Xznsm1Xy0OYNsp4FY1dGaisz+9uUFy2sI+XOUFDU/nTfnJ3Qg4
         BTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwHM0gkIXCoFDsTuXDLAKsj7hQIzYlwKCUpiE4skSQE=;
        b=QLcdEw6laWYTYgs5Loc63XDHHaDL0E/lGk2whggb8hrOqxd7cswMhlR84sx6TyFcDY
         GV2AguARKGKe0GL6g8bpeeUWAo2ZCOuBj3HZgrEfEaRfJPNlH3IIBhJUf/x2DtSJMvV7
         am7VErSjm0qtMbzA5Uk4oh1Qy3VQ8YwQKuFl5ENpz2LgUCOZ6hilmqh2bK0LOsGG0xRg
         1OI9OtzJta6WOV6Kgn1WjydImOp/gA2xNXvwUZ9YqoqkUi0EOtLfhyY4zqePt8qcAC1+
         6uZ8+HWBwHgNUhknw7UPT2nVWPSz1PArWoPoCieWMVniteATLFWdRPYC3cOBg10UVNiy
         Q45g==
X-Gm-Message-State: AODbwcAjcpx25MVmVCaZT9ybZrBCR6PVLJSMc1UZx80c5x2vg5ycIk1+
        3yg7lAGS4HZLIOM6GX4=
X-Received: by 10.107.180.135 with SMTP id d129mr1307499iof.73.1494177199231;
        Sun, 07 May 2017 10:13:19 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id h76sm277295ith.24.2017.05.07.10.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 May 2017 10:13:18 -0700 (PDT)
Message-ID: <1494177195.32697.2.camel@gmail.com>
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
From:   Liam Beguin <liambeguin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Sun, 07 May 2017 13:13:15 -0400
In-Reply-To: <xmqqwp9x9prp.fsf@gitster.mtv.corp.google.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1705021741580.3480@virtualbox>
         <1493769381.29673.39.camel@gmail.com>
         <alpine.DEB.2.20.1705031315460.3480@virtualbox>
         <xmqqwp9x9prp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 2017-05-03 at 22:04 -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > > If 'git-rebase--interactive.sh' is bound to be replaced, I could
> > > just shrink this to the Documentation cleanup (patches 4 and 5)
> > > and rework the rest on top of your new implementation.
> > 
> > I kind of hoped that Junio would chime in with his verdict. That would be
> > the ultimate deciding factor, I think.
> 
> What I can predict is that within two or three release cycles
> (unless you completely lose interest) the todo-list generation will
> be all in C and that I anticipate that the C version may even be
> capable of generating different kind of todo command (e.g. to
> support tools like your Garden Shears more natively), so the
> mid-term direction definitely is that any enhancement would in the
> end needs to happen on top of or in coordination with the C rewrite
> we've been discussing recently.
> 
> I didn't know what the comfort levels of Liam working with scripted
> vs C code, and the "vertict" depends on that, I would think.  We may
> want to discuss the enhancement in the original scripted form Liam
> did with new tests while the C rewrite is still cooking, and either
> Liam, you or somebody else can make it work with your C rewrite when
> both are ready.  If Liam feels comfortable working with you and the
> code after the C rewrite that is still in-flight, it is also fine if
> the next iteration from Liam were on top of your series.
> 
> 

Sorry for the delay, I don't mind switching to C but it would probably
be easier to see if the scripted version gets approved first.
If it does, I could then get started on the C implementation.
If you prefer I could also forget about the scripted version, make a C
implementation work and see if that gets approved.

Thanks,
Liam
