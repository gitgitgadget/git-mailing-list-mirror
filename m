From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: possible gitattributes eol bug with new eol=crlf | lf support?
Date: Mon, 13 Sep 2010 21:49:45 +0200
Message-ID: <EBF8B701-6DD6-4D7A-AE2D-49561B4FD7C6@gmail.com>
References: <AANLkTinC8g9m=2ka=7LiHH4MtfxC-NbxbsYQEbmMyXmN@mail.gmail.com> <1F2D74A7-1C9C-47D9-9C3D-E430E446CB94@gmail.com> <AANLkTi=xPpPZzUqVEHEkH2sKvSVZH+MzunET6vEA_tw5@mail.gmail.com> <4F27AD7B-2B2D-4378-B1D5-6F380396E0FF@gmail.com> <AANLkTi=9Wv9_s2zDEdpc8Dn7qXSRepZSToKkOrAoTQnR@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 21:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvF2x-0002dJ-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0IMTtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 15:49:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62390 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0IMTtv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 15:49:51 -0400
Received: by ewy23 with SMTP id 23so2865351ewy.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Oq01N2XP9mj0vqEXOO+hk7YEyz1kXfl2dXayjUC7Xfc=;
        b=yHSZ1lQKtHQe7hhEix815tUUJG7+MbTIMv556VPmAWmGWq47yzfKYn53NdvDlnSRJp
         h2NC3zpNNSPJZqC6Fc5PR91P4Q/Cal6FR/8M1JLI7wHxjmqCd/r9h4D86yrnW+HDQqG/
         BVwZB6LstvZv3tB6mia3HU1wAN3cjB79GV2Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=s9jmhaZgFHftn4nh51loTamjwQ9bYnXa/5S9V0LmAXr/TeIOlZDs/oz4ODHxAxcEP9
         GLgGzIlPSex90NbI/yZOqTa9aJJsffSHrsogtQQWDK/JCjfctbOUWiAcZ7h454q6M5Gp
         W/j85h/ZBFTbjOc31VQbplXFKTMKqWTDgOjik=
Received: by 10.14.47.79 with SMTP id s55mr3032284eeb.22.1284407389801;
        Mon, 13 Sep 2010 12:49:49 -0700 (PDT)
Received: from [192.168.0.3] ([178.72.27.54])
        by mx.google.com with ESMTPS id z55sm9767879eeh.9.2010.09.13.12.49.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:49:49 -0700 (PDT)
In-Reply-To: <AANLkTi=9Wv9_s2zDEdpc8Dn7qXSRepZSToKkOrAoTQnR@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156125>

On 12. sep. 2010, at 21.58, Robert Buck wrote:

> Thanks Eyvind,
> 
> I tried it on an experimental repository and it worked. Thank you for
> your recommendation.

Great :)

> I also found the following link at github which achieves a similar
> effect. Adding this for the record in case someone else searching for
> a solution in the future wanted more detail.
> 
>    http://help.github.com/dealing-with-lineendings/
> 
> The one thing I find curious about the github article is that it seems
> to recommend using autocrlf=true for ALL platforms once the linefeeds
> have been normalized.

That article hasn't been updated for 1.7.2, but what it's saying is that line ending normalisation should be enabled for all users (or none) if you want to avoid problems.

The point of the text attribute is to allow you to enable or disable line ending normalisation without the user having to configure anything; setting the attribute "text=auto" on all files is equivalent to every user manually setting autocrlf to "true" or "input" in that repository.

[...]

> So if we did this one-time normalization on all repositories, all
> branches, what holistic approach (eol, autocrlf) would keep our files
> sane for a mix of 1.7.2 and later, and 1.7.0.1 and earlier, Windows,
> Mac, and Linux?

I would set the text attribute to auto for all files (add the line "* text=auto" to .gitattributes) to take care of users with git 1.7.2 or newer.  Users with older versions of git should set autocrlf=true (Windows) or autocrlf=input (Mac and Linux).

Once all users are upgraded to newer versions of git you can change the normalisation to target only specific files or file types, but that's not advisable while any of your users have autocrlf enabled.

- Eyvind
