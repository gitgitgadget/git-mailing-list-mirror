From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Sun, 15 May 2016 16:29:36 -0400
Message-ID: <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
References: <CADKp0pwHKvfSDG_-4p5tUn0_QiUGKzmRj5RwphfA8sZ_7CVHqw@mail.gmail.com>
 <20160513223336.GA18287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 15 22:32:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b22ib-0001yI-1q
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 22:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbcEOUaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 16:30:18 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33683 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcEOUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 16:30:17 -0400
Received: by mail-io0-f174.google.com with SMTP id f89so188729113ioi.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pUWS1UasE0tM1dq7a6D7JB/RlVWWLEXt2r3IT/4azPk=;
        b=As8gj0Qo6NE5G6UZt4Uyz3YvIBFYp73jK9gvHAvxuKX16tTSTNGNqsPp2SWfOoG3Uy
         w51RiCqeL6MdjkUn/VCH35O+ktPvu+2UryP6lwUVaRuznFYg/rvV5qwrb89zRvz6YBLp
         7CQMEInKtJmQ3lKtF9fO1tXn9nZxJBAACN22cd+Dsa5iqwFU/EdnetEFR+MYC82RYl5s
         J7SVqFH9ImxqkEJ+FjRjOVdHDRtBRF00x6+faHMdMupIw+09DcDAEnHmdu/nfLDmd3Kb
         dEyvMDIRT1icryws8VQRzC9m5xXy+u5lCtNfgqnuAENgyLHC6ODDCzqMoedEd4TJmNMN
         kPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pUWS1UasE0tM1dq7a6D7JB/RlVWWLEXt2r3IT/4azPk=;
        b=V6pWMy9iZsIn7k4yTLCeHnrsNssbHRwEFYS6E/rqxNzT0c+jDDLJp+bpmtlm1VkFod
         ixHzW1EM2lu/MjnOLP6i1maSVM4GXuqRkNnlupQL8Azbp/rMZFL7It/Zot9mvRY0HIJs
         /EWEy/ExxlAsg1EUteBzYUiGJV+NPUo1VqEJq5H6lsgFBmEzyKkYmeSw+4DczW89tXyK
         08NTellqak63oBuOEP8cgTbzWqs8yH2CifCtIciDS+7rSFuEXhDXhxmHp4dov/skhacq
         6ySEEzOMW0Ypa3rWExVGKRE7+hgC9o/2Z4DFoCHHa7CsX6dkxZwO+UUkGfBEmTFHfM50
         iaoA==
X-Gm-Message-State: AOPr4FUWpcwM0dqfx6tzmTxOAtrYcaLYm2Aw4P49h6j0WfQl5z1nD0IlOAlqCL2t/j0kDuwbaYFzIPvxxGziYQ==
X-Received: by 10.36.149.137 with SMTP id m131mr7364457itd.94.1463344215970;
 Sun, 15 May 2016 13:30:15 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Sun, 15 May 2016 13:29:36 -0700 (PDT)
In-Reply-To: <20160513223336.GA18287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294682>

Try it by making some changes to files and committing them, and then push.
It works fine for me when there is nothing to actually push, but not
so when there are commits to push.

It always outputs the progress to STDERR even when I add --quiet.



On Fri, May 13, 2016 at 6:33 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 13, 2016 at 05:21:30PM -0400, Chris B wrote:
>
>> Hi I am using 2.8.2.windows.1 and writing Powershell scripts doing
>> some Git stuff.
>>
>> I have to use the --quiet option for git because it constantly outputs
>> progress to stderr.
>>
>> However, it seems that --quiet does not actually work in git push. The
>> output still goes to stderr.
>> When there are changes committed to push it always outputs something
>> to stderr. If there is nothing to push, then it actually is silent.
>
> Can you be more specific? It seems to work for me:
>
>   $ rm -rf dst.git &&
>     git init --bare -q dst.git &&
>     git push dst.git
>   Counting objects: 6, done.
>   Delta compression using up to 8 threads.
>   Compressing objects: 100% (3/3), done.
>   Writing objects: 100% (6/6), 441 bytes | 0 bytes/s, done.
>   Total 6 (delta 0), reused 0 (delta 0)
>   To dst.git
>    * [new branch]      master -> master
>
>   $ rm -rf dst.git &&
>     git init --bare -q dst.git &&
>     git push -q dst.git
>   [no output]
>
> Are you seeing progress reporting, the status table, or something else?
> Are you using a particular protocol that might invoke a git-remote-*
> helper that doesn't respect the quiet flag?
>
> -Peff
