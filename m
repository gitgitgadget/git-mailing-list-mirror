From: Florian Aspart <florian.aspart@gmail.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 16:17:52 +0200
Message-ID: <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
 <5582BA1F.1030409@drmicha.warpmail.net> <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
 <20150618132622.GJ18226@serenity.lan> <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5aeC-0002g3-82
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 16:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbbFROSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 10:18:14 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:36575 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbbFROSN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 10:18:13 -0400
Received: by yhan67 with SMTP id n67so57036863yha.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Jw0shOQaWzlXjiPykek7MG0xYXOr4++Hhu8ZA3e65DA=;
        b=O7MCBHLXwG2UN4b417EK72BsyfAvgUEFze+e0w8zX8l/hMXhxw/xkkvk0NXw6ZTAcd
         Eq8DvjjeMRQiNfvbSHeSE7j8SieHdbCBSVKSVhdP55NZqQ7uHtsvNtIiKrB3r65bVpab
         62ops1SeKDaX+ZRk1TwaT+zajqsPEAxKcd01rwvONKyURxgTxYXYmMMsGfFffn9YvJE6
         TuIK85LmMsJT1jYE3HBVVYdYC5dLkgznyQIxk8Xp8djZwiQm6TtH6FetyxoSpBm47h5G
         1xLxyXzk5uYd9ilWHYaGyUePVwPVVbmgKDQsCSZ0WzkT6YgeQSSgg2ZI3Zw/9HWdP3Az
         dR0g==
X-Received: by 10.129.49.198 with SMTP id x189mr14016452ywx.47.1434637092625;
 Thu, 18 Jun 2015 07:18:12 -0700 (PDT)
Received: by 10.37.114.85 with HTTP; Thu, 18 Jun 2015 07:17:52 -0700 (PDT)
In-Reply-To: <20150618141116.GK18226@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272010>

2015-06-18 16:11 GMT+02:00 John Keeping <john@keeping.me.uk>:
> On Thu, Jun 18, 2015 at 03:51:25PM +0200, Florian Aspart wrote:
>> 2015-06-18 15:26 GMT+02:00 John Keeping <john@keeping.me.uk>:
>> > [Please don't top-post on this list.]
>> >
>> > On Thu, Jun 18, 2015 at 03:15:38PM +0200, Florian Aspart wrote:
>> >> 2015-06-18 14:31 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
>> >> > Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
>> >> >> Hi everyone,
>> >> >>
>> >> >> I created a clean filter to apply on some files before commiting them.
>> >> >> The filter works correctly when I commit the file and is also applied
>> >> >> when I usethe iff command line tool.
>> >> >> However, when using difftool with meld, the filter is not applied and
>> >> >> the different versions of the files are compared without any
>> >> >> filtering.
>> >> >>
>> >> >> Is there a way to apply the clean/smudge filters when comparing the
>> >> >> working copy of a file to the HEAD version in a gui diff tool?
>> >> >>
>> >> >> I'm using git version 2.4.3 under Ubuntu.
>> >> >>
>> >> >> Best,
>> >> >> Florian
>> >> >
>> >> > Are you saying that "difftool" compares an uncleaned working tree file
>> >> > with a cleaned blob? That would be a bug in either difftool or the way
>> >> > we feed difftool.
>> >> >
>> >> yes in this case "difftool" compares an uncleaned working tree file
>> >> with a cleaned blob. I did not try the smudge filter to see if it
>> >> applied in difftool.
>> >>
>> >> I think the problem comes from the way difftool is feeded, since I
>> >> also had this problem when setting an external tool for the diff in
>> >> the gitconfig file.
>> >>
>> >> However, I'm not sure if this is a bug or it is designed to be so.
>> >> If the external tool changes a cleaned working tree file during the
>> >> diff, then by saving this file the result of the cleaning filter would
>> >> also be saved in the working tree.
>> >
>> > How is your filter configured?  Is it using a simple pattern (e.g.
>> > "*.c") or is it using a file path?
>> >
>> > git-difftool uses `git checkout-index --all --prefix=$dir/` and I wonder
>> > if the prefix means that the attribute specification does not match the
>> > temporary file that difftool produces, so no filter is applied.
>>
>> It is using a simple pattern:
>> *.ipynb filter=clean_ipynb
>
> I also realised that the code for file diff is very different from
> directory diff do you see any difference between git-difftool acting on
> files and with the `--dir-diff` option?

No, even with the --dir-diff option, the filter is still not applied.
