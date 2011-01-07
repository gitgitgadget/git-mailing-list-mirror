From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 06 Jan 2011 17:07:05 -0800
Message-ID: <7vpqs98qti.fsf@alter.siamese.dyndns.org>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com> <20110106180051.GC11346@burratino>
 <7vpqs9aiul.fsf@alter.siamese.dyndns.org> <20110106204605.GA15090@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 02:07:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb0nu-0007c4-Kj
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 02:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1AGBHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 20:07:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab1AGBHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 20:07:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A94444842;
	Thu,  6 Jan 2011 20:07:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaPtU4d9+LSoTFJA17mtiHARjxo=; b=wjy4vU
	gYSP0zv8YHk5ET+IfVUkNKTgb/qbzbt/lvi96IU+6SK53RG9XpgbwFCT96js+hkf
	fNw1v/NdXDieRfJ04G8E3heQ55gU1iwfpAQsNUZj3a0qGSVEF0RWlSaq2D/bxc4l
	9ksO6MTmue4No8Wzyx4F0i3EQ2h3osnKZL/MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eb4aGbnhNb6jVxpUOycbr8ABkcCKUY9L
	gqz0nJWtxDe6vHELwXNCYG2vX8+8/bDK81c+q0lBlQx2X2jEtczWstyWyY+6R/sF
	Nri1TmfpxQae34PRs38dWfxzhybk2uXmLhfCwVV5CJwVnlKeab81C1Zkez0rqiqj
	b6nSPjdoLp4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 659184840;
	Thu,  6 Jan 2011 20:07:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17A26483E; Thu,  6 Jan 2011
 20:07:45 -0500 (EST)
In-Reply-To: <20110106204605.GA15090@burratino> (Jonathan Nieder's message of
 "Thu\, 6 Jan 2011 14\:46\:05 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8CACCEFC-19FA-11E0-86F7-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164690>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Also isn't the breakage not just this test, but also in all the tests that
>> try to run "svnadmin load"?  Shouldn't we somehow hoist this logic out of
>> t9010 and put it in t/lib-vcs-svn.sh or somewhere?

Am I mistaken and t9010 is the only one that needs the fix in your patch?
