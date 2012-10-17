From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: clean up __gitcomp() tests
Date: Wed, 17 Oct 2012 20:21:21 +0200
Message-ID: <CAMP44s2Daj-yvTqKc-fMiqvA64z_odZy_dhGvtB7rM--LbuQRQ@mail.gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	<1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
	<20121017175040.GE2156@goldbirke>
	<20121017175428.GF2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYFJ-000528-TX
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab2JQSVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 14:21:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53584 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab2JQSVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2012 14:21:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so7690447obb.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1jKaGj+NxjKdrYKteR80wfmXmlMOZ1Hd9iPE3rvBFDY=;
        b=EhpSunDOww5sTMt72y/1LKPfgt27TRFztoellac5YxRJIG1ogUjasre0wF142UoxBm
         33vZbpBr+P6/1WTUNhir+UtKqbOSvDg/Hyk4YKHBC8FBQP7SVHzbD1OJCWG+wrCsEYq2
         6M32bklbC10rRPQA0gCWfPcSoFVe7dd+ap8crLgw71O1KsFxgq0UZpNSICa9JARjTJkW
         +oAevunKuM9byeSmpUz2kBZR7a0CPyojN/QR0O0XKcj4srJvr6mDQ5RfOU7Cssko6wrD
         2lTRtxLRY4MfkF6vk9YUOxAtyUgchNeRzUZt3X0bABL3Qm35ccD1Z+vMTAx17hU2rTUC
         c+KA==
Received: by 10.60.27.71 with SMTP id r7mr16233308oeg.96.1350498081759; Wed,
 17 Oct 2012 11:21:21 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 11:21:21 -0700 (PDT)
In-Reply-To: <20121017175428.GF2156@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207930>

On Wed, Oct 17, 2012 at 7:54 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> Clean up two issues in the tests I added in 74a8c849 (tests: add test=
s
> for the __gitcomp() completion helper function, 2012-04-17):
>
>  - The COMPREPLY array is created using 'local -a' while in a
>    subshell.  However, the local keyword should only be used in a
>    shell function, and a variable created in a subshell is by
>    definition local to that subshell.  Use 'declare -a' instead.
>
>  - The contents of the COMPREPLY array is written through an IFS
>    fiddling + echo + redirection combo, although there is the
>    print_comp() helper function for exactly this purpose.

Makes sense. But this code seems awfully similar, a helper function mig=
ht help.

--=20
=46elipe Contreras
