From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to continue to run 'git svn fetch' for a repo with no git-svn 
	metadata
Date: Wed, 28 Apr 2010 00:04:24 +0800
Message-ID: <n2p46dff0321004270904gc590ef83v4b338719c4c18637@mail.gmail.com>
References: <t2u46dff0321004270248l49d1ae30l6b168342e01a5bfd@mail.gmail.com>
	 <z2l51dd1af81004270751yf026e946p4b00552eaf4f2632@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 18:05:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6nHY-0003Fz-V1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 18:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0D0QE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 12:04:27 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:61425 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0D0QE0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 12:04:26 -0400
Received: by qyk9 with SMTP id 9so19552903qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4wF2kVbZ1kYelQrUWIo/uV2cFYkxRnfaPHefPxttFJM=;
        b=KZSnfhjqULnsIUQCk2SH7Ldz+trmDAyiq0NH2kYcJ9s6cnrU6RDfgIp8OXHibQmuZ3
         /a2wKMNAwpF1lYgbunrVaUIm1q5mzoHe1xBid0ZoU4gyagtUneTde+K2hCkHDVyfimz6
         orNJL7juLtkSaCT9Ct/jVjsAyKimXAYO9IGvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=igHCfnIz5KcC4zR+wud+vBYyCOH0welPOXI33iBw4wcAI2nxHh8KEx/7N6EzD9UXbQ
         OOBLi21jZ4zmwpVfoNzGz/qsvIWp5cdeXrNd4HZLidChGZNY7mWIZDgFaJI9XmXzNxOg
         hKTJMB3H0tXrH4aUNmyLEY+AMPG2uo8rJVYtk=
Received: by 10.229.222.12 with SMTP id ie12mr3371965qcb.77.1272384264904; 
	Tue, 27 Apr 2010 09:04:24 -0700 (PDT)
Received: by 10.229.79.3 with HTTP; Tue, 27 Apr 2010 09:04:24 -0700 (PDT)
In-Reply-To: <z2l51dd1af81004270751yf026e946p4b00552eaf4f2632@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145927>

On Tue, Apr 27, 2010 at 10:51 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> Read these:
>
> =C2=A0 =C2=A0http://code.google.com/p/chromium/wiki/UsingGit#Initial_=
Setup
> =C2=A0 =C2=A0http://trac.parrot.org/parrot/wiki/git-svn-tutorial
>
> This should probably be in the git-svn documentation itself.

Thanks. The last link explains very clear. I just copy and paste from i=
t.

Adding git-svn metadata to the github clone

If you want to re-populate the SVN metadata that can quickly be done
by taking your up-to-date clone of leto's repo off of gihub and adding
this to your .git/config

    [svn-remote "svn"]
            url =3D https://svn.parrot.org/parrot
            fetch =3D trunk:refs/remotes/trunk
Then run this command to find the "top commit"

     git show origin/upstream | head -n 1
and put that commit hash into a file .git/refs/remotes/trunk
(obviously replace the has with the one from the above command)

     echo c85aaa38b99cedb087e5f6fb69ce6d4a6ac57a0b > .git/refs/remotes/=
trunk
and finally

     git svn fetch
