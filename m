From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone -b
Date: Mon, 01 Jul 2013 09:46:53 -0700
Message-ID: <7v61wui5xe.fsf@alter.siamese.dyndns.org>
References: <51CD7AB7.3040409@atlas-elektronik.com>
	<51D12A0E.60709@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:47:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UthFk-0006Sx-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab3GAQq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jul 2013 12:46:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab3GAQq4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jul 2013 12:46:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 836342D542;
	Mon,  1 Jul 2013 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5SnrZQswsqVq
	9hasJEbdTyCyVv0=; b=YYJxGOubOZhFizwdtiilKeFpuVBGUGM0C+9/R80OClAj
	V+RRzD1z1pkPg5zppYNKu0eW7seARM8GKVsPlVdyJ4HhibwqxN4ojYNNv69EzFuE
	YxohWNH/ia5eVGiQ1JZtns6/uCwTTtQ1U5Kp0l6oK2HK+zA8bAip/e2aUOgyVN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=J5Kuhe
	7LE5w0/BSBdQYT36aYMXp2YRyye/Bv6ffp1Hp0brfdJM69QhOhTreKupX3XrP85y
	CCrVRIsfK5kNKINz97gylRl8nRpZf02PQS71V6fkqpPfJBd+f8oBzTXgrd61VYoQ
	vtUGp21l0j/U2CMb9a1KL+jDsV4sAyv3pxq4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D242D541;
	Mon,  1 Jul 2013 16:46:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEDA52D540;
	Mon,  1 Jul 2013 16:46:54 +0000 (UTC)
In-Reply-To: <51D12A0E.60709@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of
	"Mon, 1 Jul 2013 09:04:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D64D089A-E26D-11E2-9C77-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229310>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

>> Is there any reason why 'git clone -b' only takes a branch (from ref=
s/heads/)
>> or a tag (from refs/tags/) ?

Because they are common enough, and doing the same for an arbitrary
object is just as easy to do something like:

	git clone -n
        git checkout $an_arbitrary_commit_object_name^0

>> Background: At $dayjob we're using some kind of 'hidden' refs (in re=
fs/releases/)
>> to communicate between the 'branch integrator' (who creates the ref =
in refs/releases/)
>> and the 'build master' who wants to build that ref.=20

While I wasn't paying much attention to this, I vaguely recall that
people pointed out that using a fresh clone every time may not be
what you want to do in the first place, and I happen to agree with
them (and that is why I am not very much interested in this topic).
