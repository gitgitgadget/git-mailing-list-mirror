From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Mon, 21 Jan 2008 22:37:00 -0800
Message-ID: <7vejcav01f.fsf@gitster.siamese.dyndns.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
	<alpine.LSU.1.00.0801220527550.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 07:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHCli-0007xx-Jw
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 07:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYAVGhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 01:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYAVGhX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 01:37:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYAVGhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 01:37:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 260566384;
	Tue, 22 Jan 2008 01:37:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC786383;
	Tue, 22 Jan 2008 01:37:12 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801220527550.5731@racer.site> (Johannes
	Schindelin's message of "Tue, 22 Jan 2008 05:35:40 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71422>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 22 Jan 2008, Sam Vilain wrote:
>
>>  Documentation/gitattributes.txt |   19 +++++++++++++++++++
>
> As I said on IRC already, I don't think that this is served well as a=
n=20
> "attribute"... it is most likely that the issue either affects _all_=20
> filenames , or _none_.

I do not think .gitattributes is the way to go, but I do not
think this has to be all or nothing either.

I can well imagine somebody wanting to do:

	Documentation/ja/README-spelled-in-Japanese
	Documentation/ja/... other files in Japanese ...
	Documentation/zh/README-spelled-in-Chinese
	Documentation/zh/... other files in Chinese ...

and have all files under Documentation/ja/ in EUC-JP while
Documentation/zh/ are BIG5 or whatever (I do not speak nor write
Chinese).

Maybe the project originates from Brasil and the string
"Documentation" itself is spelled as "Documenta=C3=A7=C3=A3o" and in
Latin-1 (no, I do not write pt_BR either, and I admit at this
point this is a contrived example that I cannot _that_ well
imagine, but is not so far-fetched).

So we _could_ have .git-encoding in Documentation/ja/ and
Documentation/zh/ each of which says "this directory and
everything below are in this encoding, unless overriden
otherwise by a deeper directory".
