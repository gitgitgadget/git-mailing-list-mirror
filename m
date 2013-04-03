From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 03 Apr 2013 11:21:56 -0700
Message-ID: <7v38v75vaz.fsf@alter.siamese.dyndns.org>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
 <3b24bc742b9738531d707932a9775c98@meuh.org>
 <87k3ojtz9n.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 03 20:22:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNSKL-0007NE-Io
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 20:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762929Ab3DCSV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 14:21:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762922Ab3DCSV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 14:21:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DE641228D;
	Wed,  3 Apr 2013 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+R+Wke6yyvrikPdWQSCx/r5Veg=; b=fXaW0v
	Mc9GyJHnXyYsOozSYfWBCQGgRTV99Mgv7zu9xHVMoOigIBtPhDmmQyvyfNUGUeR4
	vLMSxPc+kMtmu/yJXaexXIVnKteMZz5ISTxCy2dlJHxy2gS6aOsAJiQ/ngoHEwR3
	f6I77apvqwJELHK/7NCDK0Hp1qogcLTIWuewA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ft8mld4a/WEoXl67TpeqL8VF5fHvAuWj
	4IqA2pLiwuJilAcv0NyRcCfacSvBnTVzVzIU7qMZDwEPTqU86xA7HCThmVXvCyV3
	sgUm8qoXwn9+yOVzbLQ7eWyzCCKyEFruyQDwQqgvT/0qKvrN7WdVk4FBPpL4dwQ2
	MXEKsq58gSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83DCC1228B;
	Wed,  3 Apr 2013 18:21:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA52B1228A; Wed,  3 Apr
 2013 18:21:57 +0000 (UTC)
In-Reply-To: <87k3ojtz9n.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Wed, 3 Apr 2013 17:22:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5ED1161C-9C8B-11E2-AF1B-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219959>

Thomas Rast <trast@inf.ethz.ch> writes:

> Yann Droneaud <ydroneaud@opteya.com> writes:
> ...
>> Is there any other kind of object that can be tagged ... and what is
>> the purpose of this ?
>
> Any object type, including tags.  Signed tags of other tags probably
> make sense if you want to express extra approval on top of the original
> signature.

I looked at what "git show" implements, and it seems to peel each
level of tags to show all of them, which is very good.
