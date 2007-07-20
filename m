From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 11:27:34 +0200
Message-ID: <46A08006.4020500@fs.ei.tum.de>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org> <85644fvdrn.fsf@lola.goet
 he.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 11:27:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBolz-0006bZ-TF
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 11:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbXGTJ1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Jul 2007 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbXGTJ1i
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 05:27:38 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:34948 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbXGTJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 05:27:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A4B24280A5;
	Fri, 20 Jul 2007 11:27:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kIyBuJR7MxqK; Fri, 20 Jul 2007 11:27:35 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-202.dclient.lsne.ch [85.218.11.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 462A92809E;
	Fri, 20 Jul 2007 11:27:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <85644fvdrn.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53075>

David Kastrup wrote:
>> Otherwise you could have two very different trees that encode the
>> same *content* (just with different ways of getting there -
>> depending on whether you have a history with empty trees or not),
>> and that's very much against the philosophy of git, and breaks some
>> fundamental rules (like the fact that "same content =3D=3D same SHA1=
").
>=20
> No, the content is _different_.  One tree contains a tracked
> directory, the other does not.  That means that the trees behave
> _differently_ when you manipulate them, and that means that they are
> _not_ the same tree.

You are mistaking things.  Like the executable bit on a file is not con=
tent, the fact that a directory should be kept despite being empty is a=
lso an *attribute* of the directory.  This is meta-data, not actual dat=
a (content).  So no matter how elegant tracking the "." entry might be =
(and I think it is, because it covers a lot of corner cases already), i=
t puts the information at the wrong place.

That's sad, because otherwise it would be really elegant.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
