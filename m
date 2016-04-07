From: Antti Halttunen <Antti.Halttunen@iki.fi>
Subject: Re: bug: nested submodules get an absolute gitdir path
Date: Thu, 7 Apr 2016 09:44:13 +0300
Message-ID: <CALoo-5XQtLsiEneqLdJyi8Wa5pTX_Kz8f7C1H6ir2=J2ZLAyLg@mail.gmail.com>
References: <CALoo-5WcdMNMcCW0EQv1VqkE5Ax7bMnvo2r7niYhYyMjA8c4wg@mail.gmail.com>
	<xmqqmvp6zsos.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 08:44:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao3fv-00083J-61
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 08:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbcDGGoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 02:44:15 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36259 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcDGGoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 02:44:14 -0400
Received: by mail-ig0-f172.google.com with SMTP id f1so146918611igr.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 23:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=UaTnvE9iG4dkX5fhiwLnrihXcwxMf4F1hg0ZU+1iv5I=;
        b=SzH4ZMKGXEEoCLjFsn31qwve+mlItlT4N79AOJe1Bqjh7q8wJvD8zbVNphjcjm0cH6
         4nHSuihX9sSdyeKYftq+81/GYUvhA+hE+ff+B2wrW5P264VKQ0WuV6YezND8BkjMFtqh
         UnEpnH6ONDF3rjohqTFuj8wJQG/e/wU4iYbU/fsHEBYKew591OpS+rDCbEQI2B8C8G2G
         ed0z0n7xPbdQJ5hw8Xqicz5YdTEZqvTkihvrf37dgL9jN7ngt5lpE9RoHq+Becokd1AH
         zmnA7WJSZ2MBUZl+5YrSgv5ZomyQ63Vg6ZY2gL27guqKKIdYkhEHGntrNrzO2mQFqXw5
         VovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UaTnvE9iG4dkX5fhiwLnrihXcwxMf4F1hg0ZU+1iv5I=;
        b=iQjHeBf9HgfISY/gKA/7cH5pO8Qmc0WyPzzqEaZhRFaSY3l8MNF1FXV1HUFftHRnOj
         bECwuBC0eW8WVmqukBD8cACKypspNtiXP950pJg17b3yt8A5srH/uN/ecVyl2QbcstO2
         TC6l2fchJ4vtiQDlnkkeUEBdr/h9YbWHmIrwYEGFLTAhGg7aOai8mI5kCBIf5IAazppc
         XpUNEULdiRMM9WJGJjxXL4Hnx1uU/iaskklz5wM5tk+YAm3A+vFGt+40Yh65Ma7bmX0x
         8EIih2tcdEye2PLlaH5gvAIHWb5NC7OtimrPVTHtjk1H+qGlZ5/G9ZfT2iP8hfNYHO7d
         0QBA==
X-Gm-Message-State: AD7BkJIerCgQjeWcPMpHZ/XzWKyntikuxZHtdHF/VV79baFAAhf8L6MpceyzNb6kXb3v4/G0TO1aOlSrWYvH3g==
X-Received: by 10.50.118.4 with SMTP id ki4mr28464785igb.53.1460011453371;
 Wed, 06 Apr 2016 23:44:13 -0700 (PDT)
Received: by 10.79.74.71 with HTTP; Wed, 6 Apr 2016 23:44:13 -0700 (PDT)
In-Reply-To: <xmqqmvp6zsos.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 5gKIJUN0JZ1gRpVT_DbR2Q2kPts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290909>

On Wed, Apr 6, 2016 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antti Halttunen <Antti.Halttunen@iki.fi> writes:
>
>> Starting with git v2.7.0,
>>
>> submodules two levels deep get a .git contents of:
>>  gitdir: /absolute/path/name
>
> I think that this is $gmane/290491
>
> http://thread.gmane.org/gmane.comp.version-control.git/290491
>
> and queued as sb/submodule-helper-clone-regression-fix topic,
> currently included on the 'pu' branch.  Can you try it and see if it
> fixes your issue?

it does, thanks.

> Thanks.
>
>>
>> This breaks repos that are moved or copied:
>>
>> fatal: Not a git repository:
>> /tmp/tmp.gIyxKWIC26/repo/.git/modules/sub/modules/sub
>> fatal: 'git status --porcelain' failed in submodule sub
>>
>> The script https://gitlab.com/snippets/17301 reproduces the issue.
>>
>> git bisect points to commit ee8838d1.
>>
>> thanks,

-- 
antti
