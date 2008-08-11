From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 15:33:32 -0700
Message-ID: <7vod3zuqpv.fsf@gitster.siamese.dyndns.org>
References: <20080811190924.GR18960@genesis.frugalware.org>
 <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
 <20080811214639.GA28340@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:34:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfyO-0004hf-7x
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYHKWdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbYHKWdm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:33:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYHKWdl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:33:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFBCB5531B;
	Mon, 11 Aug 2008 18:33:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA03E5531A; Mon, 11 Aug 2008 18:33:34 -0400 (EDT)
In-Reply-To: <20080811214639.GA28340@leksak.fem-net> (Stephan Beyer's message
 of "Mon, 11 Aug 2008 23:46:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BA3F242-67F5-11DD-84B0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92012>

Stephan Beyer <s-beyer@gmx.net> writes:

> Sorry, I forgot to change this to [PATCH v2] or something.
>
> And...
>
> Stephan Beyer wrote:
>> diff --git a/merge-recursive.h b/merge-recursive.h
>> index f37630a..a9eead3 100644
>> --- a/merge-recursive.h
>> +++ b/merge-recursive.h
>> @@ -1,6 +1,8 @@
>>  #ifndef MERGE_RECURSIVE_H
>>  #define MERGE_RECURSIVE_H
>>  
>> +extern struct commit *make_virtual_commit(struct tree *tree,
>> +					  const char *comment);
>>  int merge_recursive(struct commit *h1,
>>  		    struct commit *h2,
>>  		    const char *branch1,
>
> Is this a mistake that some forward declarations in header files are not
> declared "extern"?

Yup, that looks old fashioned.
