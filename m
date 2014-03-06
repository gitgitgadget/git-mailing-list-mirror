From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Thu, 06 Mar 2014 20:35:48 +0100
Message-ID: <5318CE14.1090000@web.de>
References: <1393974076.7891.27.camel@Naugrim> <5317662C.6010404@web.de> <1394064956.7891.28.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Henri GEIST <geist.henri@laposte.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLe5G-0005Fj-AU
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbaCFTfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 14:35:54 -0500
Received: from mout.web.de ([212.227.15.3]:65427 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbaCFTfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:35:53 -0500
Received: from [192.168.178.41] ([84.132.148.165]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M5wkL-1X5vCw3DJZ-00xpoH; Thu, 06 Mar 2014 20:35:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394064956.7891.28.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:p8hmRRUjZAjmfstB+NWjqQ7Tyepi0t5K9BS9qGqXimmnY7IpzyQ
 rEMQottainVhBuh84sJOoV8ppnfqQ/cJib2Xuf1zrWuo1xhWuLpfIINT5YgjvO1U0ybVHmB
 sAi+5gxP38fznCplfZgtgXenoLPhgYZBFs36mVnldQaciyk5WPYH/Z11TshrveXyUBHbbo/
 5ihOWnp7R+s0fLT5KQsUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243539>

Am 06.03.2014 01:15, schrieb Henri GEIST:
> Le mercredi 05 mars 2014 =C3=A0 19:00 +0100, Jens Lehmann a =C3=A9cri=
t :
>> Am 05.03.2014 00:01, schrieb Henri GEIST:
>> - Wouldn't it be easier to pass the '--recurse-submodules"
>>   option to the "git clone" call for the superproject instead
>>   of adding the _do_clone_submodules() function doing a
>>   subsequent "git submodule update --init --recursive"? That
>>   is also be more future proof with respect to the autoclone
>>   config option we have in mind (which would add that behavior
>>   for "git clone" itself, making the call you added redundant).
>=20
> That is what I planned to do at beginning.
> But git-gui never call git clone anywhere.
> It make the clone step by step with a long and complicated list of
> commands just like a Tcl rewrite of git-clone.
> Have a look on the function _do_clone2 in choose_repository.tcl.

You're right, it does fetch followed by read-tree ... so my
proposal doesn't make much sense here, sorry for bothering you
without checking the source first.

> As I suspect there should be a good reason for this that I did not
> understand I have choose to not refactoring it.

That makes sense. Shawn, could you shed some light on why clone
is coded again using plumbing in git gui instead of just calling
the clone command?

> And in fact looking in the code 'git clone --recursive' do nothing
> else than calling 'git submodule update --init --recursive' like I
> have done to complete this rewrite of 'git-clone'.

Yep. Note to self: Port everything we add to clone to git gui too.
