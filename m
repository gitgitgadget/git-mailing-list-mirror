From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/23] worktree: introduce "add" command
Date: Sat, 4 Jul 2015 04:54:20 -0400
Message-ID: <CAPig+cSKDUr2GjVqNLKQ7Cb7LooE9bvUzZXEv3cEr3kzyCuSTw@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-14-git-send-email-sunshine@sunshineco.com>
	<CACsJy8A2eB2-t4t4oxvWiTnEFr7jJxcVBnn+zHq4uNNTk3sypg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 11:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBgaZ-0003M8-Ir
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 11:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbGEJvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 05:51:52 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34262 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbGEJvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 05:51:51 -0400
Received: by ykfy125 with SMTP id y125so126454484ykf.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yWCnjhJ3Pd/d59eM6bakIVEbdlCsdITEkuUDD+Xnjuk=;
        b=OD64FjnVLgkxw++ClF8KhWjyxt+l28fUhVgG15+lFKtKGa3nNVsX9V3xtl+TMrh2Fm
         pt12TrBD/q/Or0N6/CZ+L8O7gkxK2WvEHLaib5E46C8MuZx7cnyCHeN5JKRtl8JP+61h
         BWh9U4G9ruOeEDlVZnb3yZHqv7aFs8WPBc2j+C6k7FtLgjllCdUagnTJoFayCUj21Mc7
         1OMHxvwklsH2thj710MmJ3b71vf0wRU241xvbKoi2Mih+SOsJIbL993M17cju5f5/g/d
         vHIRvPqUNb4OvNT2VxfeVHY4dZ28JWfQqNN20jOBxqwHx+kgjuGVwzslHTt34cA4ztfF
         63OA==
X-Received: by 10.170.75.194 with SMTP id r185mr48678889ykr.69.1436000060842;
 Sat, 04 Jul 2015 01:54:20 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 4 Jul 2015 01:54:20 -0700 (PDT)
In-Reply-To: <CACsJy8A2eB2-t4t4oxvWiTnEFr7jJxcVBnn+zHq4uNNTk3sypg@mail.gmail.com>
X-Google-Sender-Auth: hVIF5dgYZ9-BxSvtK2PHp2Zw_VI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273358>

On Fri, Jul 3, 2015 at 10:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>  COMMANDS
>>  --------
>> +add <path> <branch>::
>> +
>> +Check out `<branch>` into a separate working directory, `<path>`, creating
>> +`<path>` if necessary. The new working directory is linked to the current
>> +repository, sharing everything except working directory specific files
>> +such as HEAD, index, etc. If `<path>` already exists, it must be empty.
>
> Side note, "must be empty" is an implementation limitation. I think
> the two-way merge employed by git-checkout can deal with dirty <path>
> and only perform the checkout if there is no data loss. But we can
> leave this for later.

Perhaps we should omit the bit about an existing but empty directory
for now? Like this:

    Create `<path>` and checkout `<branch>` into it. The new working
    directory is linked to the current repository, sharing everything
    except working directory specific files such as HEAD, index, etc.
