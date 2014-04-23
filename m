From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 13:15:18 -0700
Message-ID: <xmqq1twnztt4.fsf@gitster.dls.corp.google.com>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
	<xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
	<CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
	<xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
	<CAHd499Cw8=FMctRA49MUi+vP2gvMyXH9WgcfCKK_MrKDEOfvjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3Zt-0001ps-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbaDWUPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:15:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757513AbaDWUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:15:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F6A7E4C1;
	Wed, 23 Apr 2014 16:15:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ayesvC71MlodVKb3P4SkdzNhLqA=; b=PmK6ss
	SlcWAxhKACMlfetVXern5QB4Dh4GYBRsDm97bOPFzK0ievp2tZNS1flux0wINSPD
	5poS6gMbonmJObGvYopKaxECo6dBHNHldSMbmxc+SDHKxzwTyfXxSAdhqKW7iaXk
	oEUaXqQxuuup7E4MtRgRVHA6D3KywWxAAaYX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kSdyyKZPL0QitTepiPGCml/jEK4HKjHY
	nN+Sa0gGbj6wDKHEX/uizQ4pko8kJPi7PMXFcBnBB9HOVGQEKK/fsK7AJVdXEWiL
	cZF5P6Hp5AHAuReaP8/eO5EckZQAVHft9b/KbchSqOj5xEKWFyWj85VjDzzZcQnn
	1x3Io6eO8Bk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401467E4C0;
	Wed, 23 Apr 2014 16:15:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92A7D7E4BE;
	Wed, 23 Apr 2014 16:15:20 -0400 (EDT)
In-Reply-To: <CAHd499Cw8=FMctRA49MUi+vP2gvMyXH9WgcfCKK_MrKDEOfvjw@mail.gmail.com>
	(Robert Dailey's message of "Wed, 23 Apr 2014 14:59:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE8CCF08-CB23-11E3-822B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246885>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> On Wed, Apr 23, 2014 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>
>> [Administrivia: because people read from top to bottom / why is it
>> bad to top-post? / please do not top-post.]
>>
>>> On Tue, Apr 22, 2014 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>>>
>>>>> git log log --graph --abbrev-commit --decorate --date=relative
>>>>> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
>>>>> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
>>>>> white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes
>>>>> ...
> ... I also tried removing it to test
> but i saw no difference; tag names are still visible.

I do not use these eye-candies myself (they are too distracting for
me), but doesn't "%d" in the format string mean "decorate"?
