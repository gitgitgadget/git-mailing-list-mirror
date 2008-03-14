From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify MSGFMT setting in Makefile
Date: Thu, 13 Mar 2008 21:50:44 -0700
Message-ID: <7vabl1vrh7.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
 <20080222065836.GE8410@spearce.org>
 <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
 <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site>
 <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site>
 <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com>
 <20080305071915.GI8410@spearce.org>
 <7v63w0gs87.fsf@gitster.siamese.dyndns.org>
 <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
 <18394.671.630499.836160@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1tR-0001Gr-No
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbYCNEvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYCNEvF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:51:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYCNEvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:51:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3857F1010;
	Fri, 14 Mar 2008 00:51:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 67F42100B; Fri, 14 Mar 2008 00:50:56 -0400 (EDT)
In-Reply-To: <18394.671.630499.836160@cargo.ozlabs.ibm.com> (Paul Mackerras's
 message of "Fri, 14 Mar 2008 15:44:15 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77174>

Paul Mackerras <paulus@samba.org> writes:

> I have a few commits for you to pull, but I am about to push a patch
> for gitk like the one you sent for git-gui, so I'll send you a pull
> request when I've done that.

Thanks.

>>  else
>>  	MSGFMT ?= msgfmt
>> -	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
>> +	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)
>
> I had to put "echo $$?" for it to work rather than "echo $?".

Yeah, very sorry about this; Shawn already has pointed it out to me.
