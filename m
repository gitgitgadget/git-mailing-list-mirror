From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 4/7] l10n: builtin/pull.c: mark strings for translation
Date: Sat, 9 Apr 2016 12:34:48 +0000
Message-ID: <5708F6E8.506@sapo.pt>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
 <1460145765-7454-4-git-send-email-vascomalmeida@sapo.pt>
 <xmqqd1pzvo0p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 14:35:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aos6Y-0004Xd-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbcDIMfE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2016 08:35:04 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:34425 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753929AbcDIMfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 08:35:02 -0400
Received: (qmail 1451 invoked from network); 9 Apr 2016 12:35:00 -0000
Received: (qmail 22120 invoked from network); 9 Apr 2016 12:35:00 -0000
Received: from unknown (HELO [192.168.64.2]) (vascomalmeida@sapo.pt@[207.158.41.54])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <worldhello.net@gmail.com>; 9 Apr 2016 12:34:54 -0000
X-PTMail-RemoteIP: 207.158.41.54
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqd1pzvo0p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291097>

=C0s 20:33 de 08-04-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Some translations might also translate "<remote>" and "<branch>".
>> ...
>>  		fprintf_ln(stderr, _("See git-pull(1) for details."));
>>  		fprintf(stderr, "\n");
>> -		fprintf_ln(stderr, "    git pull <remote> <branch>");
>> +		fprintf_ln(stderr, _("    git pull <remote> <branch>"));
>=20
> But "git pull" itself must never be translated, and there is no hint
> given to those who are working on *.po files to prevent it.
>=20
> Wouldn't it make more sense to do it like this?
>=20
> 	fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"=
));
>=20
Yes, I think the way you suggest is better, since it prevents
translation mistakes. I'll do the same to

eval_gettextln "    git branch --set-upstream-to=3D\$remote/<branch>\$d=
isplay_branch_name"

in git-parse-remote.sh ending.
