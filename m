From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 06 Nov 2009 01:02:35 -0800
Message-ID: <7v4op82fh0.fsf@alter.siamese.dyndns.org>
References: <20091106073707.GA14881@glandium.org>
 <7vtyx82g2a.fsf@alter.siamese.dyndns.org> <20091106085917.GA497@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:02:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6KiW-0004On-S9
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 10:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbZKFJCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 04:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754941AbZKFJCh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 04:02:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbZKFJCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 04:02:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 545FB76434;
	Fri,  6 Nov 2009 04:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CDQMFWBVDt/21Us3hA2xmJfva8I=; b=sgY7Mf
	3kHy/1FPnVRIV717K8CB3LxhRb9KX1yAmvzMs/I/kaM/9u0qloLSJ11SKwy2rpcC
	GV9mnWMiyt4X/aMoG5xJPgdszHrnsM3tk+0FL8FKXIZzbxgFssOxT1396tC0GTL7
	XI/0jUR2IIxVgqghMoWTs/ObZX2q6RDjDhW5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFHXWNL4+JaXqJJ2EEEM4KWf0hLXuzFk
	K4RvxnLfKYtT9pVcZ8zbDNLv3CROC/SRi8hMusz4cMyTvwvGsXGrtwtvQ2NEub5I
	2QCgJqP8hMoqwCUoDUl1nXuR5cHRW1d61qaO4Ig/LE3CpE8CTCLIofxNcoPEmOjN
	dvK6hkVDnPo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31B6276433;
	Fri,  6 Nov 2009 04:02:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 911C776432; Fri,  6 Nov
 2009 04:02:36 -0500 (EST)
In-Reply-To: <20091106085917.GA497@glandium.org> (Mike Hommey's message of
 "Fri\, 6 Nov 2009 09\:59\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22561E42-CAB3-11DE-9DD1-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132288>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Nov 06, 2009 at 12:49:49AM -0800, Junio C Hamano wrote:
>> The daemon sitting on the other end to serve "git://" URL won't understand
>> an attempt to push into.  What goes over the wire in the fetch protocol
>> does not give your updated "git push" enough information to guess what
>> would happen if you pushed.
>
> Maybe I'm missing something, but the only missing thing I can see at
> first thought is whether the server is going to reject non fast-forward
> updates. Are there any others ?

Hooks, for a starter.
