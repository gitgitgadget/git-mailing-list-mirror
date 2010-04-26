From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 20:08:09 +0200
Message-ID: <z2m81b0412b1004261108n5453b5d2h179a944fa8db9b49@mail.gmail.com>
References: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
	 <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:08:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6SjD-0001Sv-2r
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab0DZSIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:08:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40161 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0DZSIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:08:12 -0400
Received: by gwj19 with SMTP id 19so3976964gwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=13cAad/qS0kI/bEIkhV7wvkOB8U4du51YpsGTKyN6Rg=;
        b=mgP6jBub+vL/QyWKmHhj8E8BXOfLAlXtS4UkFJim4OQZRC66tVoHd9pFVz+zRifmAp
         NoVmObXS7w/Pf77qU9QvoXkPDxSpViy08Gg/y6qW8RKmOIiQ2ufsPApOCMI+4m3jgYQu
         6u+O8gGr1185DqtM1pUhSiaN3wd5nGyYom14w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RSPgZU0mqNs+WdGQcirER5MVbQp2MpbCW7Z8fvsBuvqBGGYT3nmY8l/E+OiQiWqp69
         v/638xWH7VECypRsb6A4Y2sVDeVs9dfUVcI5qwtG9Mf/1B5TrgFcJAh0HQcGQ7N34Itm
         ad8xvnLhiNgP2FmKeVWy2+hIUFMNz5CbbFVto=
Received: by 10.101.199.40 with SMTP id b40mr4825438anq.208.1272305290255; 
	Mon, 26 Apr 2010 11:08:10 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Mon, 26 Apr 2010 11:08:09 -0700 (PDT)
In-Reply-To: <x2z76c5b8581004261056lcdb153a5j825db166916069e9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145840>

On Mon, Apr 26, 2010 at 19:56, Eugene Sajine <euguess@gmail.com> wrote:
> On Mon, Apr 26, 2010 at 1:54 PM, Eugene Sajine <euguess@gmail.com> wrote:
>> Hi,
>>
>> I'm wondering if there is a way to get some repo information if the
>> only thing i know is SHA-1 (no full path to the file)
>
> I mean of course the SHA-1 of the blob, i.e. the result of git
> hash-object some_file

Try 'git cat-file -t <sha>'. It prints what object type is under the hash.
Than you can use either 'git cat-file <type> <sha>' (the most precise version,
which shall fail if anything is wrong), 'git cat-file -p <sha>' or plain
'git show <sha>' (which always works, unless repo's broken).
