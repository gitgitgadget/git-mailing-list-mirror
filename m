From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Sun, 18 Jan 2009 11:00:44 -0800
Message-ID: <7vfxjgxwv7.fsf@gitster.siamese.dyndns.org>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
 <49735530.4090901@lsrfire.ath.cx>
 <8c5c35580901180837i6e835d98ob8875ce1b8ad3011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOcuY-00067d-Fy
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZARTAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 14:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZARTAw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:00:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZARTAw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 14:00:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E256F91751;
	Sun, 18 Jan 2009 14:00:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0B3991750; Sun,
 18 Jan 2009 14:00:46 -0500 (EST)
In-Reply-To: <8c5c35580901180837i6e835d98ob8875ce1b8ad3011@mail.gmail.com>
 (Lars Hjemli's message of "Sun, 18 Jan 2009 17:37:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52DC4EA8-E592-11DD-96C9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106258>

Lars Hjemli <hjemli@gmail.com> writes:

> I like the idea, but it will require thorough review of all
> read_tree_recursive() consumers. So now we've got three different
> approaches:
> * me: global setting
> * dscho: parameter to read_tree_recursive()
> * you: accept the return value from the callback function
>
> Junio, what would you prefer?

As usual Ren=C3=A9 has the best taste in designing things ;-)
