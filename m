From: Florian Aspart <florian.aspart@gmail.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 15:15:38 +0200
Message-ID: <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
 <5582BA1F.1030409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:16:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Zfo-0000Br-ER
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 15:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbbFRNQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 09:16:00 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:33776 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbFRNP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 09:15:59 -0400
Received: by yhpn97 with SMTP id n97so55771851yhp.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hbyn3h5NTI5hljj1pDH4b9umbI2Hyh6Q9LeKCQw7nZM=;
        b=BRoB8UkJ2wOGWxPETtuaNiGaCKzUlw1K0h3T3yYwJhbBszrN9MmvBpZ50V2IW4TeNY
         MDHNtqncXDbNKNOuaJvWbELUfQyihCsvvqKR+E/AfOcuMt1bSlfxhE8jkofuEz9KBvoc
         HuOlXh4tEXFqaMmXH/vlOjFHZLsBO8kamQ+QLvHxMF/KhLPzwWeI1nAiaMrTogCom6kg
         hI/N62J5wP6T1is7UOyFuNQjMhYdoxjk8FZrP6WfupTNKnekc6zmF2Z5HXVELUhBcr3+
         aPz9kY6QymJvsPdDx8tHt+Pw2DhjDfD+io8ZvBWAW91SIf4lChNy53qsAoP6UZ+5jYAK
         qceg==
X-Received: by 10.170.87.134 with SMTP id e128mr13024322yka.109.1434633358376;
 Thu, 18 Jun 2015 06:15:58 -0700 (PDT)
Received: by 10.37.114.85 with HTTP; Thu, 18 Jun 2015 06:15:38 -0700 (PDT)
In-Reply-To: <5582BA1F.1030409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272006>

Hi Michael,

yes in this case "difftool" compares an uncleaned working tree file
with a cleaned blob. I did not try the smudge filter to see if it
applied in difftool.

I think the problem comes from the way difftool is feeded, since I
also had this problem when setting an external tool for the diff in
the gitconfig file.

However, I'm not sure if this is a bug or it is designed to be so.
If the external tool changes a cleaned working tree file during the
diff, then by saving this file the result of the cleaning filter would
also be saved in the working tree.

2015-06-18 14:31 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
>> Hi everyone,
>>
>> I created a clean filter to apply on some files before commiting them.
>> The filter works correctly when I commit the file and is also applied
>> when I usethe iff command line tool.
>> However, when using difftool with meld, the filter is not applied and
>> the different versions of the files are compared without any
>> filtering.
>>
>> Is there a way to apply the clean/smudge filters when comparing the
>> working copy of a file to the HEAD version in a gui diff tool?
>>
>> I'm using git version 2.4.3 under Ubuntu.
>>
>> Best,
>> Florian
>
> Are you saying that "difftool" compares an uncleaned working tree file
> with a cleaned blob? That would be a bug in either difftool or the way
> we feed difftool.
>
> Michael
>
