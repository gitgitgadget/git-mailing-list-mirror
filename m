From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Nesting a submodule inside of another...
Date: Thu, 14 Jul 2011 00:04:34 +0200
Message-ID: <4E1E1672.7040503@web.de>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com> <4E1C9F21.6070300@web.de> <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com> <4E1E0C27.60903@web.de> <7vhb6p6fcl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 00:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh7Y0-0002Gn-En
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 00:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab1GMWEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 18:04:42 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49139 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1GMWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 18:04:41 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 37B3719345572;
	Thu, 14 Jul 2011 00:04:35 +0200 (CEST)
Received: from [93.246.47.236] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qh7Xn-0002qQ-00; Thu, 14 Jul 2011 00:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7vhb6p6fcl.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+bs2GEL60yoXTaGq6bZXB5Q2F95fHro4bwqJiO
	JB2iga4AGT063IMzzS0968/I76cY5ASxibuCQr0T1ObmSxhilO
	eC4VwQMFXLoxJJ/jH2Aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177087>

Am 13.07.2011 23:27, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> It can't be communicated, as submodules are unaware of their superproject.
> 
> It's more like s/can't/shouldn't/ and s/are/shouldn't be/, no?

Right. Submodules /could/ be taught to check if they are part of a
superproject, but unless I miss something obvious they are currently
totally unaware of that (at least when it concerns their work tree, the
gitfile effort is trying to introduce some superproject awareness). And as
far as I can see that is a sound design decision as far as it concerns the
work tree. Imagine the files and/or directories a submodule has to ignore
would depend on the settings of their superproject too (which is what this
thread is about). That would lead to very interesting problems when the same
submodule would be used by different superprojects which ignore different
files and/or directories inside the submodule, which - to make things even
more interesting - might be recorded in the submodule itself ... not good.

So what about: s/can't/isn't and shouldn't/ and s/are/are and shouldn't/?
