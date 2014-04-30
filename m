From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and remote-curl.c
Date: Wed, 30 Apr 2014 10:56:10 +0200
Message-ID: <CABPQNSbSipaCAgJV0LimP-J1-WOXHQU5w9qOoBq-ccRYQFrAxw@mail.gmail.com>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-9-git-send-email-marat@slonopotamus.org> <5360B5EC.1070907@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfQK7-0006DJ-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbaD3I47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 04:56:59 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45146 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbaD3I4x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 04:56:53 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so1577029iec.10
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=k983aQesBgaDGo+CR2IMFGXofHdn4gqS2SNHOm8vfDg=;
        b=KyxPlOF/J24FWwmmXyEhYwUfqkZVbQVZkQrgJB9UTJharFZUwdXb2Fec6wT+m2TpJY
         unmBQ5y7FxNK3ixgNC57HfKWLWLDqWY47RQpJLZS6iF7/eD+vpHH3JuQdfMZXa8fMg1d
         qDTy//FgLu6Bit9Jv37oeKnQsoDnqQhtjvziULYqGTDDYgJaqiK2sxSEQoA/9BE3lMzJ
         FfIr01MIcT/UiAhx53Q93hvm14X7FSHkUU+xZIFS8G34tRYFgS1HrguTe3D3loY4XrKe
         Q7fnpcOggXm/FYV5N0MegibbdOdEKlPQG7ZTU+2Fva7iKvKIpeTuBJF+DFUPA46gHFA0
         Tgmg==
X-Received: by 10.42.24.76 with SMTP id v12mr2326871icb.59.1398848210519; Wed,
 30 Apr 2014 01:56:50 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 01:56:10 -0700 (PDT)
In-Reply-To: <5360B5EC.1070907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247684>

On Wed, Apr 30, 2014 at 10:35 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 29.04.2014 11:12, schrieb Marat Radchenko:
>> On MinGW, compat/mingw.h defines a 'mingw_main' wrapper function.
>> Fix `warning: passing argument 2 of 'mingw_main' from incompatible
>> pointer type` in http-fetch.c and remote-curl.c by dropping 'const'.
>>
>
> Would you mind cross checking your changes with the msysgit fork? Fixing the same thing in a slightly different manner will just cause unnecessary conflicts (i.e. unnecessary work for the Git for Windows maintainers, as well as for you to come up with an alternate solution for something that's long been fixed).
>
> See https://github.com/msysgit/git/commit/9206e7fd (squashed from https://github.com/msysgit/git/commit/0115ef83 and https://github.com/msysgit/git/commit/6949537a).
>

While it's certainly a good point, I think this is *our* fault for not
upstreaming our changes, and the responsibility of cleaning up merges
should lie on our shoulders. We've diverged a lot. Sure, Dscho does a
great job making the divergence less painful, but IMO we should try to
reduce the delta as well.

For instance, I think the Unicode-support patches have proven
themselves by now and should go upstream. And there's probably a ton
of smaller free-standing clean-ups that could get the same treatment.
