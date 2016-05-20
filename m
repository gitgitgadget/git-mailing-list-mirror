From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 18:21:39 +0000
Message-ID: <573F55B3.4080603@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
 <CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
 <573E30C8.4070600@sapo.pt>
 <CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
 <xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com> <573F4BEC.7000906@sapo.pt>
 <xmqqoa80ei03.fsf@gitster.mtv.corp.google.com>
 <xmqqh9dsehl6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3p3Z-0000wF-5b
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbcETSVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 14:21:48 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:50126 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750918AbcETSVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:21:48 -0400
Received: (qmail 30741 invoked from network); 20 May 2016 18:21:45 -0000
Received: (qmail 31064 invoked from network); 20 May 2016 18:21:45 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <avarab@gmail.com>; 20 May 2016 18:21:40 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqh9dsehl6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295200>

=C0s 17:59 de 20-05-2016, Junio C Hamano escreveu:
> As long as translators do not translate "Did you mean..." to begin a
> line with a tab (which I do not think there is any reason to), it is
> going to work reliably to grep for "^ lgf$" here, and it will catch
> such a potential future bug under GETTEXT_POISON build.

Translations don't affect the tests since they're run with C locale.
I think all tests source test-lib.sh which does:

	# For repeatability, reset the environment to known value.
	# TERM is sanitized below, after saving color control sequences.
	LANG=3DC
	LC_ALL=3DC
	PAGER=3Dcat
	TZ=3DUTC
	export LANG LC_ALL PAGER TZ

So, I'll remove sed command and use grep the way you said it, in the
next re-roll.
