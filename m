From: Jean-Baptiste Quenot <jbq@caraldi.com>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Tue, 28 Apr 2009 10:15:32 +0200
Message-ID: <ae63f8b50904280115y14ceef49x81ae6d61fb92e429@mail.gmail.com>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com>
	 <20080604192916.GB17327@sigill.intra.peff.net>
	 <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
	 <20080604230858.GA27136@sigill.intra.peff.net>
	 <2c6b72b30808060406u10d7b332g22ea28fe5470ddb1@mail.gmail.com>
	 <20080808211916.GA30583@sigill.intra.peff.net>
	 <2c6b72b30808100216j2c719bf2yb7dfba651db901e3@mail.gmail.com>
	 <ae63f8b50904230755p12170753qf3fc273b48afe4d4@mail.gmail.com>
	 <2c6b72b30904270321t3d73e2c5o5e3ac8d4b627e5ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 10:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyiU1-0004WZ-J7
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 10:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760231AbZD1IPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Apr 2009 04:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbZD1IPg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 04:15:36 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49143 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZD1IPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 04:15:33 -0400
Received: by fxm2 with SMTP id 2so378301fxm.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=f3SDyehDxakPE80j6AVYJDgCobZ6qVpH9AxJsCI/Dkk=;
        b=H7A9vf2kyVAvWhTayQZA7irb1bhgUD/TaOLauJ9LHqdzD3NQ37EOvdK8dpm4mBP4cr
         NN+ljQhETAcVCPUf12RSb5ejL2AsBUfVsa0+cc1FVSP3Iye1aGxNJkVXdP/BS1VChyM+
         0eXa7cIaMbTJ0gTrF9qU08JCKBn/CDNv31ICg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wH726sKZ3ZFVcmOzbgeEAFJBMIm9ZbYuQS67W6ymTmLhUt5+vPOGbjkDzRW2lbLX+8
         n2nf6YGjJix8R1oZnNG85Z7D/X7MADm+rRuuuB/oYyFvpdhaCPUoOIMKbELihe8rMtZo
         jN223Sf6+UIAAIq+Cu3ZYcvhNeMH32YHXOE8Y=
Received: by 10.239.179.13 with SMTP id b13mr355837hbg.81.1240906532156; Tue, 
	28 Apr 2009 01:15:32 -0700 (PDT)
In-Reply-To: <2c6b72b30904270321t3d73e2c5o5e3ac8d4b627e5ab@mail.gmail.com>
X-Google-Sender-Auth: 262baf922c26fb93
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117753>

2009/4/27 Jonas Fonseca <jonas.fonseca@gmail.com>:

> On Thu, Apr 23, 2009 at 16:55, Jean-Baptiste Quenot <jbq@caraldi.com>=
 wrote:

>> Restarting this old thread again. =A0Starting from 0.13 the
>> *tignowalk()* hack does not work anymore. =A0What's the preferred wa=
y to
>> feed specific revisions using stdin now?
>
> I don't know if it is preferred, but it works. First add a git alias:
>
> [alias]
> =A0 =A0 =A0 =A0tignowalk-helper =3D !git rev-list --pretty=3Draw --no=
-walk --stdin<
>
> Then modify tignowalk by replacing the line calling tig to say:
>
> TIG_MAIN_CMD=3D"git tignowalk-helper $tmp" tig </dev/tty
>
> ... and it should work. Maybe more git alias functionality can
> simplify the hack.

Works a treat, thanks!

I wonder how you managed to invent this trick though :-)
--=20
Jean-Baptiste Quenot
http://jbq.caraldi.com/
