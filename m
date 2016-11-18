Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F43A1FF40
	for <e@80x24.org>; Fri, 18 Nov 2016 00:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbcKRA21 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 19:28:27 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:32841 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbcKRA20 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 19:28:26 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so243842698qkb.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NX+Jp1cM7QB8lGDU2DfkOshw1650eQkg0gcgOArYqSM=;
        b=N60f26IuTsQvdYc3+NSrBNv4ouuCdOVBVP4ze5ec6TImi8jr8s1vw+hw16jyFySwfr
         KnzWr1lGX9NqIGw1ysIAuc56mpaojLvVkmbLFrq/yBmZO67J8xX0KVf71heZf4j1dH4P
         K8olen2wc5jvmcsRXXeoG3QL2x25AT+bUdNNCV6x3eA9DZnbQVKlFRqTelIedzzZDvH+
         aAprp5dK0yOwzdjNepQr8UsC8MH3qtCuNyE4NisVGKjnFDhjY9glkY8bUTl3/75ocvpZ
         qPFEPar0IYEI1XoHK1Un4U5daX4CmXK2RLVenxKkoRfYmr5jrGPgu3FYM3mpNmDJU3+D
         vdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NX+Jp1cM7QB8lGDU2DfkOshw1650eQkg0gcgOArYqSM=;
        b=hAKGL7piBFezUl5qUZXyPDP/6XG2Y+bcmY7XLBoGji8Sz3Sopw0mBy1deVczgqzuhM
         VTXtOWhbzj+fcKDjmYdZYm9N1BMukxwlS9OCNeZI0MzqjTj+OPqxNhPD9dPTU1iyAJb9
         yf5JwOV6g1kmVkr1saCQVMiEQ2wkuh4kRML+on3YTerQA00gXhci/X3M/pR7nQqLEPBf
         H6JnycrUhpFBdIJE5goZQRXFrKFHlCo5zp/KzwAfq0I6HxCO07H3F8nVl8T3i5I4zwnA
         ZBR1hAxra2VwRsQ9jRclXAruGBgpblZM18Bn58q1g7mkdqbfvXXU6M3IKpN0AwJF9EU0
         lTYA==
X-Gm-Message-State: AKaTC01tLuzvBl7Skzo4f9yRiwyAdc/GMWSqCzQ1DLeDaxaWl/RB6xCTBJCTJQvzGSepApFX7jjr4OliV0E9yXl8
X-Received: by 10.55.20.164 with SMTP id 36mr6929604qku.86.1479428905435; Thu,
 17 Nov 2016 16:28:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 16:28:25 -0800 (PST)
In-Reply-To: <20161116000236.GF66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-10-sbeller@google.com>
 <20161116000236.GF66382@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 16:28:25 -0800
Message-ID: <CAGZ79kY1umjAF2jsvTHoG=M21a3VqcvjM5NZYiMr+qAkv5_APw@mail.gmail.com>
Subject: Re: [PATCH 09/16] update submodules: add scheduling to update submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 4:02 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/15, Stefan Beller wrote:
>> +
>> +     child_process_clear(&cp);
>> +     return 0;
>> +}
>
> If run command is successful then it handles the clearing of the child
> process struct, correct?  Is there a negative to having all the explicit
> clears when the child was successful?

void child_process_clear(struct child_process *child)
{
    argv_array_clear(&child->args);
    argv_array_clear(&child->env_array);
}

I don't think so, as clearing empty arg arrays is a no op.

>> +#define SCHEDULED_SUBMODULES_INIT {NULL, NULL}
>
> I may not know enough about these types of initializors but that Init
> macro only has 2 entries while there are three entries in the struct
> itself.

Filled up to 3 to be explicit.

>
>> +
>> +int scheduled_submodules_nr, scheduled_submodules_alloc;
>
> Should these globals be static since they should be scoped to only this
> file?

Of course, done.

>
> nit: organization wise it makes more sense to me to have the
> 'update_submodule' helper function be located more closely to the
> 'update_submodules' function.
>

done


David wrote:
> In fact, only the first NULL is necessary; unspecified initializer entries in C default to zero.

as said above, I explicitly init all of them now.
