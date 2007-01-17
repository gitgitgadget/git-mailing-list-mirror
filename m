From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 11:27:07 -0800
Message-ID: <7vzm8hqws4.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net>
	<45AE7710.40503@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GRD-00018b-R2
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXAQT1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbXAQT1J
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:27:09 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49101 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbXAQT1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:27:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117192707.OCIQ2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 14:27:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CKTQ1W01M1kojtg0000000; Wed, 17 Jan 2007 14:27:25 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <45AE7710.40503@shadowen.org> (Andy Whitcroft's message of "Wed,
	17 Jan 2007 19:20:48 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37029>

Andy Whitcroft <apw@shadowen.org> writes:

>> -	strcpy(filename + len, ".txt");
>> +	sprintf(filename + len, ".%s", fmt_patch_suffix);
>
> This doesn't give us any possibility of not having a suffix.  Can we not
> include the . in the suffix here so that we can specify it as "".

I've considered it, but I do not think it is worth it.  

If we did so, the configuration would look like:

	[format]
		suffix = .txt

which has a certain "Huh?" factor, and more importantly, a
careless user would end up with a patchfile that is named:

	0001-Introduce-git-format-patch-suffix-patchtxt

which is I think much worse than not being able to say:

	0001-Introduce-git-format-patch-suffix-patch

But I do not care that much either way.
