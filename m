From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: Re: [PATCH] Solve git-submodule issues with detached work trees
Date: Mon, 23 Jul 2012 15:22:57 -0300
Message-ID: <CAHCkQtOCrCaF01fu-LS5jaTbiD7mxmWu0Mi5Dh1YCvcjdUkqLg@mail.gmail.com>
References: <CAHCkQtNfz8Kbn810LgXEQ_rkyk4qn5amGgHQsv2uR6H38sTSrg@mail.gmail.com>
	<7vsjcjnjvj.fsf@alter.siamese.dyndns.org>
	<500D8C30.9010807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNHc-0003Ny-Bu
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab2GWSW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jul 2012 14:22:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33411 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab2GWSW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2012 14:22:58 -0400
Received: by pbbrp8 with SMTP id rp8so11250496pbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DF1hjQjsQfEuubzNhZS5F/p2V5QnhP+BfUCH36ImNS0=;
        b=pKbRRDvJYcUztDmu4QFo/usD2Amh6Rsv/fdi8O+BWFFRqiQti8DM9IfJe7Z/lz3nQs
         pWi3a8SranLpPrxlem7lIw2w7OruiyEclilSaaPxnhVLWzCSUrRAj5HH4Ui6lVapidkZ
         91wCnLmEh2B1SQMNnFPVMl06me1aMvULlHYPn7IWuX/KSQoC1tDB/2XJEUYlSKFbetw8
         Lbb9X/Nl/Xysl+fNqBEXmNypOUOuls38gm8nQzaMO5PCA01aA9kDCaMNVPBOF/v8hFZ4
         M6O7AJ6HbKWZ11WFGwpa9OBz/EW69TiI5R50GbBa6P58zReP26/hJ5g50+3+Ez0oc9r/
         Sahw==
Received: by 10.68.226.73 with SMTP id rq9mr37039208pbc.145.1343067777950;
 Mon, 23 Jul 2012 11:22:57 -0700 (PDT)
Received: by 10.68.48.100 with HTTP; Mon, 23 Jul 2012 11:22:57 -0700 (PDT)
In-Reply-To: <500D8C30.9010807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201948>

On Mon, Jul 23, 2012 at 2:38 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 23.07.2012 07:09, schrieb Junio C Hamano:
>> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>>
>>> A common way to track dotfiles with git is using GIT_DIR and
>>> GIT_WORK_TREE to move repository out of ~/.git with something like:
>>>
>>>     git init --bare ~/.dotfiles
>>>     alias dotfiles=3D"GIT_DIR=3D~/.dotfiles GIT_WORK_TREE=3D~ git"
>>>
>>>     dotfiles add ~/.bashrc
>>>     dotfiles commit -a -m "add my bashrc"
>>>     ...
>>>
>>> but git-submodule complains when trying to add submodules:
>>>
>>>     dotfiles submodule add http://path.to/submodule
>>>     fatal: working tree '/home/user' already exists.
>>>
>>>     git --git-dir ~/.dotfiles submodule add http://path.to/submodul=
e
>>>     fatal: /usr/lib/git-core/git-submodule cannot be used without a
>>> working tree.
>>>
>>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>>> ---
>>
>> I think this is in line with what we discussed earlier on list when
>> the interaction between GIT_DIR/GIT_WORK_TREE and submodules came up
>> the last time.  Jens?
>
> Yes, I think this is the only way submodules in current git can
> be used with the GIT_DIR and GIT_WORK_TREE environment variables:
> set them when adding or initializing the submodule and always use
> the same settings when accessing them later. Daniel's dotfile
> alias achieves exactly that, so his fix looks good. But I agree
> the tests should be improved as you already pointed out.

Hi Jens, Junio.

Thanks for reviewing the patch, glad to hear this is acceptable way to
fix my itch.

I will work soon on getting the test cases improved and the patch
submitted without line wrapping.

thanks again,
Daniel.
