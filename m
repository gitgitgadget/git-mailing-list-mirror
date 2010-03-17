From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 07:59:19 +0100
Message-ID: <4BA07DC7.9070502@viscovery.net>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 07:59:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrnE9-0006yx-Gg
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 07:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab0CQG7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 02:59:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13576 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0CQG7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 02:59:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NrnDr-0007lU-JJ; Wed, 17 Mar 2010 07:59:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 562EB1660F;
	Wed, 17 Mar 2010 07:59:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100316214717.GA24880@progeny.tock>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142369>

Jonathan Nieder schrieb:
> If I am understanding properly, your idea is that this would be used =
on
> a branch after =E2=80=9Cunmerging=E2=80=9D it from master:
>=20
>     B --- C --- D [topic]
>   /              \
>  A ---  ...   --- M ... --- U [master]
>=20
> Here M is a merge commit and U a commit reverting the change from M^
> to M.

If I were to re-merge topic into master a second time after this
situation, I would install a temporary graft that removes the second
parent of M and repeat the merge. After the graft is removed, the histo=
ry
would look like this:

     B --- C --- D --------------.   [topic]
   /              \               \
  A ---  ...   --- M ... --- U ... N [master]

Are there any downsides? I don't know - I haven't thought it through.

-- Hannes
