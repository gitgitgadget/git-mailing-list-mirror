From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Sun, 19 Aug 2012 21:38:48 +0200
Message-ID: <503140C8.3090603@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de> <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de> <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de> <7vpq84k9n5.fsf@alter.siamese.dyndns.org> <4FFB3DB9.6090808@web.de> <7vmx1uzekb.fsf@alter.siamese.dyndns.org> <502E74F8.4070209@web.de> <CABURp0qujqHRg+PkScNGbHccHyheJZesWBsJSC=crhUczOG7Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:39:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3BL1-0002ij-43
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab2HSTjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:39:00 -0400
Received: from mout.web.de ([212.227.17.12]:53686 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab2HSTi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:38:59 -0400
Received: from [192.168.178.41] ([79.193.94.6]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MLxrY-1T270L49TI-008TRi; Sun, 19 Aug 2012 21:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CABURp0qujqHRg+PkScNGbHccHyheJZesWBsJSC=crhUczOG7Mg@mail.gmail.com>
X-Provags-ID: V02:K0:Whu1s6XiM4kmCmICKolJOEmVjjoPYlAfzrK88tetqp3
 hag/WqPl5a28G51BIUbU1iXAD/HrBaCH6/ixiLmiXCNYM518tV
 QuKDLFx0x2+OqdnbVIrMarhYIoikON6BcAJUdOO4Z29165dexR
 yzQa0xmVPp9bGzcAsyS1hwoXwiloMANftTG5fX9eOo8LO51FxU
 3rqv7ah2+HoLZ8GydZo3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203734>

Am 17.08.2012 20:11, schrieb Phil Hord:
> On Fri, Aug 17, 2012 at 12:44 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> I'm almost there. The only thing left is to check if a nested
>> submodule is using a git directory. In that case I expect "rm" to
>> fail even when -f is used to protect the submodule's history. I
>> still need to find a suitable command for recursing the submodules
>> and doing that check.
> 
> I suppose the style of this is wrong, but this seems to work for me.
> 
> git submodule foreach --recursive '! test -f .git'

Thanks! I was looking for something less expensive, but given that
I don't expect removing submodules to be a performance critical
operation this test should just work fine.
