Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C772B1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 06:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbcFUGeF (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 02:34:05 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36609 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcFUGeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 02:34:03 -0400
Received: by mail-io0-f169.google.com with SMTP id s63so4002060ioi.3
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 23:32:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WNh0Zj4D+WjlK97/pci7qtbaTLDy7T7FIixD457MOeE=;
        b=H9PAIs1hWkJQmwCuG5sic2iopZyI1uO1sFF6MLkLjFec5cbzAUQOiNLHFSs9mId0aC
         iVQEdIayfE89NRO42A62I/s0X+oKpYJPvZZ43sr/crsrUf6ipqzGlIntoyfWG97vRX8x
         CnzywvF65xlQ04JoODvIRaVYLo727qVT0mMdLwXkQ04NJIxJ+UN9AiL0OjP61wwBWqjM
         bAM7OOqvuhk8U07qqPbxngtwv0Ebc2VQCoK3LjRC/JHau0FBvtcgPocBfWT/Ie7t+iVb
         pkoZfxgyo3+E88pf+qir1mgu66w4TVzFKVwG0i2Cbm/Z1iFP7iODq2YJyp7STZJ1iGZz
         5FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WNh0Zj4D+WjlK97/pci7qtbaTLDy7T7FIixD457MOeE=;
        b=Ha7l6LxznH4Nnq7g9D7uUjHCU2izYPyvh1LmfVZxTvogf6fgdy5Rb2VV0+Qa9d/VSv
         sdYCeivDuk1ucbfFyoRuqCz4qlYWl67/9EOZsp/jB7GZP3bV+2RJl4O0FC4Y4lLqkNj/
         +ZauZxDUufzyliiAtASObOZloHqiSv0Oxym2TWNcpD+W1rIXYoBqYTfVq3bz5GaiosUi
         UIxGZ3DYJ78K9P4SL1idjowY+4QnlqL4FLXhAYKyM0hgGpKCikYTDHNk82rDS9ZaJNi+
         sf6giQyoEyr7fGuOe+l53ISPj2oOdnVqs381igLE43JmXybSVvIi6zvZxb0MXKFQm1QA
         bvgg==
X-Gm-Message-State: ALyK8tLvdJMCjbmLQiALN4YJcoquRzk+WQPLympR24joRBtLLTSbbGdQJnNJg1a1wRLqwDpoR8UwPMxNFmOVfQ==
X-Received: by 10.107.174.5 with SMTP id x5mr28831786ioe.76.1466490734879;
 Mon, 20 Jun 2016 23:32:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Mon, 20 Jun 2016 23:32:14 -0700 (PDT)
In-Reply-To: <CAGZ79kZyEzp92JP_Bp2te1XO=PB0+fwFn57MrBPuWe25PQKOog@mail.gmail.com>
References: <loom.20160620T145755-931@post.gmane.org> <CAGZ79kZyEzp92JP_Bp2te1XO=PB0+fwFn57MrBPuWe25PQKOog@mail.gmail.com>
From:	Istvan Zakar <istvan.zakar@gmail.com>
Date:	Tue, 21 Jun 2016 08:32:14 +0200
Message-ID: <CAPV8XuZvDkcEwxRB0HwaihVo7QzqsoHTRCdV7sqxkT31-RWkmA@mail.gmail.com>
Subject: Re: Problem with --shallow-submodules option
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Thanks for the answer.
So it means that it is a setting on the server side which can be
activated? (I guess it depends on the version of the server)
I did some reading in the topic. Are you talking about this setting
"uploadpack.allowReachableSHA1InWant", or did I misunderstood what I
read?

Thanks,
    Istvan

On 20 June 2016 at 19:45, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jun 20, 2016 at 6:06 AM, Istvan Zakar <istvan.zakar@gmail.com> wrote:
>> Hello,
>>
>> I'm working on a relatively big project with many submodules. During
>> cloning for testing I tried to decrease the amount of data need to be
>> fetched from the server by using --shallow-submodules option in the clone
>> command. It seems to check out the tip of the remote repo, and if it's not
>> the commit registered in the superproject the submodule update fails
>> (obviously).
>
> Yes that is broken as the depth of a submodule is counted from its own HEAD
> not from the superprojects sha1 as it should.
>
> So it does
>
>     git clone --depth=1 <submodule-url> <submodule-path>
>
>     if HEAD != recorded gitlink sha1,
>         git fetch <recorded gitlink sha1>
>
>     git checkout <recorded gitlink sha1>
>
>> Can I somehow tell to fetch that exact commit I need for my
>> superproject?
>
> Some servers support fetching by direct sha1, which is what we make use
> of here, then it sort-of works.
>
> If the server doesn't support the capability to fetch an arbitrary sha1,
> the submodule command fails, with a message such as
>
>     error: no such remote ref $sha1
>     Fetched in submodule path '<submodule>', but it did not contain
> $sha1. Direct fetching of that commit failed.
>
> So if it breaks for you now, I would suggest not using that switch, I
> don't think there is a quick
> workaround.
>
>>
>> Thanks,
>>    Istvan
>
> Thanks,
> Stefan
>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
