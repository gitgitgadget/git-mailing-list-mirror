From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-p4.py: add support for filetype change
Date: Wed, 13 Jan 2016 09:07:25 -0800
Message-ID: <xmqqpox5pfw2.fsf@gitster.mtv.corp.google.com>
References: <1452602627-8402-1-git-send-email-romain.picard@oakbits.com>
	<CAE5ih78XSq5kFmmOYKCw0zF-NEgWH8+HS-0cHse_-mGR8r355A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Romain Picard <romain.picard@oakbits.com>,
	Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git-owner@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOtR-00058X-9f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbcAMRHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:07:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbcAMRH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:07:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A5BC3A556;
	Wed, 13 Jan 2016 12:07:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vxOl1MucTGh9CfR7dMFWX1R++Eg=; b=v87+MH
	fT13vpkFxFuXQqVH0exmSXt8q7X+4DEros8jfzGK1Ad6aS1zcEgaBu/4NwZ3VzWJ
	eMBBTSqtcvOqm/ZiCd5p71bC2N+ijqdaq+jgQ309FHjAVmiOZ2/a2XAdm+MA1nhS
	DJbbL741i/1MgApjbY/qeDAtJG98iIkomMZ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q/faOtxgcIKxTKaw6ManO3AHiI1b4FcG
	axV72B/wmmVEHED7u9wDrblHSwASSS9CnwSBPQFdbTwPTbk6uZo8k5xcOa9PMhdT
	bkM64ss2viXneEPiThwEoGIRKuJTK4PUFFrr/OvS4TQDUChhlXI5VZ+T0zw3osmZ
	bcSR4Vsfd2A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 300743A555;
	Wed, 13 Jan 2016 12:07:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 819EB3A552;
	Wed, 13 Jan 2016 12:07:26 -0500 (EST)
In-Reply-To: <CAE5ih78XSq5kFmmOYKCw0zF-NEgWH8+HS-0cHse_-mGR8r355A@mail.gmail.com>
	(Luke Diamand's message of "Wed, 13 Jan 2016 07:02:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EF7626E-BA18-11E5-8A02-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283937>

Luke Diamand <luke@diamand.org> writes:

> On 12 January 2016 at 12:43, Romain Picard <romain.picard@oakbits.com> wrote:
>> After changing the type of a file in the git repository, it is not possible to
>> "git p4 publish" the commit to perforce. This is due to the fact that the git
>> "T" status is not handled in git-p4.py. This can typically occur when replacing
>> an existing file with a symbolic link.
>>
>> The "T" modifier is now supported in git-p4.py. When a file type has changed,
>> inform perforce with the "p4 edit -f auto" command.
>
> Looks good to me, thanks.
>
> Ack.

Thanks, both.  Will queue.
