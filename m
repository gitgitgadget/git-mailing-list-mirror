From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: zsh: improve bash script loading
Date: Wed, 29 May 2013 01:30:48 -0500
Message-ID: <CAMP44s1UwYxS_sZSKTyEj5rhmrJ4gFkPc9z+eCL6WAaHXkY8eQ@mail.gmail.com>
References: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
	<51A59D8E.1040502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 29 08:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZua-0003Pg-Om
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521Ab3E2Gav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:30:51 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:49396 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757865Ab3E2Gau (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:30:50 -0400
Received: by mail-wg0-f53.google.com with SMTP id m15so6383476wgh.32
        for <git@vger.kernel.org>; Tue, 28 May 2013 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XQaNTtda2xLRAkA/Ds0KoPXqidbAiafwq+twB+FpKEA=;
        b=AD607sZtA0uOwPxDGqE1Ecw/+y1z0lTvCkz0+MxKTyO+kfQP1nIPpz6cOR+cm5Rt41
         7PytfOAcxtOFdyHVqNhjRJUx7oQKV4LGOMfMA7UPBY/QW+/ah6LPbNXSx1L1WgRSJ1zO
         DTVQJKhg5a+w6G3ON29stjRpLBIaOGJiG50yNorT1ZeN9Qz9lt2u1b0RDuCT9janxgvS
         RSw5/Pc92pW28G/d8JHk4qmvASSwfEZteFv5CNa57UMnVMHRMxTgldp67OyLe66LZyGP
         djxbTkxfpMej0IzmKQ0ojERN/eap2GZTNNKUPnkzqvlXfGs+h2LzVCXZFycrnk2WhH+j
         6Asw==
X-Received: by 10.180.184.101 with SMTP id et5mr937277wic.45.1369809048548;
 Tue, 28 May 2013 23:30:48 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Tue, 28 May 2013 23:30:48 -0700 (PDT)
In-Reply-To: <51A59D8E.1040502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225754>

On Wed, May 29, 2013 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/29/2013 5:24, schrieb Felipe Contreras:
>> +if [ -z "$script" ]; then
>> +     local -a locations
>> +     locations=(
>> +             '/etc/bash_completion.d/git' # fedora, old debian
>> +             '/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
>> +             '/usr/share/bash-completion/git' # gentoo
>> +             $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>> +             )
>
> Won't you need
>
>         local e
>
> here, or does it not matter?

You are right, otherwise it would be in the user's shell.

-- 
Felipe Contreras
