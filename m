From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/6] repack_without_refs(): convert to string_list
Date: Fri, 21 Nov 2014 15:25:31 +0100
Message-ID: <546F4B5B.2060508@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrp9X-0007tH-MV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbaKUOZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:25:35 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62905 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755254AbaKUOZe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:25:34 -0500
X-AuditID: 1207440e-f79d26d000001b6e-a6-546f4b5d1255
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.C5.07022.D5B4F645; Fri, 21 Nov 2014 09:25:33 -0500 (EST)
Received: from [192.168.69.130] (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALEPVZR001450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:25:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqBvrnR9iMOWYlUXXlW4mi4beK8wW
	b28uYbT4N6HGYvPmdhYHVo+ds+6yeyzYVOpx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGcuO
	z2Mt+M5W8fHmG9YGxrOsXYycHBICJhI3mxqYIWwxiQv31rOB2EIClxklfq4AinMB2eeYJK5d
	WMAOkuAV0Jb4c6WRCcRmEVCV2H5rIguIzSagK7GopxksLioQJHFyz3WoekGJkzOfgNWICHhJ
	nFo3A2wZs0CuxPxNzWBxYQE3iYZ3XcwQi6sken70gh3HKeAq8XRFHztEvZ7Ejuu/WCFseYnm
	rbOZJzAKzEKyYhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3E
	CAlqvh2M7etlDjEKcDAq8fAyLMsLEWJNLCuuzD3EKMnBpCTKa+iWHyLEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhLdcGCjHm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	rfMEahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8IHu9QPYWFyTm
	AkUhWk8x6nK0NL3tZRJiycvPS5US5z0GUiQAUpRRmge3ApbCXjGKA30szPsH5BIeYPqDm/QK
	aAkT0JK/S3NBlpQkIqSkGhiLAkOle4wtnlW6XJZZOHmPX8YBr83hKy0Mv96rWeD78dfK6j9R
	FxTWFjrqMQav2JZ/ZyZv29RJweabT1R2f3dP+suyoHiLZ/6hqsYfWw7ZGvz6LzZj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2014 03:09 PM, Michael Haggerty wrote:
> This is basically an atomized version of Ronnie/Jonathan/Stefan's
> patch [1] "refs.c: use a stringlist for repack_without_refs". But I've
> actually rewritten most of it from scratch, using the original patch
> as a reference.

Naturally, right after I emailed this series I realized that there have
been two more iterations on the original patch, which I overlooked
because I was not CCed on them. (I'm not complaining, just explaining.)

I don't think that those iterations changed anything substantial that
overlaps with my version, but TBH it's such a pain in the ass working
with patches in email that I don't think I'll go to the effort of
checking for sure unless somebody shows interest in actually using my
version.

Sorry for being grumpy today :-(

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
