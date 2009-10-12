From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: complete refs for git-grep
Date: Mon, 12 Oct 2009 16:42:02 -0700
Message-ID: <7v4oq46uyd.fsf@alter.siamese.dyndns.org>
References: <200910071727.50770.trast@student.ethz.ch>
 <9f58ba1e7db9702d1b0594a8016c204e3d50b72f.1255337776.git.trast@student.ethz.ch> <20091012142710.GI9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY8-0007dA-6K
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbZJLXmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756810AbZJLXmx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:42:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415AbZJLXmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:42:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A6855636F;
	Mon, 12 Oct 2009 19:42:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fni1Ag/xx5JKnG+3Ko5mAbnVkFs=; b=oADhdcD+q5Ck8Yg4m1vt8Y9
	QOOZpXLAGvl7QntG9G8ZJVAz0Y+rzmtaPqw2BwAdq6mAU8Pi7L5OdA0LvMLVGCW0
	JHT7FSOT98BwS5022tprV86vkPwSJCD97AxTP8/oTtKVQe+sz7mClw+/HRoU9ReN
	I3TTl9dmarJYy1PTC9tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rGrFYA6Li1oyNgFjT+QEpYYsTuYBlg9l6YU5eJ0SWwEAkZskd
	Prm4PziqQOLwLOQYpcQio+bP7lldmpSb6v3ZHTm41URQMez5lMxicwPqInR0Mah4
	va8oFSQDTeW/XdWXZXyNGPPPbYhN+IySQwy00ispkfvv3rAtyOfKXp0Elc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F11F05636E;
	Mon, 12 Oct 2009 19:42:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFBDF5636B; Mon, 12 Oct
 2009 19:42:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAA7C5B0-B788-11DE-B0A7-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130098>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Thomas Rast <trast@student.ethz.ch> wrote:
>> > So I'll roll a simpler patch that just always (before --) completes
>> > refs instead, if that's ok.
>
> Hard to argue with that logic.  :-)
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks.

>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 6fd7e1d..b08cd77 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1048,7 +1048,8 @@ _git_grep ()
>>  		return
>>  		;;
>>  	esac
>> -	COMPREPLY=()
>> +
>> +	__gitcomp "$(__git_refs)"
>>  }
>
> -- 
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
