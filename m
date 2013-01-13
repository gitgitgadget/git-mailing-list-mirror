From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 13 Jan 2013 08:50:37 -0800
Message-ID: <20130113165037.GA5118@ftbfs.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
 <50F28BB5.9080607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 13 17:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuQmA-00086w-93
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 17:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab3AMQux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 11:50:53 -0500
Received: from zoom.lafn.org ([108.92.93.123]:44097 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab3AMQux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 11:50:53 -0500
Received: from yeeloong.ftbfs.org (pool-108-23-63-172.lsanca.fios.verizon.net [108.23.63.172])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r0DGonp3052900;
	Sun, 13 Jan 2013 08:50:49 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by yeeloong.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1TuQlZ-0001UF-Ci; Sun, 13 Jan 2013 08:50:37 -0800
Mail-Followup-To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <50F28BB5.9080607@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213387>

On Sun, Jan 13, 2013 at 11:25:57AM +0100, Torsten B=F6gershausen wrote:
> @@ -16,10 +16,10 @@ sub err {
> =20
>  while (<>) {
>  	chomp;
> -	/^\s*sed\s+-i/ and err 'sed -i is not portable';
> -	/^\s*echo\s+-n/ and err 'echo -n is not portable (please use printf=
)';
> -	/^\s*declare\s+/ and err 'arrays/declare not portable';
> -	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use typ=
e)';
> +	/^\s*sed\s+-i\s+\S/ and err 'sed -i is not portable';
> +	/^\s*echo\s+-n\s+\S/ and err 'echo -n is not portable (please use p=
rintf)';
> +	/^\s*declare\s+\S/ and err 'arrays/declare not portable';
> +	/^\s*[^#]\s*which\s+[-a-zA-Z0-9]+$/ and err 'which is not portable =
(please use type)';

The "[^#]" appears to ensure that there's at least one character
before the which and that it's not a pound sign.  Why is this done?
Why isn't it done for the other commands?
