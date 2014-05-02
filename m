From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Fri, 2 May 2014 07:15:44 +0700
Message-ID: <CACsJy8AhxJDcBHNWbssWs2F1oQB4xGG7rpBePX60m4=_+MVEZw@mail.gmail.com>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
 <20140501172007.GZ9218@google.com> <20140501230041.GC75770@vauxhall.crustytoothpaste.net>
 <20140501230553.GE9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 02:16:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg19H-0006mk-A7
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaEBAQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:16:15 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33055 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaEBAQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:16:14 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so4023991qge.16
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XUrbuXd/5pC43KHS98xwOK3Vwr8fa/Aqns/Jw+CyL4A=;
        b=Y7/QAwH6P9m61fcw5u2Kz28T7aPN5V/+bkYvGExwanr/3mM4+LzChOlLMCHSbvGriN
         qJ+6mEnwjNlwfn2Z5ncuqjo5ef4oHS9gLATwcpAdPuvewgMRJN6qto2OxDlBco2t/6xg
         2dtBwZMKpG9nXW/GE1ZwZKuiTPoX8iRX3QHIUD6oCJ9K+OFvhO5Skx9zcsaUWKj6BSHX
         4r286vhUBpu7GHpcLpd5wlqcqkL9/gtIDkldNYwoSK8JftgrqrxIltSCI2ubcdyo8UeP
         L0UAUYRdynxG8wta6aDYiMcwzUCm8aRzTacwigWUiSZNcmNki7TWVBpdASI9HK9AXU6R
         UO9Q==
X-Received: by 10.140.107.198 with SMTP id h64mr16984563qgf.30.1398989774113;
 Thu, 01 May 2014 17:16:14 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Thu, 1 May 2014 17:15:44 -0700 (PDT)
In-Reply-To: <20140501230553.GE9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247909>

On Fri, May 2, 2014 at 6:05 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> brian m. carlson wrote:
>> On Thu, May 01, 2014 at 10:20:07AM -0700, Jonathan Nieder wrote:
>
>>> What happened to the
>>>
>>>      struct object_id {
>>>              unsigned char id[20];
>>>      };
>>>
>>>      ...
>>>
>>>      struct object {
>>>              ...
>>>              struct object_id id;
>>>      };
>>>
>>> idea?
>>
>> There didn't seem to be a huge amount of support for it.
>
> I can make up for it in enthuasiasm.  Please?  It's something I've
> wanted for a long time but never found the time to do.

It's definitely better in the sense that the compiler will catch new
"char[20]" declarations for us. It's also a lot more work.

>>                                                           Also, there
>> were concerns that some architectures might impose alignment constraints
>> on it that made sizeof(struct object_id) != 20.
>
> Sounds awful.  What architecture?

No architecture was named last time if I remember correctly. But we
could check "sizeof(struct object_id) == 20" in a test or something.
When people scream, we can pack the struct on that particular
platform?
-- 
Duy
