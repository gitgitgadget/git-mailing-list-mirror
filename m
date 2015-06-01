From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Mon, 01 Jun 2015 09:39:53 -0700
Message-ID: <xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:40:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSkr-0002hD-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbbFAQj6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 12:39:58 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34745 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbFAQj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:39:56 -0400
Received: by ieczm2 with SMTP id zm2so113487615iec.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=L/JXzq1wW/uzs+dGAgs4UskGKvuijxKdzbvHlTvJzXU=;
        b=n0s/G9Qz3reIm18o04Nqj/IV/BgGV2rqbsGwd/FqZlhqLTWAsK5E0ThUxRqhU1noQ3
         afedUT0p/2fSXk6vSiaSNrq8Guq4s0JptdJcZYv06yh4H1MG6kpFQVmjMltCWIVuksgP
         Z9kdXm4horR4JlYa0NBXR1eA++TJB5/rGNWIaJMnmpQzbSXOzuTgAXmaqhwVumAPEwy7
         WuHuJ9pdRIDnK04mzXgzHv9F9nZDeZ426LRzWXKFMxuWMxpg6y6aTfn29ABx+OnKAxb5
         yTtqO3CcVt633ZqU6OVTo6Zo0ZaKumNilieqW9uxVhG0NIHIN2olPGkV2UTbSMtmdFw1
         H0sA==
X-Received: by 10.43.119.70 with SMTP id ft6mr30026739icc.15.1433176795734;
        Mon, 01 Jun 2015 09:39:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id c20sm10723151ioc.40.2015.06.01.09.39.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 09:39:55 -0700 (PDT)
In-Reply-To: <1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	("Galan =?utf-8?Q?R=C3=A9mi=22's?= message of "Mon, 1 Jun 2015 11:57:22
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270435>

Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Instead of removing a line to remove the commit, you can use the
> command "drop" (just like "pick" or "edit"). It has the same effect a=
s
> deleting the line (removing the commit) except that you keep a visual
> trace of your actions, allowing a better control and reducing the
> possibility of removing a commit by mistake.
>
> Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-i=
np.fr>
> ---

Matthieu, is this part of your class project?

I vaguely recall that your school wants your sign-off to release
patches to us or something like that, and that I saw some other
patches came with your sign-off, so I am being curious.

> @@ -505,7 +506,7 @@ do_next () {
>  	rm -f "$msg" "$author_script" "$amend" || exit
>  	read -r command sha1 rest < "$todo"
>  	case "$command" in
> -	"$comment_char"*|''|noop)
> +	"$comment_char"*|''|noop|drop|d)
>  		mark_action_done
>  		;;
>  	pick|p)

Is this sufficient?

If you are going to do something in 2/2 that relies on the format of
this line being correct (as opposed to "noop" or "#" that can have
any garbage on the remainder of the line), wouldn't you want to at
least check $sha1 is sensible?
