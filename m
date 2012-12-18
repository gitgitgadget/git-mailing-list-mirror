From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: bug? 'git log -M100' is different from 'git log -M100%'
Date: Tue, 18 Dec 2012 09:47:33 +0530
Message-ID: <CAMK1S_jVuJgmdb47A=SGV7_9uH2SEj-SHYFdSY_7nSuLCNxdkQ@mail.gmail.com>
References: <20121217233446.GA5987@sita-lt.atc.tcs.com>
	<7vfw34jgmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 05:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkojj-0004ue-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 05:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab2LREYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 23:24:21 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:32986 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab2LREYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 23:24:20 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 23:24:20 EST
Received: by mail-la0-f54.google.com with SMTP id j13so118790lah.27
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 20:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pUxxE6sObe7+RPzXPHD017+upFa5Zdb+NfdX1CIy8Gw=;
        b=AAgJ15DzaSHonb/ewZ3h5YiNEJrltdJNWiRZDz5XpA+zrpSgma89ile3OdT3IpqFYz
         o/u6QrHM+RdhARSHdDNDJcYJDKW50f/75ORpAIyfLNGhXmHBJb1RVMp6NhjNAvs2x/Oe
         9sCEn3cFEXMjNc5EHRydOrlKu5gtbxL6klU5SxiHRmLv2A1wzcXn0Ze1pNkLr32Bxbf6
         mBXLAin/WBhoUZmz14hBRN+AO+sJ/C7/wi4cJeeH9QOhbw7vlSn9tg6IneagBpwtdNqm
         Uj45L0q+QBllpSV6eHryhxOfiTBMmSpjGkwLeP3n0Ora75F/kgwKXkC8cNpIOVhHECGV
         1JiQ==
Received: by 10.112.87.40 with SMTP id u8mr325069lbz.50.1355804253922; Mon, 17
 Dec 2012 20:17:33 -0800 (PST)
Received: by 10.112.31.137 with HTTP; Mon, 17 Dec 2012 20:17:33 -0800 (PST)
In-Reply-To: <7vfw34jgmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211735>

On Tue, Dec 18, 2012 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> When using -M with a number to act as a threshold for declaring
>> a change as being a rename, I found a... quirk.  Any 2-digit
>> number after the M will work,...
>
> That is not 2-digit number.
>
> A few historical trivia may help.
>
> Originally we said "you can use -M2 to choose 2/10" (like "gzip"
> taking compression levels between "-0" to "-9").  Then Linus came up
> with a clever idea to let people specify arbitrary precision by
> letting you say "-M25" to mean 25/100 and "-M254" to mean 254/1000.
>
> Read the numbers without per-cent as if it has decimal point before
> it (i.e. -M005 is talking about 0.005 which is 0.5%).  Full hundred
> per-cent has to be spelled with per-cent sign for obvious reasons
> with this scheme but that cannot be avoided.  It is a special case.

Oh nice.  Makes sense; thanks!

I submitted a patch to diff-options.txt (separately).

regards

sitaram
