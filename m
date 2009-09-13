From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: suggest gc only when counting at least 2
 objects
Date: Sun, 13 Sep 2009 10:58:45 -0700
Message-ID: <7vr5uasp4a.fsf@alter.siamese.dyndns.org>
References: <20090909195158.GA12968@localhost>
 <20090913160637.GA15256@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 13 19:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmtLt-0000W0-Io
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 19:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZIMR65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 13:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZIMR64
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 13:58:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbZIMR64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 13:58:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D153E31EEB;
	Sun, 13 Sep 2009 13:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n2NQt3P8oFFrJ49Z474cLLhgbF0=; b=evsCrd
	A2/Dq0CBUWDftNM9z7lfmmSxoPzQD7MmzSDzQ5MoHCOiuekVbTQIpH6Sx+wqYuiB
	p0uyY3LR/vlS6Ur9hE0So16619Ghiq7xXXcfVRT/OVvPnc1Wmdg7TNGZdfxQJ5nh
	VpSc1dgLYcGwSF/h+qQWzX5pxf2RhXaxFGQpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtARQ8Uzf+1qlJ4yUt3LlD91vTZVeYj1
	k8h2gGinJ2bHyxu2izRnifod5FyN4wCZChHa0RXF5fyVQWaknDj/4mbzgN82Mtgv
	PqDurgAvjmMD+tW8zwfIHPB3cGGwyQjjoCj3zolhCW0H6+3cz5GzwZUYvS/sIDHX
	DHcmKfofYDo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB2731EEA;
	Sun, 13 Sep 2009 13:58:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB06B31EE3; Sun, 13 Sep
 2009 13:58:46 -0400 (EDT)
In-Reply-To: <20090913160637.GA15256@localhost> (Clemens Buchacher's message
 of "Sun\, 13 Sep 2009 18\:06\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 184C3074-A08F-11DE-9D48-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128378>

Clemens Buchacher <drizzd@aon.at> writes:

> On Windows, git-gui suggests running the garbage collector if it finds
> 1 or more files in .git/objects/42 (as opposed to 8 files on other
> platforms).

Somebody cares to explain why this threashold number has to be different
per platform in the first place?  Instead of bumping up to 2 like your
patch did, what bad things would happen if you increased it to 8 on
Windows?  Doesn't the same badness happen on non-Windows because they have
the threashold set to 8 already?
