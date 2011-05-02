From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 02 May 2011 09:38:55 -0700
Message-ID: <7vfwoxoy5c.fsf@alter.siamese.dyndns.org>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 18:39:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGw9S-0003Lp-5V
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 18:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab1EBQjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 12:39:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab1EBQjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 12:39:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B93314DB6;
	Mon,  2 May 2011 12:41:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WngtENHNfT2fUWxQ3v5ygMVEkBc=; b=kUqz97
	OWlln1ypPf8UdjzgUD4s00BijJiq4ZD9NuWLShW0KBX0/jZuL6QqeM1KU7l+dWFd
	rO4MNqrlCKDOu+SSeGYdB4qS6Lq+05+iGjwotQInwDieXlenmvOWEh1PMUe8l8I4
	BNbmRW8niCoAn2ZfURYDr7A+vYbzkAWQhWmgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=klAHaE3ZhsZatZreivEwee9XxpyhAE+M
	5OCCMm8whYa20JibQfiG6BWEXtXtylBYVAKi0fi4A6UQDHQQ3psa3gXjv00FWVlH
	tUtPEndpJ0uRWSoEIcbbkqSUOYxbwBvawXHdwzaj7/07A8ViDgdd55hTwg09X46G
	63RjiaM122M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85FF84DB5;
	Mon,  2 May 2011 12:41:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 90F9A4DB2; Mon,  2 May 2011
 12:41:00 -0400 (EDT)
In-Reply-To: <cover.1304318972.git.bert.wesarg@googlemail.com> (Bert Wesarg's
 message of "Mon, 2 May 2011 13:39:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8106BB4-74DA-11E0-95A9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172599>

I am personally not thrilled by what this series attempts to do, but first
a few questions:

 - Are there existing non-git "grep" implementations that do this?

 - If yes:
   - what command option letter do they use to specify line number?
   - do they not support a range notation (e.g. -@ 25-30,32-40)?
   - what do they do when given more than one file?

 - If no:
   - why not?  Is it a sign that this is ill-thought out misfeature?
   - perhaps people use something like "sed -n -e 25,30p file" and be
     happy?
