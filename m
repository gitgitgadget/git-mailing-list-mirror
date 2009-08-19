From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 10:56:55 +0200
Message-ID: <c472dffc0908190156n759231e2l1074432ca0271827@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <4A8AE7C5.7050600@gmail.com> <4A8AED8B.9080604@gmail.com>
	 <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
	 <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>
	 <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de>
	 <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com>
	 <alpine.DEB.1.00.0908190910270.5594@intel-tinevez-2-302>
	 <4A8BA9EC.9000006@storm-olsen.com>
	 <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	"Johan 't Hart" <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdgyd-0000oe-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZHSI44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 04:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbZHSI44
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:56:56 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:58624 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZHSI4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 04:56:55 -0400
Received: by bwz19 with SMTP id 19so4613134bwz.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kEHh1h9hW0X7uC5ytSHbHcyJSY9vVbvP4jALELDHQqw=;
        b=DrOmLl90NOAUUQ0WfcEnKXqVu8g7BJaf51I/Z2bUpHnvuWeAahB1Oq+y5INsFYsTDq
         5G1mxsmUq7g1j0udj0LpGM+H7L71w75SqhgBc2JTE2ojepAJ37dtG+uxPc4jN2c60moj
         Xq3uUTXf2iM359NhWkIkchLjsLsX4xA6xJm18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xWoDi63EGwnUNf7hu5oLz0nuTvPQRZe6oGx839WY0pUzKVzQ7xzsXjC4WN2EOCCiKj
         +fPhkARKqFIM0/2O9lobWu2lJ4xdnmDYZbN6++FOTr1BrczrsOvgUsLrjcqkEL2CRaQO
         b/qGrk5y+t4Bpk2CJY+i2ZQ8/CTpZHP9xLvhc=
Received: by 10.223.15.17 with SMTP id i17mr1516048faa.75.1250672215142; Wed, 
	19 Aug 2009 01:56:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908190951020.5594@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126521>

Hi,

On Wed, Aug 19, 2009 at 10:29 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 19 Aug 2009, Marius Storm-Olsen wrote:
>
>> The full IDE support is secondary, first because you *can* use the I=
DE
>> already, and second because it'll be harder to whip something up whi=
ch
>> guarantees that the vcproj support stays in-sync at all times and wo=
n't
>> lag behind.
>
> I think the point of Frank's patches is to make Visual Studio users
> comfortable with Git. =A0You cannot ask those to use a build process =
or an
> IDE they are not used to.
>

I don't know Frank's intentions behind adding the .vcproj files. Maybe
it was just easier for him to create them, rather than hacking the
Makefile?

As a Windows / Visual Studio user, I have to agree with Marius' points
here. Most importantly, get the git code itself to compile with Visual
Studio. Did anyone do any benchmarking yet? I wouldn't be surprised if
we got some speed improvements from this. Also, it will no longer
impossible to use the Visual Studio debugger.

Supporting the Visual Studio compiler in the Makefile seems like an
excellent and maintainable way of getting the build up and running.

I can't speek for all Visual Studio users, of course, but personally I
couldn't care less about the .vcproj files. I use other IDE's for
developing on Windows (qt-creator, eclipse-cdt), so for me .vcproj
files would be useless. The Makefile should work from any IDE. In my
experience, all of qt-creator, eclipse _and_ Visual Studio support
running any make-like program, and parse the compiler errors correctly
without using sed or other kinds of magic.

>
> I still think it would be possible to use a combination of a
> Makefile rule and GNU make features to spit out a list of targets and
> their dependet .h and .c files.

I wouldn't mind if someone was willing to add and maintain this, of
course, but at least for me it wouldn't be particularely useful.

Cheers,
Thomas Berg
