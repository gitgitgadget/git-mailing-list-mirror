From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v2 13/22] i18n: git-sh-setup.sh: mark strings for
 translation
Date: Fri, 27 May 2016 10:17:27 +0000
Message-ID: <57481EB7.10809@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
 <1464031661-18988-14-git-send-email-vascomalmeida@sapo.pt>
 <xmqqk2igtp2e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 12:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Epy-0000rL-5h
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 12:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbcE0KRq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 06:17:46 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35968 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751253AbcE0KRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 06:17:45 -0400
Received: (qmail 8718 invoked from network); 27 May 2016 10:17:39 -0000
Received: (qmail 18703 invoked from network); 27 May 2016 10:17:39 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 27 May 2016 10:17:34 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqk2igtp2e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295746>

=C0s 22:46 de 26-05-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> >  require_work_tree_exists () {
>> > +	program_name=3D$0
>> >  	if test "z$(git rev-parse --is-bare-repository)" !=3D zfalse
>> >  	then
>> > -		die "fatal: $0 cannot be used without a working tree."
>> > +		die "$(gettext "fatal: \$program_name cannot be used without a =
working tree.")"
>> >  	fi
>> >  }
> This is probably quite a minor point, but I'd prefer if clobbering
> the variable program_name is done between "then" and "fi", i.e. when
> we know we are going to die, so the caller would not care.  Because
> we are not in control of the caller's namespace use, and we do not
> want bash-ism "local" here, that is the best we could do to make it
> safer.
>=20
I was not aware about this issue. I agree with you and I'll fix this an=
d
other instances you mentioned, in the next re-roll.
