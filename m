From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 13:33:30 -0700
Message-ID: <7v4p6k5m91.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <20080718182010.6117@nanako3.lavabit.com>
 <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
 <20080720130407.GF10347@genesis.frugalware.org>
 <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807202102370.3305@eeepc-johanness>
 <7vd4l85nv5.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Jul 20 22:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfcB-0008Jh-67
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYGTUdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbYGTUdo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:33:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYGTUdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:33:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B10A134E55;
	Sun, 20 Jul 2008 16:33:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BC2334E50; Sun, 20 Jul 2008 16:33:32 -0400 (EDT)
In-Reply-To: <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun, 20 Jul 2008 22:03:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2421FED6-569B-11DD-ACB6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89226>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> Whatever happened to quotes?
>
>         $ git merge -s subtree -Xpath="git-gui git-gui/master"

Nothing special needs to happen.  That would naturally be passed to the
underlying strategy as the equivalent of:

	$ git merge-subtree --path="git-gui git-gui/master"

but now "git-merge" is in C, it does not have to quote nor unquote
explicitly itself.  Unquoting will be done by the shell when you call
"git-merge", and quoting is unneeded when you give each argument as a
separate string in **argv to call execv().
