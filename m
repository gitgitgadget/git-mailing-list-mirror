From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git checkout --no-guess
Date: Mon, 26 Oct 2009 11:17:04 -0700
Message-ID: <76718490910261117i60a556ebv7405e945796a3610@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
	 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
	 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
	 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
	 <20091022062145.6117@nanako3.lavabit.com>
	 <7vskdcz973.fsf@alter.siamese.dyndns.org>
	 <7vtyxsxtmp.fsf_-_@alter.siamese.dyndns.org>
	 <32541b130910211551n13e0dd1bha6dcdc82d1d6b4cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2U80-0005B2-K5
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 19:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbZJZSRC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 14:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbZJZSRB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 14:17:01 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:60430 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZJZSRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 14:17:00 -0400
Received: by iwn10 with SMTP id 10so6130988iwn.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LmoS0cpvSOH+g9vP2/DqzFmhpUCf6gmIsBeNV6LAjC8=;
        b=TXkQXe2GomBH+6r5TfXMnG0JvAB5784pyeiHyYmvHXOVFvT40dk4P8ctCKweniO1FS
         OSRPJK1wNdMxs4QUk5nWh6y2on5U/oqg38rFAktlVrWwiFGp8j6HhyWtB8RSzTz40PJp
         VmfsQJ67j/A9MNA7ZcbY3i7zsTTSYfv65h51E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C4JFx2JorQJ87EZX2m4Tik33Vr0DNLpZrhc9uB2GQGPWL1bRd+UB2QHo5CDxIsB4ux
         tE36iahfpAbg2kftf33S9OU1ywt8K+xdin8uVIe706W1vKNlZt6yKQbxYvWZZGXLyFYk
         jh8pzNjjfvXw27orE3liy34s9vSYsejzu1tu0=
Received: by 10.231.120.90 with SMTP id c26mr8169540ibr.1.1256581024894; Mon, 
	26 Oct 2009 11:17:04 -0700 (PDT)
In-Reply-To: <32541b130910211551n13e0dd1bha6dcdc82d1d6b4cd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131259>

On Wed, Oct 21, 2009 at 3:51 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Wed, Oct 21, 2009 at 6:35 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> As this is strictly script-only option, do not even bother to docume=
nt it,
>> and do bother to hide it from "git checkout -h".
>
> Is it a standard git policy to not document script-only options? =C2=A0=
As a
> person who writes scripts that use git, we will need to discover thes=
e
> options somehow...
>
> Just curious. =C2=A0(And now wondering how many other wonderful optio=
ns are
> in there but undocumented...)

 *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
 *                     shown only in the full usage.

Which translates to --help-all:

--help-all
           Some git commands take options that are only used for
plumbing or that are deprecated, and such options are hidden from the
default usage. This option gives the full list of options.

 So git checkout --help-all should show it.

j.
