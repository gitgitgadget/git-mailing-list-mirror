From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Fri, 24 Jun 2011 08:17:30 +0200
Message-ID: <4E042BFA.3020909@web.de>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de> <7vboxo2ne9.fsf@alter.siamese.dyndns.org> <4E03C7E5.4050008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 24 08:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZzhy-0005vL-N6
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 08:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab1FXGRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jun 2011 02:17:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57352 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab1FXGRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 02:17:32 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 52F821A39F80D;
	Fri, 24 Jun 2011 08:17:31 +0200 (CEST)
Received: from [93.246.52.168] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QZzhr-0002zK-00; Fri, 24 Jun 2011 08:17:31 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <4E03C7E5.4050008@gmx.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18TkHv13axhIklADETLvsbs9feTFhoW0Lums4FR
	JksOCykzBmhT6Jwh6Dk+SoXL+8O/6p4LXRUc9ZRu3uq9pq9d2N
	z+MnL2QRPBlfACL7ajbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176303>

Am 24.06.2011 01:10, schrieb Andreas K=F6hler:
> There are two minor issues for me left.
> (1) The man page of submodule sync talks about "all submodules" and n=
ot
> "registered submodules". I treated it as "subsequent init" and
> personally do not restrict the list of submodules, simply because my
> build would not work without them.

While investigating this I stumbled across that too, will post a patch.

> (2) It is confusing to have registered submodules in .git/config with=
out
> a matching gitlink. Say, you switch between branch a1 with a submodul=
e s
> with url u1, to a branch without s, you git clean -xdff (url u1 is st=
ill
> in .git/config, right?), and then to a branch a2 with s pointing to u=
rl
> u2. This bugged me.

I think that is ok, because that way git remembers that the user cares
about submodule s even when he switches to a branch where s doesn't
exist. And the documentation is pretty clear that you'll have to use
"git submodule sync" to update the url itself from u1 to u2 when needed=
=2E
