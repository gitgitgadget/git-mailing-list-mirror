From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sun, 18 Jan 2009 19:07:10 -0800
Message-ID: <7v3afgt2n5.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
 <7viqod5thi.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
 <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
 <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182214180.3586@pacific.mpi-cbg.de>
 <7vvdscthmq.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0901181612p5181c36eub337a339cd777da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Ray Chuan" <rctay89@gmail.com>, git@vger.kernel.org
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkVK-0002oi-TQ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbZASDHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbZASDHW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:07:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbZASDHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:07:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38DA0915E3;
	Sun, 18 Jan 2009 22:07:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 35EDF915E2; Sun,
 18 Jan 2009 22:07:12 -0500 (EST)
In-Reply-To: <bd6139dc0901181612p5181c36eub337a339cd777da0@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon, 19 Jan 2009 01:12:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 47D9CC9E-E5D6-11DD-BAA9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106310>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

> I totally detest having to use svn because of this), it would be nice
> to not dismiss http as "being slow anyway, so who cares about not
> making it faster"?

Nobody is arguing for "keeping it slow at all costs".

But "replace put && move with a single put, and we do not care if that
corrupts the resulting repository if it gets interrupted" is a different
story.
