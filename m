From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7 (v5)] rev-cache
Date: Tue, 06 Apr 2010 10:34:39 -0700
Message-ID: <7vd3yciixc.fsf@alter.siamese.dyndns.org>
References: <4BBA40B7.1060100@gmail.com>
 <7vaathjcru.fsf@alter.siamese.dyndns.org>
 <j2t6672d0161004060314j526e6d4q905bf427063b605f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Edelen <sirnot@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 19:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzCfv-0000gP-Uo
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 19:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab0DFRet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 13:34:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab0DFReq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 13:34:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C22BBA830D;
	Tue,  6 Apr 2010 13:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rx6bRgjylm8Z
	HX2ldmypLg8RinQ=; b=PGWmvzhcI0+n+3TnDJXIH5qYheN9Ra59LarCbi8goe7z
	/cvWxAzMJcnvz6kSlUdsyAJf09idMOH3Jf4B9PMZa7+6QvkljDeLgBDPJNQnWs4+
	wqENXqNCk/910FJoLHWvh1IVVEGPXGhrcwwLbL25pqrrxX4oy8ik8cRdsGsHrOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=exJ6Fq
	74EZwqkln0F5XOlAppZMUrLwLQPuLrOl3UBZZ5KXuDgxLhzxCduWcW1NvNNsFZpq
	x5bORG8DdbEoDgJk5FafGXjgCXqZcCUQrkObHXYqh6CrqE9h6OX2U0WhAn5WvkmT
	bNCbk/jG3kQdvpAnAdYeqH6DScy9V9Vt7CwsM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7C6A830C;
	Tue,  6 Apr 2010 13:34:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 101F7A8309; Tue,  6 Apr
 2010 13:34:40 -0400 (EDT)
In-Reply-To: <j2t6672d0161004060314j526e6d4q905bf427063b605f@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn?= Gustavsson"'s message of "Tue\, 6 Apr 2010
 12\:14\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFE6AFD6-41A2-11DF-B304-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144161>

In case people are wondering what the message Bj=C3=B6rn is responding =
to
said...

  From: Junio C Hamano <gitster@pobox.com>
  Subject: Re: [PATCH 0/7 (v5)] rev-cache
  Date: Mon, 05 Apr 2010 23:49:57 -0700
  References: <4BBA40B7.1060100@gmail.com>
  Message-ID: <7vaathjcru.fsf@alter.siamese.dyndns.org>

  Bj=C3=B6rn, I thought your "apply --whitespace=3Dfix" patch was suppo=
sed to be
  able to cope with this series whose [2/7] introduces a new file with =
a
  trailing blank line "t/t6019-rev-cache-list.sh" (which is correctly f=
ixed
  not to have that extra blank line at the end), and then a subsequent =
patch
  in the series [3/7] still tries to apply a patch assuming that the ex=
tra
  blank line was still there.

  But that is apparently not the case.  I think your series dealt only =
for
  the cases where the additional contents came _after_ the fixed-and-go=
ne
  blank lines, and never dealt with the case where such lines appear in=
 the
  context.

The message didn't go to vger because I botched while editing To/Cc lin=
es.
