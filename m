From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Tue, 24 Nov 2009 08:52:29 +0100
Message-ID: <b8197bcb0911232352v438c721at44601c608f4a7afe@mail.gmail.com>
References: <20091123221628.GE26810@ldl.fc.hp.com>
	 <7v6390sqhz.fsf@alter.siamese.dyndns.org>
	 <20091124004554.GA27643@ldl.fc.hp.com>
	 <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
	 <7vfx84jsef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Chiang <achiang@hp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCqCT-0002Qa-Nl
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761AbZKXHw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 02:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757729AbZKXHw0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:52:26 -0500
Received: from mail1.space2u.com ([62.20.1.135]:46692 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530AbZKXHwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 02:52:25 -0500
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com [209.85.218.223])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nAO7qNLH032609
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 08:52:23 +0100
Received: by bwz23 with SMTP id 23so6040838bwz.29
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 23:52:30 -0800 (PST)
Received: by 10.204.29.18 with SMTP id o18mr5866368bkc.39.1259049149867; Mon, 
	23 Nov 2009 23:52:29 -0800 (PST)
In-Reply-To: <7vfx84jsef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133567>

On Tue, Nov 24, 2009 at 8:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Karl Wiberg <kha@treskal.com> writes:
>
>> I think that sounds like a splendid idea. It would be interesting to
>> see just how thin a wrapper around git send-email (and format-patch)
>> stg mail could become, without sacrificing features anyone actually
>> uses. The main complication could be stg mail's templates.
>
> Why do you even need to run format-patch? =C2=A0If stg mail supports =
a good
> templates to prepare message files, it would be natural to keep using=
 that
> to prepare message files.

The only thing stg mail _really_ needs to do, strictly speaking, is to
be git send-email with an easy way to specify a patch, or a range of
patches, to send. Anything above and beyond that is functionality that
we have to write and maintain without the help of the larger git
community, and which won't be of use to said community for no good
reason. Take the template system for cover letters and patches, for
example: there's no reason why it couldn't be part of the git tools,
and if it had been, it would have had many more users and much more
developer love.

It's a question of deciding in which areas the benefits of doing it
ourselves are worth the cost, and where it's better to let git do the
job for us. And of recognizing that StGit is old enough that tradeoffs
that were worth it when git was not as mature and featureful as today
might be worth reconsidering from time to time.

(Alex: Sorry if I'm making a big deal out of this. Just because
rewriting stg mail entirely in terms of the git tools might be
_possible_ doesn't mean that just a few steps in that direction
wouldn't be worthwhile. But I thought I should raise the possibility.)

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
