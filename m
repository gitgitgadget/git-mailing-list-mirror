From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 2/4] This exports the update() function from
	builtin-add.c as
Date: Wed, 03 Oct 2007 18:03:54 -0400
Message-ID: <1191449034.7134.19.camel@hinata.boston.redhat.com>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
	 <1190868632-29287-2-git-send-email-krh@redhat.com>
	 <7v7imcv5op.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 00:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdCPS-0007uB-33
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbXJCWJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbXJCWJa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:09:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbXJCWJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:09:29 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l93M49Y9024651;
	Wed, 3 Oct 2007 18:04:09 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93M48os002612;
	Wed, 3 Oct 2007 18:04:08 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93M483S007196;
	Wed, 3 Oct 2007 18:04:08 -0400
In-Reply-To: <7v7imcv5op.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59899>

On Thu, 2007-09-27 at 02:05 -0700, Junio C Hamano wrote:
...
> I think the right organization for the "builtin-commit" series
> should be:
> 
>  * merge strbuf topic in kh/commit topic, in order to get the
>    stripspace updates and strbuf_read_file();
> 
>  * add--interactive entry point change (respin the one from the
>    old series);
> 
>  * rename update() to add_files_to_cache() and export (respin
>    this [2/4] with a better commit message);
> 
>  * create a separate rerere() function and export (respin part
>    of old series, with proper refactoring);
> 
>    I am not happy with builtin-foo.c calling into something from
>    builtin-bar.c, though.  We probably would want to move
>    rerere() and add_files_to_cache() somewhere else.
> 
>  * move launch_editor() and stripspace() to create editor.c (new
>    [4/4]);
> 
>  * add option parser in parse-options.[ch] (new [1/4]);
> 
>  * finally, create builtin-commit that uses the groundwork laid
>    out above (new [3/4]).
> 
> I ended up doing the above up to the rerere() one myself, but
> haven't done the rest.

>From what I see in next today, it looks like we're just missing the
parse-options patch and builtin-commit patches.  I resent a better
version of parse-options and a patch that ports builtin-add.c to the
option parser.  To use the option parser in more places, we'll probably
have to extend it a bit, but the patch is a good start.  Let's get that
in shape and into next and then I'll send an updated builtin-commit
patch.

thanks,
Kristian
