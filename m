From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 14:43:30 -0400
Message-ID: <CAPig+cSgTK3M7UTssiTB_Kc-UgywcbotToD64E6wUWFGDUm1mg@mail.gmail.com>
References: <01020153ad85c135-8ca8cff0-9e6f-48ea-89f3-4036814feeca-000000@eu-west-1.amazonses.com>
	<01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<CAPig+cSkE-xoaXnXHZHB4xz=ehCR973PaKbZJRyiTvHWn0AyoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:43:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akycI-0002Ak-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbcC2Snd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:43:33 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35748 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbcC2Snc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:43:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id e185so3422474vkb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=JmokDaWPWoKvtiaLc8IPn3qabSUSWW9hulGYqdvubjY=;
        b=To+LblcPhhuJp26kfL9l3DUuILqro+lkKG0GlMRbQYun4/DOt3rLJNvgmMF4wWonsg
         K5hLkpbjo1gVCOQrp+DkNjQYOcMzXn9naKyQAREnoV0u62+eaddKMQA7Ohk7EydglqX0
         eeBPc8b/aSOXOmar0r/JCyt4r3bNMcmGLudJXFGIRGUwPhbKeIjRU2s6rDSrWR4LAR3F
         L1vecbIum7IDR2WrfE3XxvXF0ttmEzKOaHkRvRa5e4EA/htlCY517iaV1hRfTsJp4z+d
         wB5dhPJ9+yyI3mEvTpyhYqu3fA3M4C+WON7P/EOEx9rIIxQqXMdn44/ftGDvUAkY8X5v
         P3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JmokDaWPWoKvtiaLc8IPn3qabSUSWW9hulGYqdvubjY=;
        b=YACuGryve3lBeW8Te7fhFej4uHEoYakf11l4zOrJdjVygt9d908orSL4E7TxBNOHQQ
         EvVP4GiskJiyKuAB6XAS4fa+iV0WgnxKJ5KGPfiSG27rr2CcxoTydggfK+n6pg/NGWCl
         b3XnTaiAN8nueXD/4ZrpUIrMZmNAZIDa536jhQMZ6WWyPKGkUvBtPowcIYnR8UjMDpf9
         EZ56odelOOimc/DVJhXa9peqcullMtSGE53ii4K6OS65XuYVRTUdkLYptFRrfJF+j/uH
         CZHdKmmvspYF63dgZ58JC5CJfqOub4PXUOuO6BYcKNLzuhR/0R9x/KtmcM1mg/giUVEY
         X3Ag==
X-Gm-Message-State: AD7BkJJzF1F8Kj7z+RqC3T2RTsPImRlQaYhbO0Bo09P1csmHJTaR7WGy4oY4UYhJcUjYLm1G3tidT8aaSXF8ww==
X-Received: by 10.176.0.75 with SMTP id 69mr2410533uai.113.1459277010791; Tue,
 29 Mar 2016 11:43:30 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 11:43:30 -0700 (PDT)
In-Reply-To: <CAPig+cSkE-xoaXnXHZHB4xz=ehCR973PaKbZJRyiTvHWn0AyoA@mail.gmail.com>
X-Google-Sender-Auth: toBnG2Ok52WDhKIpVzTlXlIV4bI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290158>

[re-sending this to the list since it's relevant, and I somehow
accidentally dropped the list]

On Mon, Mar 28, 2016 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 28, 2016 at 6:52 AM, Ray Zhang <zhanglei002@gmail.com> wrote:
>> By adding this option which defaults to true, we can use the
>> corresponding --no-checkout to make some customizations before
>> the checkout, like sparse checkout, etc.
>>
>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
>> ---
>> Changes since last version of this patch[v3]:
>>         Documentation/git-worktree.txt: HEAD --> `<branch>`
>>         t/t2025-worktree-add.sh: fix style
>
> Thanks, this version addresses the minor issues raised with the previous one.
>
> One observation below...
>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -284,11 +285,13 @@ static int add_worktree(const char *path, const char *refname,
>>         if (ret)
>>                 goto done;
>>
>> -       cp.argv = NULL;
>> -       argv_array_clear(&cp.args);
>> -       argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> -       cp.env = child_env.argv;
>> -       ret = run_command(&cp);
>> +       if (opts->checkout) {
>> +               cp.argv = NULL;
>> +               argv_array_clear(&cp.args);
>> +               argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> +               cp.env = child_env.argv;
>> +               ret = run_command(&cp);
>> +       }
>>         if (!ret) {
>>                 is_junk = 0;
>>                 free(junk_work_tree);
>
> In the no-checkout case, this code effectively becomes:
>
>     ret = run_command("update-ref"/"symbolic-ref");
>     if (ret)
>         goto done;
>     ...
>     if (!ret)
>         ...free stuff...
>     done:
>         ...
>
> 'ret' does not change value, so it's a bit odd to have an 'if (ret)'
> conditional immediately followed by an 'if (!ret)'.
>
> It might be cleaner to re-organize the code slightly so that 'if
> (ret)' is used after all run_command()s, and then outdent the "...free
> stuff..." code, like this:
>
>     ret = run_command(...);
>     if (ret)
>         goto done;
>     if (checkout) {
>         ret = run_command(...)
>         if (ret)
>             goto done;
>     }
>     ...free stuff...
>     done:
>         ...
>
> This is a very minor issue, and I'm not even convinced that the code
> is any clearer this way, so it's not something which should hold up
> this patch. If you try it and find it nicer, then it could be done as
> a follow-on cleanup patch (or a preparatory cleanup patch if you want
> to re-roll, but that's probably not necessary).
>
> I should have mentioned this earlier since I specifically looked for
> it with a previous version of the patch, but unfortunately didn't
> quite spot it. This time I did spot it.
