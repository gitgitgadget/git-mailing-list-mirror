From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Sat, 24 May 2008 12:59:12 +0200
Message-ID: <200805241259.13132.jnareb@gmail.com>
References: <20080524043118.GA23118@laptop> <m3ve142jkc.fsf@localhost.localdomain> <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 13:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzrUE-0004Lt-OF
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 13:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbYEXK7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 06:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbYEXK7V
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 06:59:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYEXK7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 06:59:20 -0400
Received: by ug-out-1314.google.com with SMTP id h2so40987ugf.16
        for <git@vger.kernel.org>; Sat, 24 May 2008 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=kcLtTeezcuIgHleHmlfk3GAqMwLXzD6BDVA/+XHk7Vk=;
        b=tK8FZVPf6bzwWCH+1/uVN7ul3OnNTbqMmqqbnyUA/ZMUuHelI1TeuEAUU0Nxd5VxRlCC7Exh2Am+cXHewRUCmkzZZGVY1xR3RkaTxm6svFan96TNn1lGhI3rf3RsbHxR35CHOuxeMVuhPRGOsdMz4mDg5EZcP793TDBhDs7cv0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Iz0TT3sz+strPIeaRWBGwKtd0yo+W/CdJPv4D/hnDRGZerhN99E1C5XRJhbmVRrqq+kYNo4o+bGvOyFRZocj0wMwjs7viRY0tPNKCfBsJ/kN1NqxGg3OH2mtaRPh5IpzYz5ute37u8czQ+kdNTYlKiNVMSnniZHjLwaFhi2N/74=
Received: by 10.67.115.1 with SMTP id s1mr2234972ugm.74.1211626758608;
        Sat, 24 May 2008 03:59:18 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.233.1])
        by mx.google.com with ESMTPS id e1sm4411962ugf.71.2008.05.24.03.59.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 03:59:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82808>

On Sat, 24 May 2008, Nguyen Thai Ngoc Duy wrote:
> On Sat, May 24, 2008 at 3:28 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> +--color::
>>> +     Show colored matches.
>>> +
>>
>> Why not borrow from GNU grep manpage?
>>
>>   --colour[=WHEN], --color[=WHEN]
>>      Surround  the  matching  string  with  the marker find in GREP_COLOR
>>      environment variable. WHEN may be 'never', 'always', or 'auto'
>>
>> We probably would also want it configurable (via config variables),
>> as `color.grep' I guess.

And color.grep.<slot>, where slot can be 'match', and probably later also
'context' (I don't remember if git-grep implements -C<num> option...).
 
> Yes. But this patch was really to scratch my itch and I felt good
> after having it colorized so did not bother with configuration system.
> I will probably make it a config var when I get tired of typing
> --color too often ;)

Thanks for sharing, although I guess Junio would prefer more complete
patch...

>> I think compatibility with grep (using GREP_COLOR) would be good idea,
>> and easily implemented.
> 
> I had no idea that variable existed.

Well, I have though that git always use external grep, so this would
be for free. After reading the patch more carefully it seems like it
isn't so.

Still, perhaps that would be a good idea, but I guess for later patch.
-- 
Jakub Narebski
Poland
