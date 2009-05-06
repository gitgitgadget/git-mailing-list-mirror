From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Thu, 7 May 2009 09:15:23 +1000
Message-ID: <fcaeb9bf0905061615v2c1b1b4fmc6ade674aabf9586@mail.gmail.com>
References: <20090506055913.GA9701@dektop> <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 07 01:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qLr-0004lB-6l
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZEFXPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 19:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZEFXPo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:15:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:61472 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbZEFXPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 19:15:43 -0400
Received: by yx-out-2324.google.com with SMTP id 3so248123yxj.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=C9XvCe4c1ZC1IS936JqqrY+kO9q1Y8/uPoTG7cTALFQ=;
        b=t5vkUEFIQrry1MCC/0ZnsI1m1WB8mdcdueQeIN4I8aHrZUnTQ9j5EPu1SExm8ER4v+
         4507Lxjl/iQHGP40NGvpnNm/wvXAzzw761AaA+fUFqAjOsto5ZcMJuPrEZ/u2G1FbcYi
         Y+YEgVNzTByD4DPiYUF1jaCjRIeNVAF5eXTFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fyKt/d+TEfEOqMMmDBJe0wNxZJgZqpCZ2caWnwwIBU+LJqo4fe5kAcm5McdWYja/13
         aVJ36ButjQceE7bjBgygV7/7P56eiAxsyVxVJRAwGK/lz9tlbd8AOsEM5Dz+Av6tJkYk
         YCbhibFLpiqjj2c9efrsTDPOX+hGy+XbycqhQ=
Received: by 10.100.105.4 with SMTP id d4mr2350799anc.39.1241651743596; Wed, 
	06 May 2009 16:15:43 -0700 (PDT)
In-Reply-To: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118407>

On Thu, May 7, 2009 at 4:14 AM, Brandon Casey <casey@nrlssc.navy.mil> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>> Hi,
>>
>> I did "make test" on a SunOS 5.10 and it failed.
>
>> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
>> index b68ab11..61ccdee 100755
>> --- a/t/t4200-rerere.sh
>> +++ b/t/t4200-rerere.sh
>> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git merge first
>> =C2=A0'
>>
>> -sha1=3D$(sed -e 's/ =C2=A0 =C2=A0.*//' .git/MERGE_RR)
>> +sha1=3D$(cut -f 1 .git/MERGE_RR)
>
> Are you using /bin/sed? =C2=A0I think it has a problem with tabs.

Yes I use /bin/sed. if /usr/xpg4/bin/sed is recommended, test-lib.sh
should set up PATH automatically, I think.
--=20
Duy
