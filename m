From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v3 1/3] pull --rebase: add --[no-]autostash flag
Date: Fri, 4 Mar 2016 11:07:40 +0530
Message-ID: <CA+DCAeSRN=nqhnv14kvbnxExiSBPnA3hLP8hY0fbd+YgTR3TNw@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqd1rbiifi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>, sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 04 06:37:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abiQs-0000ed-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 06:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbcCDFhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 00:37:42 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33602 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcCDFhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 00:37:41 -0500
Received: by mail-qk0-f193.google.com with SMTP id q184so1444987qkb.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 21:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=KZWEAnAOjjik5b9QTTnQeu1ZBxIitC+Y2gSIlT+K70w=;
        b=FrkmAbGWGyRPiPttSXF0uOKHX8yAt+HaLlMJ5S7UdQtjPttsLUpeGsiGl6yHhOHiBE
         Z0SpUOrR0XGwppAbrHZwuRjLnWEaXie+re4kaYp8qU57/28YAMLC7CMjazvoBPDKOgiw
         1SljSIqiy33H0U/uWzlBnFiHBiQPO7kx04ci2x6Irlv1o0DXPkrxF4VKaJZtXSzb1n2C
         KK/f7guOy6ZF/hs04rHWx4CJa771QHupaYSibu+AZaNs6if3CNNCH6GZXas/H+nJQJH+
         QO8HFBvL8jxfbZA2gklQwfjATUjDQXrOVsX59+NLauTyM/CBAsWM6RhqmORQRlHI+fWq
         llMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=KZWEAnAOjjik5b9QTTnQeu1ZBxIitC+Y2gSIlT+K70w=;
        b=JMcAi4GPvVmyjkehMfbWyMC3LfyBzVkeNry5BBf4KcMWnRWjvJLRKEXFf2rahvrKXP
         7awCYkJVSvB8YV1HhCz9vyckBgGEvYTlBR2r8vkgpLCzC2bZkbllistfPa7jTvvE6Bg0
         Y6a9wB5N9S0zMMD0cXifx8ui9HdexkF2TaT1G87a+awyNvYE2gTEGEYJcoOkGFEj3BNz
         F5BKIGYQ3ELOz0JDtaKcHM+N4xtW0jx/1qaR7nj6BBXJqi1kU/SvVmNJB6U/6EqBoXAI
         VmsDU2RhJ4fbmnrpBjMUvOSaqRl+PwlzNsuEshaPJMvjrjP8cydlIOSVWw9eqz4+Z+yt
         gSag==
X-Gm-Message-State: AD7BkJJU2dW8zv8nH16WsRmanohvAtezkbzcs97Cu3+kgOeFshAZ6kdy+6OxTbDh9ovXa/qlbblcbgFvnJnKsQ==
X-Received: by 10.55.54.201 with SMTP id d192mr7900326qka.23.1457069860735;
 Thu, 03 Mar 2016 21:37:40 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Thu, 3 Mar 2016 21:37:40 -0800 (PST)
In-Reply-To: <vpqd1rbiifi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288231>

On Thu, Mar 3, 2016 at 10:54 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> If rebase.autoStash configuration variable is
>> set, there is no way to override it for
>> "git pull --rebase" from the command line.
>>
>> Teach "git pull --rebase" the --[no]autostash
>> command line flag which overrides the current
>> value of rebase.autostash, if set. As "git rebase"
>> understands the --[no]autostash option, it's
>> just a matter of passing the option to underlying
>> "git rebase" when "git pull --rebase" is called.
>
> We normally wrap text with a bit less than 80 columns. Yours is wrappet
> at 50 columns which makes it look weird.

OK. I will change it.

>> +     else {
>> +             /* If --[no-]autostash option is called without --rebase */
>> +             if (opt_autostash == 0)
>> +                     die(_("--no-autostash option is only valid with --rebase."));
>> +             else if (opt_autostash == 1)
>
> The else is not needed since the other branch dies.

I'm bit confused here. Which "else" you are talking about. I think both the
"else" and "else if" are needed here because:

- for the first "else", it is necessary that the case is only executed
when --rebase option is not given. If "else" is removed then in some case
where user calls "git pull --rebase --autostash" will lead to the execution of
"else if (opt_autostash == 1)"  case.

- Also removal of  "else if (opt_autostash == 1)" is not the right thing. As
the possibility of opt_autostash = -1 is there and this change may lead to
the execution of "die(_("--no-autostash ... "));" in case user calls "git pull".

Though I agree with Eric on combining the "if and else if" cases.

Thanks,
Mehul
