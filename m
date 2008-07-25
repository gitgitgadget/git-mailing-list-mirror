From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Thu, 24 Jul 2008 21:44:47 -0700
Message-ID: <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
References: <4888144E.8090300@sneakemail.com>
 <20080724172912.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 06:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMFBl-0001NM-4n
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 06:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYGYEo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 00:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbYGYEo5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 00:44:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYGYEo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 00:44:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C9E3F42BB2;
	Fri, 25 Jul 2008 00:44:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6B27B42BB1; Fri, 25 Jul 2008 00:44:51 -0400 (EDT)
In-Reply-To: <20080724172912.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 24 Jul 2008 17:29:12 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6DB82B6C-5A04-11DD-88F3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89998>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting "Peter Valdemar Mrch (Lists)"  <4ux6as402@sneakemail.com>:
>
>> The '-trailing-space' syntax to disable the trailing-space setting is
>> not obvious and not documented as far as I can see. I would have
>> assumed a value of '' would disable it.
>>
>> Is there a documentation bug here? If so, I suggest this patch. I
>> didn't find anywhere else where the '-setting' syntax was used to
>> disable something.
>
> Doesn't gitattributes(5) describe the overall syntax in detail?

Yes, but as Peter says in his reply to you, it only talks about [-!]name
syntax to force the variable to unset (with '-' prefix) and to revert the
variable to the unspecified state (with '!' prefix).

Various "values" given to the whitespace attribute actually act as if they
are sub-variables and obey the similar "[-]name" rule, but (1) that is
left unsaid, and (2) in that context '!' does not make sense so only '-'
has any meaning.  We would certainly need to clarify that.

So I think Peter's patch is going in the right direction.
