From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/9] Progress with git submodule
Date: Fri, 28 Aug 2015 09:35:14 -0700
Message-ID: <CAGZ79kbBfHUYJN1UBeynSAwfGhSmscarGnzSs9sZJmvN2m0VQg@mail.gmail.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<b5126a0a9438e8737c726d887ebc96e3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:35:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVMch-0005zN-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 18:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbbH1QfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 12:35:16 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32824 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbH1QfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 12:35:15 -0400
Received: by ykdz80 with SMTP id z80so20761642ykd.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BSFyPWDb8z1bYPSq+5jLbfEAqiKce2xlLNhdfx+6jGs=;
        b=LiSmArZoa1HjHwtxRF74EM2h4F9MAZ2b9HR6y9AwDFHveFhFvneaBCXRKQTfMklWbd
         dzHSNjmsO2J37h/am440Hlj8dZ/pO7S/eRrmyxAsSzAIiFQQQULhOXlbJ0zzepK6X2Vl
         /zGqqI+p9ZBUdN1Z/2XLTzYJg38P/+fazJFbLR6A6RS4jGXlOXJ/nwjtHL62By5USp6M
         0x4Ao9jFm47NBdQS6zHy2ZGl7eQhxEhKfMlmxDmS79QeSuAsPHTU6jaytkeVZuumsCxu
         CtzyIG6A82+FJ3P7C76olIMmim8f8hy+dKtis6Tdy6u6kRRGSPHVLeoi6Zxr2QiFWLeP
         OUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BSFyPWDb8z1bYPSq+5jLbfEAqiKce2xlLNhdfx+6jGs=;
        b=hkgrWmwyrDRL8HFzyIGY0KZdcCMP1EMUWb90YA/wGYdQKt+KHZg7HpJQtALBdUtLIv
         wylx/PnHqCJY+yAUamtIafVSwRmJ4Y0tO3TXoCEFCA6eSizAVe6vAp0dX0RPDBkRAr2M
         68yBMOGXdVyGLxh0DAi8E2ymCPzBXxs8y0pFTjxfQOybDSrhFBFDSJYfq0MVhDbuUdJ1
         pkN4BchJDViZ5nB0CEMJjXa/QWnE2FmbCDhPR0DjLCsDhZ+tEO4uMiiI05UFDdVmN6eK
         78DOjW2sAVobotHFuz3my9eeOGH6kZ5JgonfPhrut44XkBOmjsYWSKsCVhelKsuZ9sl8
         ylUQ==
X-Gm-Message-State: ALoCoQltmISD65UStkETWLSpqAqwVapWTov5BqTDqX1GpKL+WqgymJ8+jUNhkrrHU95s5plSmwcz
X-Received: by 10.170.200.212 with SMTP id r203mr9202894yke.10.1440779714546;
 Fri, 28 Aug 2015 09:35:14 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 09:35:14 -0700 (PDT)
In-Reply-To: <b5126a0a9438e8737c726d887ebc96e3@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276726>

On Fri, Aug 28, 2015 at 3:09 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On 2015-08-28 03:14, Stefan Beller wrote:
>
>> Stefan Beller (9):
>>   submodule: implement `module_list` as a builtin helper
>>   submodule: implement `module_name` as a builtin helper
>>   submodule: implement `module_clone` as a builtin helper
>
> Another thing that just hit me: is there any specific reason why the underscore? I think we prefer dashes for subcommands (think: cherry-pick) and maybe we want to do the same for subsubcommands...
>
> Ciao,
> Dscho
>

Junio wrote on Aug 3rd:
>>>     $ git submodule--helper module_list
>>
>> Why would you use an underscore in here as opposed to a dash?
>
> Simply because the diff would be easier to read; the callers used to
> call module_list shell function, now they call the subcommand with the
> same name of submodule--helper.

I mean no user is expected to use the submodule--helper functions directly and
we want to get rid of them eventually anyway (once the whole git-submodule.sh
is rewritten in C we can just call the C functions instead of calling
out to helpers)
