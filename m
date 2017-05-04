Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14A6207FF
	for <e@80x24.org>; Thu,  4 May 2017 05:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbdEDFEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 01:04:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33972 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbdEDFEM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 01:04:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id d1so583944pfe.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/W/QkUzeOyQA0dEJoMXD7xQf3vdwv7oPj9grSTfNvOQ=;
        b=JaDcu3fAhQ28AHT5CjT+57hcqcORsPOqOJHLiVK0Yx0zfgAomYoy3lPJX94dngge5I
         bXxKNjDeAikcFIqIFdAQ+OxP5krrW/Op6PPBUZ/2O2oHTtB3bontAGJzDj/gvPNdsMti
         5c4SacSZDhPXtBn8sJ3B4Ru3socsHrRODgp1DsPSHEqQ615laYfGG9Rmr8sAh0iKrXcf
         l0EchL+yPUegTdDazJBmOuVri+Hjesunpd0iKBOb1tnjkOostjmF7SBA8aWpHBX4lmHy
         +neZzxvToAWIHEveyfFBfgCAMIK6dG4e8kBaw6lq8dD6WzgUbNwyy8zMihNtNKAEHa2a
         cSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/W/QkUzeOyQA0dEJoMXD7xQf3vdwv7oPj9grSTfNvOQ=;
        b=rYLBU8AEIXsQzcE8GKfbjAr3F4ZdCuQqG9B4VDCVcztkr4aeCn+kYXLbpO3TDMZ4nb
         rYMjYn7f1CYIwS0embDwqeha27TxGgQ24BphtdXhC6x1HZPJynhXGmQ96k92P9ui8Uy+
         Leas8ss1F80ooGc8+pqgvI5XOPwOfKicXzvahHXzA+88uM38I/dZPEVPJsPvzc5hIFHu
         fx20SSad46vzRSxmM72r4uE+pCU/8r9gMmiUrPK8Eb2YQ+7h6oNSSAwkyNMN/mdI28Yt
         eiLwaliOQifWTPSKP4185oAe3Y3Rr0gJgrQDgW0LH60BbBEyf7waHn990ee1Myszh/n1
         vnqQ==
X-Gm-Message-State: AN3rC/5Oz8ZPvuylfnUf8TaxkVeMeHNzVec7w2uhRwvftf8BVzZasbp/
        wp5NSc6ngk9+UA==
X-Received: by 10.99.127.19 with SMTP id a19mr10244422pgd.213.1493874252135;
        Wed, 03 May 2017 22:04:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id z68sm1363629pgz.14.2017.05.03.22.04.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 22:04:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
References: <20170502040048.9065-1-liambeguin@gmail.com>
        <alpine.DEB.2.20.1705021741580.3480@virtualbox>
        <1493769381.29673.39.camel@gmail.com>
        <alpine.DEB.2.20.1705031315460.3480@virtualbox>
Date:   Wed, 03 May 2017 22:04:10 -0700
In-Reply-To: <alpine.DEB.2.20.1705031315460.3480@virtualbox> (Johannes
        Schindelin's message of "Wed, 3 May 2017 13:22:03 +0200 (CEST)")
Message-ID: <xmqqwp9x9prp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If 'git-rebase--interactive.sh' is bound to be replaced, I could
>> just shrink this to the Documentation cleanup (patches 4 and 5)
>> and rework the rest on top of your new implementation.
>
> I kind of hoped that Junio would chime in with his verdict. That would be
> the ultimate deciding factor, I think.

What I can predict is that within two or three release cycles
(unless you completely lose interest) the todo-list generation will
be all in C and that I anticipate that the C version may even be
capable of generating different kind of todo command (e.g. to
support tools like your Garden Shears more natively), so the
mid-term direction definitely is that any enhancement would in the
end needs to happen on top of or in coordination with the C rewrite
we've been discussing recently.

I didn't know what the comfort levels of Liam working with scripted
vs C code, and the "vertict" depends on that, I would think.  We may
want to discuss the enhancement in the original scripted form Liam
did with new tests while the C rewrite is still cooking, and either
Liam, you or somebody else can make it work with your C rewrite when
both are ready.  If Liam feels comfortable working with you and the
code after the C rewrite that is still in-flight, it is also fine if
the next iteration from Liam were on top of your series.


