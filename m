From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Fwd: Possible bug report: `git commit -ammend`
Date: Sat, 16 Nov 2013 10:28:36 +0700
Message-ID: <CACsJy8Ckb+qdQFcTHPcAiRy_08Nxtz5Uh_9R+NXz4yixWR9DUQ@mail.gmail.com>
References: <CAMyx446B1U30RL9X7vOrY-u7fQ_cEqRJxn_M8Wn8PuOJhdO-1Q@mail.gmail.com>
 <CAMyx444wJeQUpxZmXmYx-mKE0kniO=ELo5HgzQ1unV4O15oxWw@mail.gmail.com> <vpqsiux1wz3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rhys evans <rhys.evans@ft.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Nov 16 04:29:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhWZd-0003mi-SK
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 04:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595Ab3KPD3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 22:29:09 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60284 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3KPD3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 22:29:07 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so27954qae.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 19:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XcztscWqHp/BY+zT0/IRh9uWhPkujYrRnO6Syq8Vxzg=;
        b=NmOFU2ewI+dx9exe4/JqMM7N7aVKsAZdF/+eJHjInY6xs8qiIPiw4ru8UTxdR4W+6u
         di8TQ2mbyz6OinewR6jynq8gA6I7ynyI2LTnaIoOCG+BHKWmqJK7n+faS6tVH7qoIYiH
         UStB3PhFgrohQ3QmGC8e2J/MQm/RzwW2JV9hKY1HQHZJHa91xwf2VrryI5za2LtffiPx
         4ZkB4X0ltDA9FswtM7Pkb5f+KPdHpnefJcHXoTXbSrFMwIatZ1BN1GYxDNimjmLtO0xs
         5WsYk67mAMZp0nNm7WjhlTpORmfHBDCuMnqGCc/85V+wK1H7Mw4WWTttDLq4fwOCDzFY
         fGqg==
X-Received: by 10.49.1.230 with SMTP id 6mr16087927qep.48.1384572546729; Fri,
 15 Nov 2013 19:29:06 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Fri, 15 Nov 2013 19:28:36 -0800 (PST)
In-Reply-To: <vpqsiux1wz3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237923>

On Fri, Nov 15, 2013 at 10:54 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> rhys evans <rhys.evans@ft.com> writes:
>
>> I ran `git commit -ammend` on a repo where 1 out of 3 files changed
>> were staged for commit.
>>
>> I would've expected an error to be thrown due to the double typo but
>> instead it committed all 3 files with the message 'mend'.
>>
>> So it looks like it interpreted it as `git commit -a -m 'mend'`.
>
> Yes. This is a rather widespread convention (e.g. rm -fr == rm -r -f).
> Git does a special-case for -amend to avoid confusion:
>
>   $ git commit -amend
>   error: did you mean `--amend` (with two dashes ?)
>
> But it did not special-case the double-typo.

"-m" taking a string without a space or '=' increases the risk of this
typo. If it does require '=' or ' ' after -m then -ammend is more
likely to be rejected. Anybody know why we should support -mabc,
besides convenient?
-- 
Duy
