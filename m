From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 13:10:38 +0100
Message-ID: <4F6B16BE.1050003@viscovery.net>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hong Xu <xuhdev@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAgqv-0003or-Ol
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650Ab2CVMKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 08:10:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36924 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab2CVMKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 08:10:42 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SAgql-0004Bd-2Y; Thu, 22 Mar 2012 13:10:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C5D1D1660F;
	Thu, 22 Mar 2012 13:10:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F6AFEC8.9090907@in.waw.pl>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193646>

Am 3/22/2012 11:28, schrieb Zbigniew J=C4=99drzejewski-Szmek:
> On 03/22/2012 07:04 AM, Hong Xu wrote:
>> Hello everyone,
>>
>> If my ssh key is encrypted, "git pull origin mas<tab>" will give a
>> unexpected result, something like this:
>>
>> git pull origin masEnter passphrase for key '/home/user/.ssh/id_rsa'=
:
>>
>> I know maybe it is not possible to complete the "master", but maybe =
it
>> is better to not complete anything than append something like that?
> It is ssh itself which emits this message. The completion script call=
s
> 'git ls-remote origin', which in turn invokes ssh. Typing the passwor=
d in
> actually works, but I understand that you are annoyed by the message.
>=20
> I don't think there's an easy way to silence this in git completion,
> without affecting other times when the key would be requested. E.g. w=
e
> would want ssh to ask for the key while doing 'git pull', but not whe=
n run
> automatically during completion.
>=20
> Maybe git-ls-remote should learn --quiet?

No. IMHO, bash completion stretches too far by asking the remote for th=
e
refs that it has.

-- Hannes
