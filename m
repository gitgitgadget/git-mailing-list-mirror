From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 18:05:10 -0800
Message-ID: <7v3aupzu09.fsf@gitster.siamese.dyndns.org>
References: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
	<1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
	<7vmysy7oav.fsf@gitster.siamese.dyndns.org>
	<200711290215.34237.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 03:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxYmt-0007pS-EF
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 03:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165AbXK2CFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 21:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758023AbXK2CFS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 21:05:18 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56975 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbXK2CFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 21:05:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E499F2F0;
	Wed, 28 Nov 2007 21:05:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CD609ADBD;
	Wed, 28 Nov 2007 21:05:34 -0500 (EST)
In-Reply-To: <200711290215.34237.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Thu, 29 Nov 2007 02:15:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66492>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Maybe we should have a boolean indicating whether the arguments refer
> to filespecs or not to make this clear or rewite the mingw fallouts in
> some other way.

I wondered the same, but my vote would be to make them separate
functions.  You would need a function to abstract out pasting of paths
to ease MinGW people even without this "ah absolute -- let's make it
relative to work tree first" hack, anyway.
