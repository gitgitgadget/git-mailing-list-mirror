From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in
	status output
Date: Wed, 10 Jan 2007 19:16:16 +0100
Message-ID: <1168452977.19643.57.camel@ibook.zvpunry.de>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
	 <1168412892113-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 10 19:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4i0N-0004gp-L1
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbXAJSQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXAJSQb
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:16:31 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:45754 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964967AbXAJSQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:16:30 -0500
To: git@vger.kernel.org
In-Reply-To: <1168412892113-git-send-email-j.ruehle@bmiag.de>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36521>

hi,

Am Mittwoch, den 10.01.2007, 08:08 +0100 schrieb Juergen Ruehle:
...
> @@ -311,12 +312,14 @@ void wt_status_print(struct wt_status *s)
...
> +		else if (s->is_initial)
> +			printf("nothing to commit (working directory is empty)\n");
Shouldn't the user know that there is nothing in his working directory?

> +		else
> +			printf("nothing to commit (working directory matches HEAD)\n");
How about s/matches HEAD/clean/

There is another thing:
# Changed but not added:
#   (use "git add <file>..." to incrementally add content to commit)
#
#       deleted:    blah

How about adding some more hints (e.g.: git rm --cached <file>)
depending on the diff_queue in wt_status_print_changed_cb()?


bye michael
