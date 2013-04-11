From: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
Subject: Re: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Thu, 11 Apr 2013 10:36:14 +0600
Message-ID: <51663DBE.2080603@bee.kz>
References: <5165B758.4070308@bee.kz> <CAJDDKr76K_-d6JSgv67DcXnZybpxkTjYPJxdObU3wrn+nYV3dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 06:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9FI-0005Ed-MG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 06:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab3DKEgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 00:36:20 -0400
Received: from mail-bk0-f50.google.com ([209.85.214.50]:46289 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3DKEgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 00:36:19 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so583044bkc.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bee.kz; s=beekz;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3YSPnmEwBhONLvBKN1d8uNsKwIjNeoq0fFP/EZxHif4=;
        b=ZP/bXvnkQS7xEhaFa3sJKB153D6/20cC9NscmX6ElMdY5dVgai3G2Lk9zXlc1dTee4
         q88y9jBxBOxUExoqnmIRXC4vl9RtcZCNu7unrqtgY47CywaGPsMXixpbV0vQsZ+f6BPq
         vGl4D/FspEXwZqUrBHgKblbMgUbZwTinHJFhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=3YSPnmEwBhONLvBKN1d8uNsKwIjNeoq0fFP/EZxHif4=;
        b=noLo7AUZfyx2w0hcSVGYJEIimX7TaR9LbW4cLHW0K2Vrh5tRe7SlXj4SWUEnG3Y4Zb
         lhdllchDvzmqyyaAw9Two4MX12KA732c0xvxAoodNv5SQXNEamv9aD/RAv2FvlzUTcqL
         7BqyJUXYch9eeZlAzMLkJUiZ0bF9OZPKwuMqXoD34xMwP1V5ADzJAf4g1G3U0h5IeFTt
         NroCBeJHF+wCpHIiHWUJjcZmjw2cfSyymtRb9oneKSnOX+MVvTJPF4nRYicjeG3HVrcy
         CLE3wP8jUo20abNj5HtHglkxNqOF/+dK6Fm0KNzGPUYUQz7CXjg5pd02lx1zFIAXAvsU
         6EGw==
X-Received: by 10.205.11.194 with SMTP id pf2mr1809643bkb.46.1365654978490;
        Wed, 10 Apr 2013 21:36:18 -0700 (PDT)
Received: from Tairs-MacBook-Pro.local ([2.135.63.167])
        by mx.google.com with ESMTPS id v2sm1008285bkw.5.2013.04.10.21.36.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 21:36:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAJDDKr76K_-d6JSgv67DcXnZybpxkTjYPJxdObU3wrn+nYV3dw@mail.gmail.com>
X-Gm-Message-State: ALoCoQkxVrpowijsJ/1eDjYa2TNBdhb2/aW2Wupm5FOavuhiX9cCU59CbMtFSaFXSjlZP0ooTk7l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220817>

On 4/11/13 8:46 AM, David Aguilar wrote:
> Apologies because I don't know the Tk API very well.
>
> In Qt there is an API method to raise windows -- QWidget::raise().
>
> Is there no similar API in Tk?
>
> I seems like this may be related:
>
> http://wiki.tcl.tk/9457
>
> ..but it seems that -topmost may not be exactly the same thing.
>
> That said, if there's no portable way to do it, then this is certainly a
> workaround.

Yes, I tried that one. Here is a quick test:

========== hello.tcl =============
#!/bin/sh
# Tcl ignores the next line -*- tcl -*- \
exec wish "$0" -- "$@"

package require Tk

grid [ttk::button .b -text "Hello World"]
wm attributes . -topmost true
==================================

I'm not sure I'm doing it right, but it doesn't work.

Look like Tcl/Tk dev are very paranoic about windows created from 
Terminal/shell scripts: they don't let them take over , even if it is 
desired.
