From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 09 Nov 2010 13:53:29 +0100
Message-ID: <4CD94449.1040201@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>	<1288524860-538-2-git-send-email-avarab@gmail.com>	<4CCFCCC8.7080603@viscovery.net>	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>	<4CD8F965.6050402@viscovery.net>	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>	<4CD918AB.6060206@viscovery.net>	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>	<4CD9241F.6070807@viscovery.net>	<AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>	<4CD933BF.6070105@viscovery.net>	<AANLkTimhbp3AngtJjBYhHpa173=D-XJOg9L2sd6YMCwA@mail.gmail.com>	<4CD93CF2.2060800@viscovery.net> <AANLkTiny+NmXew6UxjNMO+o75=CxxWm9iVRMRxs0LyTJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 13:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFni2-0006cz-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 13:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab0KIMxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 07:53:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2460 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1749667Ab0KIMxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 07:53:34 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFnhZ-000534-Id; Tue, 09 Nov 2010 13:53:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4FBC81660F;
	Tue,  9 Nov 2010 13:53:29 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTiny+NmXew6UxjNMO+o75=CxxWm9iVRMRxs0LyTJ@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161043>

Am 11/9/2010 13:38, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> I understood your previous comments to mean that the invocation time
> of git-* on one hand and cat(1) on the other hand had to do with how
> many DLL's the former needed.

I was only guessing; I can't explain the timing difference.

> Since git-sh-i18n--envsubst needs the same DLL's (i.e. the libc) as
> cat(1) and *nothing else* it should be as fast as cat(1) and not as
> slow as git-*(1) once I fix that unfortunate Makefile bug, right?

Wrong. Please accept it as a fact (and I'll forgive your ignorance ;) I
would like to spend the time explaining the reasons only if you want to
compile git on Windows yourself.

-- Hannes
