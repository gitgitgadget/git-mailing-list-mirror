From: Junio C Hamano <gitster@pobox.com>
Subject: [Junio C Hamano] Re: Consolidate SHA1 object file close
Date: Sat, 14 Jun 2008 15:42:33 -0700
Message-ID: <7viqwbfxk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 00:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7eTJ-0000dw-Fw
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 00:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbYFNWmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbYFNWmu
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 18:42:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbYFNWmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 18:42:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D05B85433;
	Sat, 14 Jun 2008 18:42:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F2685432; Sat, 14 Jun 2008 18:42:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35B819C2-3A63-11DD-8BC4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85048>

--=-=-=

Somehow the thread went off-list, so I'm diverting it back to the list...


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

X-From-Line: gitster@pobox.com Sat Jun 14 15:32:07 2008
X-Delivered: at request of junio on gitster
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	gitster.siamese.dyndns.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO autolearn=ham version=3.1.7-deb
X-Delivered: at request of junio on gitster
Received: from snug.pobox.com (snug.pobox.com [208.210.124.72]) by
 mailstore.pobox.com (Postfix) with ESMTP id D97DFA61E1 for
 <77302942@mailstore.pobox.com>; Sat, 14 Jun 2008 18:28:37 -0400 (EDT)
Received: from snug.pobox.com (localhost [127.0.0.1]) by snug.pobox.com
 (Postfix) with ESMTP id BCF1BAAFF8 for <77302942@mailstore.pobox.com>; Sat,
 14 Jun 2008 18:28:59 -0400 (EDT)
Delivered-To: gitster@pobox.com
X-Pobox-Delivery-ID:
 4769CB2C-3A61-11DD-B8B0-D5FA46518568-77302942!snug.pobox.com
x-pobox-client-address: 207.106.133.19
x-pobox-client-name: a-sasl-fastnet.sasl.smtp.pobox.com
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
 [207.106.133.19]) by snug.pobox.com (Postfix) with ESMTP id C550CAB981 for
 <gitster@pobox.com>; Sat, 14 Jun 2008 18:28:56 -0400 (EDT)
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CAB715360; Sat, 14
 Jun 2008 18:28:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1150C535F; Sat, 14 Jun 2008 18:28:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
References: <20080611222534.GC16439@artemis.madism.org>
 <alpine.LFD.1.10.0806120758090.3041@woody.linux-foundation.org>
 <20080612160012.GA13533@artemis.madism.org>
 <alpine.LFD.1.10.0806121108210.3041@woody.linux-foundation.org>
 <20080613074951.GA596@artemis.madism.org>
 <20080613093101.GA4372@artemis.madism.org>
 <alpine.LFD.1.10.0806130749190.2949@woody.linux-foundation.org>
 <20080613155948.GB8340@artemis.madism.org>
 <alpine.LFD.1.10.0806130911520.2949@woody.linux-foundation.org>
 <20080613181044.GC27202@artemis.madism.org>
 <20080613181557.GD27202@artemis.madism.org>
 <alpine.LFD.1.10.0806131431320.2949@woody.linux-foundation.org>
 <7vhcbvhohr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806141212280.2949@woody.linux-foundation.org>
Date: Sat, 14 Jun 2008 15:28:27 -0700
In-Reply-To: <alpine.LFD.1.10.0806141212280.2949@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sat, 14 Jun 2008 12:16:42 -0700 (PDT)")
Message-ID: <7vmylnfy7o.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID:
 39470578-3A61-11DD-A04B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
X-ICG-Account-ID: 77302942
Lines: 27
Xref: gitster.siamese.dyndns.org all:19108 outgo-mail:18323 git-mail:45236
MIME-Version: 1.0

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 14 Jun 2008, Junio C Hamano wrote:
>> 
>> I've queued this...
>> 
>> commit 6483925999cde47e5108414ac3f57760394ee2d2
>> Author: Junio C Hamano <gitster@pobox.com>
>> Date:   Fri Jun 13 23:00:51 2008 -0700
>> 
>>     sha1_file.c: dead code removal
>
> Ok, the following three emails will contain three patches on top of that 
> commit that I think are ready for inclusion. They haven't seen a ton of 
> testing, and they are obviously to very core functionality, so in that 
> sense they are a big "scary".

Other than that I had to stop for a few seconds to think at the magic "20
bytes longer", they look scary-but-correct ;-).

I've tagged 1.5.6-rc3 with this (and other fixups), but it appears the
network between me and k.org is crappy today so I'll stop hacking for the
rest of the afternoon and spend time on something else.  Will push the
results out sometime tonight.

Thanks.


--=-=-=--
