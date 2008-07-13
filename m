From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mailinfo: use strbuf's instead of fixed buffers
Date: Sun, 13 Jul 2008 14:37:50 -0700
Message-ID: <7v4p6tqxch.fsf@gitster.siamese.dyndns.org>
References: <4876820D.4070806@etek.chalmers.se>
 <7vod55o0tx.fsf@gitster.siamese.dyndns.org>
 <48768F30.8070409@etek.chalmers.se>
 <7v3amhnwy9.fsf@gitster.siamese.dyndns.org>
 <48769E40.8030303@etek.chalmers.se> <48769E91.60205@etek.chalmers.se>
 <7vy747fx9x.fsf_-_@gitster.siamese.dyndns.org>
 <487A46C5.6000503@etek.chalmers.se> <487A4948.8080003@etek.chalmers.se>
 <487A497E.6030308@etek.chalmers.se> <487A49B4.6000407@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9HU-000443-UE
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYGMVh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYGMVh5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:37:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYGMVh5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 17:37:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D56DA2EF56;
	Sun, 13 Jul 2008 17:37:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 441E72EF55; Sun, 13 Jul 2008 17:37:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F47E7654-5123-11DD-896E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88343>

Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:

> +static void parse_bogus_from(const struct strbuf *line)
>  {
> ...
> +static void handle_from(const struct strbuf *from)
>  {
> ...
>  	if (!at)
> -		return bogus_from(line);
> +		return parse_bogus_from(from);

That's GCCism isn't it?  I'll queue this probably for 'pu' with local
fixups, so no need to resend for this particular issue, though.
