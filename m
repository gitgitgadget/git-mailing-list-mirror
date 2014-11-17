From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] config: clear the executable bits (if any) on $GIT_DIR/config
Date: Mon, 17 Nov 2014 09:26:28 +0100
Message-ID: <5469B134.1050306@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu>	<1416036379-4994-3-git-send-email-mhagger@alum.mit.edu> <xmqqvbmfyo8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 09:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqHdz-0006Tq-AD
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 09:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaKQI0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 03:26:36 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46107 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbaKQI0e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 03:26:34 -0500
X-AuditID: 12074414-f79446d0000031d8-cd-5469b137b0a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 72.85.12760.731B9645; Mon, 17 Nov 2014 03:26:31 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAH8QTcr024958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 03:26:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqqvbmfyo8w.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqGu+MTPEYOUpXYuuK91MFg29V5gt
	Fv47ym6xvynJgcVj56y77B4XLyl7fN4k59E85TxrAEsUt01SYklZcGZ6nr5dAnfGjfsvWQoa
	BSsW9r9ibmA8yNvFyMkhIWAicfPnXhYIW0ziwr31bF2MXBxCApcZJW7svMUIkhASOMck8eaa
	NIjNK6Atsf/KdVYQm0VAVWL6tBVgNWwCuhKLepqZQGxRgSCJk3uus0PUC0qcnPkEbIGIgJrE
	xLZDYDazQI7Eg48fwGqEBcIkpk84CbV4FaPElHVHwIZyClhLHDt5EqpBT2LH9V+sELa8RPPW
	2cwTGAVmIdkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKE
	hLPIDsYjJ+UOMQpwMCrx8O7IzgwRYk0sK67MPcQoycGkJMpr5QAU4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMK7fjVQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgld7
	A1CjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHaWw3SzltckJgL
	FIVoPcWoKCXO6wWSEABJZJTmwY2FJalXjOJAXwrzZoJU8QATHFz3K6DBTECDGY+lggwuSURI
	STUwWh9onxvn4Lm3a2PmYQfDKV/FxGUzfMOF0lyUWY8KPDl3etpW1x/9OzxvfQpf9tt8yscg
	v6t7l983jj+9bdbsdzXvDDRlJ6l4NZ2b071mqxGfx77aR/y8B3Jf7rARKHuwbEP+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/16/2014 07:49 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> There is no reason for $GIT_DIR/config to be executable, plus this
>> change will help clean up repositories affected by the bug that was
>> fixed by the previous commit.
> 
> I do not think we want to do this.
> 
> It is a welcome bugfix to create $GIT_DIR/config without executable
> bit when and only when we create it.  It is very much in line with
> "There is no reason for $GIT_DIR/config to be executable"---we do
> not need to make it executable ourselves, so we shouldn't, but we
> did which was a bug we want to fix in patch 1/2 you posted.
> 
> But with the "preserve existing permissions" fix we did earlier, the
> end users are now allowed to flip the executable bit on for their
> own purpose, and dropping it without knowing why they are doing so
> is simply rude.  And honestly, Git do *not* even want to know why
> the users want to flip the bit.
> 
> So I would suggest not to spend any cycle or any code complexity to
> "repair" existing repositories.  Having that bit on does not hurt
> anybody.  Those who found it curious can flip that bit off and then
> Git with "preserve existing permissions" fix will keep that bit off
> from then on.

I disagree. The point of "preserve existing permissions" was to allow
people to make their config files more readable/writable than the
default, with the main use case being to help users who want to hide
secret information in their config files.

I think it is really far-fetched to imagine that anybody made his config
file executable on purpose. Whereas we are *sure* that we have created
lots of repositories with config files that were set executable by accident.

Let's redefine the "feature" that was added in 2.1 from "preserve
existing permissions" to "preserve existing read/write permissions" and
thereby help people clean up the mess we made.

That being said, I still believe that executable config files are not a
significant risk in practice, so I'm not going to lose sleep about it
either way.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
