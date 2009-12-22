From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge pack file from small unpacked objects
Date: Tue, 22 Dec 2009 10:11:15 -0800
Message-ID: <7veimm3mm4.fsf@alter.siamese.dyndns.org>
References: <404585ED79625A40AB5A9884ECA9A63B3E02083F@VMBX125.ihostexchange.net>
 <75B8C0BEE0AE2A44AA971D218D9FE99E3DD8C61C@VMBX125.ihostexchange.net>
 <28c656e20912220054qc7b6497t79e135c913865c22@mail.gmail.com>
 <75B8C0BEE0AE2A44AA971D218D9FE99E6B06F111@VMBX125.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: B Smith-Mannschott <bsmith.occs@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Nick Triantos <nick@perceptivepixel.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9Ck-00025t-I6
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbZLVSL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZLVSL0
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:11:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZLVSLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 13:11:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F3D95A95FD;
	Tue, 22 Dec 2009 13:11:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e/c9QXKVqAdXsDW78ramGGLy8tg=; b=eBoqJc
	WUPgth0pJq5gtl22rMjnc2I4bfEUtgro5hEnYeQTHp6oL2HTn3Q8uJwAm8P7m+bC
	YCRB6wdCqbO+odvuI6Uw6rEmRyZ6CA2ctZDmVV7mDBVCpLroSTTyLE8Y1sZBKoeR
	P5uXe6oZnbCbOQCxLBY4yKVUhEFWG8/J3l6R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=liPdCTPIxRIcZ62IY8/LeNfr5JctW0wV
	st6Rw02jyYtapOA6yjjDy0qj69+P40NEKRERASRQyvMmwEpqUR4M7IZuztmYF59+
	6dWeqIHZOTmJU0mBqzMPEdib/YxXaobE7hb7EflY3EdMEl1W/eEXotJDQdDQpS1+
	fmvNfpTW9F0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C037EA95FC;
	Tue, 22 Dec 2009 13:11:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9831BA95EE; Tue, 22 Dec 2009
 13:11:17 -0500 (EST)
In-Reply-To: <75B8C0BEE0AE2A44AA971D218D9FE99E6B06F111@VMBX125.ihostexchange.net> (Nick
 Triantos's message of "Tue\, 22 Dec 2009 13\:04\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68B4EC7E-EF25-11DE-8610-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135589>

Nick Triantos <nick@perceptivepixel.com> writes:

> Is there an easy way to unpack the pack file and see what's inside (including sizes)?

Unpack?

    (mkdir /var/tmp/junk &&
     cd /var/tmp/junk &&
     git init && git unpack-objects) <.git/objects/pack/pack-$that_one.pack

It might also be interesting to see

    git verify-pack -v .git/objects/pack/pack-$that_one.pack
