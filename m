From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: git repack: --depth=100000 causing larger not smaler pack file?
Date: Mon, 23 Mar 2009 10:20:55 +0000
Message-ID: <e2b179460903230320x47d98bfdl614007bed7117b45@mail.gmail.com>
References: <867i2ot1fu.fsf@broadpark.no>
	 <alpine.LFD.2.00.0903171608080.30483@xanadu.home>
	 <86y6uwzgzo.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhIa-0001Rj-5P
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZCWKU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbZCWKU6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:20:58 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:62861 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZCWKU5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:20:57 -0400
Received: by qyk16 with SMTP id 16so2372431qyk.33
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F/Uiu4Yu0XVkBOibpydd5Rcu0eP3bTw+ReOVtugSMrk=;
        b=UrU7/KAkf3xDXbggxEPFViuQpBqKZyuX1Dp5pie+NGKKwPdVxc55qSES9XtPpNaqOX
         lV9v2mbksUAYvtG3phMsSZhAzXaItMPJNjx7GK5rhGjsYguc1X4R6Vxt0AymIzTeAaUJ
         Q3QXeqEF3kqVe3q2OlCcH9B4Sr5u89l6MG9pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o6q05Mqqm3yNsMsgMEK0T/x61LI9ToOmaZ0gxjrz5A3XOOjYeeffoXjQYJRfeDh67L
         d5EgIWzdKSc4SD/BeFD9xAwIBAqlEKBap62ECCDiM6h36zdp40vhR+gBvE9J4keVbF3m
         E8VSyI0q43WylO9Lr6GRcpspYdqh5UTx/5q+s=
Received: by 10.224.46.10 with SMTP id h10mr8556946qaf.176.1237803655232; Mon, 
	23 Mar 2009 03:20:55 -0700 (PDT)
In-Reply-To: <86y6uwzgzo.fsf@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114270>

2009/3/23 Kjetil Barvik <barvik@broadpark.no>:
> =C2=A0PS! =C2=A0I have the following in my $HOME/.gitconfig file:
>
> [repack]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0UseDeltaBaseOffset =3D true
> [gc]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0auto =3D 25
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autopacklimit =3D 1

Just an aside, but from my reading of how it works, there's very
little point in setting gc.auto to anything less than 257 and
statistically it won't kick in predictably unless set quite a bit
higher (say an order of magnitude).

Mike
