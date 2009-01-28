From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 19:09:13 -0800
Message-ID: <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com>
 <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com>
 <alpine.DEB.1.00.0901280034310.3586@pacific.mpi-cbg.de>
 <20090127233939.GD1321@spearce.org>
 <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:11:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0pV-00057s-0R
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZA1DJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZA1DJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:09:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbZA1DJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:09:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AD17994D59;
	Tue, 27 Jan 2009 22:09:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 610C894D4F; Tue,
 27 Jan 2009 22:09:15 -0500 (EST)
In-Reply-To: <20090128020220.GE1321@spearce.org> (Shawn O. Pearce's message
 of "Tue, 27 Jan 2009 18:02:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 118CDC34-ECE9-11DD-8134-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107458>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> PJ Hyett <pjhyett@gmail.com> wrote:
>> 
>> Is there any possibility to have the server code in an upcoming
>> release account for clients running 1.6.1?
>
> I can't think off-hand of a way for the server to know what version
> the client is.  There's nothing really different in the protocol
> between a 1.6.1 client and a v1.5.5-rc0~44^2 (introduction of
> include-tag) or later client.

Hmm, I am puzzled.

I do not know how 41fa7d2 (Teach git-fetch to exploit server side
automatic tag following, 2008-03-03), which is about the conversation
between fetch-pack and upload-pack, is relevant to the issue at hand,
which is about the conversation between send-pack and receive-pack.

In send-pack receive-pack protocol, the server talks first before
listening to the client, and the .have data is in this first part of the
conversation.

By the way, I think Documentation/technical/pack-protocol.txt needs to be
updated.  send-pack receive-pack protocol uses C and S to mean receiver
and sender respectively.  We should at least s/C/R/ that part, and
possibly add description about ".have" thing.
