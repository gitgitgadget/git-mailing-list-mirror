Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A471F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162967AbeBOPYp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 10:24:45 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:41013 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162872AbeBOPYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:24:42 -0500
Received: by mail-lf0-f53.google.com with SMTP id f136so16768lff.8
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FVL2feRCBb7I/iTchwZq59WPH0McXkTztLlt4p9Dsms=;
        b=HdzZ/YuL2e+uFAJsQ82WQRbTgtJaCqo+cdg2nvt20KkDbK8lvydN5bmZz6j3yLmkHB
         5bnHKU1wC959XOlnB1MvevVxdLYkW0jTxrGA7Kx3FwVzlxW7lf2xTjonOevuhRjxKl+l
         z0zMRW8qgCjF28y+UXP51o1KDrkYIx/IaliUqYbznfCYfSMeaswR5LJejH3Fvdsq3vkP
         92rItug+0lW8L6kjZgS+jSKWV+nfyitxLteL6d4DZxiDRWW0vqhCfdd/exyeSiaG3s5Y
         ugcegtB1vIeSKel6nDV2KuvDO8Od4v8qBuIjDrQj6p+YlQcWazcEIXx7od0ZEyABTpDX
         aUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FVL2feRCBb7I/iTchwZq59WPH0McXkTztLlt4p9Dsms=;
        b=RjzWaJZbqBaEbqBrlfD7wD2Lo6S9nG/LTYN/azKbOWbGJSp3vAyQBMooQtp+cuY3Uk
         sFiESnV1afRWs7cqElytYFPxCKWOZNspf6jJKW1OMdHeuGG7WwQdP50ijnpFIKimnL8O
         TGXu9F/nxNm2OqAHmJlAb7Fw4Q0rhu1dOoF7yvQsDA5k6d/wr74S0FGc+ye9gfZBwmSN
         XCjhn7SrmG2F8VG+TbjwjZlkQtpGL736gRmgDpRPiYzMLODLPzOoax1QX9e1T9lPI9j9
         eBWqK7gO4zq4e3ZvV5gvtZ2G+ZtAzbuylGc7RB1Bjcba21VxYXmjwOhhMkEGteUYsDSj
         UILA==
X-Gm-Message-State: APf1xPCzz3LSgoOTiHIKK5O084rmX6rfuJW3tbJuaT6rv4eaMrzagRI8
        a9UnLnNlx+WbPlLNzAoxgtsEIsya+PsujmBnVDw=
X-Google-Smtp-Source: AH8x225ln8h6q3Nj7/I0QlEm6/7nv5Hm3K9WE2F2jXogltjRfgTPcZc5JTleSkUMZITCqMzGBuGV+ODtXwdMAs5ETdE=
X-Received: by 10.25.24.203 with SMTP id 72mr2077705lfy.132.1518708281112;
 Thu, 15 Feb 2018 07:24:41 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.2.138 with HTTP; Thu, 15 Feb 2018 07:24:40 -0800 (PST)
In-Reply-To: <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de> <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de> <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 15 Feb 2018 09:24:40 -0600
X-Google-Sender-Auth: XeFtFBv5t5cPMqDO2kB6i6zefqg
Message-ID: <CAHd499CSe6d1SBaDYNRD9HXaWRJ9QYzmOCaBWFrV52UNRMVqhA@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> $ git rm -r --cached . && git add .
>>
>> (Both should work)
>>
>> To be honest, from the documentation, I can't figure out the difference =
between
>> $ git read-tree --empty
>> and
>> $ git rm -r --cached .
>>
>> Does anybody remember the discussion, why we ended up with read-tree ?
>
> We used to use neither, and considered it fine to "rm .git/index" if
> you wanted to empty the on-disk index file in the old world.  In the
> modern world, folks want you to avoid touching filesystem directly
> and instead want you to use Git tools, and the above are two obvious
> ways to do so.
>
> "git read-tree" (without any parameter, i.e. "read these 0 trees and
> populate the index with it") and its modern and preferred synonym
> "git read-tree --empty" (i.e. "I am giving 0 trees and I know the
> sole effect of this command is to empty the index.") are more direct
> ways to express "I want the index emptied" between the two.
>
> The other one, "git rm -r --cached .", in the end gives you the same
> state because it tells Git to "iterate over all the entries in the
> index, find the ones that match pathspec '.', and remove them from
> the index.".  It is not wrong per-se, but conceptually it is a bit
> roundabout way to say that "I want the index emptied", I would
> think.
>
> I wouldn't be surprised if the "rm -r --cached ." were a lot slower,
> due to the overhead of having to do the pathspec filtering that ends
> up to be a no-op, but there shouldn't be a difference in the end
> result.

Sorry to bring this old thread back to life, but I did notice that
this causes file modes to reset back to 644 (from 755) on Windows
version of Git. Is there a way to `$ git read-tree --empty && git add
.` without mucking with file permissions?
