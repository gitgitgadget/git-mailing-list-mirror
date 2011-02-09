From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Updated patch series for default upstream merge
Date: Tue, 08 Feb 2011 16:34:15 -0800
Message-ID: <7vlj1qoxko.fsf@alter.siamese.dyndns.org>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
 <1297211028-14382-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 01:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmy0t-00079V-RL
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 01:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab1BIAe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 19:34:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1BIAe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 19:34:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1996343C9;
	Tue,  8 Feb 2011 19:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tbV82yekoCgq8K6vGOvtFnGlCsQ=; b=aT5zSh
	ZrFxxHG5zfYadCe/LFwdNAKZjEuPPx6Ki5ioEMAO7Ik2ee8Kd/rsGf21nrgubF57
	abwZnpcVW9WfQFeSvkdwt6BR9QTLlBgyzGf8MTKNt1HM1L/gCaTgOALZqbtXv2Jv
	STmTI+2hGRQeXDGIhh8r+PYVlAlq0wL3IeX80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hy+4iBFRU9xBtqyKoaQ2lAdWrgdQ2Oxt
	qowTUkJzVMMrJgZClqPbaUBBq/uEM9BMz761mr+ynNIApQbMnJ6L1iYyknbrjRXw
	QIztVApQPxUzT301tpxjCXEEF2/g5Kce4pqRb6bGHfmLY0/VK/2W4MJsoy2bw3z2
	YY30M+c8ELE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB48943C5;
	Tue,  8 Feb 2011 19:35:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B66C043C4; Tue,  8 Feb 2011
 19:35:15 -0500 (EST)
In-Reply-To: <1297211028-14382-1-git-send-email-jaredhance@gmail.com> (Jared
 Hance's message of "Tue\,  8 Feb 2011 19\:23\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 791C90DA-33E4-11E0-B667-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166382>

Jared Hance <jaredhance@gmail.com> writes:

> Notes/Complications:
> 	- I'm not sure whether the option should be merge.defaultUpstream
> 	  or merge.defaultToUpstream

Probably the latter.

> 	- Should [remotes] be changed to [branches]? I felt like it was
> 	  a completely different change and didn't belong in the patch series.

Perhaps at the beginning (just like your 1/3 refactoring) or at the end as
a separate patch?

> 	- I left one of the ifs with unnecessary braces for clarity because
> 	  of a nested if-else: is this the preferred style?

If you are talking about the one at @@ -1017,9 +1023,13 @@, it looks fine
to me.  The new "else" you added to @@ -525,6 +527,8 @@ may probably want
to start on the same line as closing "}" of the "if", though.  IOW, like
this:

	if (cond) {
        	...
	} else {
        	...
	}

not like this:

	if (cond) {
        	...
	}
        else {
        	...
	}

But other than that looks reasonable.

Thanks.
