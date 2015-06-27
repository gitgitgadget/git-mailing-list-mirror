From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 21:25:12 -0700
Message-ID: <CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com> <1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
 <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com> <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 06:25:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hgP-0006c9-9L
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbF0EZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:25:33 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36045 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbF0EZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:25:32 -0400
Received: by oigb199 with SMTP id b199so88050802oig.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jfi3bUSnecvnbHZQXtleyl39BoCXQ7nHxke3FAmjzns=;
        b=bHwI2p4M8QkkVb0NMwVp4qbdIPo5+ItKJuiXJBIxdVMSmvQWartNSvOqjiwKRhKtma
         YPmB4Hwj90xn0y4KEIuLao3vu9lvJmN0bbOfBB0+nqF5WjI8ppPN+UxpZqPhb4XiehmI
         GzJLEXp221iLrPjIaAjHPPlagFilW41V8qZzgTBV/JYx7KEXRihl+6dFxdtuXORI17l9
         ICYIXSu+QnhGt1IFHmE2C2K5rHCsWs3P0kBwwalgE2S7sbaQDqz+l3TXKC7Uk0TwpruA
         92FnnmXhjxIsoDvuPQkyz4xJQ+si38c+moKkgyUcN+1HEJu5eZZeiSQ+0ZK3fCii1mNS
         03Eg==
X-Received: by 10.60.15.68 with SMTP id v4mr4240515oec.17.1435379131451; Fri,
 26 Jun 2015 21:25:31 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Fri, 26 Jun 2015 21:25:12 -0700 (PDT)
In-Reply-To: <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
X-Google-Sender-Auth: rfen06lji_CFcORdhtOSTD47nhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272849>

On Fri, Jun 26, 2015 at 9:10 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> If we don't want to support positional arguments, then I would suggest
> supporting first the following instead:
>
>          git bisect terms --name-good=fast --name-bad=slow
>          git bisect terms --name-bad=slow --name-good=fast
>
> This would make the interface consistent with the code.

Which somewhat defeats the point of introducing "old" and "new", though.
The "terms" support is for people who feel that good/bad would be too confusing
for the particular bisect session (e.g. because they are hunting for a fix).

>> We may want to start supporting
>>
>>         git bisect start --new=master --old=maint
>
> Maybe we could also support:
>
> git bisect start --name-good=fast --name-bad=slow --fast=maint --slow=master

The same comment for the token after --name-, but allowing the terms to be set
at "start" could be a type-saver.  With need for added "--name-"
prefix (worse, twice),
I am not sure if it would be seen as a useful type-saver, though.

Thanks.
