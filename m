From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Add documentation on how to integrate commands.
Date: Sun, 25 Nov 2012 08:12:35 +0100
Message-ID: <50B1C4E3.9070500@alum.mit.edu>
References: <20121124122333.BAD7B4065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 08:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcWSt-0001oW-V0
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 08:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab2KYHMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 02:12:41 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:50541 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750924Ab2KYHMk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 02:12:40 -0500
X-AuditID: 12074412-b7f216d0000008e3-3c-50b1c4e7177a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 05.7F.02275.7E4C1B05; Sun, 25 Nov 2012 02:12:39 -0500 (EST)
Received: from [192.168.69.140] (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAP7CaDN031152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 02:12:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <20121124122333.BAD7B4065F@snark.thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqPv8yMYAg707JSyubvGx6LrSzeTA
	5LHsayeLx+dNcgFMUdw2SYklZcGZ6Xn6dgncGat2tTIV3OWpaDu3n6mBcQ1XFyMnh4SAicSc
	OZMYIWwxiQv31rOB2EIClxklTjzO72LkArJPM0l8uXmeGSTBK6AtMevvIyYQm0VAVWLpletg
	DWwCuhKLeprB4qICYRJr9hxigqgXlDg58wkLiC0ioC7x4chRoDkcHMwC4hL9/8DCwgIuEu9O
	/2SF2Gsp0TPxJ1icU8BKYuq6U2DjmQV0JN71PWCGsOUltr+dwzyBUWAWkg2zkJTNQlK2gJF5
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIkArtYFx/Uu4QowAHoxIP783E
	jQFCrIllxZW5hxglOZiURHl19gGF+JLyUyozEosz4otKc1KLDzFKcDArifAeWAuU401JrKxK
	LcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4L10GKhRsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDt9QFp5y0uSMwFikK0nmLU5diwvv0JoxBLXn5e
	qpQ47xaQIgGQoozSPLgVsJT0ilEc6GNh3r0gVTzAdAY36RXQEiagJU9nrwNZUpKIkJJqYCyX
	/v+1MuhC5c+sfh1GH1sWk5yW7yZRy2ZcbpCducGnq81K1o37R9RT5g6Rl2vb/d5ovF5nN/f3
	wpra9f8nCEWuMIoIlg7fJqSZUCcVeSh+wgc7PiMf4S3zzkgsU4q5JaM1UebJyWuG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210335>

On 11/24/2012 01:23 PM, Eric S. Raymond wrote:
> ---
>  Documentation/CommandIntegration |   69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/CommandIntegration
> 
> diff --git a/Documentation/CommandIntegration b/Documentation/CommandIntegration
> new file mode 100644
> index 0000000..be248f7
> --- /dev/null
> +++ b/Documentation/CommandIntegration
> @@ -0,0 +1,69 @@
> [...]
> +You must have a test, written to report in TAP (Test Anything Protocol).
> +Tests are executables (usually shell scripts) that live in the 't' 
> +subdirectory of the tree.  Each test name begins with 't' and a sequence
> +number that controls where in the test sequence it will be executed;
> +conventionally the rest of the name stem is that of the command 
> +being tested.
> +
> +If your test requires an example repository, create it yourself in the
> +test script.  There is a test library of shell functions that assists
> +wit this; when you use it, the environment is set in a predictable way
> +so the author, committer and timestamps are all set to a single well
> +known value, allowing git to create a commit that is reproducible on
> +all platforms. A test_tick function is used in the scripts to move the
> +clock, allowing different times to be used. For an example see
> +t7502-commit.sh, or really any script in that directory.

I think that here a reference to the file t/README would help (and
perhaps make part of your text redundant).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
