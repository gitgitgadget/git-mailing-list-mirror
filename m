From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author
 for pick, reword
Date: Wed, 13 Aug 2014 14:47:51 +0200
Message-ID: <53EB5E77.8010005@alum.mit.edu>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com> <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 14:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHXyB-0002rU-3H
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 14:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaHMMrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 08:47:55 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63567 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750751AbaHMMry (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2014 08:47:54 -0400
X-AuditID: 1207440e-f79da6d0000002fc-8d-53eb5e795558
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 90.C4.00764.97E5BE35; Wed, 13 Aug 2014 08:47:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0A4F.dip0.t-ipconnect.de [93.219.10.79])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7DClpXP018617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 13 Aug 2014 08:47:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqFsZ9zrYYMU9Y4tDc++xW3Rd6Way
	aOi9wmzxo6WH2eLgMUkHVo+ds+6yezzr3cPocfGSsseUe/9ZPT5vkgtgjeK2SUosKQvOTM/T
	t0vgzji5+ztbwRmBirl/TzA2MM7k7WLk5JAQMJF4+GMKI4QtJnHh3nq2LkYuDiGBy4wSi5/1
	MoMkhATOMUlsuRYDYvMKaEvM7LgCFmcRUJVo3nCKCcRmE9CVWNTTDGaLCgRJzP48jx2iXlDi
	5MwnLCC2iIC5xPEds8DizAJZEu1vtoPNERZIkdiwZhPUrtmMEnNm8HUxcnBwCoRLLG9SgyjX
	kXjX94AZwpaX2P52DvMERoFZSDbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	xnq5mSV6qSmlmxgh4c23g7F9vcwhRgEORiUeXo+o18FCrIllxZW5hxglOZiURHlXBQCF+JLy
	UyozEosz4otKc1KLDzFKcDArifCejATK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YW
	pBbBZGU4OJQkeF1igRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQXEaXwyMVJAU
	D9De9zEge4sLEnOBohCtpxgVpcR5C0ASAiCJjNI8uLGwpPWKURzoS2FeVpDtPMCEB9f9Cmgw
	E9Dgza6vQAaXJCKkpBoYl8wL82arUj7QF9JZcH7PPsb1JzlCPTn9d7XmvHPo/mbqvNnRqs4/
	dMvO3hqRS5aXWk+5TM9tX+/9rX16t8OCzAirE9e/Tk3X5tEt3CErvdKzi6u1bfKi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255207>

On 08/07/2014 01:59 AM, Fabian Ruch wrote:
> pick and reword are atomic to-do list commands in the sense that they
> open a new task which is closed after the respective command is
> completed. squash and fixup are not atomic. They create a new task
> which is not completed until the last squash or fixup is processed.

I don't understand the distinction that you are attempting to draw
between "atomic" and "non-atomic" commands.  For example, in the
following command list:

    pick 1111111
    squash 2222222
    fixup 3333333

the "pick" command doesn't seem very atomic, because the *end* result of
the three commands is a single commit that is affected by all three
commands.  Furthermore, if we change the example to

    pick 1111111
    squash --reset-author 2222222
    fixup --signoff 3333333

then isn't it clear that the user's intention was to apply both options,
"--reset-author" and "--signoff", to the resulting commit?  In other
words, it seems to me that any options on such a chain of lines should
be collected and applied to the final commit as a whole.

> Lift the general unknown option blockade for the pick and reword
> commands. If `do_cmd` comes across one of the options `--signoff` and
> `--reset-author` while parsing a to-do entry and the scheduled
> command is either `pick` or `reword`, relay the option to `do_pick`.

The new user-exposed options should be documented in the git-rebase(1)
manpage and probably also in the help text that is appended to every
"rebase -i" todo list.

> The `do_pick` options `--gpg-sign` and `--file` are not yet supported
> because `do_cmd` cannot handle option arguments and options with
> spaces at the moment. It is true that edit is one of the atomic
> commands but it displays hash information when the rebase is stopped
> and some options rewrite the picked commit which alters that
> information. squash and fixup still do not accept user options as the
> interplay of `--reset-author` and the author script are yet to be
> determined.
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
