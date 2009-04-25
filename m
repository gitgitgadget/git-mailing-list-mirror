From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Extra metadata in the commit?
Date: Sat, 25 Apr 2009 11:49:37 +0200
Message-ID: <81b0412b0904250249k717ae07did24867bd6ca6e8a2@mail.gmail.com>
References: <d411cc4a0904241547p64c0af2bycae20cd4b26e43f6@mail.gmail.com>
	 <alpine.DEB.1.00.0904250154080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 11:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxeY5-0002kh-UX
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 11:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbZDYJtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 05:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbZDYJtj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 05:49:39 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45122 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZDYJtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 05:49:39 -0400
Received: by fxm2 with SMTP id 2so1473202fxm.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PQYEBuKmxr2ijMnDhDzK/2kFDIz/gQraDaMA40JE4ko=;
        b=Lb3YOKWtKTskU/ItOHnL2F53OILxUNsMZdZEq2p+CxxMdEy8/CG06HUsQu6rr93HKM
         ey4rourSUxrziL1cdAxE7vtopfYaipWxio89ToSyfLGPp9LH4YcuhNAeahqP2YDDXA50
         nrBpbLA3ravfxkeLemnJEnILDjx7Zp2eUeTZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bKXYtfAz7fT8/o5ez+9jeeqxAXIeXprH4gMfiEek7LjXj+viXtfRqwvQI+jxhCZbis
         1p44T7Bh7wr3YVhmkx4E4mfbjxFbmE1fuJmfTC+IGvdRIBnCDG4uQ40pbksTaZxAMGoD
         yqTHUnGp/BgNIbRMk0vHUx2Dj03vZxudJKp3Q=
Received: by 10.204.69.66 with SMTP id y2mr2994906bki.49.1240652977450; Sat, 
	25 Apr 2009 02:49:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904250154080.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117541>

2009/4/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 24 Apr 2009, Scott Chacon wrote:
>
>> I'm working on a hg<->git bidirectional tool using Git as the
>> communication protocol, so there is a bunch of Hg metadata that I ne=
ed
>> to keep in Git to ensure I can convert commits created in Hg back in=
to
>> the exact same objects after they upload to the Git db and then come
>> back down. =C2=A0This means storing explicit rename info, branch nam=
es, etc
>> somewhere without messing up Git clients that want to work on the sa=
me
>> repo. =C2=A0So, I can keep this data in the commit message, but I th=
ought it
>> would be cleaner to keep it as extra fields in the commit object bef=
ore
>> the "\n\n" separator.
>
> I'd suggest keeping it in the commit body, for better visibility and
> easier handling by tools.
>

BTW, by the same convention we treat the very first line of a commit
message specially, we can say that the last line, if non-empty
(IOW, does not end with \n), is treated specially by UI tools
(grayed out, for example):

  Subject\n
  \n
  Body\n
  \n
  something:very:special
