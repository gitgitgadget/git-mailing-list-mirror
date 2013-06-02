From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] object.c: Fix a sparse warning
Date: Sun, 02 Jun 2013 08:12:42 +0200
Message-ID: <51AAE25A.6080009@alum.mit.edu>
References: <51AA3363.8030705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 08:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj1XT-0006hk-B9
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 08:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab3FBGMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 02:12:53 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43311 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300Ab3FBGMv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 02:12:51 -0400
X-AuditID: 12074414-b7fb86d000000905-0e-51aae2620d1c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 22.9D.02309.262EAA15; Sun,  2 Jun 2013 02:12:50 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD4528.dip0.t-ipconnect.de [79.221.69.40])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r526CiE2004875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Jun 2013 02:12:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51AA3363.8030705@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqJv0aFWgwcxjlhZdV7qZLBp6rzBb
	7J62gM2B2ePiJWWPxxNPsHp83iQXwBzFbZOUWFIWnJmep2+XwJ2x+OgdpoI2zorObUdYGhhX
	sXcxcnJICJhIbNy9mQXCFpO4cG89WxcjF4eQwGVGiSsbDoAlhATOMkk8mJEBYvMKaEt0fJjM
	BmKzCKhKLH/TCVbDJqArsainmQnEFhUIk3i/bCorRL2gxMmZT8BqRASiJHp27gZazMHBLKAl
	sWCNJUhYWMBYYsOjk2wQq4wkNq2bAVbOCRTf1zybGcRmFtCReNf3AMqWl9j+dg7zBEaBWUg2
	zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIYErsoPxyEm5
	Q4wCHIxKPLwd21cFCrEmlhVX5h5ilORgUhLlLX4AFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	u3INUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYJ39UOgRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtLcTpJ23uCAxFygK0XqKUZdj
	xo/J7xiFWPLy81KlxHlngBQJgBRllObBrYClqVeM4kAfC/POB6niAaY4uEmvgJYwAS15Yr0c
	ZElJIkJKqoFReLt4avmD8rOzDP4fWjPZuejMzk9+l6KXLuE6uGfXuqP8N9bN0+h9H3R5o+66
	klizLw6MnxuXLDvBfZhzZt0bqeNNjY9+3ecOXvWTL/1a9fHVP+yun+s6b/xl8zKP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226149>

On 06/01/2013 07:46 PM, Ramsay Jones wrote:
> 
> Sparse issues an "'object_array_slopbuf' not declared. Should it be
> static?" warning. In order to suppress the warning, since this
> symbol does not need more than file visibility, we simply add the
> static modifier to its declaration.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Michael,
> 
> If you need to re-roll the patches in your 'mh/reflife' branch,
> could you please squash this into the patch corresponding to
> commit cbdeb23e ("object_array_entry: fix memory handling of
> the name field", 25-05-2013).

Ramsay, thanks for fixing this.

Junio, it doesn't seem worth spamming the list with a re-roll for this
and the other 1-line fixup commit that I already sent.  Would you mind
either pulling the re-rolled version that I published here:

    git://github.com/mhagger/git.git
    branch reflife-v3, 50f7a18ee9ad537a7bf7992d6eb145299a4884b9

or squashing them onto the patch series yourself?  Let me know if this
is inconvenient.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
