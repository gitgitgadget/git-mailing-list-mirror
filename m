From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 12:51:47 -0700
Message-ID: <7vty1tr418.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312171257.GA25347@kroah.com>
 <7vzkblsnos.fsf@alter.siamese.dyndns.org> <20120312192627.GA24873@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:52:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BHk-0005u6-Q8
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 20:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab2CLTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 15:51:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756787Ab2CLTvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 15:51:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 657306249;
	Mon, 12 Mar 2012 15:51:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=guTSPXLn5zOzmnvhwDo1sri4iDU=; b=gieOyG
	7luDRACtCIj53I8vUrl1paMPkVGnrH3ONpQoZIumeuieck3dRRplxoalwLm7e6w7
	4KYE0Qgv6fL7jMl4wqc6V1+E5hjPCRYqsru3qU/Zw0+HZzhjRzA1wRIhhkoNIxOm
	jZiILvcUd6NeEOPkJh1YaXrXSIF2p7Kvh29uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RF2hVxnQlUcwdoPA8FgVgx1peKHuvC1U
	Bstse/EnEhTmvMICeyRqFDb4ALDGONJfDrPNlHNi3e9+uqxkvCle+9twmPnKIlbH
	c/GD5vDNJtnDYgWrsJuG7UK94Hvtek2Ii/ICNWCbwWw6/5FezhvJtsjumxjp0gBo
	yUoAlH8isLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C6486248;
	Mon, 12 Mar 2012 15:51:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD4F6247; Mon, 12 Mar 2012
 15:51:48 -0400 (EDT)
In-Reply-To: <20120312192627.GA24873@kroah.com> (Greg KH's message of "Mon,
 12 Mar 2012 12:26:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE19BD5C-6C7C-11E1-B0CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192934>

Greg KH <greg@kroah.com> writes:

> On Mon, Mar 12, 2012 at 11:01:55AM -0700, Junio C Hamano wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> > Does the flag propagate from 'git quiltimport'?
>> 
>> I didn't even know the script was shipped as part of the main
>> Porcelain until I looked.  I do not think anybody is maintaining it;
>> the last update was from the 1.6.2 era.
>
> Ah, so my feeling that I'm the only one using it is true :)
>
>> A tested patch from quilt stakeholders is very much welcomed.
>
> I'll be glad to maintain this if you need me to.  I'll poke around with
> it tomorrow to see what needs to be done here.

Surely, and thanks.
