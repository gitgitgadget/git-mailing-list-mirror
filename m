From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/16] ls-files: add --overlay option
Date: Tue, 16 Sep 2008 10:00:50 -0700
Message-ID: <7v7i9c6n5p.fsf@gitster.siamese.dyndns.org>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
 <1221397685-27715-16-git-send-email-pclouds@gmail.com>
 <1221397685-27715-17-git-send-email-pclouds@gmail.com>
 <7vljxtb3tf.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0809160500y4b67c621g45b0c6ddf3745a84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:02:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfdwG-0003Ya-Sn
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbYIPRA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbYIPRA6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:00:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYIPRA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:00:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2476D60781;
	Tue, 16 Sep 2008 13:00:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 547E16077A; Tue, 16 Sep 2008 13:00:53 -0400 (EDT)
In-Reply-To: <fcaeb9bf0809160500y4b67c621g45b0c6ddf3745a84@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue, 16 Sep 2008 19:00:03 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 073771CC-8411-11DD-9AE7-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96017>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

>>  By the way, I do not see an easy way to review what paths are marked with
>>  no-checkout easily from your command set.  It might be worthwhile to add a
>>  new option that iterates over the index, finds a set of common prefixes to
>>  no-checkout entries and reports that set.
>
> What is it for? I can only think of it (actually the opposite, find a
> set of common prefixes to checkout entries) as a way to reconstruct
> narrow spec (simple rules only).

That's the list you can use as input to "find $them -type f" to see what
stale files from previous unnarrowed checkout are on the filesystem.

I agree that the opposite is also interesting and could be useful.  Only
the individual index entries remember the area the user told us to check
out, and I expect that "what's my narrow area right now?" would be a
common question users may want to ask.  A full answer can be obtained with
ls-files --narrow, but if we can summarize it into a more concise form, it
would be a useful thing to do.
