From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Mon, 11 Oct 2010 20:56:59 -0700
Message-ID: <7v8w24oygk.fsf@alter.siamese.dyndns.org>
References: <20101009201751.GK9348@bzzt.net>
 <20101010024124.GA20305@burratino> <20101010103327.GO9348@bzzt.net>
 <20101010180909.GA12320@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnout Engelen <arnouten@bzzt.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 05:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5VzI-0002ya-VK
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 05:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab0JLD5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 23:57:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab0JLD5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 23:57:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D60D9DDEB7;
	Mon, 11 Oct 2010 23:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sC4kIE/pRqCBiBDrgNDrGHUKz2E=; b=UGBb+GFTPqoAhe44vo5T+L3
	ZNgodk3aZ1gUDhftRFo2w/hfldhmdwaB0gqWOGYZwn4vfLWUctddpmPB103zv3WK
	2SJEM4EoKAVRvsOewZ7mSzvWzSXTstTFgwC3KukBdGq5VXxF8Ix13Q3SPnTNVQva
	4YSg57VI4anjpATAsFlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=DdvfIZTneApOPdoKKwpy3T4Nn+5HTtHBYUucaBE7UZmbyAEEV
	6jqUqQbMlrZAIKs9YqNZph+Ekkn4czOB2ZoVA6ixIWD/BP9pO6jm0D0uR3jjNGqD
	zpeIRmxxlyEyfhicm6dTNYNzaWJTLKdY+sNK7S+ivnujS3QMprGo9gGaGQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A26BADDEAF;
	Mon, 11 Oct 2010 23:57:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAC39DDEAA; Mon, 11 Oct
 2010 23:57:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C724F120-D5B4-11DF-BBAF-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158820>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Arnout Engelen wrote:
>> On Sat, Oct 09, 2010 at 09:41:24PM -0500, Jonathan Nieder wrote:
>
>>> 	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
>>> 	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device
>>
>> Perhaps we should also log the current working directory when the temporary 
>> filename is relative?
>
> Let's step back for a moment.  Was there an example that prompted
> this patch?  Were you aware of where git would be trying to create
> files in that example?  (I'm genuinely curious.)
>
> Converting the filename to an absolute path with make_absolute_path
> might be useful, but I am not entirely sure it is worth the
> complication.

For that matter, I am not sure if it is worth the strdup "just in case it
fails" either.
