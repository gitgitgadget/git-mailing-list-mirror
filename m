From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 03 Dec 2010 13:02:17 -0800
Message-ID: <7vfwueo9ie.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
 <20101203202923.GB15517@burratino>
 <AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
 <20101203205534.GA15658@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:02:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcmB-0003Ge-QG
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab0LCVCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:02:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0LCVCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:02:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A2653504;
	Fri,  3 Dec 2010 16:03:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VrFcITmjfBlDO2PocUV8mSsxON8=; b=KSIpxP
	o/yYAGlCIL4AKiKRiG20qHxzMAZhI7+Hv/Z5YcA81QeV7qVBJUdOfI/n6gFz4C+z
	PDFqNv7Xp/r0AIaDCwOIWQ9GMfcFmw4M8ZJgaZtXYh0wBIVrN9Kb4oNwXyoxFydv
	NkpApwqj8SOa5nK6bKOoxgcN4B/ma0ufjcSuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=az3KDWcobC9Mx44yd+GAWpFImZw0A3HY
	6ZzQE61J82Z69kAPmKcIVlMrWLI3lwMaRqH1ZKVP+XwxOoeOCB1F6KeH8f2gWFhe
	WEdU3khG9kIRziEl0B0PLbTNskZ4Z5vjtdwoqEobu/ca58riF3ZESRMJlGoTm6Zr
	BnkeWUssSrA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA6CE34FB;
	Fri,  3 Dec 2010 16:02:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A43AD34F6; Fri,  3 Dec 2010
 16:02:38 -0500 (EST)
In-Reply-To: <20101203205534.GA15658@burratino> (Jonathan Nieder's message of
 "Fri\, 3 Dec 2010 14\:55\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B352C236-FF20-11DF-81DC-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162853>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> ::SourceMode1 SourceMode2 resultMode Source1-SHA1 Source2-SHA1 resultingSHA1 MM path/to/file
> [...]
>> 1. a) Why this exact output is not provided in "git log --raw" or in
>> "git whatchanged" for the merge commits? b) Can it be provided?
>
> Sorry to be opaque.  "git log" et al accept -c too, of course. :)  I pointed
> to diff-tree because it seems you are scripting, so its simplicity and
> better guarantees about long-term compatibility might be appealing.

Two nits if this is really to help scripters.

 - Both -c and --cc cull merges uninteresting at the file level; if the
   script _really_ wants to view the whole history, giving -m would be
   more appropriate.

 - The default history traversal is --dense and also with merge
   simplification turned on; again, if the script _really_ wants to view
   the whole history, --sparse and/or --full-history would be necessary
   depending on the needs.
