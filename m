From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Wed, 13 Jun 2012 19:00:07 +0100
Message-ID: <4FD8D527.6050703@diamand.org>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com> <4FD6440C.7090900@nokia.com> <4FD67530.1090002@diamand.org> <4FD70DEB.7040506@nokia.com> <20120612222431.GA13427@padd.com> <4FD83A08.6070208@nokia.com> <4FD88DE0.4050606@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Ilya Dogolazky <ilya.dogolazky@nokia.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sers2-0003L4-QO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab2FMSAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 14:00:38 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62212 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2FMSAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 14:00:37 -0400
Received: by eeit10 with SMTP id t10so306621eei.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 11:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=OezfQTFM8qeiyHb14v2iiW8fkA5FDqMJdWZ3wG12Co8=;
        b=c9PoGEYojPPtiEz4ZLigmln0rn+3jRgRJL8e2L+1H1Xnkr9u8s+2w1XliJIrihjTTG
         bHXWZ5nebLMZa+21BgNQj8rBqwjf8mnIvS69rVRpy/AHfTZceRxlgBmfY0RlMs86Vw8W
         UhFheG+/9Li8L02nItoNQzyNDRYqtRb3pu7hRY7PVFug1DcfrQuAuZOfkz4WK9uXU+t2
         ICoRgUxehnot9VUTOzJ51eiz646EFI+w0VvTD5q6CSLulkzU3tESRrEv6VkKitvSwmvy
         kxI3SECWU54L4L+YMZBICPQryqMdTofAH5yQpf8Jo3ydGi9fWzdse3wJOrRdefHUqOOO
         rB3Q==
Received: by 10.14.47.129 with SMTP id t1mr1456013eeb.179.1339610435640;
        Wed, 13 Jun 2012 11:00:35 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id x52sm10183886eea.11.2012.06.13.11.00.34
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 11:00:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <4FD88DE0.4050606@nokia.com>
X-Gm-Message-State: ALoCoQlOoYxhovTYszs39yJXIdMGo/7wWlByHJVJv3ydW9/mwJ04DOROwdBZP6+yij6Bl1bdJXkv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199912>

On 13/06/12 13:56, Ilya Dogolazky wrote:
> Hi !
>
> 06/13/2012 09:58 AM, Ilya Dogolazky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
>> $ P4CLIENT=3Dxexe1 git p4 submit
>> Error: Cannot locate perforce checkout of //xxx/yyy/ in client view
>
> After some playing around with git-p4 script and adding debugging
> printing I realized, that the solution is to do
>
> $ P4CLIENT=3Dxexe1 git p4 clone //xxx/yyy/zzz@all ~/xexe1
> instead of just
> $ P4CLIENT=3Dxexe1 git p4 clone //xxx/yyy@all ~/xexe1
>
> After that "git-p4 submit" started to work.
>
> I still don't understand p4 enough in order to know why it's happenin=
g,
> but now at least I can clone+change+rebase+submit files into the
> perforce repository with git-p4, which is great.
>
> Luke, Pete: thanks a lot for your help and patience!

So - what is a p4 stream? I found some blurb on the Perforce website bu=
t=20
I was none the wiser after reading it.

Thanks!
Luke
