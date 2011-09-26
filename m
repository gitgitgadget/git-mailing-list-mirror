From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can a git changeset be created with no parent
Date: Mon, 26 Sep 2011 12:25:41 -0700
Message-ID: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 21:25:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GoL-0001Kp-8v
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 21:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1IZTZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 15:25:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab1IZTZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 15:25:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188705BD0;
	Mon, 26 Sep 2011 15:25:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t74NZi72aQ+9
	3o6OhNu6EH0mpx4=; b=dWBZ1w0pSkqMbnAGy78bmSDB6BG7R6R0QpCOGPi3u+tY
	2Eo1rdXc1HJGbJyJ932VgMBH69pGCaiJsJLvIStF9wLH0+ClnByJGLWFyo0V0dZ0
	1GWvQ6v2M9f8VrTqBinEZMEo4CaXuUtGjs00mf0bJTm05nT9MScLBFXHmNT/Z7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R/FLFo
	6Cstb4HZ+J9XrhKRoosEHglGcZapADg57CNDO8sovEDdLH0+MDEy09qPE3HBi+Nm
	4j+QjEqrfA4TfSRxRlElYDDZ5+0UDHRSMbEIHD87+U8xAQNeU6yeiHDQqAXiPk4j
	CNV8lcUjTH9IIKJH/pjTigM1MgjFN39qrLA2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FA9E5BCF;
	Mon, 26 Sep 2011 15:25:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A7D5BCD; Mon, 26 Sep 2011
 15:25:42 -0400 (EDT)
In-Reply-To: <1316961212.4388.5.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sun, 25 Sep 2011 16:33:21
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 533A11F8-E875-11E0-A1B3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182153>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Sun, 2011-09-25 at 07:15 -0700, vra5107 wrote:
>> Hi
>>=20
>>         I am currently in the process of converting a large hg repos=
itory.
>> One of the changesets has no parents assigned. So to mirror that is =
it
>> possible to create a git changeset that doesnot have a parent ?
>
> They're called commits in git, and yes it's possible. They are called
> orphan commits and it's what you get when you do the first commit in =
the

Just to set the terminology straight, s/orphan/root/;

> repository.
>
> You can do this with 'git checkout --orphan somebranch'. Notice that =
the

The orphan here refers to the fact that the next commit will not be a
child of the current commit. The resulting one is a "root" commit.
