From: Junio C Hamano <gitster@pobox.com>
Subject: Re: capturing the packfile from git-upload-pack
Date: Fri, 15 Apr 2011 10:46:28 -0700
Message-ID: <7vy63bcsqz.fsf@alter.siamese.dyndns.org>
References: <1302837720729-6275146.post@n2.nabble.com>
 <BANLkTimAt_gcp1uBR_0H7LJHUdFGqHbRvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:46:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAn6S-00067A-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956Ab1DORqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:46:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab1DORqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0320D32FB;
	Fri, 15 Apr 2011 13:48:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVmM1ODa8cwdfRbxgHv4YTuQqKA=; b=W7WV2+
	Fp2KLBFJy9yGdxotYXtuuPE56cMOCeYVEZraSpAbH8J1xB6s/8y+VbgA6XngYtuU
	zTKKjafyfuh8E8oGnxfLZR2KUSha3Ph2it50F1340TQNKm37QEMHIK+Zy3RAO/lx
	zrsr57amNSI5A3MRlOoYtfmPhjQhbOd38ZIAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SZr0QpoMX71xoDMVR1RQntDnHiE5R/F/
	Jd3lemiFKQpCScrnie1lB6RYjHuog/fVh8AU7VPi9Aifm/M+AG6CVjDv571+rbW4
	eRbykBn8z6xxYbrM7Es8q3mbOlY9p928RSBmC9lxlLGN5Ei8EZ/R3HcB6NIZKBIs
	97xTanmtKrs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C602032FA;
	Fri, 15 Apr 2011 13:48:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7E6D32F9; Fri, 15 Apr 2011
 13:48:28 -0400 (EDT)
In-Reply-To: <BANLkTimAt_gcp1uBR_0H7LJHUdFGqHbRvA@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 15 Apr 2011 11:46:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94947E54-6788-11E0-97CC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171622>

Shawn Pearce <spearce@spearce.org> writes:

> On Thu, Apr 14, 2011 at 23:22, madmarcos <fru574@my.utsa.edu> wrote:
>> is there a git command that can capture in a separate file the packfile that
>> is generated and transmitted from a "want"ed branch during the
>> git-upload-pack command? I need a good sample to study.
>
> No.
>
> But you can create an input file yourself, the pkt-line format is
> pretty simple. Pipe the input to git-upload-pack, and it will spit
> back the response. :-)

If you are running 1.7.5-rc0 or newer, GIT_TRACE_PACKET may also be of
help.
