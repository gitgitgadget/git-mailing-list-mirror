From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git difftool does does not respect current working directory
Date: Sun, 15 May 2011 22:39:18 -0700
Message-ID: <7v1uzznr09.fsf@alter.siamese.dyndns.org>
References: <loom.20110514T160931-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 07:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLqWm-0006yJ-2O
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 07:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab1EPFj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 01:39:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab1EPFjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 01:39:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6C5C353C;
	Mon, 16 May 2011 01:41:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L7pUh0fqSFJ2
	gyEtLPJNrAneLn0=; b=cboxSNpX5mBZrjD/zsjNTY1cudwwcu/JjxKkoPJZzLbR
	tu3lE3GZiv0SfAiL4/FT+ycaNCwH/ZeXafLLI7OP3mt01q8e6EC3vtqNVLdsfL2K
	Tu2cKdc2jTJYVtPWhXkSSCixfZL0QrOrr6KcujqTEaRwIMghEi+4UwFd2NSapWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=amzBGW
	ol/kOPnza4yjNNKYXX25jAFGgHLOtoHMmE6v+4Zqz6tol2E78BbV0wiflSsCWz4t
	0gBnnTal0qMdVk3wbwY0gV2uLGrnhyF5i8XWENzQf0X/Xu8RQUGwCymwAfTRGr4g
	Q2N/JnmoJj4S7ClLkrRtwAbveg9+AndJONSa0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3FB8353B;
	Mon, 16 May 2011 01:41:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E7C3E3538; Mon, 16 May 2011
 01:41:26 -0400 (EDT)
In-Reply-To: <loom.20110514T160931-46@post.gmane.org> (=?utf-8?B?IkZyw6lk?=
 =?utf-8?B?w6lyaWM=?= Heitzmann"'s message of "Sat, 14 May 2011 14:25:40 +0000
 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 260F54CC-7F7F-11E0-8513-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173703>

=46r=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes:

> Unfortunately, 'git difftool' does not keep the current working direc=
tory while
> launching gvimdiff.
>
> =3D> Is it done on purpose ?
> If not, it is probably a good idea to fix this.

I will not comment on "on purpose?" part, as I do not use difftool myse=
lf.

But the right set of questions to ask is not the above, but these:

 - Is it on purpose that difftool runs its diff viewer from the top of =
the
   working tree?

 - Is there any existing user who depends on that current behaviour?  I=
OW,
   would anybody suffer if difftool suddenly starts to run the diff vie=
wer
   from the subdirectory that the user started "git difftool" from?

If the answers to both of them are No, then it might be a good idea to
change the behaviour.
