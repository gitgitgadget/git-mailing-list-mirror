From: Peter Voss <info@petervoss.org>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 14:04:49 +0200
Message-ID: <EDAD14B2-414A-436B-BA85-CBD9A13B2B87@petervoss.org>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org> <adf1fd3d0907130320s726bb80at58d454c830c7d5be@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Jul 13 14:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQKHF-0005ld-Hn
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 14:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbZGMMEz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 08:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbZGMMEy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 08:04:54 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:60278 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbZGMMEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 08:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1247486692; l=2195;
	s=domk; d=petervoss.org;
	h=References:Date:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:To:From:Cc:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=lYwcakpZIfrmTkJGyv0+fF6S8IA=;
	b=WXf8td0IYjOp3gfLNHpVFF2cFTc1SFow9oRhw3ztB1htRaMfnvwTXWuscL4VkCZlT7B
	eHYHj65xsAgYUAviEcWVyQ7lHspf0OX0+IgnCKv6rwDkU5WFKtP+b2wetWBK5N7LbTsTF
	VjvPqkPzF2qlUCGuXf5rAkN/XKyW0c/pofA=
X-RZG-AUTH: :JWICemC4fusRF4tAhweiuU4SRqyWF3gXMlHyMhzObhKwDIReNIDrirxOEFeT
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.108]
	(ip-62-143-242-232.unitymediagroup.de [62.143.242.232])
	by post.strato.de (fruni mo50) (RZmta 18.49)
	with ESMTP id z04158l6DBFeWj ; Mon, 13 Jul 2009 14:04:49 +0200 (MEST)
In-Reply-To: <adf1fd3d0907130320s726bb80at58d454c830c7d5be@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123188>

Hi Santi,

On 13.07.2009, at 12:20, Santi B=E9jar wrote:

> 2009/7/13 Peter Voss <info@petervoss.org>:
>> Hi,
>>
>> I want to use the git submodule feature to move part of my code to a
>> different repository at github.
>>
>> The issue is that developers should use different repository URLs =20
>> for the
>> submodule depending on whether they have commit rights or not.
>>
>> At the beginning I was using the public URL to set-up the submodule:
>> git submodule add git://github.com/x/mymodule.git mymodule
>>
>> The issue is that some developers are working behind a firewall =20
>> that blocks
>> the git protocol. These could only use the git@github.com:x/=20
>> mymodule.git URL
>> to get access.
>> But other developers can only go through the public URL
>> git://github.com/x/mymodule.git. So whatever I use it won't work for
>> everybody.
>>
>> What's the best way to deal with that? Could I set-up different =20
>> repository
>> URLs for one and the same submodule and use which one is appropriate=
?
>
> After the "git submodule init" you can customize the url. From "man
> git-submodule":
>
> init::
>        Initialize the submodules, i.e. register each submodule name
>        and url found in .gitmodules into .git/config.
>        The key used in .git/config is `submodule.$name.url`.
>        This command does not alter existing information in .git/=20
> config.
>        You can then customize the submodule clone URLs in .git/config
>        for your local setup and proceed to 'git submodule update';
>        you can also just use 'git submodule update --init' without
>        the explicit 'init' step if you do not intend to customize
>        any submodule locations.
>
> You can also use the config url."<actual url base>".insteadOf =3D <ot=
her
> url base>.
> See the git-pull manpage for examples.

I didn't get the insteadOf config running (maybe I have to update to a =
=20
more recent version of git). But modifying the URL in .git/config =20
should be a doable approach for us. In order to add the insteadOf =20
section we would have to edit the .git/config file as well, so that =20
doesn't seem to be much better.

Thanks for your help,
--Peter

> HTH,
> Santi
