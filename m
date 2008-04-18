From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Fri, 18 Apr 2008 11:37:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804181135540.2779@woody.linux-foundation.org>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org> <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com> <7vskxjj9rb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?R=E9mi_Vanicat?= <vanicat@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 10:58:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmvU4-0006GP-3l
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 20:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760588AbYDRSiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 14:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760587AbYDRSiF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 14:38:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47689 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760582AbYDRSiE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 14:38:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3IIbSuD026956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Apr 2008 11:37:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3IIbPHn009534;
	Fri, 18 Apr 2008 11:37:28 -0700
In-Reply-To: <7vskxjj9rb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.96 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79876>



On Fri, 18 Apr 2008, Junio C Hamano wrote:
>
> -		(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
> +		(printf '%s\n' "$SUBJECT" ; echo ; cat "$dotest/msg") |

Well, get rid of the superfluous second 'echo' then too, replacing it 
with another '\n'. IOW:

	( printf '%s\n\n' "$SUBJECT" ; cat "$dotest/msg" ) | 

instead.

		Linus
