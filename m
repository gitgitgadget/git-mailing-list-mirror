From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 2/5] connect: use static list of repo-local env vars
Date: Wed, 24 Feb 2010 08:33:15 +0100
Message-ID: <cb7bb73a1002232333o2470b8d5x3dd9bd22dd30764e@mail.gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1266968136-11129-3-git-send-email-giuseppe.bilotta@gmail.com> 
	<4B84D1BD.2030908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBkc-00075D-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab0BXHdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 02:33:37 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:44051 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0BXHdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 02:33:37 -0500
Received: by ewy4 with SMTP id 4so694502ewy.28
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=n2QNaGcPEBFVUJrp5O8mhlMsG47riIuzk6iHVoAx+js=;
        b=M2HzQurKoQvDB5C4fS92C1VJ7SQJm5th+hBbLTVemlKUbw4BnLxSeG98ZCWo5wIJnQ
         wRiOtiYDiBpt0ggU9n5C9H4aCpL2n/SP1vNAeeM9uKQfhKvfK5LNUZX8KNpSO+Rln/a3
         JEfqhxFZT6tG6eh95IQS6XGEN3BMb1QLavKhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wS2RtxT1Xn50RBRICpNXYlfqPkYotUdOuDLV3Bb8U/l62sfMyccxlqF0t2NNqTKct4
         GW4sT55x6qSiXQJXqAiMtz6kod4YELP+F3tHNJyNypp2ppxI9gigMTXv96I0mSlirftw
         XsqPCUXX8zj1e7Nl5Iopc9LQ4Eo8qJKvXA3h8=
Received: by 10.213.49.140 with SMTP id v12mr6659432ebf.6.1266996815259; Tue, 
	23 Feb 2010 23:33:35 -0800 (PST)
In-Reply-To: <4B84D1BD.2030908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140914>

Doh. I knew I should have waitied a little more before sending the new
series ...

On Wed, Feb 24, 2010 at 8:14 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Giuseppe Bilotta schrieb:
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* remove these from the environment */
>
> You shouldn't remove this comment.

Right. I should probably rephrase it a little, though.

>> - =A0 =A0 =A0 =A0 =A0 =A0 const char *env[] =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALTERNATE_DB_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DB_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_DIR_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_WORK_TREE_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GRAFT_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 INDEX_ENVIRONMENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NO_REPLACE_OBJECTS_ENVIRON=
MENT,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL
>> - =A0 =A0 =A0 =A0 =A0 =A0 };
>> - =A0 =A0 =A0 =A0 =A0 =A0 conn->env =3D env;
>> + =A0 =A0 =A0 =A0 =A0 =A0 conn->env =3D local_repo_env;
>
> IMO, you should squash this patch and the previous one under the subj=
ect
> "Move list of repo-local environment variables to a public place", an=
d
> that public place could be environment.c instead of a new file cache.=
c
> (the name "cache.c" is definitely wrong).

The list is now the right place (v4). The squashing is most definitely
a good idea, gives a better idea of the code movement.

--=20
Giuseppe "Oblomov" Bilotta
