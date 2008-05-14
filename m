From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 14 May 2008 12:23:10 -0700
Message-ID: <7vod78n10h.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 <7vve1yzgfc.fsf@gitster.siamese.dyndns.org> <482018E4.9000908@gnu.org>
 <482B0354.2060207@gnu.org> <7vhcd0oiov.fsf@gitster.siamese.dyndns.org>
 <482B3854.9040906@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 21:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMaC-0005eh-Mk
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbYENTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYENTXV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:23:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbYENTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:23:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CF3841DD;
	Wed, 14 May 2008 15:23:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1311B41DA; Wed, 14 May 2008 15:23:14 -0400 (EDT)
In-Reply-To: <482B3854.9040906@gnu.org> (Paolo Bonzini's message of "Wed, 14
 May 2008 21:07:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35C84F08-21EB-11DD-8D7C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82137>

Paolo Bonzini <bonzini@gnu.org> writes:

>>>> I think it is reasonable to require cloning with the
>>>> least-common-denominator version in this case.  Think of what
>>>> happened if the pack format changed.
>>> Any news on this (and on 1/7, which is in pu)?
>>
>> The pack-format change is a big deal and benefit everybody.  Comparing it
>> with this change feels like comparing an apple and a poppy seed, doesn't
>> it?
>
> Yes, but it is the same.  Another example is when remotes started
> being created in refs/remotes/origin upon cloning.  In general, you
> cannot expect a clone to be downwards-compatible (or, you should
> expect a clone *not* to be downwards-compatible).

I think we are in agreement and that is all the more reason we have to be
extremely careful not to introduce incompatibility without a clear
advantage.  The commands involved with your patch work with or without the
new default entry in the config created by the clone exactly the same way,
and the versions before your patch would choke with the new default entry.
