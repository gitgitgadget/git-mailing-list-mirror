From: "Ian Brown" <ianbrn@gmail.com>
Subject: Re: git and filesystem problems (ext3 and vfat)
Date: Thu, 16 Oct 2008 18:23:53 +0200
Message-ID: <d0383f90810160923m60ec95d8v8550a611f91176b6@mail.gmail.com>
References: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
	 <48F76936.3010801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqVev-0004yA-Mx
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 18:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYJPQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbYJPQX5
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 12:23:57 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:52217 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYJPQX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 12:23:57 -0400
Received: by gv-out-0910.google.com with SMTP id e6so44032gvc.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QyFFeGz7Sj4ElyDvoSCr83zKyYE9sg/KSf43ow7d2FY=;
        b=gU4Bi7cL7u46iXL+koLfLhJM+O2bNT1CI4h7nWwQ8nw17cFxs89koGYJAaKC/0E8y9
         fnMHmKpQQjEnQGA2A0kYZAdLlA+cEnmS3tuqnlVISjNEAETSQrVS/4QUadhqbH1yq4MB
         +mdnPzq0mrjo3W7yLD6W5+SrDIsIlFriXArRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VjsXAkHTH/g88f2Ybj5uU1IygZOMMBGp/DZcjC3qRiLafzxYhnajb4NY00g8mrA3pP
         lw6LxYOQAl6ZeDjWmRhnHoW/h8kR8Ni3fIWtTZv2vQvbE/95dHTuM1Q+5WGxiJrWW/XI
         8BnwA08peWYQn4hyHeJeiMMcZ8ZbMm7leqJTw=
Received: by 10.86.60.14 with SMTP id i14mr3101fga.73.1224174233417;
        Thu, 16 Oct 2008 09:23:53 -0700 (PDT)
Received: by 10.86.27.16 with HTTP; Thu, 16 Oct 2008 09:23:53 -0700 (PDT)
In-Reply-To: <48F76936.3010801@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98398>

Hello,
Thanks for you quick answer.

ls shows the files.

git status shows:
fatal: Not a git repository
Regards,
IB

On Thu, Oct 16, 2008 at 6:17 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Ian Brown venit, vidit, dixit 16.10.2008 18:03:
>> Hello, ]
>>
>>  I have a diskOnKey which has a vfat filesystem.
>> I ran there:
>> git clone git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
>> the I copied all the wireless-2.6 folder to an ext3 partition.
>
> How did you copy it?
>
>> There I ran git diff.
>>
>> I get many messages like these (probably on all files of the repository):
>>
>> diff --git a/COPYING b/COPYING
>> deleted file mode 100644
>> index ca442d3..0000000
>> --- a/COPYING
>> +++ /dev/null
>> @@ -1,356 +0,0 @@
>> -
>>
>> and then all the lines of the file with "-" in the beginning, as if
>> they are empty.
>>
>> Why is it so ?
>> Is there any way to overcome it ?
>> Must I run "git clone" on an ext3 DiskOnKey only ?
>
> git diff gives you the difference between the index and the work tree.
> The index is the one you copied from vfat; git doesn't see the files on
> the ext3 work tree. Do you see them with ls?
>
> One by one I would try
>
> git status
> git reset
> git reset --hard
>
> in order to reconcile your index with your checkout. You probably need
> the last one.
>
> Michael
>
