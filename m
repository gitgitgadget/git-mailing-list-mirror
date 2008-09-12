From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] git rm: Support for removing submodules
Date: Fri, 12 Sep 2008 14:59:12 -0700
Message-ID: <7v1vzpnhzj.fsf@gitster.siamese.dyndns.org>
References: <20080912210817.31628.69014.stgit@localhost>
 <20080912210902.31628.7325.stgit@localhost>
 <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGgv-0000vT-3v
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbYILV7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758169AbYILV7T
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:59:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbYILV7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:59:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC2AB7EF2E;
	Fri, 12 Sep 2008 17:59:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 58F1C7EF2C; Fri, 12 Sep 2008 17:59:14 -0400 (EDT)
In-Reply-To: <7v8wtxniez.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 12 Sep 2008 14:49:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B48F220-8116-11DD-A6E3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95776>

Junio C Hamano <gitster@pobox.com> writes:

>> +{
>> +	char *key = submodule_by_path(name);
>> +	char *sectend = strrchr(key, '.');
>> +
>> +	assert(sectend);
>> +	*sectend = 0;
>
> Here is one caller I questioned in my comments on [1/6]...

Another thing --- can submodule_by_path() ever return NULL saying "I do
not see one in the configuration"?
